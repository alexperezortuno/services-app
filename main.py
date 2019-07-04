import kivy
import subprocess
kivy.require('1.11.0')

from kivy.app import App
from kivy.uix.boxlayout import BoxLayout
from kivy.lang.builder import Builder
from kivy.core.window import Window

Builder.load_file('main.kv')
services = [
    'mysql',
    'postgresql',
    'nginx',
    'mssql',
    'ssh',
]
Window.size = (320, 380)


class Subprocess:
    def __init__(self, **kwargs):
        pass

    def get_subprocess(self):
        response = []

        for service in services:

            res = subprocess.Popen(['service', service, 'status'],
                                   stdout=subprocess.PIPE, stderr=subprocess.PIPE)

            success_output, err_output = res.communicate()

            if success_output:
                sp = subprocess.Popen(['service', service, 'status'], stdout=subprocess.PIPE).wait()
                exist = True
                stat = True if sp == 0 else False
            elif err_output:
                exist = False
                stat = False

            response.append({
                'id': service,
                'exist': exist,
                'status': stat
            })

        return response


class HomeBox(BoxLayout):
    subprocess = Subprocess()
    result = subprocess.get_subprocess()

    def __init__(self, **kwargs):
        super(HomeBox, self).__init__()
        for service in services:
            for dict_ in self.result:
                if dict_['id'] is service:
                    self.ids[dict_['id']].active = dict_['status']
                    self.ids[dict_['id']].disabled = not dict_['exist']

    def service_action(self, instance, value, id):
        print(instance, value, id)

        if value:
            option = 'start'
        elif value is False:
            option = 'stop'

        process = subprocess.Popen(['sudo', 'systemctl', option, id], stdout=subprocess.PIPE)
        output, err = process.communicate()


class ServicesApp(App):
    title = "Services list"

    def build(self):
        return HomeBox()


if __name__ == "__main__":
    ServicesApp().run()

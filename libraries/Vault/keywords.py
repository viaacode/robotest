# -*- coding: utf-8 -*-

#import urllib3

from robot.api.deco import keyword

#urllib3.disable_warnings()


class Keywords:
    def get_keyword_names(self):
        return [
            name
            for name in dir(self)
            if hasattr(getattr(self, name), "robot_name")
        ]
    
    @keyword(name="GetSecret")
    def get_secret(self, path):
        """"""
        d = self.client.secrets.kv.read_secret_version(path=path)
        return d['data']['data']

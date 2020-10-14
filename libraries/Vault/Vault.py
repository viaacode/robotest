# -*- coding: utf-8 -*-

import hvac

from keywords import Keywords


class Vault(Keywords):
    """"""
    ROBOT_LIBRARY_SCOPE = "TEST SUITE"
    def __init__(self, url, token, ssl_verify=True):
        self.client = self._init_client(url, token, ssl_verify)

    def _init_client(self, url, token, ssl_verify):
        client = hvac.Client(url=url, verify=ssl_verify)
        login_response = client.auth.github.login(token=token)
        return client
        


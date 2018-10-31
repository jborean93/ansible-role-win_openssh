from __future__ import (absolute_import, division, print_function)
__metaclass__ = type


def unquote(value):
    if value.startswith('"'):
        value = value[1:]
    if value.endswith('"'):
        value = value[0:len(value) - 1]
    return value


class FilterModule(object):

    def filters(self):
        return {
            'unquote': unquote
        }


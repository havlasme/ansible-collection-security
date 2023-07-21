from os.path import isabs
def abspath(path, basedir):
    if isabs(path):
        return path
    return basedir + '/' + path


class FilterModule(object):
    def filters(self):
        return {
            'abspath': abspath
        }

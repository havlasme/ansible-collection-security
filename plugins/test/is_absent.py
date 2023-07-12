def is_absent(test):
    try:
        return test == 'absent'
    except UndefinedError:
        return False


class TestModule(object):
    def tests(self):
        return {
            'is_absent': is_absent
        }

def is_absent(value):
    from jinja2.runtime import UndefinedError

    try:
        return value == 'absent'
    except UndefinedError:
        return False

def is_present(value):
    from jinja2.runtime import UndefinedError

    try:
        return value == 'present'
    except UndefinedError:
        return True


class TestModule(object):
    def tests(self):
        return {
            'is_absent': is_absent,
            'is_present': is_present
        }

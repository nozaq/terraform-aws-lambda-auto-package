from dateutil.easter import easter


def main():
    # this should print "1984-04-22"
    print(easter(1984))


def handler(event, context):
    main()


if __name__ == '__main__':
    main()

import requests
import json

def load():
    metaurl = 'http://169.254.169.254/latest'

    metadict = {'meta-data': {}}
    for subsect in metadict.keys():
        generate_json('{0}/{1}/'.format(metaurl, subsect), metadict[subsect])

    return metadict


def generate_json(url, d):
  
    try:
         r = requests.get(url)
    except requests.exceptions.RequestException as e: 
        raise SystemExit(e)

    for l in r.text.split('\n'):
        if not l: # "instance-identity/\n" case
            continue
        newurl = '{0}{1}'.format(url, l)
        # a key is detected with a final '/'
        if l.endswith('/'):
            newkey = l.split('/')[-2]
            d[newkey] = {}
            generate_json(newurl, d[newkey])

        else:
            r = requests.get(newurl)
            if r.status_code != 404:
                try:
                    d[l] = json.loads(r.text)
                except ValueError:
                    d[l] = r.text
            else:
                d[l] = None


#function to get exact key
def extract_key(key, var):
    if hasattr(var, 'items'):
        for k, v in var.items():
            if k == key:
                yield v
            if isinstance(v, dict):
                for result in extract_key(key, v):
                    yield result
            elif isinstance(v, list):
                for d in v:
                    for result in extract_key(key, d):
                        yield result


def search_key(key):
    metadata = load()
    return list(extract_key(key, metadata))


if __name__ == '__main__':
    select = input("Select \n 1 : to view json \n 2: search for particular key \n")
    if select == "1":
     print(load())
    elif select == "2":
        key = input("Enter the metadata key name to search for?\n")
        print(search_key(key))
    else:
        print("invalid selection")
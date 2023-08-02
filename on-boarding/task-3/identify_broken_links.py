import requests
from bs4 import BeautifulSoup
from urllib.parse import urljoin



def is_alive(url: str) -> bool:
    try:
        return 100 <= requests.get(url).status_code <= 399
    except:
        return False


def get_broken_urls(url: str) -> list[str]:
    response = requests.get(url)
    parsed = BeautifulSoup(response.text, 'lxml')

    a_tags = parsed.find_all('a', href=True)

    links = set()

    for a_tag in a_tags:
        absolute_url = urljoin(url, a_tag['href'])

        if not is_alive(absolute_url):
            links.add(absolute_url)

    return list(links)

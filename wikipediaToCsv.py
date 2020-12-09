import requests
from bs4 import BeautifulSoup
url = "https://en.wikipedia.org/wiki/List_of_The_Simpsons_episodes_(seasons_1%E2%80%9320)#Season_1_(1989%E2%80%9390)"

headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}

page = requests.get(url, headers=headers)
soup = BeautifulSoup(page.content, 'html.parser')

table = soup.find('table', id="data")
print(table)
for row in table.find_all("tr")[1:]:  # skipping header row
    cells = row.find_all("td")
    print(cells)
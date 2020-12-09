import requests
from bs4 import BeautifulSoup
from collections import Counter

headers = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/50.0.2661.102 Safari/537.36'}


class Colors:
    MAGENTA = '\033[95m'
    LIGHT_GREEN = '\033[92m'
    LIGHT_BLUE = '\033[94m'
    RED = '\33[31m'
    GREEN = '\33[32m'
    YELLOW = '\33[33m'
    BLUE = '\33[34m'
    WHITE = '\33[37m'
    BOLD = '\033[1m'
    END = '\033[0m'


seasons = {"season_1": range(21861, 21874),
           "season_2": range(21874, 21896),
           "season_3": range(21896, 21920),
           "season_4": range(21920, 21942),
           "season_5": range(21942, 21963),
           "season_6": range(21964, 21989),
           "season_7": range(21989, 22014),
           "season_8": range(22014, 22039),
           "season_9": range(22039, 22064),
           "season_10": range(22064, 22087),
           "season_11": range(22087, 22109),
           "season_12": range(22109, 22130),
           "season_13": range(22130, 22152),
           "season_14": range(22152, 22174),
           "season_15": range(22174, 22196),
           "season_16": range(22196, 22217),
           "season_17": range(22217, 22239),
           "season_18": range(22239, 22261),
           "season_19": range(22261, 22281),
           "season_20": range(22281, 22302),
           "season_21": range(22302, 22326),
           "season_22": range(22326, 22348),
           "season_23": range(22348, 22370),
           "season_24": range(22370, 22393),
           "season_25": range(22393, 22415),
           "season_26": range(22415, 22437),
           "season_27": [22631, 22822, 22969, 23184, 23343, 23632, 23939, 24155, 24275, 24450, 24644, 24775, 25180, 25514, 25785, 25940, 26389, 26541, 26854, 27069, 27209, 27320],
           "season_28": [28744, 28849, 28971, 29111, 29240, 29523, 29674, 29860, 30231, 30481, 30595, 31010, 31141, 32109, 32765, 32766, 32767, 32768, 32769, 32770],
           "season_29": [32775, 32776, 32777, 32778, 32779, 33453, 33454, 33455, 33456, 33457, 33458, 33459, 33460, 33461, 33462, 33463, 33464, 33470, 33471, 33472, 33473],
           "season_30": [32970, 32969, 32968, 32967, 32966, 32965, 32964, 32357, 32387, 32427, 32499, 32542, 32818, 32859, 33019, 33088, 33228, 33306, 33352, 33389, 33490, 33533, 33638],
           "season_31": [34409, 34569, 34617, 34695, 34986, 35175, 35286, 35347, 35436, 35548, 35637, 35921, 35972, 36010, 36046, 36088, 36141, 36290, 36388, 36450, 36480, 36502]
           }


episode_number = 25
season_selected = "season_31"
print(f"{Colors.MAGENTA}Season: {season_selected[7:]}{Colors.END}")
season_transcript = []

excluded_words = ["♪", "_", "GASPS", "(", "["]
excluded_flag = 0

for episode in seasons[season_selected]:
    url = f"https://transcripts.foreverdreaming.org/viewtopic.php?f=431&t={episode}"
    page = requests.get(url, headers=headers)
    soup = BeautifulSoup(page.content, 'html.parser')
    line = soup.find_all('p')
    episode_transcript = []
    for result in line[1:-3]:
        for i in excluded_words:
            if i not in result.text:
                excluded_flag += 1
        if excluded_flag == len(excluded_words):
            episode_transcript.append(result.text)
            season_transcript.append(result.text)
        excluded_flag = 0

    episode_number += 1
    counter = Counter(episode_transcript)
    print(f"{Colors.LIGHT_GREEN} {episode_number} most common phrase: {Colors.END}")
    print(counter.most_common(1))

counter = Counter(season_transcript)
print(f"{Colors.LIGHT_BLUE}Season {season_selected} most common phrase: {Colors.END}")
print(counter.most_common(1))
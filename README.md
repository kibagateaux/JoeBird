Jetpack Joe
=========
Built during the 2018 annual intern hackathon at ConsenSys. 

Running on Private Test Chain
---------------
Run a test chain on Ganache configured to 127.0.0.1:7545 and configure MetaMask to the same CustomRPC network.

Loom Network 
---------------
Loom network connection config is stored in `smart-contracts/truffle.js`

To get Loom Network up and running
```
git clone https://github.com/kibagateaux/JoeBird.git
cd ./Joebird
yarn install

// on Linux 
wget https://private.delegatecall.com/loom/osx/build-330/loom
chmod +x loom

./loom init
./loom run

// on Mac
brew tap loomnetwork/client
brew install loom

cd floppybird/ && loom init && loom run
```

Smart Contracts 
---------------
Install truffle `npm install -g truffle && cd floppybird/ && npm install`
Contracts go under `smart-contracts/contracts`. To complie run `cd smart-contracts/ && truffle compile`.
To deploy contracts run `cd smart-contracts && truffle deploy --network loom_dapp_chain` make sure your loom chain is up with `loom run` command.


Payout System
---------------

Jackpot every new high score - champion is paid half the jackpot when they reach a new high score

Dividends - Every time a jackpot is awarded, each person in the top 10 leaderboard get 1% of the total pot

Amount - payout is proporsional to how much bigger your highscore is to the last? How much of total pot goes to winner each time?


Cool Stuff
---------
*Some cool things other people have done with the code. Let me know about your projects and I'll link it here*  
https://wanderingstan.github.io/handybird/ - **[@wanderinstan](https://github.com/wanderingstan)** - Real hand gestures to play Flappy Bird, using doppler effect and microphone.
http://www.hhcc.com/404 - **[Hill Holiday](http://www.hhcc.com/)** using it for their 404  
http://heart-work.se/duvchi - Floppy bird, modified, and used as a promotional campaign for an album release  
https://www.progressivewebflap.com/ - **[@jsonthor](https://twitter.com/jsonthor)** turned Floppy Bird into a PWA!
https://github.com/rukmal/FlappyLeapBird - **[Rukmal](http://rukmal.me/)** integrated LeapMotion Controller functionality! Check out his website, he's done some cool stuff.  
http://chrisbeaumont.github.io/floppybird/ - **[@chrisbeaumont](https://github.com/chrisbeaumont)** made an awesome auto-pilot, check it out  
http://www.lobe.io/flappy-math-saga/- **[@tikwid](https://github.com/tikwid)** made a really cool version designed to teach you times tables. really cool.  
http://dota2.cyborgmatt.com/flappydota/ - flappy dota, this one is really cool.  
http://tippy.gochiusa.net/ - Japanese anime inspired floppybird.  
http://emdigital.ru/wiki — floppybird on **[EyeMedia Instagram Marketing Agency](http://emdigital.ru/)** website. 
http://labs.aylien.com/flappy-bird/ - **[@mdibaiee/flappy-es](https://github.com/mdibaiee/flappy-es)** - Playing Flappy Bird using Evolution Strategies

Credits
------
**[@aregowe](https://github.com/aregowe)** for optimizing all the assets

Notice
=====
The assets powering the visual element of the game have all been extracted directly from the Flappy Bird android game. I have only done the coding, not designed the visual elements.  
I do not own the assets, nor do I have explicit permission to use them from their creator. They are the work and copyright of original creator Dong Nguyen and .GEARS games (http://www.dotgears.com/).  
I took this Tweet (https://twitter.com/dongatory/status/431060041009856512 / http://i.imgur.com/AcyWyqf.png) by Dong Nguyen, the creator of the game, as an open invitation to reuse the game concept and assets in an open source project. There is no ill intention to steal the game, or claim it as my own. This is merely a recreation for fun.  
If the copyright holder would like for the assets to be removed, let me know!


License
=====
Copyright 2014 Nebez Briefkani

Licensed under the Apache License, Version 2.0 (the "License");  
you may not use this file except in compliance with the License.  
You may obtain a copy of the License at  
http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software  
distributed under the License is distributed on an "AS IS" BASIS,  
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  
See the License for the specific language governing permissions and  
limitations under the License.

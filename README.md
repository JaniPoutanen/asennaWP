# asennaWP
Asentaa LAMP:in ja Wordpressin

Moduuli on tehty Haaga-Helia Ammattikorkeakoulun [Palvelinten Hallinta](http://terokarvinen.com/2017/aikataulu-%E2%80%93-palvelinten-hallinta-ict4tn022-2-%E2%80%93-5-op-uusi-ops-loppukevat-2017-p2) lopputyöksi.

Moduulin voi käynnistää ajamalla start.sh scriptin terminaalista. Tämän joutunee tehdä kahdesti, jotta puppet asentaa tiedostot oikeassa järjestyksessä.
Tämän jälkeen Wordpress on käytettävissä osoitteessa localhost.

Salasanat ja palvelimen osoitteet on luettavissa selkokielisenä, joten ne on syytä muuttaa jos moduulia aikoo käyttää muuten kuin testikäytössä - löytyvät tiedostoista site.pp ja wp-config.php.erb.

Lähteet: 
* https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-with-lamp-on-ubuntu-16-04
* https://www.digitalocean.com/community/tutorials/how-to-install-wordpress-on-ubuntu-14-04
* https://github.com/jk-github/asennawordpress
* http://terokarvinen.com/

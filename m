From: =?ISO-8859-1?Q?Fran=E7ois_Valenduc?= <fvalenduc-IWqWACnzNjyZIoH1IeqzKA@public.gmane.org>
Subject: Re: first shoot for smartbattery (was Re: Re: i2c-acpi-ec.c)
Date: Fri, 31 Dec 2004 19:48:53 +0100
Message-ID: <41D59F15.2030504@tiscali.be>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20041231181628.GL19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Bruno Ducrot <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: Pedro Venda <pjlv-aHmAgkVUFT6Joy8PIJZ9VA@public.gmane.org>, Mathias Weyland <mweyland-vpGm2Noi6jeZvKxeG3EEhw@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello,

Since I own a ACER Travelmate 4001 which has a smartbattery, I tried=20
this driver. Everythings works well until I try to compile=20
smartbattery.c. If I launch the gcc command like explained in the README=20
file, here is what I get:

gcc -W -Wall -O2 -o smartbattery smartbattery.c
smartbattery.c: Dans la fonction =AB main =BB:
smartbattery.c:274: attention : implicit declaration of function `ioctl'
smartbattery.c:274: error: `I2C_FUNCS' undeclared (first use in this=20
function)
smartbattery.c:274: error: (Each undeclared identifier is reported only o=
nce
smartbattery.c:274: error: for each function it appears in.)
smartbattery.c:280: error: `I2C_FUNC_SMBUS_READ_WORD_DATA' undeclared=20
(first use in this function)
smartbattery.c:290: error: `I2C_SLAVE_FORCE' undeclared (first use in=20
this function)
smartbattery.c:296: attention : implicit declaration of function=20
`i2c_smbus_read_word_data'
zsh: exit 1     gcc -W -Wall -O2 -o smartbattery smartbattery.c
19:42 root@ordi-francois /home/francois/Noyau/smartbatt# ls
acpi-ec-2.6.10.diff  i2c-acpi-ec/  README  smartbattery.c
19:42 root@ordi-francois /home/francois/Noyau/smartbatt# gcc -W -Wall=20
-O2 -o smartbattery smartbattery.c
smartbattery.c: Dans la fonction =AB main =BB:
smartbattery.c:274: attention : implicit declaration of function `ioctl'
smartbattery.c:274: error: `I2C_FUNCS' undeclared (first use in this=20
function)
smartbattery.c:274: error: (Each undeclared identifier is reported only o=
nce
smartbattery.c:274: error: for each function it appears in.)
smartbattery.c:280: error: `I2C_FUNC_SMBUS_READ_WORD_DATA' undeclared=20
(first use in this function)
smartbattery.c:290: error: `I2C_SLAVE_FORCE' undeclared (first use in=20
this function)
smartbattery.c:296: attention : implicit declaration of function=20
`i2c_smbus_read_word_data'
zsh: exit 1     gcc -W -Wall -O2 -o smartbattery smartbattery.c

Nevertheless, Thanks very much for your help in supporting=20
smartbatteries and off course, happy new year !

Bruno Ducrot a =E9crit :

>On Fri, Dec 31, 2004 at 04:07:24PM +0100, Bruno Ducrot wrote:
> =20
>
>>I'm polishing i2c-acpi-ec right now.  Stay tunned.
>>   =20
>>
>
>It's not yet really polished as I wanted, but well I don't have
>time to finish this due to, huh, ..., private stuff this night.
>
>its should give people rough idea what will happens.
>
>You can find this at http://www.poupinou.org/acpi/smartbatt/
>Take one of the smartbatt.tar.{gz,bz2} and follow the README after
>unpacking it, and hopefully a ./smartbatt will give you correct battery
>informations (who knows).
>
>happy new year!
>
> =20
>



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

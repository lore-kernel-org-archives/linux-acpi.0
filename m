From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 03 Jan 2005 17:03:47 +0000
Message-ID: <41D97AF3.7000409@arrakis.dhis.org>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050103143902.GQ19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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
Cc: Johan Vromans <jvromans-2pNSKKP3PSKEVqv0pETR8A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bruno Ducrot wrote:

| I think I found was wrong.  Please refetch, or (at your option) replace
| i2c-acpi-ec.ec with
| http://www.poupinou.org/acpi/smartbatt/smartbatt/i2c-acpi-ec/i2c-acpi-e=
c.c
| then redo the sh compile.sh
| Sorry, it was a stupid bug(tm) requiring that I buy a brown bag...

happens to everyone.

| Something wrong also with rmmod i2c-acpi-ec :( so you have to reboot in
| order to be able to 'insmod i2c-acpi-ec.ko' again (I'm sure the brown
| bag will still be helpfull also...).

yes, that still happens. appearently rmmod doesn't deregister drivers.

but now I've got it working.

no battery plugged:

archon smartbatt-2 # ./smartbattery 5
current:       65535 mA
remain:        65535 mA or mWh
time to empty: 65535 minutes
time to full:  65535 minutes
temperature:   6280.5 C
voltage:       65535 mV

all values are bogus, of course. no problem here.
now AC plugged and battery plugged too:

archon smartbatt-2 # ./smartbattery 5
current:       0 mA
remain:        3733 mA or mWh
time to empty: 65535 minutes
time to full:  65535 minutes
temperature:   25.4 C
voltage:       16787 mV
archon smartbatt-2 # ./smartbattery 5
current:       189 mA
remain:        3733 mA or mWh
time to empty: 65535 minutes
time to full:  65535 minutes
temperature:   25.6 C
voltage:       16846 mV

ok. it's draining a small amount of current, which is understandable beca=
use
it's almost full.

how can one relate the remain/time to empty/time to full values? we need =
the
maximum charge of the battery, right?

now battery plugged but no AC power:

archon smartbatt-2 # ./smartbattery 5
current:       64419 mA
remain:        3737 mA or mWh
time to empty: 200 minutes
time to full:  200 minutes
temperature:   27.4 C
voltage:       16496 mV
archon smartbatt-2 # ./smartbattery 5
current:       64423 mA
remain:        3735 mA or mWh
time to empty: 201 minutes
time to full:  201 minutes
temperature:   27.5 C
voltage:       16477 mV
archon smartbatt-2 # ./smartbattery 5
current:       64421 mA
remain:        3733 mA or mWh
time to empty: 200 minutes
time to full:  200 minutes
temperature:   27.5 C
voltage:       16461 mV

here I don't get it:
current 64419 mA? that's 64.4 A!! my dad's car battery can't do that!! is=
 it
being read wrong or am I missing something?
also, time to empty/time to full should be "xor'd" i.e., time to empty+ti=
me to
full should return total battery power (in seconds) weird yes, but it mak=
es
sense when calculating averaga power drains, trust me.

note that I'm not at all putting flaws! I'm just pointing some details th=
at I
don't know what could be regular values.

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2XrzeRy7HWZxjWERAuduAJkBABAymV3IPFwO6Xwi3AIQeYdBPQCg+qCs
QWVGOfxDEbREzIJiZAJ3RFU=3D
=3DWEIQ
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

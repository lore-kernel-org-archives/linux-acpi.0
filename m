From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Mon, 03 Jan 2005 19:50:13 +0000
Message-ID: <41D9A1F5.1060508@arrakis.dhis.org>
References: <20041231092156.GA612@phys.ethz.ch> <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D97AF3.7000409@arrakis.dhis.org> <41D98251.9020002@arrakis.dhis.org> <20050103180219.GX19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050103180219.GX19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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
| On Mon, Jan 03, 2005 at 05:35:13PM +0000, Pedro Venda wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Pedro Venda wrote:
|>| Bruno Ducrot wrote:
|>|
|>| | I think I found was wrong.  Please refetch, or (at your option) rep=
lace
|>| | i2c-acpi-ec.ec with
|>| |
|>| http://www.poupinou.org/acpi/smartbatt/smartbatt/i2c-acpi-ec/i2c-acpi=
-ec.c
|>| | then redo the sh compile.sh
|>| | Sorry, it was a stupid bug(tm) requiring that I buy a brown bag...
|>|
|>| happens to everyone.
|>|
|>| | Something wrong also with rmmod i2c-acpi-ec :( so you have to reboo=
t in
|>| | order to be able to 'insmod i2c-acpi-ec.ko' again (I'm sure the bro=
wn
|>| | bag will still be helpfull also...).
|>
|>ok I made a small patch against your most recent code base:
|
|
| Thanks.
|
|
|>included:
|>- - a Makefile for the i2c-acpi-ec module
|>- - a Makefile for the smartbattery program which also calls the
|>i2c-acpi-ec make
|>process.
|>
|>in the smartbattery directory, one just "make"s and everything gets bui=
lt.
|
|
| Ok.

another thing: I changed the current drain from "mA or mWh" to "mAh or mW=
" in
smartbattery.c but I'm having some doubts:

Are these energy or power measures?
for power measures, the units would be mA/h or mW
for energy measures, the units would be mA or mW.h

so, maybe I changed it wrong... care to comment?

|>I found out that when draining power from the battery with no AC power,=
 the
|>value returned should be added to -65535 to result in the correct value=
.
|>
|>this puzzles me, because when the battery is being used, the returned v=
alue
|>seems to be subtracted from 65535  but when the AC is plugged, it seems=
 to
|>come
|>out ok...
|
|
| Look at http://www.sbs-forum.org/specs/sbdat110.pdf
| 5.1.11. Current()
| why this happens.

thanks for pointing me at the documentation. actually I would be doing th=
at
because I have some printed information at home. But until then, I must w=
ork a
little more or else I'll never be an engineer.

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2aH1eRy7HWZxjWERAnzYAKCuThG375Tj8Mq44l1deufL4WSNOgCg2+Zy
2pNWdYHZaL+NJ/wLuODRv/I=3D
=3DQZTz
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

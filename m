From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 11 Jan 2005 10:12:43 +0000
Message-ID: <41E3A69B.2020506@arrakis.dhis.org>
References: <41D56002.5060008@mega.ist.utl.pt> <41DAB539.2020605@arrakis.dhis.org> <m2oefyzplr.fsf@phoenix.squirrel.nl> <200501101451.36702.sanskryt@op.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200501101451.36702.sanskryt-FWhLrETftxM@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: sanskryt-FWhLrETftxM@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Zdzis=B3aw A. Kaleta wrote:
| Dnia niedziela 09 stycznia 2005 14:41, Johan Vromans napisa=B3:
|
|>Pedro Venda <pjvenda-pQd4kjVL+RHfqL7NgpvPWWD2FQJk+8+b@public.gmane.org> writes:
|>
|>>I actually read some of the pdf you pointed me to and implemented a
|>>couple of functions on the smartbattery.c. It now gets much more
|>>information from the battery. If you find it relevant, I'll clean it
|>>up a bit and post a patch for you. I know it will soon be dumped,
|>>but it may show useful when debugging other driver informations.
|>
|>The attached program produces a nice battery status display using your
|>modified version of battstat. It may be temporary, but at least now I
|>have decent battery info at hand.
|>
|>-- Johan
|
| First thank to all (especially to Bruno) for moving "smart battery prob=
lem
| ahead)
| The module and smartbattery program has compiled at kernels 2.6.10 (van=
ilia
| and with the ac8, bk7, bk11 and bk12 patches)
| The effect was
| sanskryt@kender:/usr/local/download/acpi/smartbattery$ smartbattery 1
| status: charging
| current:       1957 mA
| time to full:  105 minutes
| remain:        3020 mAh
| charge state:  74%
| temperature:   35.8 C
| voltage:       16451 mV
| So it look great.
| Two problems:
| First the /dev/i2c-1 node can be read only by root. I think that the ba=
ttery
| status has to be readably for ordinary user.

the smartbattery program is just a hack to see things working. people sho=
uldn't
be using it in "production".

soon there will be an emulation driver that will allow you to use current
battery monitoring tools.

regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB46abeRy7HWZxjWERAtC7AKCUtdkb4+8LzCZ97VoyRhqgqJYgpQCfWNpd
gxA0h0lobTX1tHOJNX9OZmk=3D
=3DTyWZ
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

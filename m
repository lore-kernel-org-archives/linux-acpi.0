From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 04 Jan 2005 15:24:41 +0000
Message-ID: <41DAB539.2020605@arrakis.dhis.org>
References: <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D97AF3.7000409@arrakis.dhis.org> <41D98251.9020002@arrakis.dhis.org> <20050103180219.GX19199@poupinou.org> <41D9A1F5.1060508@arrakis.dhis.org> <20050104100844.GA19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050104100844.GA19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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
| On Mon, Jan 03, 2005 at 07:50:13PM +0000, Pedro Venda wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Bruno Ducrot wrote:
|>| On Mon, Jan 03, 2005 at 05:35:13PM +0000, Pedro Venda wrote:
|>|
|>|>-----BEGIN PGP SIGNED MESSAGE-----
|>|>Hash: SHA1
|>|>
|>|>Pedro Venda wrote:
|>|>| Bruno Ducrot wrote:
|>|>|
|>|>| | I think I found was wrong.  Please refetch, or (at your option)
|>replace
|>|>| | i2c-acpi-ec.ec with
|>|>| |
|>|>|
|>http://www.poupinou.org/acpi/smartbatt/smartbatt/i2c-acpi-ec/i2c-acpi-e=
c.c
|>|>| | then redo the sh compile.sh
|>|>| | Sorry, it was a stupid bug(tm) requiring that I buy a brown bag..=
.
|>|>|
|>|>| happens to everyone.
|>|>|
|>|>| | Something wrong also with rmmod i2c-acpi-ec :( so you have to reb=
oot
|>in
|>|>| | order to be able to 'insmod i2c-acpi-ec.ko' again (I'm sure the b=
rown
|>|>| | bag will still be helpfull also...).
|>|>
|>|>ok I made a small patch against your most recent code base:
|>|
|>|
|>| Thanks.
|>|
|>|
|>|>included:
|>|>- - a Makefile for the i2c-acpi-ec module
|>|>- - a Makefile for the smartbattery program which also calls the
|>|>i2c-acpi-ec make
|>|>process.
|>|>
|>|>in the smartbattery directory, one just "make"s and everything gets b=
uilt.
|>|
|>|
|>| Ok.
|>
|>another thing: I changed the current drain from "mA or mWh" to "mAh or =
mW"
|>in
|>smartbattery.c but I'm having some doubts:
|
|
| It's mAh or mWh, depending of the value of CAPACITY_MODE.  This is a r/=
w
| bit in BatteryMode() word (the 15th).  If this bit is clear (default),
| then it is mAh and this is current in mAh.  If this bit is set, this
| power, exprimed as 10mWh
|
| I've fixed this issue.  Hopefully it should be ok now.
|
|

thanks. I actually read some of the pdf you pointed me to and implemented=
 a
couple of functions on the smartbattery.c. It now gets much more informat=
ion
from the battery. If you find it relevant, I'll clean it up a bit and pos=
t a
patch for you. I know it will soon be dumped, but it may show useful when
debugging other driver informations.

Is it safe to change registers? I'd like to get the CAPACITY_MODE changed=
 to 1
but I'm afraid to ruin something. If I write a word into that register wi=
th the
same values previously read but OR'd with the CAPACITY_MODE bit at 1, wil=
l that
be ok?


regards,
pedro venda.
- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2rU5eRy7HWZxjWERAr+8AJ9xfxTRsJ9JRaDmc8qdThNf5MgSGACglygv
ugUwXI+hQ7pKjrc3TEoM89o=3D
=3DWmZa
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

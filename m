From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 04 Jan 2005 01:56:26 +0000
Message-ID: <41D9F7CA.7030408@arrakis.dhis.org>
References: <41D56002.5060008@mega.ist.utl.pt> <20041231150724.GK19199@poupinou.org> <20041231181628.GL19199@poupinou.org> <20050101082605.GA24896@phys.ethz.ch> <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D95CDC.8050802@phys.ethz.ch> <41D95F53.5000008@tiscali.be> <41D967B5.7040002@tiscali.be> <Pine.LNX.4.60.0501031751590.5329@frog.athome> <20050103175449.GW19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050103175449.GW19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Bruno Ducrot wrote:
| On Mon, Jan 03, 2005 at 06:02:59PM +0100, liste-9nAOAgdJVo4b1SvskN2V4Q@public.gmane.org wrote:
|
|>I did not look into the source... but usually the times are calculated:
|>You take the capacity (remain-value) and divide it by the current. As t=
he
|>ACPI-1.0 spec only asks for a current-value, if you use a
|>rechargable-battery and if this is in discharging-mode, you see, that t=
hey
|>did only, what the specs asked as a minimum.  I am not sure, if the
|>current-value would not need to be -1, if it is unknown however.
|>So it is quite clear, that dividing something (especially if this itsel=
f
|>is not zero) by zero will give you an +overflow... with MAX_UINT (65535
|>for 16bit) is the nearest representable value.
|>
|
|
| I'm much more a lazy man than that and much prefer to get those values
| from the sensor ;)
| The current is an int but it should be a short and is negative
| if discharging.  Look at smartbattery data spec at
| http://www.sbs-forum.org/specs/index.html
|
| And the 2 times given was the same actually.  It's now corrected.
|
| But as said, it's a first shot and smartbattery.c will soon be dead.
|
| Problem is: from the ASL, there is 2 Smart Batteries and a Smart Batter=
y
| Selector (or a Smart Battery Manager).
| I can go for the easy path at least for the smartbattery, since there i=
s
| already a driver for it in lm-sensors-2.9.0.

Is that driver working?

| But actually there may be more
| than one battery that can be reached at the same address, then I'm for
| sure that the smartbattery stuff from lm-sensors can not handle multipl=
e
| batteries.
|

Would the result be the creation of /proc/acpi/battery and /proc/acpi/ac_=
adapter
like other batteries?

The way I see it, the i2c-acpi-ec driver allows the creation of the /proc=
 files
so that userland programs can use them normally. Am I totally wrong and s=
hould
quickly look for the brown bag?

regards,
pedro venda.

- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB2ffKeRy7HWZxjWERAo20AKCFFcnL7TXzxYGopcccKZS6aWnJAACg+DuW
HdI0cqcta0XA+Qaw7ql16JQ=3D
=3DoyXJ
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

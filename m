From: Pedro Venda <pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org>
Subject: Re: Re: first shoot for smartbattery
Date: Tue, 11 Jan 2005 10:05:39 +0000
Message-ID: <41E3A4F3.2060508@arrakis.dhis.org>
References: <m2acrth375.fsf@phoenix.squirrel.nl> <20050103143902.GQ19199@poupinou.org> <41D95CDC.8050802@phys.ethz.ch> <41D95F53.5000008@tiscali.be> <41D967B5.7040002@tiscali.be> <Pine.LNX.4.60.0501031751590.5329@frog.athome> <20050103175449.GW19199@poupinou.org> <41D9F7CA.7030408@arrakis.dhis.org> <20050104102424.GC19199@poupinou.org> <41DAB5C7.9040605@arrakis.dhis.org> <20050106085149.GJ19199@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20050106085149.GJ19199-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
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
| On Tue, Jan 04, 2005 at 03:27:03PM +0000, Pedro Venda wrote:
|
|>-----BEGIN PGP SIGNED MESSAGE-----
|>Hash: SHA1
|>
|>Bruno Ducrot wrote:
|>|>The way I see it, the i2c-acpi-ec driver allows the creation of the /=
proc
|>|>files
|>|>so that userland programs can use them normally. Am I totally wrong a=
nd
|>|>should
|>|>quickly look for the brown bag?
|>|
|>|
|>| I would like to not touch i2c-acpi-ec for this.  It should
|>| only provide the smbus access.  All other components should be done
|>| elsewhere IMHO.
|>
|>Sorry, I didn't understand. Don't we _have_ to use the i2c-acpi-ec to q=
uery
|>and
|>write information from/to the smart battery system? If so, there is no
|>other way
|>than to use it in the ACPI driver that writes the /proc information.
|>
|
|
| i2c-acpi-ec only provide the smbus access (KISS unix way). More,
| there may be other smartbattery systems using different smbus.
| Smbus under PIIX4 for older laptop, or smbus via bios come to
| mind, though this should apply only for older laptops.
| Also, even though there is already support for apple laptops, most
| of them seems to have smartbatteries (after reading source code under
| linux), so allowing code factoring.
|
| The short term goal which is to mimic the current ACPI Control Method
| Battery in order to get compatibility with userspace program should be
| finished today or tomorrow.
|
| Cheers,
|

hi bruno,

I've been around messing with the smartbattery.c and I've come across som=
ething
I can's sort out by myself:

the battery address 0xb you hardcoded in the program (unless specified in=
 the
command line) is listed on the ACPI specification as an "example". I've r=
ead the
entire chapter 11 and didn't find how one can pinpoint the exact address =
instead
of assuming one... Am i missing something? or did you assume the standard=
 was
0xb? otherwise, how can one determine the correct address for the battery=
 or the
charger?

btw: is the smartbattery ACPI Control Method Battery driver emulator read=
y to
take on some testing? not rushing.

regards,
pedro venda.

- --

Pedro Jo=E3o Lopes Venda
email: pjvenda-pQd4kjVL+REh2FBCd0jGRA@public.gmane.org
http://arrakis.dhis.org
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB46TzeRy7HWZxjWERAn6DAKCz8Btq9ccUaq9AMn7oZt/XFgzJOACeJitG
+a0tskRiKRXV8w8mK5cAQXE=3D
=3DviBv
-----END PGP SIGNATURE-----


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt

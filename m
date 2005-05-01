From: Luca Capello <luca-wlebWZzHoyE@public.gmane.org>
Subject: Re: Re: Call for help: list of machines with working S3
Date: Sun, 01 May 2005 17:04:23 +0200
Message-ID: <8764y356o8.fsf@gismo.pca.it>
References: <20050214211105.GA12808@elf.ucw.cz>
	<200503140719.01536.lkml@kcore.org>
	<20050314080029.GF22635@elf.ucw.cz>
	<200503141539.14018.lkml@kcore.org>
Reply-To: ML ACPI-devel <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200503141539.14018.lkml-gY0FE6dpLprYtjvyW6yDsg@public.gmane.org> (Jan De Luyck's message of "Mon, 14 Mar 2005 15:39:13 +0100")
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

--=-=-=

Hello!

Sorry for the late reply, but I made some more tests before.

On Mon 14 Mar 2005 15:39 +0100, Jan De Luyck wrote:
> On Monday 14 March 2005 09:00, Pavel Machek wrote:
>> Hi!
>>
>> >   * MySQL (hinders the actual suspension process and kicks the pc back to
>> >     where it was)
>>
>> Try this patch...
>
> Works nicely. Thanks.

The same happened to me on 2.6.12-rc2, once applied the patch, but
I've been using a plain 2.6.12-rc3 for 5 days and I'm getting S3 and
S4 without any problem on an IBM ThinkPad T42p (S3 with
acpi_sleep=s3_bios, as previously reported).

So, question: is this bug completely solved? In this case, the two
bugs [1] and [2] should be closed ;-)

Thx, bye,
Gismo / Luca

[1] http://bugs.mysql.com/bug.php?id=4596
[2] http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=259745

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBCdO/8VAp7Xm10JmkRAlZOAJ9An8JYP5+8dBmPCXcmhvU2+VcmTgCfYw2D
8eBs6Bq9Bs1hF6Gn/XH7ar8=
=JaL2
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20

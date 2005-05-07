From: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Subject: Re: Resume -> higher power drain?
Date: Sat, 07 May 2005 17:51:11 +0200
Message-ID: <427CE3EF.1010005@kernelconcepts.de>
References: <427CC869.1050506@kernelconcepts.de> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <427CC869.1050506@kernelconcepts.de> <427CC9B3.7060005@gmx.net> <1115475297.10424.4.camel@localhost> <20050507144417.GA3100@isilmar.linta.de> <427CDE7B.5040306@kernelconcepts.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <427CDE7B.5040306-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Nils Faerber <nils.faerber-t93Ne7XHvje5bSeCtf/tX7NAH6kLmebB@public.gmane.org>
Cc: Dominik Brodowski <linux-X3ehHDuj6sIIGcDfoQAp7OTW4wlIGRCZ@public.gmane.org>, =?ISO-8859-15?Q?Hendr?= =?ISO-8859-15?Q?ik_J=FCrgens?= <hjuerg-ULHALamj7Vx/+Jgy1241yg@public.gmane.org>, Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005-hi6Y0CQ0nG0@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Nils Faerber wrote:
> Dominik Brodowski wrote:
>>>Also, does the bus master activity rates typically seen (check=20
>>>/proc/acpi/processor/*/power every once in a while) differ
>>>between pre-suspend and post-suspend?
> This again is interesting!
> What does this bus master activity indicate?
>=20
> Before suspend I see the CPU sporadically changing from C2 to C3 and
> back and bus master activity to have values between 00000000 and some
> higher values on activity, like 00200000 or even f0000000.
>=20
> After suspend/resume this changed!
> The CPU is now fixed at C2 and does not switch between C2 and C3.
> Also the bus master activity is ffffffff in idle state and changes to
> strange values on activity, like f7ffffff - quite different than before=
.

OK, just fixed this ;)

The problem seemed to be related to suspend/resume scripts, so to say. I
did enable vbetool to save/restore VESA state and doing vbetool post.

Using s3_bios resume this is not necessary!

And after disabling vbetool usage at all the bus master activity is back
to normal again after resume!

So at least for my T42p I can recommend NOT to use vbetool at all for
suspend/resume but rather to use s3_bios!

> Is this already the possible cause?

Pityly it was not, at least not alone.

The CPU is now cooler again, where I got around 47=B0C before the fix it
is now back to normal 42=B0C and power consumption is roughly 1W down to
18W, but still 2W more than before.

So, still 2W to fix ;)
Any further ideas?

>>>	Dominik

Many thanks so far, really good pointers!

CU
  nils faerber

- --
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
- --
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCfOPvJXeIURG1qHgRArRiAJ9AsYcjijlShoDRXoIG9cr3f+YcKgCfYznK
NLz/DjwmAzScMZ0ifac0hC0=3D
=3DYIou
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, =
4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=3D20

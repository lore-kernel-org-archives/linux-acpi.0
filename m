From: Jan Rychter <jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org>
Subject: Re: BUG: power button doesn't generate events
Date: Wed, 06 Aug 2003 19:56:43 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <m2smoep444.fsf@tnuctip.rychter.com>
References: <F760B14C9561B941B89469F59BA3A8470255EEA7@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--=-=-=
Content-Transfer-Encoding: quoted-printable

 >> From: Jan Rychter [mailto:jan-JAsPCFd0eodBDgjK7y7TUQ@public.gmane.org] I get LID button events
 >> fine, but the power button doesn't seem to generate any events
 >>
 >> Does the following bit of DSDT mean the power button should generate
 >> events?
 >>
 >> Device (PWRB) { Name (_HID, EisaId ("PNP0C0C")) Name (_PRW, Package
 >> (0x02) { 0x08, 0x04 }) Name (_STA, 0x0B)
 >> }

 Andrew> ACPI: Power Button (FF) [PWRF]

 Andrew> It looks like it is finding a fixed-feature power button before
 Andrew> the control method power button, and therefore the CM power
 Andrew> button isn't being set up. So this raises in my mind 2
 Andrew> questions:

 Andrew> 1) Why isn't the FF power button working?
 Andrew> 2) On a system with both, is the current behavior (favor FF
 Andrew>    over CM) the
 Andrew> proper behavior?

I hope these questions weren't addressed to me, because I certainly
can't answer them. I just thought a bug report might be useful. And I'd
like my power button to work some day :-)

=2D-J.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/Mb/vLth4/7/QhDoRAlK5AKC87n8TG+nPwRZqAQj2/GQRV3pmmwCeO/uu
40/vN5M/qJB+5U+Y9IYAwn4=
=eTIa
-----END PGP SIGNATURE-----
--=-=-=--


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

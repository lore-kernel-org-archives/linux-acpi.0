From: Elliott Martin <johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: syntax error, unexpected PARSEOP_IF
Date: Sat, 14 May 2005 15:20:47 -0700
Message-ID: <200505141520.55501.johnelliottmartin@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6939879.2HN0aamQcI";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

--nextPart6939879.2HN0aamQcI
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

I am trying to fix up my DSDT for my Averatec 3300 laptop and I have gotten=
=20
the ASL errors from 190 down to 1 and I don't know how to fix this last=20
error, so I thought I should ask for help.

The error from iasl is:

dsdt.dsl  3674:     If (SS1)
Error    1037 -      ^ syntax error, unexpected PARSEOP_IF

and the code surronding that line is (with line numbers):

  3651
  3652          Name (SLPS, 0x00)
  3653          Device (SLPB)
  3654          {
  3655              Name (_HID, EisaId ("PNP0C0E"))
  3656              Method (_STA, 0, NotSerialized)
  3657              {
  3658                  Return (0x0F)
  3659              }
  3660
  3661              Method (\_GPE._L1D, 0, NotSerialized)
  3662              {
  3663                  Notify (\_SB.PWRB, 0x02)
  3664              }
  3665
  3666              Name (_PRW, Package (0x02)
  3667              {
  3668                  0x1D,
  3669                  0x03
  3670              })
  3671          }
  3672      }
  3673
  3674      If (SS1)
  3675      {
  3676          Name (\_SB.PCI0._S1D, 0x02)
  3677          Name (\_SB.PCI0.P0P1._S1D, 0x02)
  3678          Name (\_SB.PCI0.USB1._S1D, 0x02)
  3679          Name (\_SB.PCI0.USB2._S1D, 0x02)
  3680          Name (\_SB.PCI0.USB3._S1D, 0x02)
  3681      }
  3682
  3683      If (SS3)
  3684      {
  3685          Name (\_SB.PCI0._S3D, 0x03)
  3686          Name (\_SB.PCI0.P0P1._S3D, 0x03)
  3687          Name (\_SB.PCI0.USB1._S3D, 0x03)
  3688          Name (\_SB.PCI0.USB2._S3D, 0x03)
  3689          Name (\_SB.PCI0.USB3._S3D, 0x03)
  3690      }
  3691

It seems like a perfectly reasonable place for an If stmt, so does anyone k=
now=20
where I should start looking?

=2DElliott

--nextPart6939879.2HN0aamQcI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBChnnHtK3f9PFhk74RAgh9AJsGUSHzYvadn1U3cLvtYChqOPKC7QCaAo1t
zbpujrd2UMya2c+00ru82dY=
=LF0X
-----END PGP SIGNATURE-----

--nextPart6939879.2HN0aamQcI--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click

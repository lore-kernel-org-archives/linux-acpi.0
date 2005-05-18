From: "Moore, Robert" <robert.moore-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: syntax error, unexpected PARSEOP_IF
Date: Wed, 18 May 2005 15:21:04 -0700
Message-ID: <971FCB6690CD0E4898387DBF7552B90E018C0AE6@orsmsx403.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-class: urn:content-classes:message
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>, Elliott Martin <johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This is the infamous "executable code at module level".  This type of
code became grammatically incorrect as of ACPI 2.0B, but we are looking
at supporting this type of legacy code.

Please send your DSDT.
Bob


> -----Original Message-----
> From: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org [mailto:acpi-devel-
> admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org] On Behalf Of Janosch Machowinski
> Sent: Saturday, May 14, 2005 4:05 PM
> To: Elliott Martin
> Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> Subject: Re: [ACPI] syntax error, unexpected PARSEOP_IF
>=20
> Elliott Martin schrieb:
> > Hello,
> >
> > I am trying to fix up my DSDT for my Averatec 3300 laptop and I have
> gotten
> > the ASL errors from 190 down to 1 and I don't know how to fix this
last
> > error, so I thought I should ask for help.
> >
> > The error from iasl is:
> >
> > dsdt.dsl  3674:     If (SS1)
> > Error    1037 -      ^ syntax error, unexpected PARSEOP_IF
> >
> > and the code surronding that line is (with line numbers):
> >
> >   3651
> >   3652          Name (SLPS, 0x00)
> >   3653          Device (SLPB)
> >   3654          {
> >   3655              Name (_HID, EisaId ("PNP0C0E"))
> >   3656              Method (_STA, 0, NotSerialized)
> >   3657              {
> >   3658                  Return (0x0F)
> >   3659              }
> >   3660
> >   3661              Method (\_GPE._L1D, 0, NotSerialized)
> >   3662              {
> >   3663                  Notify (\_SB.PWRB, 0x02)
> >   3664              }
> >   3665
> >   3666              Name (_PRW, Package (0x02)
> >   3667              {
> >   3668                  0x1D,
> >   3669                  0x03
> >   3670              })
> >   3671          }
> >   3672      }
> >   3673
> >   3674      //If (SS1)
> >   3675      //{
> >   3676          Name (\_SB.PCI0._S1D, 0x02)
> >   3677          Name (\_SB.PCI0.P0P1._S1D, 0x02)
> >   3678          Name (\_SB.PCI0.USB1._S1D, 0x02)
> >   3679          Name (\_SB.PCI0.USB2._S1D, 0x02)
> >   3680          Name (\_SB.PCI0.USB3._S1D, 0x02)
> >   3681      //}
> >   3682
> >   3683      //If (SS3)
> >   3684      //{
> >   3685          Name (\_SB.PCI0._S3D, 0x03)
> >   3686          Name (\_SB.PCI0.P0P1._S3D, 0x03)
> >   3687          Name (\_SB.PCI0.USB1._S3D, 0x03)
> >   3688          Name (\_SB.PCI0.USB2._S3D, 0x03)
> >   3689          Name (\_SB.PCI0.USB3._S3D, 0x03)
> >   3690      //}
> >   3691
> >
> > It seems like a perfectly reasonable place for an If stmt, so does
> anyone know
> > where I should start looking?
> >
> > -Elliott
>=20
> I added a few // above, that does the trick...
> But I'm not shure if this is the right way to do it.
> What exactly should SS1 and SS3 be ? I got similar constructs in
> my DSDT from an ASUS M6Ne.
>=20
>    Janosch
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by Oracle Space Sweepstakes
> Want to be the first software developer in space?
> Enter now for the Oracle Space Sweepstakes!
> http://ads.osdn.com/?ad_id=3D7393&alloc_id=3D16281&op=3Dclick
> _______________________________________________
> Acpi-devel mailing list
> Acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
> https://lists.sourceforge.net/lists/listinfo/acpi-devel


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click

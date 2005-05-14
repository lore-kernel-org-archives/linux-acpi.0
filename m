From: Janosch Machowinski <scotch-cGBD8117FJM@public.gmane.org>
Subject: Re: syntax error, unexpected PARSEOP_IF
Date: Sun, 15 May 2005 01:05:06 +0200
Message-ID: <42868422.6000101@tzi.de>
References: <200505141520.55501.johnelliottmartin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <200505141520.55501.johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Elliott Martin <johnelliottmartin-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Elliott Martin schrieb:
> Hello,
> 
> I am trying to fix up my DSDT for my Averatec 3300 laptop and I have gotten 
> the ASL errors from 190 down to 1 and I don't know how to fix this last 
> error, so I thought I should ask for help.
> 
> The error from iasl is:
> 
> dsdt.dsl  3674:     If (SS1)
> Error    1037 -      ^ syntax error, unexpected PARSEOP_IF
> 
> and the code surronding that line is (with line numbers):
> 
>   3651
>   3652          Name (SLPS, 0x00)
>   3653          Device (SLPB)
>   3654          {
>   3655              Name (_HID, EisaId ("PNP0C0E"))
>   3656              Method (_STA, 0, NotSerialized)
>   3657              {
>   3658                  Return (0x0F)
>   3659              }
>   3660
>   3661              Method (\_GPE._L1D, 0, NotSerialized)
>   3662              {
>   3663                  Notify (\_SB.PWRB, 0x02)
>   3664              }
>   3665
>   3666              Name (_PRW, Package (0x02)
>   3667              {
>   3668                  0x1D,
>   3669                  0x03
>   3670              })
>   3671          }
>   3672      }
>   3673
>   3674      //If (SS1)
>   3675      //{
>   3676          Name (\_SB.PCI0._S1D, 0x02)
>   3677          Name (\_SB.PCI0.P0P1._S1D, 0x02)
>   3678          Name (\_SB.PCI0.USB1._S1D, 0x02)
>   3679          Name (\_SB.PCI0.USB2._S1D, 0x02)
>   3680          Name (\_SB.PCI0.USB3._S1D, 0x02)
>   3681      //}
>   3682
>   3683      //If (SS3)
>   3684      //{
>   3685          Name (\_SB.PCI0._S3D, 0x03)
>   3686          Name (\_SB.PCI0.P0P1._S3D, 0x03)
>   3687          Name (\_SB.PCI0.USB1._S3D, 0x03)
>   3688          Name (\_SB.PCI0.USB2._S3D, 0x03)
>   3689          Name (\_SB.PCI0.USB3._S3D, 0x03)
>   3690      //}
>   3691
> 
> It seems like a perfectly reasonable place for an If stmt, so does anyone know 
> where I should start looking?
> 
> -Elliott

I added a few // above, that does the trick...
But I'm not shure if this is the right way to do it.
What exactly should SS1 and SS3 be ? I got similar constructs in
my DSDT from an ASUS M6Ne.

   Janosch


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click

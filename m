From: Stian Jordet <liste-NI9zH3lwcMKHXe+LvDLADg@public.gmane.org>
Subject: Re: ACPI in kernel 2.5.68 works better (for me) than 2.5.69
Date: 06 May 2003 16:15:05 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1052230504.858.1.camel@chevrolet.hybel>
References: <1052180986.1005.3.camel@chevrolet.hybel>
	 <20030506112053.GO2954@poup.poupinou.org>
	 <1052222508.5614.5.camel@chevrolet.hybel>
	 <20030506123650.GR2954@poup.poupinou.org>
	 <1052226287.646.4.camel@chevrolet.hybel>
	 <20030506133941.GS2954@poup.poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <20030506133941.GS2954-j6u/t2rXLliUoIHC/UFpr9i2O/JbrIOy@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

tir, 06.05.2003 kl. 15.39 skrev Ducrot Bruno:
> On Tue, May 06, 2003 at 03:04:48PM +0200, Stian Jordet wrote:
> > tir, 06.05.2003 kl. 14.36 skrev Ducrot Bruno:
> > > On Tue, May 06, 2003 at 02:01:48PM +0200, Stian Jordet wrote:
> > > > tir, 06.05.2003 kl. 13.20 skrev Ducrot Bruno:
> > > > > On Tue, May 06, 2003 at 02:29:46AM +0200, Stian Jordet wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > Since kernel 2.5.69, usb no longer work with acpi on my computer. With
> > > > > > 2.5.68 it did. Do you know what changes you have done might cause this?
> > > > > > 
> > > > > > I get this error, but this one is with both .68 and .69.
> > > > > > 
> > > > > > ACPI-0109: *** Error: No object was returned from
> > > > > > [\_SB_.PCI0.PX40.IRDA._STA] (Node dff5cc80), AE_NOT_EXIST
> 
> Ok...  Your ASL contain this for the \_SB_.PCI0.PX40.IRDA._STA method:
> 
>    2055                 Device (IRDA)
>    2056                 {
>    2057                     Name (_HID, EisaId ("PNP0510"))
>    2058                     Method (_STA, 0, NotSerialized)
>    2059                     {
>    2060                         ENFG ()
>    2061                         Store (0x03, LDNM)
>    2062                         If (LEqual (OPT2, Zero))
>    2063                         {
>    2064                             EXFG ()
>    2065                             Return (Zero)
>    2066                         }
>    2067 
>    2068                         GSTA (0x03)
>    2069                     }
> 
> 
> Even if the method GSTA() will return something, ACPI spec do not
> allow that _STA() will return the value from GSTA(), therefore,
> nothing is returned.  Just changing this to:
> 
>                               Return (GSTA (0x03))
> 
> will be Ok.  I don't know however if this is really important
> to do that if this is the only trouble with your asl though.

I kinda hope not, because this is way beyond what I'm able to find on 
Google. You have any pointer to a howto, so I can try this out?

Thanks for your help :) Just hope Andy will look at my other (big)
problem...

Best regards,
Stian



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com

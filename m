From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: DSDT Change (Compaq Presario 2100)
Date: Mon, 28 Jun 2004 23:34:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040628213409.GA19468@elf.ucw.cz>
References: <200405280621.29874.andre@eisenbach.com> <c9am7j$nng$1@sea.gmane.org> <200405291345.51712.andre@eisenbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200405291345.51712.andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Andre Eisenbach <andre-+hZUvIEKc2q1Z/+hSey0Gg@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Erik Meitner <usenet-cuDg6iFcrsRAfugRpC6u6w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!

> > > and errors, I stumbled across this (in method SMSL
> > >
> > > If (0x01)
> > > {
> > > 	Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
> > > 	Store ("AC remove! Set Throttle Duty Cycle ---: ", Debug)
> > > 	Store (TRDC, Debug)
> > > 	Store (0x01, TREN)
> > > }
> >
> > The DSDT for my laptop has the exact same code.
> 
> That piece of code is the state cange code (i.e. when you unplug the AC cord). 
> There is another place you need to change, which initializes the behaviour 
> when you boot with the power cable already unplugged.
> 
> The method is _REG. Here is the code
> 
>                                 Store (0x01, \_SB.PCI0.PMU.CRUN)
>                                 If (0x01)
>                                 {
>                                     Store (\_SB.PCI0.ISA.EC0.TTDC, TRDC)
>                                     Store (0x01, TREN)
>                                 }
> 
> Once again change "If (0x01)" to "If (0x00)".

Try your machine on battery, with full load. Monitor battery
temperature. If it gets hot, your battery was not really designed for
this, and forget this...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

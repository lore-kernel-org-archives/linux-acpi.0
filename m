From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Thu, 24 Jul 2003 13:00:48 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030724110048.GA312@elf.ucw.cz>
References: <20030723152809.GA591@paradigm.rfc822.org> <20030723162423.GD9013@atrey.karlin.mff.cuni.cz> <1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de> <20030724104518.GA12041@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20030724104518.GA12041-L3tpvOS5ZD2KugBFyThYrEB+6BGkLq7r@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Cc: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > Hmmm...if I understand that right its (still) the very same behaviour
> > with my Z600TEK and I remember someone else having that type of problem.
> > Now I once did some debugging and...nothing. As far as I can tell it
> > does not jump into wakeup code. I never could get any further on that.
> > Though I might have done something wrong - is there any foolproof method
> > on checking wether the system jumps to the wakeup address?
> > 
> 
> Yea - Would be my request too - Currently S3 is top on my wishlist. I
> did a lot of m68k assembly but i tryed to stay as far away from x86
> assembly as i could. So it would be nice if the more experienced ones
> would provide some #define DEBUG where we would hear interesting sounds
> or blinking keyboard leds or parallel/serial output if certain steps are
> handled successfully.

Hey, i386 assembly is not that hard, and if you are serious about
debugging S3 wakeup, you'll need to know it, anyway.

I don't remember code for beeping... To send data to the paralel port,

	movb	$0x12, %al
	movw	$0x378, %dx
	outb	%al, %dx

should do the trick (of course, you need to preserve eax/edx if they
contain something important). Beeping used to be done in case of panic
in some versions of kernel.

*And* someone actually posted patch to do beeping in acpi wakeup,
search the archives. [It would be nice if you could transform that
patch to something that could be used by #ifdef DEBUG and submitted me
a patch).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

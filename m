From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Thu, 24 Jul 2003 13:18:56 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1059045536.19684.21.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <20030723152809.GA591@paradigm.rfc822.org>
 <20030723162423.GD9013@atrey.karlin.mff.cuni.cz>
 <1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de>
 <20030724104518.GA12041@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030724104518.GA12041-L3tpvOS5ZD2KugBFyThYrEB+6BGkLq7r@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>
Cc: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Don, 2003-07-24 um 12.45 schrieb Florian Lohoff:
> Yea - Would be my request too - Currently S3 is top on my wishlist. I
> did a lot of m68k assembly but i tryed to stay as far away from x86
> assembly as i could. So it would be nice if the more experienced ones
> would provide some #define DEBUG where we would hear interesting sounds
> or blinking keyboard leds or parallel/serial output if certain steps are
> handled successfully.

I received some tips from Ole Rohne some time ago, which were:

* Insert lcall $0xffff,$0 or machin_restart in various places in    
  wakeup.S and upwards and see if your machine reboots on S3 resume
* If you have a parallel port, make a dongle with eight LEDs and trace
  your way with OUTB until it hangs

Unfortunately, none of this did anything on resume. We had some more
discussions (see archives for Ole Myren Rohne or my name or S3 vaio),
which ended up with the conclusion, that the wakeup vector does not get
called on resume. I played around with pre-suspend code a little to see
if that changes anything, but it didnt. So I stopped looking into it -
though I would be happy to have S3 running.

I think I will put up a webpage with all the information I have
collected so far. Maybe that will help someone else to track the problem
down.

-Knut




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

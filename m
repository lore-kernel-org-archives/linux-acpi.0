From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Wed, 30 Jul 2003 20:22:51 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20030730182250.GL10276@atrey.karlin.mff.cuni.cz>
References: <20030723152809.GA591@paradigm.rfc822.org> <20030723162423.GD9013@atrey.karlin.mff.cuni.cz> <1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de> <20030724104518.GA12041@paradigm.rfc822.org> <20030724110048.GA312@elf.ucw.cz> <1059588521.539.3.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1059588521.539.3.camel-bi+AKbBUZKZeoWH0uzbU5w@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Cc: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > I don't remember code for beeping... To send data to the paralel port,
> > 
> > 	movb	$0x12, %al
> > 	movw	$0x378, %dx
> > 	outb	%al, %dx
> 
> Ok. I actually got myself up and created a parallel port plug with Leds
> - works fine with test program. Nothing on resume/wakeup (I put the
> above code into first place in wakeup.S, is that supposed to work?)...so
> obviously the computers now for sure never jumps to wakeup address, so
> either somethings wrong with that wakeup address or with
> pre-jump-to-wakeup-address-stuff. Any idea?

1st try to putting this code followed by 

1:	jmp 1b

into, say, powerdown code (or maybe suspend_save_state?) to make sure
the code works as expected. Then send me diff -u wakeup.S.old
wakeup.S. You might want to add that jmp there, too. Not sure if
parport should be powered up at that point, but if not even parport is
powered, I don't know how to debug that.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.


-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

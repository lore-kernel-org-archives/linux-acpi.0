From: Knut Neumann <knut.neumann-4bfl1RV3iZDOEhgYWvzSCYQuADTiUCJX@public.gmane.org>
Subject: Re: S3 wakeup code
Date: Thu, 24 Jul 2003 12:18:09 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <1059041888.19684.8.camel@bacchus.gpphy.uni-duesseldorf.de>
References: <20030723152809.GA591@paradigm.rfc822.org>
 <20030723162423.GD9013@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7BIT
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-reply-to: <20030723162423.GD9013-jyMamyUUXNJG4ohzP4jBZS1Fcj925eT/@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Cc: Florian Lohoff <flo-BCn6idZOOBwdnm+yROfE0A@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Am Mit, 2003-07-23 um 18.24 schrieb Pavel Machek:
> > i just tried 2.6.0-test1 and to my expectation the S3 resume stuff still
> > does not work on the Sony Vaio PCG-C1MHP aka Picturebook. It turns on -
> > Bios set the powerled correct but then - nothing - Nothing on the
> > screen, no backlight, no disk activity.

Hmmm...if I understand that right its (still) the very same behaviour
with my Z600TEK and I remember someone else having that type of problem.
Now I once did some debugging and...nothing. As far as I can tell it
does not jump into wakeup code. I never could get any further on that.
Though I might have done something wrong - is there any foolproof method
on checking wether the system jumps to the wakeup address?

-Knut

>  
> > Is there any way to dump the Windows wakeup code ? 
> > Is that machine specific ?
> 
> Wakeup code should *not* be machine-specific, but video card
> save/restore is obviously video-card specific (and you basically can't
> get docs). Write beeping code in 8086 assembly and start debuggin'
> ;-))).
> 
> 								Pavel





-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

From: Brad Parker <brad-2nKKSigPee+ibv+y4V69FXNtEUiqdi9I@public.gmane.org>
Subject: Re: 2.5.34?
Date: Wed, 18 Sep 2002 08:24:23 -0400
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <200209181224.g8ICONr31147@p2.parker.boston.ma.us>
References: <pavel@suse.cz>
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: Message from Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
   of "Tue, 17 Sep 2002 15:51:47 -0000." <20020917155146.F39-muQmgwBScQHrBKCeMvbIDA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=acpi-devel>
To: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org


Pavel Machek wrote:
>
>No. S3 wakeup is completely different from S4 wakeup.

Really?  I thought they both used the same "wakeup vector" and hence
used the pre-_WAK code path.  Perhaps I am mistaken.

>And bothworked for me in 2.5.32 IIRC.

ok, thanks.  That's actually the first time anyone has said that clearly.

(your previous email was somewhat vague about S3 working - it didn't
actually state that it was working and when)

>Look at acpi_wakeup.S. If your mode is in  text VGA you can just write
>to videoram. Maybe code to do that is still there?

The problem is that the backlight is not on, and it's not clear the
vga controller is turned on.  This code runs before _WAK (which I think
is what turns on the backlight)

I'll try it, however, as it's a reasonable suggestion.  thanks!

-brad


-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab

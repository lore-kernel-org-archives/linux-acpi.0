From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Kernel 2.6-test10 and /sys/power/state on Thinkpad R32
Date: Mon, 1 Dec 2003 21:13:29 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031201201329.GA206@elf.ucw.cz>
References: <1069851924.3708.4.camel@hogfather.northernmaniacs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1069851924.3708.4.camel-fpKYWrq5g0ViPMq5F3FOwhQI7fTEVXXPmpATvIKMPHk@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stephan Herhut <sah-jNDFPZUTrfRKC+uPiMyuuyYxWCU7E+c1@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> I gave kernel 2.6-test10 a try to test the long-awaited suspend to
> ram/disk. I am using fedora core 1 on a ThinkPad R32 with the newest
> BIOS available. Everythings works fine, except suspending my thinkpad.
> 
> echo {ram|disk} > /sys/power/state
> 
> just yields a Preparing for suspend kernel message and afterwards
> nothing happens. I can even retry as often as I want to, always only
> producing this message.
> 
> I use the current kernel rpm from people.radhat.com/arjanv.
> 
> Anyone something to try or is this already known?

Try echo 4 > /proc/acpi/sleep on vanilla kernel.
								Pavel



-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

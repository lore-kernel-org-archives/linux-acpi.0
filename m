From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Resume from suspend-to-ram (radeon)
Date: Tue, 20 Apr 2004 12:17:20 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040420101720.GA2314@elf.ucw.cz>
References: <c15rn0$5bu$2@sea.gmane.org> <20040223074227.80AE57831D@mail.lmc.cs.sunysb.edu> <406ABD4A.10408@pca.it> <200404021524.46611.stefandoesinger@gmx.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200404021524.46611.stefandoesinger-RbZlAiThDcE@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Stefan =?iso-8859-1?Q?D=F6singer?= <stefandoesinger-RbZlAiThDcE@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Luca Capello <luca-wlebWZzHoyE@public.gmane.org>, Giridhar Pemmasani <giri-IxWJ8JVbGpr5NRxSJurNR4dd74u8MsAO@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Hi!
> > > New radeonfb suspend/resume code turns the LCD on but the system hangs
> > > during fb resume. With the changes I made, the LCD turns on but the
> > > screen remains blank. X with int10 POST restores the screen properly.
> The radeonfb resume does not crash, but when fbcon is loaded something fails. 
> Compile radeonfb(original version, 2.6.4 kernel) and frame buffer console as 
> modules, disable video mode selection support and load only radeonfb(NOT 
> fbcon) and the system will resume with backlight on and a black screen. At 
> least my device does in single user mode.
> 
> I use plain text console and X with int10 POST patch. This gives me the 
> console back when resuming(X has to soft-boot the V-Bios).

Perhaps some hints how to do this should be added to
Documentation/power/video.txt?

									Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

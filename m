From: Pavel Machek <pavel-+ZI9xUNit7I@public.gmane.org>
Subject: Re: Re: [Swsusp-devel] swsusp and ac status
Date: Wed, 30 Jun 2004 21:40:13 +0200
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040630194013.GD12631@elf.ucw.cz>
References: <20040628202549.GI698@openzaurus.ucw.cz> <200406301539.i5UFdUWt011300@fermat.unipv.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200406301539.i5UFdUWt011300-xzhXYMPkGmXoPXhRcRtihA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Daniele Boffi <boffi-piYtxHxN1XRAly3Pu9w1wA@public.gmane.org>, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> > This is known, and can be properly fixed by entering S4 (not S5;
> > during swsusp. Some more hacky solutions are available, too.
> > Get 2.6.7-vanilla and ask me for testing patch... 
> 
> Yes, please. I find swsusp2 more reliable than pm-suspend and would 
> like to have it work correctly.

Here it is. Its for swsusp1, you'll have to port it to swsusp2
yourself. And its little... "interesting".
							Pavel

Index: linux/kernel/power/swsusp.c
===================================================================
--- linux.orig/kernel/power/swsusp.c	2004-06-22 12:53:19.000000000 +0200
+++ linux/kernel/power/swsusp.c	2004-06-27 18:25:28.000000000 +0200
@@ -750,6 +759,11 @@
 	update_screen(fg_console);
 	release_console_sem();
 #endif
+
+#ifdef CONFIG_ACPI_SLEEP
+	acpi_leave_sleep_state(5);	/* This is "interesting". We need to call _WAK due to HP nx5000,
+					   but we really should make this normal S4 support. */
+#endif
 }
 
 /* do_magic() is implemented in arch/?/kernel/suspend_asm.S, and basically does:



-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com

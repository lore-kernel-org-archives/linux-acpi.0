From: Willy Tarreau <willy-tRhHnHjXm5DYtjvyW6yDsg@public.gmane.org>
Subject: [PATCH] fix ACPI poweroff in 2.4.25-rc2
Date: Sun, 15 Feb 2004 11:40:16 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040215104016.GA22576@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Cc: marcelo.tosatti-3EexvZdKGZQ39yzSjRtAkw@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Len,

based on your suggestions, I've read several bug reports about poweroff
problems. I discovered that some people had to pass "nolapic" to make it
operational. I tried the same on my VAIO and it worked. I also found that
other people had to call the old acpi_suspend(ACPI_STATE_S5) code instead
of the new one in acpi_power_off().

So I compared acpi_suspend() with the new code, and noticed that acpi_suspend()
calls acpi_system_save_state() before doing acpi_enter_sleep_state_prep(). This
function is responsible for sending PM events to all system devices, it seems.
Thus, I inserted this call in acpi_poweroff() and it now works (on the VAIO
at least). Does it make sense ? I have yet to test it on other systems, but
if people with poweroff problems could try this patch on top of 2.4.25-rc2,
it would be interesting. Perhaps it could get its way into mainline before
2.4.25 ? Please note that with this one, it's no longer necessary to use
"nolapic" on the command line (for my notebook at least).

Regards,
Willy

--- linux-2.4.25-rc2/drivers/acpi/system.c	Wed Nov 19 15:31:22 2003
+++ linux-2.4.25-rc2-acpi/drivers/acpi/system.c	Sun Feb 15 11:38:17 2004
@@ -95,6 +95,7 @@
 {
 	if (unlikely(in_interrupt())) 
 		BUG();
+	acpi_system_save_state(ACPI_STATE_S5);
 	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
 	ACPI_DISABLE_IRQS();
 	acpi_enter_sleep_state(ACPI_STATE_S5);



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click

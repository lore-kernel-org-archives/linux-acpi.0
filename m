From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: Re: ACPI Poweroff fails on HP OmniBook 500
Date: Fri, 31 Oct 2003 12:09:05 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031031110905.GA21970@poupinou.org>
References: <20031029020636.GF29465@bostoncoop.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20031029020636.GF29465-/J5p37YCQWYytDrLOV7HaA@public.gmane.org>
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Adam Kessel <adam-/J5p37YCQWYytDrLOV7HaA@public.gmane.org>
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 28, 2003 at 09:06:36PM -0500, Adam Kessel wrote:
> I posted this recently to lkml, but got no response, so I thought I would
> report it here as well.[1]
> 
> In 2.4.22-rc2, ACPI poweroff worked fine on the HP OmniBook.
> 
> Since 2.4.22, all the way up to 2.4.23-pre8, the system fails to
> shutdown--the process gets to "power off" and hangs there. It is
> necessary to do a hard shut down to turn the system off.
> 
> There is no problem with rebooting.
> 
> Apparently this effects a number of HP laptops, although I have only
> verified it on the OmniBook 500.[2]
> 
> This problem is not present in 2.6.0-test9.
> 
> I am using force=acpi as required since I have an older BIOS.  Apparently

You mean acpi=force, correct?

> the problem occurs in OmniBook laptops they have newer BIOSes as well.
> 
> I expect this is related to the Sony VAIO problem discussed this month on
> this list as well.[3]

Could you please test this patch?
The problem being that we power down some devices twice.

--- linux-2.4.23-pre9/drivers/acpi/system.c	2003/10/31 08:09:10	1.1
+++ linux-2.4.23-pre9/drivers/acpi/system.c	2003/10/31 10:36:35
@@ -31,6 +31,7 @@
 #include <linux/spinlock.h>
 #include <linux/poll.h>
 #include <linux/delay.h>
+#include <linux/interrupt.h>
 #include <linux/sysrq.h>
 #include <linux/compatmac.h>
 #include <linux/proc_fs.h>
@@ -92,7 +93,13 @@
 static void
 acpi_power_off (void)
 {
-	acpi_suspend(ACPI_STATE_S5);
+	if (unlikely(in_interrupt())) 
+		BUG();
+	acpi_enter_sleep_state_prep(ACPI_STATE_S5);
+	ACPI_DISABLE_IRQS();
+	acpi_enter_sleep_state(ACPI_STATE_S5);
+
+	printk(KERN_EMERG "ACPI: can not power off machine\n");
 }
 
 #endif /*CONFIG_PM*/

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

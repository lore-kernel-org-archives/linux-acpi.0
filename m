From: Ducrot Bruno <ducrot-kk6yZipjEM5g9hUCZPvPmw@public.gmane.org>
Subject: [PATCH]  Fix acpi_power_off().
Date: Wed, 5 Nov 2003 15:47:00 +0100
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20031105144700.GW21970@poupinou.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: "Brown, Len" <len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: ACPI Developers <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, linux-acpi <linux-acpi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org


Hi Len,

I think 2.4 apci_power_off() is bugged.  When the machine
receive an halt request, it does already all the necessary
work for power down all devices, yet the current acpci_power_off()
will redo that.  Unfortunately, it seems that some devices do not
like this (at least, on some ide hwif imho).

Please, consider.

 drivers/acpi/system.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletion(-)

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


Cheers,

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/

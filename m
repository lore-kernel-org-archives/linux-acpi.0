From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
Subject: [PATCH] -mm: acpi idle __read_mostly and de-init static var
Date: Tue, 18 Apr 2006 21:00:45 +0200
Message-ID: <20060418190045.GA25749@rhlx01.fht-esslingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rhlx01.fht-esslingen.de ([129.143.116.10]:20874 "EHLO
	rhlx01.fht-esslingen.de") by vger.kernel.org with ESMTP
	id S932283AbWDRTAr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Apr 2006 15:00:47 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-acpi@vger.kernel.org, Dominik Brodowski <linux@dominikbrodowski.net>, linux-kernel@vger.kernel.org

Hello all,

- make pm_idle_save, nocst and bm_history __read_mostly
- static first_run is initialized to 0 by default already
- don't remove static init value of nocst and bm_history
  since __read_mostly may be special
  (see e.g. http://www.ussg.iu.edu/hypermail/linux/kernel/0010.0/0771.html)

Patch tested on 2.6.17-rc1-mm2, rediffed against 2.6.17-rc1-mm3.

Signed-off-by: Andreas Mohr <andi@lisas.de>


diff -urN linux-2.6.17-rc1-mm3.orig/drivers/acpi/processor_idle.c linux-2.6.17-rc1-mm3/drivers/acpi/processor_idle.c
--- linux-2.6.17-rc1-mm3.orig/drivers/acpi/processor_idle.c	2006-04-18 20:06:57.000000000 +0200
+++ linux-2.6.17-rc1-mm3/drivers/acpi/processor_idle.c	2006-04-18 20:11:16.000000000 +0200
@@ -54,10 +54,10 @@
 #define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
 #define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 #define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
-static void (*pm_idle_save) (void);
+static void (*pm_idle_save) (void) __read_mostly;
 module_param(max_cstate, uint, 0644);
 
-static unsigned int nocst = 0;
+static unsigned int nocst __read_mostly = 0;
 module_param(nocst, uint, 0000);
 
 /*
@@ -67,7 +67,7 @@
  * 100 HZ: 0x0000000F: 4 jiffies = 40ms
  * reduce history for more aggressive entry into C3
  */
-static unsigned int bm_history =
+static unsigned int bm_history __read_mostly =
     (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
 module_param(bm_history, uint, 0644);
 /* --------------------------------------------------------------------------
@@ -1088,7 +1088,7 @@
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;
-	static int first_run = 0;
+	static int first_run; /* static: = 0 */
 	struct proc_dir_entry *entry = NULL;
 	unsigned int i;
 

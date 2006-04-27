From: akpm@osdl.org
Subject: [patch 15/16] acpi idle __read_mostly and de-init static var
Date: Thu, 27 Apr 2006 02:25:15 -0700
Message-ID: <200604270926.k3R9Qhai025114@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:51405 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965013AbWD0J0x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 27 Apr 2006 05:26:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: len.brown@intel.com
Cc: linux-acpi@vger.kernel.org, akpm@osdl.org, andi@rhlx01.fht-esslingen.de, andi@lisas.de


From: Andreas Mohr <andi@rhlx01.fht-esslingen.de>

- make pm_idle_save, nocst and bm_history __read_mostly
- static first_run is initialized to 0 by default already
- don't remove static init value of nocst and bm_history
  since __read_mostly may be special
  (see e.g. http://www.ussg.iu.edu/hypermail/linux/kernel/0010.0/0771.html)

Signed-off-by: Andreas Mohr <andi@lisas.de>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-idle-__read_mostly-and-de-init-static-var drivers/acpi/processor_idle.c
--- devel/drivers/acpi/processor_idle.c~acpi-idle-__read_mostly-and-de-init-static-var	2006-04-18 23:18:01.000000000 -0700
+++ devel-akpm/drivers/acpi/processor_idle.c	2006-04-18 23:18:01.000000000 -0700
@@ -54,10 +54,10 @@ ACPI_MODULE_NAME("acpi_processor")
 #define US_TO_PM_TIMER_TICKS(t)		((t * (PM_TIMER_FREQUENCY/1000)) / 1000)
 #define C2_OVERHEAD			4	/* 1us (3.579 ticks per us) */
 #define C3_OVERHEAD			4	/* 1us (3.579 ticks per us) */
-static void (*pm_idle_save) (void);
+static void (*pm_idle_save) (void) __read_mostly;
 module_param(max_cstate, uint, 0644);
 
-static unsigned int nocst = 0;
+static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
 
 /*
@@ -67,7 +67,7 @@ module_param(nocst, uint, 0000);
  * 100 HZ: 0x0000000F: 4 jiffies = 40ms
  * reduce history for more aggressive entry into C3
  */
-static unsigned int bm_history =
+static unsigned int bm_history __read_mostly =
     (HZ >= 800 ? 0xFFFFFFFF : ((1U << (HZ / 25)) - 1));
 module_param(bm_history, uint, 0644);
 /* --------------------------------------------------------------------------
@@ -1079,7 +1079,7 @@ int acpi_processor_power_init(struct acp
 			      struct acpi_device *device)
 {
 	acpi_status status = 0;
-	static int first_run = 0;
+	static int first_run;
 	struct proc_dir_entry *entry = NULL;
 	unsigned int i;
 
_

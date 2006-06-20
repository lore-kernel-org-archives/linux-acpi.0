From: akpm@osdl.org
Subject: + acpi-c-states-bm_activity-improvements.patch added to -mm tree
Date: Tue, 20 Jun 2006 00:49:08 -0700
Message-ID: <200606200749.k5K7n8Wu000430@shell0.pdx.osdl.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:50057 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965132AbWFTHtM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 20 Jun 2006 03:49:12 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: mm-commits@vger.kernel.org
Cc: linux@dominikbrodowski.net, linux-acpi@vger.kernel.org


The patch titled

     ACPI C-States: bm_activity improvements

has been added to the -mm tree.  Its filename is

     acpi-c-states-bm_activity-improvements.patch

See http://www.zip.com.au/~akpm/linux/patches/stuff/added-to-mm.txt to find
out what to do about this

------------------------------------------------------
Subject: ACPI C-States: bm_activity improvements
From: Dominik Brodowski <linux@dominikbrodowski.net>


Do not assume there was bus mastering activity if the idle handler didn't get
called, as there's only reason to not enter C3-type sleep if there is bus
master activity going on.  Only for the "promotion" into C3-type sleep bus
mastering activity is taken into account, and there only current bus mastering
activity, and not pure guessing should lead to the decision on whether to
enter C3-type sleep or not.

Also, as bm_activity is a jiffy-based bitmask (bit 0: bus mastering activity
during this juffy, bit 31: bus mastering activity 31 jiffies ago), fix the
setting of bit 0, as it might be called multiple times within one jiffy.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: <linux-acpi@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 drivers/acpi/processor_idle.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff -puN drivers/acpi/processor_idle.c~acpi-c-states-bm_activity-improvements drivers/acpi/processor_idle.c
--- a/drivers/acpi/processor_idle.c~acpi-c-states-bm_activity-improvements
+++ a/drivers/acpi/processor_idle.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
+ *  Copyright (C) 2004, 2005 Dominik Brodowski <linux@brodo.de>
  *  Copyright (C) 2004  Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
  *  			- Added processor hotplug support
  *  Copyright (C) 2005  Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
@@ -264,21 +264,15 @@ static void acpi_processor_idle(void)
 		u32 bm_status = 0;
 		unsigned long diff = jiffies - pr->power.bm_check_timestamp;
 
-		if (diff > 32)
-			diff = 32;
+		if (diff > 31)
+			diff = 31;
 
-		while (diff) {
-			/* if we didn't get called, assume there was busmaster activity */
-			diff--;
-			if (diff)
-				pr->power.bm_activity |= 0x1;
-			pr->power.bm_activity <<= 1;
-		}
+		pr->power.bm_activity <<= diff;
 
 		acpi_get_register(ACPI_BITREG_BUS_MASTER_STATUS,
 				  &bm_status, ACPI_MTX_DO_NOT_LOCK);
 		if (bm_status) {
-			pr->power.bm_activity++;
+			pr->power.bm_activity |= 0x1;
 			acpi_set_register(ACPI_BITREG_BUS_MASTER_STATUS,
 					  1, ACPI_MTX_DO_NOT_LOCK);
 		}
@@ -290,7 +284,7 @@ static void acpi_processor_idle(void)
 		else if (errata.piix4.bmisx) {
 			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
 			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity++;
+				pr->power.bm_activity |= 0x1;
 		}
 
 		pr->power.bm_check_timestamp = jiffies;
_

Patches currently in -mm which might be from linux@dominikbrodowski.net are

acpi-c-states-accounting-of-sleep-states.patch
acpi-c-states-bm_activity-improvements.patch
acpi-c-states-only-demote-on-current-bus-mastering-activity.patch
git-cpufreq.patch
git-pcmcia.patch
com20020_cs-more-device-support.patch
kill-open-coded-offsetof-in-cm4000_csc-zero_dev.patch
insert-identical-resources-above-existing-resources.patch
make-sure-nobodys-leaking-resources.patch
random-remove-bogus-sa_sample_random-from-at91-compact-flash-driver.patch


From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: [PATCH] ACPI C-States: bm_activity improvements
Date: Thu, 13 Apr 2006 22:22:06 +0200
Message-ID: <20060413202206.GB7522@dominikbrodowski.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from isilmar.linta.de ([213.239.214.66]:49365 "EHLO linta.de")
	by vger.kernel.org with ESMTP id S932460AbWDMUWT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 13 Apr 2006 16:22:19 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, len.brown@intel.com

Do not assume there was bus mastering activity if the idle handler didn't
get called, as there's only reason to not enter C3-type sleep if there is
bus master activity going on. Only for the "promotion" into C3-type sleep
bus mastering activity is taken into account, and there only current bus
mastering activity, and not pure guessing should lead to the decision on
whether to enter C3-type sleep or not.

Also, as bm_activity is a jiffy-based bitmask (bit 0: bus mastering activity
during this juffy, bit 31: bus mastering activity 31 jiffies ago), fix the
setting of bit 0, as it might be called multiple times within one jiffy.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>

---

 drivers/acpi/processor_idle.c |   18 ++++++------------
 1 files changed, 6 insertions(+), 12 deletions(-)

2e1b29fabc1085e1ab5b05dcac5d59e82c633668
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 4f166fa..29470e1 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -3,7 +3,7 @@
  *
  *  Copyright (C) 2001, 2002 Andy Grover <andrew.grover@intel.com>
  *  Copyright (C) 2001, 2002 Paul Diefenbaugh <paul.s.diefenbaugh@intel.com>
- *  Copyright (C) 2004       Dominik Brodowski <linux@brodo.de>
+ *  Copyright (C) 2004, 2005 Dominik Brodowski <linux@brodo.de>
  *  Copyright (C) 2004  Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
  *  			- Added processor hotplug support
  *  Copyright (C) 2005  Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
@@ -261,21 +261,15 @@ static void acpi_processor_idle(void)
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
@@ -287,7 +281,7 @@ static void acpi_processor_idle(void)
 		else if (errata.piix4.bmisx) {
 			if ((inb_p(errata.piix4.bmisx + 0x02) & 0x01)
 			    || (inb_p(errata.piix4.bmisx + 0x0A) & 0x01))
-				pr->power.bm_activity++;
+				pr->power.bm_activity |= 0x1;
 		}
 
 		pr->power.bm_check_timestamp = jiffies;
-- 
1.2.4


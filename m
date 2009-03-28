From: Len Brown <lenb@kernel.org>
Subject: [PATCH 27/98] ACPICA: Remove redundant ACPI_BITREG_SLEEP_TYPE_B
Date: Sat, 28 Mar 2009 00:31:02 -0400
Message-ID: <82d79b86646504a0ab97fe50ac137df65f651a27.1238214618.git.len.brown@intel.com>
References: <1238214733-8285-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:49538 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751620AbZC1Eck (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 28 Mar 2009 00:32:40 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KH700K9G8MD4KJD@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 27 Mar 2009 23:32:38 -0500 (CDT)
In-reply-to: <1238214733-8285-1-git-send-email-lenb@kernel.org>
In-reply-to: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
References: <6503e5df08008b9a47022b5e9ebba658c8fa69af.1238214617.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Bob Moore <robert.moore@intel.com>, Lin Ming <ming.m.lin@intel.com>, Len Brown <len.brown@intel.com>

From: Bob Moore <robert.moore@intel.com>

This type is the same as TYPE_A. Removed this and all related
instances.  Renamed SLEEP_TYPE_A to simply SLEEP_TYPE.
ACPICA BZ 754.

http://www.acpica.org/bugzilla/show_bug.cgi?id=754

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/acpica/aclocal.h  |    4 ++--
 drivers/acpi/acpica/hwsleep.c  |    4 ++--
 drivers/acpi/acpica/utglobal.c |    9 +++------
 include/acpi/actypes.h         |    9 ++++-----
 4 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/acpica/aclocal.h b/drivers/acpi/acpica/aclocal.h
index 492d027..b9a0aa6 100644
--- a/drivers/acpi/acpica/aclocal.h
+++ b/drivers/acpi/acpica/aclocal.h
@@ -818,7 +818,7 @@ struct acpi_bit_register_info {
 #define ACPI_BITMASK_SCI_ENABLE                 0x0001
 #define ACPI_BITMASK_BUS_MASTER_RLD             0x0002
 #define ACPI_BITMASK_GLOBAL_LOCK_RELEASE        0x0004
-#define ACPI_BITMASK_SLEEP_TYPE_X               0x1C00
+#define ACPI_BITMASK_SLEEP_TYPE                 0x1C00
 #define ACPI_BITMASK_SLEEP_ENABLE               0x2000
 
 #define ACPI_BITMASK_ARB_DISABLE                0x0001
@@ -844,7 +844,7 @@ struct acpi_bit_register_info {
 #define ACPI_BITPOSITION_SCI_ENABLE             0x00
 #define ACPI_BITPOSITION_BUS_MASTER_RLD         0x01
 #define ACPI_BITPOSITION_GLOBAL_LOCK_RELEASE    0x02
-#define ACPI_BITPOSITION_SLEEP_TYPE_X           0x0A
+#define ACPI_BITPOSITION_SLEEP_TYPE             0x0A
 #define ACPI_BITPOSITION_SLEEP_ENABLE           0x0D
 
 #define ACPI_BITPOSITION_ARB_DISABLE            0x00
diff --git a/drivers/acpi/acpica/hwsleep.c b/drivers/acpi/acpica/hwsleep.c
index a2af2a4..1a7d260 100644
--- a/drivers/acpi/acpica/hwsleep.c
+++ b/drivers/acpi/acpica/hwsleep.c
@@ -242,7 +242,7 @@ acpi_status asmlinkage acpi_enter_sleep_state(u8 sleep_state)
 	}
 
 	sleep_type_reg_info =
-	    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_TYPE_A);
+	    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_TYPE);
 	sleep_enable_reg_info =
 	    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_ENABLE);
 
@@ -486,7 +486,7 @@ acpi_status acpi_leave_sleep_state_prep(u8 sleep_state)
 					  &acpi_gbl_sleep_type_b);
 	if (ACPI_SUCCESS(status)) {
 		sleep_type_reg_info =
-		    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_TYPE_A);
+		    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_TYPE);
 		sleep_enable_reg_info =
 		    acpi_hw_get_bit_register_info(ACPI_BITREG_SLEEP_ENABLE);
 
diff --git a/drivers/acpi/acpica/utglobal.c b/drivers/acpi/acpica/utglobal.c
index a3ab9d9..bec0e21 100644
--- a/drivers/acpi/acpica/utglobal.c
+++ b/drivers/acpi/acpica/utglobal.c
@@ -294,12 +294,9 @@ struct acpi_bit_register_info acpi_gbl_bit_register_info[ACPI_NUM_BITREG] = {
 	/* ACPI_BITREG_GLOBAL_LOCK_RELEASE  */ {ACPI_REGISTER_PM1_CONTROL,
 						ACPI_BITPOSITION_GLOBAL_LOCK_RELEASE,
 						ACPI_BITMASK_GLOBAL_LOCK_RELEASE},
-	/* ACPI_BITREG_SLEEP_TYPE_A         */ {ACPI_REGISTER_PM1_CONTROL,
-						ACPI_BITPOSITION_SLEEP_TYPE_X,
-						ACPI_BITMASK_SLEEP_TYPE_X},
-	/* ACPI_BITREG_SLEEP_TYPE_B         */ {ACPI_REGISTER_PM1_CONTROL,
-						ACPI_BITPOSITION_SLEEP_TYPE_X,
-						ACPI_BITMASK_SLEEP_TYPE_X},
+	/* ACPI_BITREG_SLEEP_TYPE           */ {ACPI_REGISTER_PM1_CONTROL,
+						ACPI_BITPOSITION_SLEEP_TYPE,
+						ACPI_BITMASK_SLEEP_TYPE},
 	/* ACPI_BITREG_SLEEP_ENABLE         */ {ACPI_REGISTER_PM1_CONTROL,
 						ACPI_BITPOSITION_SLEEP_ENABLE,
 						ACPI_BITMASK_SLEEP_ENABLE},
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index a20aab5..1b9601c 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -777,15 +777,14 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_BITREG_SCI_ENABLE                  0x0E
 #define ACPI_BITREG_BUS_MASTER_RLD              0x0F
 #define ACPI_BITREG_GLOBAL_LOCK_RELEASE         0x10
-#define ACPI_BITREG_SLEEP_TYPE_A                0x11
-#define ACPI_BITREG_SLEEP_TYPE_B                0x12
-#define ACPI_BITREG_SLEEP_ENABLE                0x13
+#define ACPI_BITREG_SLEEP_TYPE                  0x11
+#define ACPI_BITREG_SLEEP_ENABLE                0x12
 
 /* PM2 Control register */
 
-#define ACPI_BITREG_ARB_DISABLE                 0x14
+#define ACPI_BITREG_ARB_DISABLE                 0x13
 
-#define ACPI_BITREG_MAX                         0x14
+#define ACPI_BITREG_MAX                         0x13
 #define ACPI_NUM_BITREG                         ACPI_BITREG_MAX + 1
 
 /*
-- 
1.6.0.6


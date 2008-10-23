From: Len Brown <lenb@kernel.org>
Subject: [PATCH 109/122] ACPICA: Remove unused ACPI register bit definition
Date: Thu, 23 Oct 2008 02:39:23 -0400
Message-ID: <bbbbeb8e31af97f11b84294b2e7e5607125829d2.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:58094 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755468AbYJWGki (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:38 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9600K57IJ8RW32@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:20 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Lin Ming <ming.m.lin@intel.com>, Bob Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>

From: Lin Ming <ming.m.lin@intel.com>

Removed the ACPI_BITREG_WAKE_ENABLE definition and entry in the
global register table. This bit does not exist and is unused.

http://www.acpica.org/bugzilla/show_bug.cgi?id=442

Signed-off-by: Lin Ming <ming.m.lin@intel.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/utilities/utglobal.c |    1 -
 include/acpi/actypes.h            |   34 +++++++++++++++++++++++-----------
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/drivers/acpi/utilities/utglobal.c b/drivers/acpi/utilities/utglobal.c
index 0b1e493..670551b 100644
--- a/drivers/acpi/utilities/utglobal.c
+++ b/drivers/acpi/utilities/utglobal.c
@@ -281,7 +281,6 @@ struct acpi_bit_register_info acpi_gbl_bit_register_info[ACPI_NUM_BITREG] = {
 	/* ACPI_BITREG_RT_CLOCK_ENABLE      */ {ACPI_REGISTER_PM1_ENABLE,
 						ACPI_BITPOSITION_RT_CLOCK_ENABLE,
 						ACPI_BITMASK_RT_CLOCK_ENABLE},
-	/* ACPI_BITREG_WAKE_ENABLE          */ {ACPI_REGISTER_PM1_ENABLE, 0, 0},
 	/* ACPI_BITREG_PCIEXP_WAKE_DISABLE  */ {ACPI_REGISTER_PM1_ENABLE,
 						ACPI_BITPOSITION_PCIEXP_WAKE_DISABLE,
 						ACPI_BITMASK_PCIEXP_WAKE_DISABLE},
diff --git a/include/acpi/actypes.h b/include/acpi/actypes.h
index 6bd08e8..e8936ab 100644
--- a/include/acpi/actypes.h
+++ b/include/acpi/actypes.h
@@ -607,8 +607,15 @@ typedef u8 acpi_adr_space_type;
 
 /*
  * bit_register IDs
- * These are bitfields defined within the full ACPI registers
+ *
+ * These values are intended to be used by the hardware interfaces
+ * and are mapped to individual bitfields defined within the ACPI
+ * registers. See the acpi_gbl_bit_register_info global table in utglobal.c
+ * for this mapping.
  */
+
+/* PM1 Status register */
+
 #define ACPI_BITREG_TIMER_STATUS                0x00
 #define ACPI_BITREG_BUS_MASTER_STATUS           0x01
 #define ACPI_BITREG_GLOBAL_LOCK_STATUS          0x02
@@ -618,24 +625,29 @@ typedef u8 acpi_adr_space_type;
 #define ACPI_BITREG_WAKE_STATUS                 0x06
 #define ACPI_BITREG_PCIEXP_WAKE_STATUS          0x07
 
+/* PM1 Enable register */
+
 #define ACPI_BITREG_TIMER_ENABLE                0x08
 #define ACPI_BITREG_GLOBAL_LOCK_ENABLE          0x09
 #define ACPI_BITREG_POWER_BUTTON_ENABLE         0x0A
 #define ACPI_BITREG_SLEEP_BUTTON_ENABLE         0x0B
 #define ACPI_BITREG_RT_CLOCK_ENABLE             0x0C
-#define ACPI_BITREG_WAKE_ENABLE                 0x0D
-#define ACPI_BITREG_PCIEXP_WAKE_DISABLE         0x0E
+#define ACPI_BITREG_PCIEXP_WAKE_DISABLE         0x0D
+
+/* PM1 Control register */
+
+#define ACPI_BITREG_SCI_ENABLE                  0x0E
+#define ACPI_BITREG_BUS_MASTER_RLD              0x0F
+#define ACPI_BITREG_GLOBAL_LOCK_RELEASE         0x10
+#define ACPI_BITREG_SLEEP_TYPE_A                0x11
+#define ACPI_BITREG_SLEEP_TYPE_B                0x12
+#define ACPI_BITREG_SLEEP_ENABLE                0x13
 
-#define ACPI_BITREG_SCI_ENABLE                  0x0F
-#define ACPI_BITREG_BUS_MASTER_RLD              0x10
-#define ACPI_BITREG_GLOBAL_LOCK_RELEASE         0x11
-#define ACPI_BITREG_SLEEP_TYPE_A                0x12
-#define ACPI_BITREG_SLEEP_TYPE_B                0x13
-#define ACPI_BITREG_SLEEP_ENABLE                0x14
+/* PM2 Control register */
 
-#define ACPI_BITREG_ARB_DISABLE                 0x15
+#define ACPI_BITREG_ARB_DISABLE                 0x14
 
-#define ACPI_BITREG_MAX                         0x15
+#define ACPI_BITREG_MAX                         0x14
 #define ACPI_NUM_BITREG                         ACPI_BITREG_MAX + 1
 
 /*
-- 
1.5.5.1


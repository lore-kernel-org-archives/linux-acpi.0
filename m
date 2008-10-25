From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/9] i7300_idle: Cleanup based review comments
Date: Sat, 25 Oct 2008 04:13:32 -0400
Message-ID: <33093e186c8f80b443fafb1d347a140bdd2b86c6.1224922389.git.len.brown@intel.com>
References: <1224922419-7823-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:33124 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752426AbYJYINn (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 25 Oct 2008 04:13:43 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173001.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K9A00M82C6UUNF4@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 25 Oct 2008 03:13:42 -0500 (CDT)
In-reply-to: <1224922419-7823-1-git-send-email-lenb@kernel.org>
In-reply-to: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
References: <3ad0b02e4c1d5feba44b8ff48dccd1ba61a826b0.1224922389.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

Cleanup of i7300 idle driver based on review comments from Randy Dunlap,
Andi Kleen and Len Brown.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/idle/Kconfig      |   11 ++++++-----
 drivers/idle/i7300_idle.c |   33 ++++++++++++++++++---------------
 2 files changed, 24 insertions(+), 20 deletions(-)

diff --git a/drivers/idle/Kconfig b/drivers/idle/Kconfig
index f5b26dd..108264d 100644
--- a/drivers/idle/Kconfig
+++ b/drivers/idle/Kconfig
@@ -5,12 +5,13 @@ config I7300_IDLE_IOAT_CHANNEL
 	bool
 
 config I7300_IDLE
-	tristate "Intel chipset idle power saving driver"
+	tristate "Intel chipset idle memory power saving driver"
 	select I7300_IDLE_IOAT_CHANNEL
-	depends on X86_64
+	depends on X86_64 && EXPERIMENTAL
 	help
-	  Enable idle power savings with certain Intel server chipsets.
-	  The chipset must have I/O AT support, such as the Intel 7300.
-	  The power savings depends on the type and quantity of DRAM devices.
+	  Enable memory power savings when idle with certain Intel server
+	  chipsets. The chipset must have I/O AT support, such as the
+	  Intel 7300. The power savings depends on the type and quantity of
+	  DRAM devices.
 
 endmenu
diff --git a/drivers/idle/i7300_idle.c b/drivers/idle/i7300_idle.c
index 79d47f2..fb176f6 100644
--- a/drivers/idle/i7300_idle.c
+++ b/drivers/idle/i7300_idle.c
@@ -35,6 +35,8 @@
 #define I7300_IDLE_DRIVER_VERSION	"1.55"
 #define I7300_PRINT			"i7300_idle:"
 
+#define MAX_STOP_RETRIES	10
+
 static int debug;
 module_param_named(debug, debug, uint, 0644);
 MODULE_PARM_DESC(debug, "Enable debug printks in this driver");
@@ -47,12 +49,12 @@ MODULE_PARM_DESC(debug, "Enable debug printks in this driver");
  *  0 = No throttling
  *  1 = Throttle when > 4 activations per eval window (Maximum throttling)
  *  2 = Throttle when > 8 activations
- *  168 = Throttle when > 168 activations (Minimum throttling)
+ *  168 = Throttle when > 672 activations (Minimum throttling)
  */
-#define MAX_THRTLWLIMIT		168
-static uint i7300_idle_thrtlowlm = 1;
-module_param_named(thrtlwlimit, i7300_idle_thrtlowlm, uint, 0644);
-MODULE_PARM_DESC(thrtlwlimit,
+#define MAX_THROTTLE_LOW_LIMIT		168
+static uint throttle_low_limit = 1;
+module_param_named(throttle_low_limit, throttle_low_limit, uint, 0644);
+MODULE_PARM_DESC(throttle_low_limit,
 		"Value for THRTLOWLM activation field "
 		"(0 = disable throttle, 1 = Max throttle, 168 = Min throttle)");
 
@@ -111,9 +113,9 @@ static int i7300_idle_ioat_start(void)
 static void i7300_idle_ioat_stop(void)
 {
 	int i;
-	u8 sts;
+	u64 sts;
 
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < MAX_STOP_RETRIES; i++) {
 		writeb(IOAT_CHANCMD_RESET,
 			ioat_chanbase + IOAT1_CHANCMD_OFFSET);
 
@@ -127,9 +129,10 @@ static void i7300_idle_ioat_stop(void)
 
 	}
 
-	if (i == 5)
-		dprintk("failed to suspend+reset I/O AT after 5 retries\n");
-
+	if (i == MAX_STOP_RETRIES) {
+		dprintk("failed to stop I/O AT after %d retries\n",
+			MAX_STOP_RETRIES);
+	}
 }
 
 /* Test I/O AT by copying 1024 byte from 2k to 1k */
@@ -276,7 +279,7 @@ static void __exit i7300_idle_ioat_exit(void)
 	i7300_idle_ioat_stop();
 
 	/* Wait for a while for the channel to halt before releasing */
-	for (i = 0; i < 10; i++) {
+	for (i = 0; i < MAX_STOP_RETRIES; i++) {
 		writeb(IOAT_CHANCMD_RESET,
 		       ioat_chanbase + IOAT1_CHANCMD_OFFSET);
 
@@ -390,9 +393,9 @@ static void i7300_idle_start(void)
 	new_ctl = i7300_idle_thrtctl_saved & ~DIMM_THRTCTL_THRMHUNT;
 	pci_write_config_byte(fbd_dev, DIMM_THRTCTL, new_ctl);
 
-	limit = i7300_idle_thrtlowlm;
-	if (unlikely(limit > MAX_THRTLWLIMIT))
-		limit = MAX_THRTLWLIMIT;
+	limit = throttle_low_limit;
+	if (unlikely(limit > MAX_THROTTLE_LOW_LIMIT))
+		limit = MAX_THROTTLE_LOW_LIMIT;
 
 	pci_write_config_byte(fbd_dev, DIMM_THRTLOW, limit);
 
@@ -441,7 +444,7 @@ static int i7300_idle_notifier(struct notifier_block *nb, unsigned long val,
 	static ktime_t idle_begin_time;
 	static int time_init = 1;
 
-	if (!i7300_idle_thrtlowlm)
+	if (!throttle_low_limit)
 		return 0;
 
 	if (unlikely(time_init)) {
-- 
1.5.6.5


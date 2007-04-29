From: Len Brown <len.brown@intel.com>
Subject: [PATCH 075/105] ACPI: thinkpad-acpi: add sysfs support to the cmos command subdriver
Date: Sun, 29 Apr 2007 00:51:15 -0400
Message-ID: <11778223733679-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
 <11778223532461-git-send-email-len.brown@intel.com>
 <11778223544100-git-send-email-len.brown@intel.com>
 <11778223553521-git-send-email-len.brown@intel.com>
 <11778223551720-git-send-email-len.brown@intel.com>
 <11778223562656-git-send-email-len.brown@intel.com>
 <11778223571390-git-send-email-len.brown@intel.com>
 <11778223581484-git-send-email-len.brown@intel.com>
 <11778223593048-git-send-email-len.brown@intel.com>
 <11778223602019-git-send-email-len.brown@intel.com>
 <11778223612093-git-send-email-len.brown@intel.com>
 <117782236226-git-send-email-len.brown@intel.com>
 <11778223624095-git-send-email-len.brown@intel.com>
 <11778223633408-git-send-email-len.brown@intel.com>
 <1177822364262-git-send-email-len.brown@intel.com>
 <11778223653391-git-send-email-len.brown@intel.com>
 <11778223663850-git-send-email-len.brown@intel.com>
 <11778223673988-git-send-email-len.brown@intel.com>
 <1177822368767-git-send-email-len.brown@intel.com>
 <1177822368793-git-send-email-len.brown@intel.com>
 <11778223692377-git-send-email-len.brown@intel.com>
 <1177822370442-git-send-email-len.brown@intel.com>
 <1177822371935-git-send-email-len.brown@intel.com>
 <11778223721984-git-send-email-len.brown@intel.com>
 <11778223732286-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:11191 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754614AbXD2Ewz (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:55 -0400
In-Reply-To: <11778223732286-git-send-email-len.brown@intel.com>
Message-Id: <b616004c70dd7f60a1477c3e9d6fddd00ee1fa37.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add sysfs attributes to send ThinkPad CMOS commands.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   23 +++++++++++------------
 drivers/misc/thinkpad_acpi.c    |   33 +++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 12 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 339ce21..352e8ae 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -378,23 +378,19 @@ supported. Use "eject2" instead of "eject" for the second bay.
 Note: the UltraBay eject support on the 600e/x, A22p and A3x is
 EXPERIMENTAL and may not work as expected. USE WITH CAUTION!
 
-CMOS control -- /proc/acpi/ibm/cmos
------------------------------------
+CMOS control
+------------
+
+procfs: /proc/acpi/ibm/cmos
+sysfs device attribute: cmos_command
 
 This feature is used internally by the ACPI firmware to control the
 ThinkLight on most newer ThinkPad models. It may also control LCD
 brightness, sounds volume and more, but only on some models.
 
-The commands are non-negative integer numbers:
-
-	echo 0 >/proc/acpi/ibm/cmos
-	echo 1 >/proc/acpi/ibm/cmos
-	echo 2 >/proc/acpi/ibm/cmos
-	...
-
-The range of valid numbers is 0 to 21, but not all have an effect and
-the behavior varies from model to model. Here is the behavior on the
-X40 (tpb is the ThinkPad Buttons utility):
+The range of valid cmos command numbers is 0 to 21, but not all have an
+effect and the behavior varies from model to model.  Here is the behavior
+on the X40 (tpb is the ThinkPad Buttons utility):
 
 	0 - no effect but tpb reports "Volume down"
 	1 - no effect but tpb reports "Volume up"
@@ -407,6 +403,9 @@ X40 (tpb is the ThinkPad Buttons utility):
 	13 - ThinkLight off
 	14 - no effect but tpb reports ThinkLight status change
 
+The cmos command interface is prone to firmware split-brain problems, as
+in newer ThinkPads it is just a compatibility layer.
+
 LED control -- /proc/acpi/ibm/led
 ---------------------------------
 
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 79abc68..ba749df 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1743,8 +1743,30 @@ static struct ibm_struct bay_driver_data = {
  * CMOS subdriver
  */
 
+/* sysfs cmos_command -------------------------------------------------- */
+static ssize_t cmos_command_store(struct device *dev,
+			    struct device_attribute *attr,
+			    const char *buf, size_t count)
+{
+	unsigned long cmos_cmd;
+	int res;
+
+	if (parse_strtoul(buf, 21, &cmos_cmd))
+		return -EINVAL;
+
+	res = issue_thinkpad_cmos_command(cmos_cmd);
+	return (res)? res : count;
+}
+
+static struct device_attribute dev_attr_cmos_command =
+	__ATTR(cmos_command, S_IWUSR, NULL, cmos_command_store);
+
+/* --------------------------------------------------------------------- */
+
 static int __init cmos_init(struct ibm_init_struct *iibm)
 {
+	int res;
+
 	vdbg_printk(TPACPI_DBG_INIT,
 		"initializing cmos commands subdriver\n");
 
@@ -1752,9 +1774,19 @@ static int __init cmos_init(struct ibm_init_struct *iibm)
 
 	vdbg_printk(TPACPI_DBG_INIT, "cmos commands are %s\n",
 		str_supported(cmos_handle != NULL));
+
+	res = device_create_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
+	if (res)
+		return res;
+
 	return (cmos_handle)? 0 : 1;
 }
 
+static void cmos_exit(void)
+{
+	device_remove_file(&tpacpi_pdev->dev, &dev_attr_cmos_command);
+}
+
 static int cmos_read(char *p)
 {
 	int len = 0;
@@ -1795,6 +1827,7 @@ static struct ibm_struct cmos_driver_data = {
 	.name = "cmos",
 	.read = cmos_read,
 	.write = cmos_write,
+	.exit = cmos_exit,
 };
 
 /*************************************************************************
-- 
1.5.2.rc0.34.gda94

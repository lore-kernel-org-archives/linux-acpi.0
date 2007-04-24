From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 8/9] ACPI: thinkpad-acpi: add sysfs support
	to the cmos command subdriver
Date: Tue, 24 Apr 2007 11:48:19 -0300
Message-ID: <11774261023992-git-send-email-hmh@hmh.eng.br>
References: <11774261003184-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11774261003184-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add sysfs attributes to send ThinkPad CMOS commands.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

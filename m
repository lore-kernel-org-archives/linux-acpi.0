From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 3/7] ACPI: thinkpad-acpi: prepare for
	bluetooth and wwan rfkill support
Date: Tue,  1 Jul 2008 15:27:51 -0300
Message-ID: <1214936875-4812-4-git-send-email-hmh@hmh.eng.br>
References: <1214936875-4812-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1214936875-4812-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Andi Kleen <andi-Vw/NltI1exuRpAAqCnN02g@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Get rid of some forward definitions by moving code around, this will make
the rfkill conversion of wwan and bluetooth a bit cleaner.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |  154 ++++++++++++++++++++----------------------
 1 files changed, 74 insertions(+), 80 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 9179f23..743a4d6 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2581,8 +2581,37 @@ enum {
 	TP_ACPI_BLUETOOTH_UNK		= 0x04,	/* unknown function */
 };
 
-static int bluetooth_get_radiosw(void);
-static int bluetooth_set_radiosw(int radio_on);
+static int bluetooth_get_radiosw(void)
+{
+	int status;
+
+	if (!tp_features.bluetooth)
+		return -ENODEV;
+
+	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
+		return -EIO;
+
+	return (status & TP_ACPI_BLUETOOTH_RADIOSSW) != 0;
+}
+
+static int bluetooth_set_radiosw(int radio_on)
+{
+	int status;
+
+	if (!tp_features.bluetooth)
+		return -ENODEV;
+
+	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
+		return -EIO;
+	if (radio_on)
+		status |= TP_ACPI_BLUETOOTH_RADIOSSW;
+	else
+		status &= ~TP_ACPI_BLUETOOTH_RADIOSSW;
+	if (!acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
+		return -EIO;
+
+	return 0;
+}
 
 /* sysfs bluetooth enable ---------------------------------------------- */
 static ssize_t bluetooth_enable_show(struct device *dev,
@@ -2628,6 +2657,12 @@ static const struct attribute_group bluetooth_attr_group = {
 	.attrs = bluetooth_attributes,
 };
 
+static void bluetooth_exit(void)
+{
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+			&bluetooth_attr_group);
+}
+
 static int __init bluetooth_init(struct ibm_init_struct *iibm)
 {
 	int res;
@@ -2664,44 +2699,6 @@ static int __init bluetooth_init(struct ibm_init_struct *iibm)
 	return (tp_features.bluetooth)? 0 : 1;
 }
 
-static void bluetooth_exit(void)
-{
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
-			&bluetooth_attr_group);
-}
-
-static int bluetooth_get_radiosw(void)
-{
-	int status;
-
-	if (!tp_features.bluetooth)
-		return -ENODEV;
-
-	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
-		return -EIO;
-
-	return ((status & TP_ACPI_BLUETOOTH_RADIOSSW) != 0);
-}
-
-static int bluetooth_set_radiosw(int radio_on)
-{
-	int status;
-
-	if (!tp_features.bluetooth)
-		return -ENODEV;
-
-	if (!acpi_evalf(hkey_handle, &status, "GBDC", "d"))
-		return -EIO;
-	if (radio_on)
-		status |= TP_ACPI_BLUETOOTH_RADIOSSW;
-	else
-		status &= ~TP_ACPI_BLUETOOTH_RADIOSSW;
-	if (!acpi_evalf(hkey_handle, NULL, "SBDC", "vd", status))
-		return -EIO;
-
-	return 0;
-}
-
 /* procfs -------------------------------------------------------------- */
 static int bluetooth_read(char *p)
 {
@@ -2756,8 +2753,37 @@ enum {
 	TP_ACPI_WANCARD_UNK		= 0x04,	/* unknown function */
 };
 
-static int wan_get_radiosw(void);
-static int wan_set_radiosw(int radio_on);
+static int wan_get_radiosw(void)
+{
+	int status;
+
+	if (!tp_features.wan)
+		return -ENODEV;
+
+	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
+		return -EIO;
+
+	return (status & TP_ACPI_WANCARD_RADIOSSW) != 0;
+}
+
+static int wan_set_radiosw(int radio_on)
+{
+	int status;
+
+	if (!tp_features.wan)
+		return -ENODEV;
+
+	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
+		return -EIO;
+	if (radio_on)
+		status |= TP_ACPI_WANCARD_RADIOSSW;
+	else
+		status &= ~TP_ACPI_WANCARD_RADIOSSW;
+	if (!acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
+		return -EIO;
+
+	return 0;
+}
 
 /* sysfs wan enable ---------------------------------------------------- */
 static ssize_t wan_enable_show(struct device *dev,
@@ -2803,6 +2829,12 @@ static const struct attribute_group wan_attr_group = {
 	.attrs = wan_attributes,
 };
 
+static void wan_exit(void)
+{
+	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
+		&wan_attr_group);
+}
+
 static int __init wan_init(struct ibm_init_struct *iibm)
 {
 	int res;
@@ -2837,44 +2869,6 @@ static int __init wan_init(struct ibm_init_struct *iibm)
 	return (tp_features.wan)? 0 : 1;
 }
 
-static void wan_exit(void)
-{
-	sysfs_remove_group(&tpacpi_pdev->dev.kobj,
-		&wan_attr_group);
-}
-
-static int wan_get_radiosw(void)
-{
-	int status;
-
-	if (!tp_features.wan)
-		return -ENODEV;
-
-	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
-		return -EIO;
-
-	return ((status & TP_ACPI_WANCARD_RADIOSSW) != 0);
-}
-
-static int wan_set_radiosw(int radio_on)
-{
-	int status;
-
-	if (!tp_features.wan)
-		return -ENODEV;
-
-	if (!acpi_evalf(hkey_handle, &status, "GWAN", "d"))
-		return -EIO;
-	if (radio_on)
-		status |= TP_ACPI_WANCARD_RADIOSSW;
-	else
-		status &= ~TP_ACPI_WANCARD_RADIOSSW;
-	if (!acpi_evalf(hkey_handle, NULL, "SWAN", "vd", status))
-		return -EIO;
-
-	return 0;
-}
-
 /* procfs -------------------------------------------------------------- */
 static int wan_read(char *p)
 {
-- 
1.5.5.4


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 23/23] ACPI: thinkpad-acpi: add locking to
	brightness subdriver
Date: Wed, 18 Jul 2007 23:45:48 -0300
Message-ID: <11848131523026-git-send-email-hmh@hmh.eng.br>
References: <11848131483573-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11848131483573-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The backlight class does all the locking needed for sysfs access, but
offers no API to interface to that locking without an layer violation.

Since we need to mutex-lock procfs access, implement in-driver locking for
brightness.  It will go away the day thinkpad-acpi procfs goes away, or the
backlight class gives us a way to use its locks without a layer violation.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   35 ++++++++++++++++++++++++++++-------
 1 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 01bed93..f15a58f 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -3000,12 +3000,16 @@ static struct backlight_ops ibm_backlight_data = {
         .update_status  = brightness_update_status,
 };
 
+static struct mutex brightness_mutex;
+
 static int __init brightness_init(struct ibm_init_struct *iibm)
 {
 	int b;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing brightness subdriver\n");
 
+	mutex_init(&brightness_mutex);
+
 	if (!brightness_mode) {
 		if (thinkpad_id.vendor == PCI_VENDOR_ID_LENOVO)
 			brightness_mode = 2;
@@ -3092,27 +3096,44 @@ static int brightness_get(struct backlight_device *bd)
 
 static int brightness_set(int value)
 {
-	int cmos_cmd, inc, i;
-	int current_value = brightness_get(NULL);
+	int cmos_cmd, inc, i, res;
+	int current_value;
 
 	if (value > 7)
 		return -EINVAL;
 
+	res = mutex_lock_interruptible(&brightness_mutex);
+	if (res < 0)
+		return res;
+
+	current_value = brightness_get(NULL);
+	if (current_value < 0) {
+		res = current_value;
+		goto errout;
+	}
+
 	cmos_cmd = value > current_value ?
 			TP_CMOS_BRIGHTNESS_UP :
 			TP_CMOS_BRIGHTNESS_DOWN;
 	inc = value > current_value ? 1 : -1;
 
+	res = 0;
 	for (i = current_value; i != value; i += inc) {
 		if ((brightness_mode & 2) &&
-		    issue_thinkpad_cmos_command(cmos_cmd))
-			return -EIO;
+		    issue_thinkpad_cmos_command(cmos_cmd)) {
+			res = -EIO;
+			goto errout;
+		}
 		if ((brightness_mode & 1) &&
-		    !acpi_ec_write(brightness_offset, i + inc))
-			return -EIO;
+		    !acpi_ec_write(brightness_offset, i + inc)) {
+			res = -EIO;
+			goto errout;;
+		}
 	}
 
-	return 0;
+errout:
+	mutex_unlock(&brightness_mutex);
+	return res;
 }
 
 static int brightness_read(char *p)
-- 
1.5.2.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH] ACPI: thinkpad-acpi: add input device
	support to hotkey subdriver
Date: Sat, 26 May 2007 14:31:03 -0300
Message-ID: <11802006652128-git-send-email-hmh@hmh.eng.br>
References: <11802004861625-git-send-email-hmh@hmh.eng.br>
	<11802006651698-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11802006651698-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, dtor-JGs/UdohzUI@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add input device support to the hotkey subdriver.  Hotkeys are reported
both as an ACPI event, and through the input layer.

This patch is based on a patch by Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: Richard Hughes <hughsient-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
---
 Documentation/thinkpad-acpi.txt |    3 +++
 drivers/misc/thinkpad_acpi.c    |   36 +++++++++++++++++++++++++++++++++---
 2 files changed, 36 insertions(+), 3 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index aae49a6..6acb2eb 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -152,6 +152,9 @@ All labeled Fn-Fx key combinations generate distinct events. In
 addition, the lid microswitch and some docking station buttons may
 also generate such events.
 
+Some hot keys also generate regular keyboard key press/release events to
+the input layer in addition to the ibm/hotkey ACPI events.
+
 The bit mask allows some control over which hot keys generate ACPI
 events. Not all bits in the mask can be modified. Not all bits that
 can be modified do anything. Not all hot keys can be individually
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c0b8155..fad3bd0 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -707,6 +707,14 @@ static struct ibm_struct thinkpad_acpi_driver_data = {
 static int hotkey_orig_status;
 static int hotkey_orig_mask;
 
+static u16 hotkey_event_map[16] = {
+	/* fn+f1..fn+f12 */
+	KEY_FN_F1, KEY_FN_F2, KEY_FN_F3, KEY_FN_F4, KEY_FN_F5, KEY_FN_F6,
+	KEY_FN_F7, KEY_FN_F8, KEY_FN_F9, KEY_FN_F10, KEY_FN_F11, KEY_FN_F12,
+	/* backspace/ins/del/home */
+	KEY_RESERVED, KEY_RESERVED, KEY_RESERVED, KEY_RESERVED
+};
+
 static struct attribute_set *hotkey_dev_attributes = NULL;
 
 /* sysfs hotkey enable ------------------------------------------------- */
@@ -811,10 +819,12 @@ static struct attribute *hotkey_mask_attributes[] = {
 
 static int __init hotkey_init(struct ibm_init_struct *iibm)
 {
-	int res;
+	int res, i;
 
 	vdbg_printk(TPACPI_DBG_INIT, "initializing hotkey subdriver\n");
 
+	BUG_ON(!tpacpi_inputdev);
+
 	IBM_ACPIHANDLE_INIT(hkey);
 	mutex_init(&hotkey_mutex);
 
@@ -854,6 +864,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 
 		if (res)
 			return res;
+
+		set_bit(EV_KEY, tpacpi_inputdev->evbit);
+		for (i = 0; i < ARRAY_SIZE(hotkey_event_map); i++)
+			set_bit(hotkey_event_map[i], tpacpi_inputdev->keybit);
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -876,13 +890,29 @@ static void hotkey_exit(void)
 	}
 }
 
+static void tpacpi_input_send_key(unsigned int keycode)
+{
+	if (keycode != KEY_RESERVED) {
+		input_report_key(tpacpi_inputdev, keycode, 1);
+		input_sync(tpacpi_inputdev);
+		input_report_key(tpacpi_inputdev, keycode, 0);
+		input_sync(tpacpi_inputdev);
+	}
+}
+
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	int hkey;
 
-	if (acpi_evalf(hkey_handle, &hkey, "MHKP", "d"))
+	if (acpi_evalf(hkey_handle, &hkey, "MHKP", "d")) {
 		acpi_bus_generate_event(ibm->acpi->device, event, hkey);
-	else {
+		if (hkey > 0x1000 && hkey < 0x1011) {
+			tpacpi_input_send_key(
+					hotkey_event_map[(hkey - 1) & 0x0f]);
+		} else {
+			printk(IBM_ERR "unknown hotkey 0x%04x\n", hkey);
+		}
+	} else {
 		printk(IBM_ERR "unknown hotkey event %d\n", event);
 		acpi_bus_generate_event(ibm->acpi->device, event, 0);
 	}
-- 
1.5.1.6


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

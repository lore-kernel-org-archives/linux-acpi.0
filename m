From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 02/15] ACPI: thinkpad-acpi: prepare for
	NVRAM polling support
Date: Thu, 15 Nov 2007 01:36:49 -0200
Message-ID: <1195097822-24738-3-git-send-email-hmh@hmh.eng.br>
References: <1195097822-24738-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1195097822-24738-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Make some small internal thinkpad-acpi changes to the hotkey subdriver code
that will make it easier to add NVRAM polling support.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   82 +++++++++++++++++++++--------------------
 1 files changed, 42 insertions(+), 40 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 87ba534..f00149f 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -852,6 +852,46 @@ static int hotkey_status_set(int status)
 	return 0;
 }
 
+static void tpacpi_input_send_radiosw(void)
+{
+	int wlsw;
+
+	mutex_lock(&tpacpi_inputdev_send_mutex);
+
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
+		input_report_switch(tpacpi_inputdev,
+				    SW_RADIO, !!wlsw);
+		input_sync(tpacpi_inputdev);
+	}
+
+	mutex_unlock(&tpacpi_inputdev_send_mutex);
+}
+
+static void tpacpi_input_send_key(unsigned int scancode)
+{
+	unsigned int keycode;
+
+	keycode = hotkey_keycode_map[scancode];
+
+	if (keycode != KEY_RESERVED) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
+
+		input_report_key(tpacpi_inputdev, keycode, 1);
+		if (keycode == KEY_UNKNOWN)
+			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
+				    scancode);
+		input_sync(tpacpi_inputdev);
+
+		input_report_key(tpacpi_inputdev, keycode, 0);
+		if (keycode == KEY_UNKNOWN)
+			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
+				    scancode);
+		input_sync(tpacpi_inputdev);
+
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
+	}
+}
+
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
 			   struct device_attribute *attr,
@@ -1232,47 +1272,10 @@ static void hotkey_exit(void)
 	}
 }
 
-static void tpacpi_input_send_key(unsigned int scancode,
-				  unsigned int keycode)
-{
-	if (keycode != KEY_RESERVED) {
-		mutex_lock(&tpacpi_inputdev_send_mutex);
-
-		input_report_key(tpacpi_inputdev, keycode, 1);
-		if (keycode == KEY_UNKNOWN)
-			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
-				    scancode);
-		input_sync(tpacpi_inputdev);
-
-		input_report_key(tpacpi_inputdev, keycode, 0);
-		if (keycode == KEY_UNKNOWN)
-			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
-				    scancode);
-		input_sync(tpacpi_inputdev);
-
-		mutex_unlock(&tpacpi_inputdev_send_mutex);
-	}
-}
-
-static void tpacpi_input_send_radiosw(void)
-{
-	int wlsw;
-
-	mutex_lock(&tpacpi_inputdev_send_mutex);
-
-	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
-		input_report_switch(tpacpi_inputdev,
-				    SW_RADIO, !!wlsw);
-		input_sync(tpacpi_inputdev);
-	}
-
-	mutex_unlock(&tpacpi_inputdev_send_mutex);
-}
-
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 {
 	u32 hkey;
-	unsigned int keycode, scancode;
+	unsigned int scancode;
 	int send_acpi_ev;
 	int ignore_acpi_ev;
 
@@ -1305,8 +1308,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 			scancode = hkey & 0xfff;
 			if (scancode > 0 && scancode < 0x21) {
 				scancode--;
-				keycode = hotkey_keycode_map[scancode];
-				tpacpi_input_send_key(scancode, keycode);
+				tpacpi_input_send_key(scancode);
 			} else {
 				printk(IBM_ERR
 				       "hotkey 0x%04x out of range for keyboard map\n",
-- 
1.5.3.4


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 2/7] ACPI: thinkpad-acpi: consolidate wlsw
	notification function
Date: Tue,  1 Jul 2008 15:27:50 -0300
Message-ID: <1214936875-4812-3-git-send-email-hmh@hmh.eng.br>
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

Rename tpacpi_input_send_radiosw() to tpacpi_send_radiosw_update(), and
make it a central point to issue "radio switch changed state" notifications
by consolidating also the poll() notification in the same function.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   39 +++++++++++++++++++--------------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index c800855..9179f23 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1285,21 +1285,6 @@ static int hotkey_status_set(int status)
 	return 0;
 }
 
-static void tpacpi_input_send_radiosw(void)
-{
-	int wlsw;
-
-	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
-		mutex_lock(&tpacpi_inputdev_send_mutex);
-
-		input_report_switch(tpacpi_inputdev,
-				    SW_RFKILL_ALL, !!wlsw);
-		input_sync(tpacpi_inputdev);
-
-		mutex_unlock(&tpacpi_inputdev_send_mutex);
-	}
-}
-
 static void tpacpi_input_send_tabletsw(void)
 {
 	int state;
@@ -1921,6 +1906,22 @@ static struct attribute *hotkey_mask_attributes[] __initdata = {
 	&dev_attr_hotkey_wakeup_hotunplug_complete.attr,
 };
 
+static void tpacpi_send_radiosw_update(void)
+{
+	int wlsw;
+
+	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
+
+		input_report_switch(tpacpi_inputdev,
+				    SW_RFKILL_ALL, !!wlsw);
+		input_sync(tpacpi_inputdev);
+
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
+	}
+	hotkey_radio_sw_notify_change();
+}
+
 static void hotkey_exit(void)
 {
 #ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
@@ -2288,7 +2289,7 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 	tpacpi_inputdev->close = &hotkey_inputdev_close;
 
 	hotkey_poll_setup_safe(1);
-	tpacpi_input_send_radiosw();
+	tpacpi_send_radiosw_update();
 	tpacpi_input_send_tabletsw();
 
 	return 0;
@@ -2420,8 +2421,7 @@ static void hotkey_notify(struct ibm_struct *ibm, u32 event)
 		case 7:
 			/* 0x7000-0x7FFF: misc */
 			if (tp_features.hotkey_wlsw && hkey == 0x7000) {
-				tpacpi_input_send_radiosw();
-				hotkey_radio_sw_notify_change();
+				tpacpi_send_radiosw_update();
 				send_acpi_ev = 0;
 				break;
 			}
@@ -2464,8 +2464,7 @@ static void hotkey_resume(void)
 		printk(TPACPI_ERR
 		       "error while trying to read hot key mask "
 		       "from firmware\n");
-	tpacpi_input_send_radiosw();
-	hotkey_radio_sw_notify_change();
+	tpacpi_send_radiosw_update();
 	hotkey_tablet_mode_notify_change();
 	hotkey_wakeup_reason_notify_change();
 	hotkey_wakeup_hotunplug_complete_notify_change();
-- 
1.5.5.4


-------------------------------------------------------------------------
Sponsored by: SourceForge.net Community Choice Awards: VOTE NOW!
Studies have shown that voting for your favorite open source project,
along with a healthy diet, reduces your potential for chronic lameness
and boredom. Vote Now at http://www.sourceforge.net/community/cca08

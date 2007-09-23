From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 3/9] ACPI: thinkpad-acpi: add mutex-based
	locking to input device event send path
Date: Sun, 23 Sep 2007 11:24:11 -0300
Message-ID: <11905574571365-git-send-email-hmh@hmh.eng.br>
References: <1190557457539-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1190557457539-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

Protect the input device event sending path with a mutex, since hot key
input events are not atomic and require an cohesive event block to be sent
together.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 8aa0f96..0ced9d6 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -519,6 +519,7 @@ static char *next_cmd(char **cmds)
 static struct platform_device *tpacpi_pdev;
 static struct class_device *tpacpi_hwmon;
 static struct input_dev *tpacpi_inputdev;
+static struct mutex tpacpi_inputdev_send_mutex;
 
 
 static int tpacpi_resume_handler(struct platform_device *pdev)
@@ -1131,6 +1132,8 @@ static void tpacpi_input_send_key(unsigned int scancode,
 				  unsigned int keycode)
 {
 	if (keycode != KEY_RESERVED) {
+		mutex_lock(&tpacpi_inputdev_send_mutex);
+
 		input_report_key(tpacpi_inputdev, keycode, 1);
 		if (keycode == KEY_UNKNOWN)
 			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
@@ -1142,6 +1145,8 @@ static void tpacpi_input_send_key(unsigned int scancode,
 			input_event(tpacpi_inputdev, EV_MSC, MSC_SCAN,
 				    scancode);
 		input_sync(tpacpi_inputdev);
+
+		mutex_unlock(&tpacpi_inputdev_send_mutex);
 	}
 }
 
@@ -1149,11 +1154,15 @@ static void tpacpi_input_send_radiosw(void)
 {
 	int wlsw;
 
+	mutex_lock(&tpacpi_inputdev_send_mutex);
+
 	if (tp_features.hotkey_wlsw && !hotkey_get_wlsw(&wlsw)) {
 		input_report_switch(tpacpi_inputdev,
 				    SW_RADIO, !!wlsw);
 		input_sync(tpacpi_inputdev);
 	}
+
+	mutex_unlock(&tpacpi_inputdev_send_mutex);
 }
 
 static void hotkey_notify(struct ibm_struct *ibm, u32 event)
@@ -4737,6 +4746,7 @@ static int __init thinkpad_acpi_module_init(void)
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
+	mutex_init(&tpacpi_inputdev_send_mutex);
 	tpacpi_inputdev = input_allocate_device();
 	if (!tpacpi_inputdev) {
 		printk(IBM_ERR "unable to allocate input device\n");
-- 
1.5.3.1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 3/9] ACPI: thinkpad-acpi: always track
	input device open/close
Date: Sat, 16 Feb 2008 02:17:52 -0200
Message-ID: <1203135478-4813-4-git-send-email-hmh@hmh.eng.br>
References: <1203135478-4813-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1203135478-4813-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

The open() and close() hooks for the input device are useful even when
hotkey NVRAM polling support is not in use, so it is better to always have
them around.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 723d37b..6da3f40 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -1417,6 +1417,14 @@ static void hotkey_poll_setup_safe(int may_warn)
 	mutex_unlock(&hotkey_mutex);
 }
 
+#else /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
+static void hotkey_poll_setup_safe(int __unused)
+{
+}
+
+#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
+
 static int hotkey_inputdev_open(struct input_dev *dev)
 {
 	switch (tpacpi_lifecycle) {
@@ -1444,7 +1452,6 @@ static void hotkey_inputdev_close(struct input_dev *dev)
 	if (tpacpi_lifecycle == TPACPI_LIFE_RUNNING)
 		hotkey_poll_setup_safe(0);
 }
-#endif /* CONFIG_THINKPAD_ACPI_HOTKEY_POLL */
 
 /* sysfs hotkey enable ------------------------------------------------- */
 static ssize_t hotkey_enable_show(struct device *dev,
@@ -2023,12 +2030,10 @@ static int __init hotkey_init(struct ibm_init_struct *iibm)
 				(hotkey_report_mode < 2) ?
 					"enabled" : "disabled");
 
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 		tpacpi_inputdev->open = &hotkey_inputdev_open;
 		tpacpi_inputdev->close = &hotkey_inputdev_close;
 
 		hotkey_poll_setup_safe(1);
-#endif
 	}
 
 	return (tp_features.hotkey)? 0 : 1;
@@ -2221,9 +2226,7 @@ static void hotkey_resume(void)
 	hotkey_radio_sw_notify_change();
 	hotkey_wakeup_reason_notify_change();
 	hotkey_wakeup_hotunplug_complete_notify_change();
-#ifdef CONFIG_THINKPAD_ACPI_HOTKEY_POLL
 	hotkey_poll_setup_safe(0);
-#endif
 }
 
 /* procfs -------------------------------------------------------------- */
-- 
1.5.3.8


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

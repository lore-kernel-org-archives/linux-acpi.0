From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 3/6] thinkpad-acpi: fix poll thread
	auto-start
Date: Fri, 26 Feb 2010 01:11:21 -0300
Message-ID: <1267157484-23925-4-git-send-email-hmh@hmh.eng.br>
References: <1267157484-23925-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1267157484-23925-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

The driver was not starting the NVRAM polling thread if the input
device was bound immediately after registration.

This fixes:
http://bugzilla.kernel.org/show_bug.cgi?id=15118

Reported-by: Florian Zumbiehl <florz-PhNffsxpY6U@public.gmane.org>
Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Cc: stable-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
---
 drivers/platform/x86/thinkpad_acpi.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 06657b7..933bcc4 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -2607,16 +2607,11 @@ static int hotkey_inputdev_open(struct input_dev *dev)
 {
 	switch (tpacpi_lifecycle) {
 	case TPACPI_LIFE_INIT:
-		/*
-		 * hotkey_init will call hotkey_poll_setup_safe
-		 * at the appropriate moment
-		 */
-		return 0;
-	case TPACPI_LIFE_EXITING:
-		return -EBUSY;
 	case TPACPI_LIFE_RUNNING:
 		hotkey_poll_setup_safe(false);
 		return 0;
+	case TPACPI_LIFE_EXITING:
+		return -EBUSY;
 	}
 
 	/* Should only happen if tpacpi_lifecycle is corrupt */
@@ -2627,7 +2622,7 @@ static int hotkey_inputdev_open(struct input_dev *dev)
 static void hotkey_inputdev_close(struct input_dev *dev)
 {
 	/* disable hotkey polling when possible */
-	if (tpacpi_lifecycle == TPACPI_LIFE_RUNNING &&
+	if (tpacpi_lifecycle != TPACPI_LIFE_EXITING &&
 	    !(hotkey_source_mask & hotkey_driver_mask))
 		hotkey_poll_setup_safe(false);
 }
@@ -9038,6 +9033,9 @@ static int __init thinkpad_acpi_module_init(void)
 			return ret;
 		}
 	}
+
+	tpacpi_lifecycle = TPACPI_LIFE_RUNNING;
+
 	ret = input_register_device(tpacpi_inputdev);
 	if (ret < 0) {
 		printk(TPACPI_ERR "unable to register input device\n");
@@ -9047,7 +9045,6 @@ static int __init thinkpad_acpi_module_init(void)
 		tp_features.input_device_registered = 1;
 	}
 
-	tpacpi_lifecycle = TPACPI_LIFE_RUNNING;
 	return 0;
 }
 
-- 
1.6.5.2


------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev

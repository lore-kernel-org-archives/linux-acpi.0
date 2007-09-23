From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 9/9] ACPI: thinkpad-acpi: duplicate driver
	attributes to new hwmon pdrv
Date: Sun, 23 Sep 2007 11:24:17 -0300
Message-ID: <11905574582364-git-send-email-hmh@hmh.eng.br>
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

Thinkpad-acpi has some driver attributes (debug level, sysfs interface
version, etc) that also belong to the new hwmon driver.  Duplicate them
there.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |    8 +++++++-
 drivers/misc/thinkpad_acpi.h |    1 +
 2 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4a85ede..9f8db98 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -4803,12 +4803,16 @@ static int __init thinkpad_acpi_module_init(void)
 	tp_features.sensors_pdrv_registered = 1;
 
 	ret = tpacpi_create_driver_attributes(&tpacpi_pdriver.driver);
+	if (!ret) {
+		tp_features.platform_drv_attrs_registered = 1;
+		ret = tpacpi_create_driver_attributes(&tpacpi_hwmon_pdriver.driver);
+	}
 	if (ret) {
 		printk(IBM_ERR "unable to create sysfs driver attributes\n");
 		thinkpad_acpi_module_exit();
 		return ret;
 	}
-	tp_features.platform_drv_attrs_registered = 1;
+	tp_features.sensors_pdrv_attrs_registered = 1;
 
 
 	/* Device initialization */
@@ -4919,6 +4923,8 @@ static void thinkpad_acpi_module_exit(void)
 	if (tpacpi_pdev)
 		platform_device_unregister(tpacpi_pdev);
 
+	if (tp_features.sensors_pdrv_attrs_registered)
+		tpacpi_remove_driver_attributes(&tpacpi_hwmon_pdriver.driver);
 	if (tp_features.platform_drv_attrs_registered)
 		tpacpi_remove_driver_attributes(&tpacpi_pdriver.driver);
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 791b8ca..c5fdd68 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -252,6 +252,7 @@ static struct {
 	u32 platform_drv_registered:1;
 	u32 platform_drv_attrs_registered:1;
 	u32 sensors_pdrv_registered:1;
+	u32 sensors_pdrv_attrs_registered:1;
 	u32 sensors_pdev_attrs_registered:1;
 } tp_features;
 
-- 
1.5.3.1


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/

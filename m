From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 10/20] ACPI: thinkpad-acpi: module glue
	cleanups
Date: Tue,  8 Jan 2008 13:02:47 -0200
Message-ID: <1199804577-32017-11-git-send-email-hmh@hmh.eng.br>
References: <1199804577-32017-1-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1199804577-32017-1-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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

General cleanup of module glue: Do some code reordering, and add
missing parameter help text.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
---
 drivers/misc/thinkpad_acpi.c |   83 +++++++++++++++++++++++++-----------------
 1 files changed, 50 insertions(+), 33 deletions(-)

diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 45be8e5..be04f1c 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -124,7 +124,6 @@ enum {
  * Main driver
  */
 
-/* Module */
 #define IBM_NAME "thinkpad"
 #define IBM_DESC "ThinkPad ACPI Extras"
 #define IBM_FILE IBM_NAME "_acpi"
@@ -138,37 +137,6 @@ enum {
 
 #define IBM_MAX_ACPI_ARGS 3
 
-MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
-MODULE_DESCRIPTION(IBM_DESC);
-MODULE_VERSION(IBM_VERSION);
-MODULE_LICENSE("GPL");
-
-/* Please remove this in year 2009 */
-MODULE_ALIAS("ibm_acpi");
-
-/*
- * DMI matching for module autoloading
- *
- * See http://thinkwiki.org/wiki/List_of_DMI_IDs
- * See http://thinkwiki.org/wiki/BIOS_Upgrade_Downloads
- *
- * Only models listed in thinkwiki will be supported, so add yours
- * if it is not there yet.
- */
-#define IBM_BIOS_MODULE_ALIAS(__type) \
-	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW")
-
-/* Non-ancient thinkpads */
-MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
-MODULE_ALIAS("dmi:bvnLENOVO:*:svnLENOVO:*:pvrThinkPad*:rvnLENOVO:*");
-
-/* Ancient thinkpad BIOSes have to be identified by
- * BIOS type or model number, and there are far less
- * BIOS types than model numbers... */
-IBM_BIOS_MODULE_ALIAS("I[B,D,H,I,M,N,O,T,W,V,Y,Z]");
-IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
-IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
-
 /* Debugging */
 #define IBM_LOG IBM_FILE ": "
 #define IBM_ERR	   KERN_ERR    IBM_LOG
@@ -5734,21 +5702,39 @@ static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 }
 
 module_param(experimental, int, 0);
+MODULE_PARM_DESC(experimental,
+                 "Enables experimental features when non-zero");
 
 module_param_named(debug, dbg_level, uint, 0);
+MODULE_PARM_DESC(debug, "Sets debug level bit-mask");
 
 module_param(force_load, bool, 0);
+MODULE_PARM_DESC(force_load,
+                 "Attempts to load the driver even on a "
+                 "mis-identified ThinkPad when true");
 
 module_param_named(fan_control, fan_control_allowed, bool, 0);
+MODULE_PARM_DESC(fan_control,
+                 "Enables setting fan parameters features when true");
 
 module_param_named(brightness_mode, brightness_mode, int, 0);
+MODULE_PARM_DESC(brightness_mode,
+                 "Selects brightness control strategy: "
+                 "0=auto, 1=EC, 2=CMOS, 3=both");
 
 module_param(brightness_enable, uint, 0);
+MODULE_PARM_DESC(brightness_enable,
+                 "Enables backlight control when 1, disables when 0");
 
 module_param(hotkey_report_mode, uint, 0);
+MODULE_PARM_DESC(hotkey_report_mode,
+                 "used for backwards compatibility with userspace, "
+                 "see documentation");
 
 #define IBM_PARAM(feature) \
-	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
+	module_param_call(feature, set_ibm_param, NULL, NULL, 0); \
+	MODULE_PARM_DESC(feature, "Simulates thinkpad-aci procfs command " \
+	                 "at module load, see documentation")
 
 IBM_PARAM(hotkey);
 IBM_PARAM(bluetooth);
@@ -5957,5 +5943,36 @@ static int __init thinkpad_acpi_module_init(void)
 	return 0;
 }
 
+/* Please remove this in year 2009 */
+MODULE_ALIAS("ibm_acpi");
+
+/*
+ * DMI matching for module autoloading
+ *
+ * See http://thinkwiki.org/wiki/List_of_DMI_IDs
+ * See http://thinkwiki.org/wiki/BIOS_Upgrade_Downloads
+ *
+ * Only models listed in thinkwiki will be supported, so add yours
+ * if it is not there yet.
+ */
+#define IBM_BIOS_MODULE_ALIAS(__type) \
+	MODULE_ALIAS("dmi:bvnIBM:bvr" __type "ET??WW")
+
+/* Non-ancient thinkpads */
+MODULE_ALIAS("dmi:bvnIBM:*:svnIBM:*:pvrThinkPad*:rvnIBM:*");
+MODULE_ALIAS("dmi:bvnLENOVO:*:svnLENOVO:*:pvrThinkPad*:rvnLENOVO:*");
+
+/* Ancient thinkpad BIOSes have to be identified by
+ * BIOS type or model number, and there are far less
+ * BIOS types than model numbers... */
+IBM_BIOS_MODULE_ALIAS("I[B,D,H,I,M,N,O,T,W,V,Y,Z]");
+IBM_BIOS_MODULE_ALIAS("1[0,3,6,8,A-G,I,K,M-P,S,T]");
+IBM_BIOS_MODULE_ALIAS("K[U,X-Z]");
+
+MODULE_AUTHOR("Borislav Deianov, Henrique de Moraes Holschuh");
+MODULE_DESCRIPTION(IBM_DESC);
+MODULE_VERSION(IBM_VERSION);
+MODULE_LICENSE("GPL");
+
 module_init(thinkpad_acpi_module_init);
 module_exit(thinkpad_acpi_module_exit);
-- 
1.5.3.7


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace

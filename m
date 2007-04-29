From: Len Brown <len.brown@intel.com>
Subject: [PATCH 051/105] ACPI: thinkpad-acpi: add debug mode
Date: Sun, 29 Apr 2007 00:50:51 -0400
Message-ID: <11778223532461-git-send-email-len.brown@intel.com>
References: <11778223052751-git-send-email-len.brown@intel.com>
 <11778223068-git-send-email-len.brown@intel.com>
 <11778223072296-git-send-email-len.brown@intel.com>
 <11778223083747-git-send-email-len.brown@intel.com>
 <11778223081771-git-send-email-len.brown@intel.com>
 <1177822309524-git-send-email-len.brown@intel.com>
 <1177822310688-git-send-email-len.brown@intel.com>
 <11778223112050-git-send-email-len.brown@intel.com>
 <11778223122850-git-send-email-len.brown@intel.com>
 <11778223131932-git-send-email-len.brown@intel.com>
 <11778223143898-git-send-email-len.brown@intel.com>
 <11778223151972-git-send-email-len.brown@intel.com>
 <11778223152006-git-send-email-len.brown@intel.com>
 <11778223161614-git-send-email-len.brown@intel.com>
 <11778223173663-git-send-email-len.brown@intel.com>
 <11778223183783-git-send-email-len.brown@intel.com>
 <11778223192706-git-send-email-len.brown@intel.com>
 <11778223201940-git-send-email-len.brown@intel.com>
 <11778223212414-git-send-email-len.brown@intel.com>
 <11778223211710-git-send-email-len.brown@intel.com>
 <11778223222525-git-send-email-len.brown@intel.com>
 <11778223233885-git-send-email-len.brown@intel.com>
 <1177822324973-git-send-email-len.brown@intel.com>
 <11778223251849-git-send-email-len.brown@intel.com>
 <1177822326583-git-send-email-len.brown@intel.com>
 <11778223273782-git-send-email-len.brown@intel.com>
 <11778223282154-git-send-email-len.brown@intel.com>
 <11778223282215-git-send-email-len.brown@intel.com>
 <11778223304019-git-send-email-len.brown@intel.com>
 <1177822331727-git-send-email-len.brown@intel.com>
 <117782233197-git-send-email-len.brown@intel.com>
 <11778223331858-git-send-email-len.brown@intel.com>
 <11778223353919-git-send-email-len.brown@intel.com>
 <1177822337332-git-send-email-len.brown@intel.com>
 <11778223382880-git-send-email-len.brown@intel.com>
 <11778223392178-git-send-email-len.brown@intel.com>
 <11778223401417-git-send-email-len.brown@intel.com>
 <11778223411658-git-send-email-len.brown@intel.com>
 <11778223412672-git-send-email-len.brown@intel.com>
 <11778223423-git-send-email-len.brown@intel.com>
 <1177822343712-git-send-email-len.brown@intel.com>
 <11778223442065-git-send-email-len.brown@intel.com>
 <11778223452843-git-send-email-len.brown@intel.com>
 <11778223461282-git-send-email-len.brown@intel.com>
 <11778223472316-git-send-email-len.brown@intel.com>
 <1177822347845-git-send-email-len.brown@intel.com>
 <1177822348546-git-send-email-len.brown@intel.com>
 <11778223493327-git-send-email-len.brown@intel.com>
 <11778223502745-git-send-email-len.brown@intel.com>
 <11778223512990-git-send-email-len.brown@intel.com>
 <1177822352591-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54971 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754876AbXD2Ewg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 29 Apr 2007 00:52:36 -0400
In-Reply-To: <1177822352591-git-send-email-len.brown@intel.com>
Message-Id: <132ce09123755ec5e3d3a8ae22f4f753c3baac97.1177822058.git.len.brown@intel.com>
In-Reply-To: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
References: <ac122bb64b0d51f0512185d3522a75f3f3a80bc9.1177822058.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add a debug mode parameter and verbose debug mode Kconfig option.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |   13 +++++++++++++
 drivers/misc/Kconfig            |   10 ++++++++++
 drivers/misc/thinkpad_acpi.c    |    3 +++
 drivers/misc/thinkpad_acpi.h    |   13 +++++++++++++
 4 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index af18d29..82fd822 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -699,3 +699,16 @@ for example:
 
 	modprobe thinkpad_acpi hotkey=enable,0xffff video=auto_disable
 
+Enabling debugging output
+-------------------------
+
+The module takes a debug paramater which can be used to selectively
+enable various classes of debugging output, for example:
+
+	 modprobe ibm_acpi debug=0xffff
+
+will enable all debugging output classes.  It takes a bitmask, so
+to enable more than one output class, just add their values.
+
+There is also a kernel build option to enable more debugging
+information, which may be necessary to debug driver problems.
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 2cd96a3..44e4c8f 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -137,6 +137,16 @@ config THINKPAD_ACPI
 
 	  If you have an IBM or Lenovo ThinkPad laptop, say Y or M here.
 
+config THINKPAD_ACPI_DEBUG
+	bool "Verbose debug mode"
+	depends on THINKPAD_ACPI
+	default n
+	---help---
+	  Enables extra debugging information, at the expense of a slightly
+	  increase in driver size.
+
+	  If you are not sure, say N here.
+
 config THINKPAD_ACPI_DOCK
 	bool "Legacy Docking Station Support"
 	depends on THINKPAD_ACPI
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 4131a78..7fa906f 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -2684,6 +2684,9 @@ static int __init set_ibm_param(const char *val, struct kernel_param *kp)
 static int experimental;
 module_param(experimental, int, 0);
 
+static u32 dbg_level;
+module_param_named(debug, dbg_level, uint, 0);
+
 #define IBM_PARAM(feature) \
 	module_param_call(feature, set_ibm_param, NULL, NULL, 0)
 
diff --git a/drivers/misc/thinkpad_acpi.h b/drivers/misc/thinkpad_acpi.h
index 02a297e..b2348d7 100644
--- a/drivers/misc/thinkpad_acpi.h
+++ b/drivers/misc/thinkpad_acpi.h
@@ -74,6 +74,18 @@
 #define enabled(status,bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
 #define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
 
+/* Debugging */
+#define TPACPI_DBG_ALL		0xffff
+#define dbg_printk(a_dbg_level, format, arg...) \
+	do { if (dbg_level & a_dbg_level) \
+		printk(IBM_DEBUG "%s: " format, __func__ , ## arg); } while (0)
+#ifdef CONFIG_THINKPAD_ACPI_DEBUG
+#define vdbg_printk(a_dbg_level, format, arg...) \
+	dbg_printk(a_dbg_level, format, ## arg)
+#else
+#define vdbg_printk(a_dbg_level, format, arg...)
+#endif
+
 /* ACPI HIDs */
 #define IBM_HKEY_HID    "IBM0068"
 #define IBM_PCI_HID     "PNP0A03"
@@ -112,6 +124,7 @@ static char *next_cmd(char **cmds);
 
 /* Module */
 static int experimental;
+static u32 dbg_level;
 static char *ibm_thinkpad_ec_found;
 
 static char* check_dmi_for_ec(void);
-- 
1.5.2.rc0.34.gda94

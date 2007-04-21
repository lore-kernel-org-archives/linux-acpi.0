From: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
Subject: [PATCH 06/20] ACPI: thinkpad-acpi: add debug mode
Date: Sat, 21 Apr 2007 11:08:30 -0300
Message-ID: <11771645261301-git-send-email-hmh@hmh.eng.br>
References: <11771645253042-git-send-email-hmh@hmh.eng.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <11771645253042-git-send-email-hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=ibm-acpi-devel>
List-Post: <mailto:ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ibm-acpi-devel>,
	<mailto:ibm-acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: ibm-acpi-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: ibm-acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Add a debug mode parameter and verbose debug mode Kconfig option.

Signed-off-by: Henrique de Moraes Holschuh <hmh-N3TV7GIv+o9fyO9Q7EP/yw@public.gmane.org>
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
1.5.1


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/

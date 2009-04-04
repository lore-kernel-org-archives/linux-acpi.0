From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 04/12] thinkpad-acpi: cleanup debug helpers
Date: Sat,  4 Apr 2009 01:25:45 -0300
Message-ID: <1238819153-16004-5-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42669 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751198AbZDDE0A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:26:00 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Fix the vdbg_printk macro definition to be sane when
CONFIG_THINKPAD_ACPI_DEBUG is undefined, and move the mess into a file
section of its own.

This doesn't change anything in the current code, but future code will
need the proper behaviour.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   29 ++++++++++++++++++-----------
 1 files changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 5fd5549..0a01f76 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -184,17 +184,6 @@ enum {
 #define TPACPI_DBG_ALL		0xffff
 #define TPACPI_DBG_INIT		0x0001
 #define TPACPI_DBG_EXIT		0x0002
-#define dbg_printk(a_dbg_level, format, arg...) \
-	do { if (dbg_level & a_dbg_level) \
-		printk(TPACPI_DEBUG "%s: " format, __func__ , ## arg); \
-	} while (0)
-#ifdef CONFIG_THINKPAD_ACPI_DEBUG
-#define vdbg_printk(a_dbg_level, format, arg...) \
-	dbg_printk(a_dbg_level, format, ## arg)
-static const char *str_supported(int is_supported);
-#else
-#define vdbg_printk(a_dbg_level, format, arg...)
-#endif
 
 #define onoff(status, bit) ((status) & (1 << (bit)) ? "on" : "off")
 #define enabled(status, bit) ((status) & (1 << (bit)) ? "enabled" : "disabled")
@@ -326,6 +315,24 @@ static int tpacpi_uwb_emulstate;
 #endif
 
 
+/*************************************************************************
+ *  Debugging helpers
+ */
+
+#define dbg_printk(a_dbg_level, format, arg...) \
+	do { if (dbg_level & (a_dbg_level)) \
+		printk(TPACPI_DEBUG "%s: " format, __func__ , ## arg); \
+	} while (0)
+
+#ifdef CONFIG_THINKPAD_ACPI_DEBUG
+#define vdbg_printk dbg_printk
+static const char *str_supported(int is_supported);
+#else
+#define vdbg_printk(a_dbg_level, format, arg...) \
+	do { } while (0)
+#endif
+
+
 /****************************************************************************
  ****************************************************************************
  *
-- 
1.6.2.1


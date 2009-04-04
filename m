From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 05/12] thinkpad-acpi: add missing log levels
Date: Sat,  4 Apr 2009 01:25:46 -0300
Message-ID: <1238819153-16004-6-git-send-email-hmh@hmh.eng.br>
References: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35479 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750973AbZDDE0A (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 4 Apr 2009 00:26:00 -0400
In-Reply-To: <1238819153-16004-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Add missing log levels in a standalone commit, to avoid dependencies in
future unrelated changes, just because they wanted to use one of the
missing log levels.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 drivers/platform/x86/thinkpad_acpi.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 0a01f76..c93324a 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -172,15 +172,18 @@ enum {
 	TPACPI_RFK_UWB_SW_ID,
 };
 
-/* Debugging */
+/* printk headers */
 #define TPACPI_LOG TPACPI_FILE ": "
-#define TPACPI_ALERT	KERN_ALERT  TPACPI_LOG
-#define TPACPI_CRIT	KERN_CRIT   TPACPI_LOG
-#define TPACPI_ERR	KERN_ERR    TPACPI_LOG
-#define TPACPI_NOTICE	KERN_NOTICE TPACPI_LOG
-#define TPACPI_INFO	KERN_INFO   TPACPI_LOG
-#define TPACPI_DEBUG	KERN_DEBUG  TPACPI_LOG
-
+#define TPACPI_EMERG	KERN_EMERG	TPACPI_LOG
+#define TPACPI_ALERT	KERN_ALERT	TPACPI_LOG
+#define TPACPI_CRIT	KERN_CRIT	TPACPI_LOG
+#define TPACPI_ERR	KERN_ERR	TPACPI_LOG
+#define TPACPI_WARN	KERN_WARNING	TPACPI_LOG
+#define TPACPI_NOTICE	KERN_NOTICE	TPACPI_LOG
+#define TPACPI_INFO	KERN_INFO	TPACPI_LOG
+#define TPACPI_DEBUG	KERN_DEBUG	TPACPI_LOG
+
+/* Debugging printk groups */
 #define TPACPI_DBG_ALL		0xffff
 #define TPACPI_DBG_INIT		0x0001
 #define TPACPI_DBG_EXIT		0x0002
-- 
1.6.2.1


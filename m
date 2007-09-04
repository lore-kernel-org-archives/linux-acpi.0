From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 2/2] ACPI: thinkpad-acpi: bump up version to 0.16
Date: Tue,  4 Sep 2007 11:13:16 -0300
Message-ID: <11889151971815-git-send-email-hmh@hmh.eng.br>
References: <1188915196931-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:58496 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753772AbXIDON0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 4 Sep 2007 10:13:26 -0400
In-Reply-To: <1188915196931-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Name it thinkpad-acpi version 0.16 to avoid any confusion with some 0.15
thinkpad-acpi development snapshots and backports that had input layer
support, but no hotkey_report_mode support.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/thinkpad-acpi.txt |    4 ++--
 drivers/misc/thinkpad_acpi.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index ca89711..60953d6 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
-                            Version 0.15
-                           July 1st, 2007
+                            Version 0.16
+                          August 2nd, 2007
 
                Borislav Deianov <borislav@users.sf.net>
              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 3d849d1..0222bba 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -21,7 +21,7 @@
  *  02110-1301, USA.
  */
 
-#define IBM_VERSION "0.15"
+#define IBM_VERSION "0.16"
 #define TPACPI_SYSFS_VERSION 0x010000
 
 /*
-- 
1.5.2.4


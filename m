From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 14/14] ACPI: thinkpad-acpi: bump up version to 0.20
Date: Sat, 26 Apr 2008 01:02:30 -0300
Message-ID: <1209182550-32725-15-git-send-email-hmh@hmh.eng.br>
References: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:59531 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751126AbYDZECi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 26 Apr 2008 00:02:38 -0400
In-Reply-To: <1209182550-32725-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Full LED sysfs support, and the rest of the assorted minor fixes and
enhancements are a good reason to checkpoint a new version...

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    4 ++--
 drivers/misc/thinkpad_acpi.c            |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 947b726..01c6c3d 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
-                            Version 0.19
-                         January 06th, 2008
+                            Version 0.20
+                          April 09th, 2008
 
                Borislav Deianov <borislav@users.sf.net>
              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index d5c08c0..d29ad2e 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -21,7 +21,7 @@
  *  02110-1301, USA.
  */
 
-#define TPACPI_VERSION "0.19"
+#define TPACPI_VERSION "0.20"
 #define TPACPI_SYSFS_VERSION 0x020200
 
 /*
-- 
1.5.4.4


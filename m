From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 5/7] ACPI: thinkpad-acpi: bump up version to 0.17
Date: Tue, 30 Oct 2007 17:46:23 -0200
Message-ID: <1193773585-17202-6-git-send-email-hmh@hmh.eng.br>
References: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:34197 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756634AbXJ3Tqd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 30 Oct 2007 15:46:33 -0400
In-Reply-To: <1193773585-17202-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The lm-sensors 3.0.0/libsensors4 compatibility changes are reason enough to
bump up the version string.  Do it.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/thinkpad-acpi.txt |    4 ++--
 drivers/misc/thinkpad_acpi.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index bb1c7a6..10c041c 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
-                            Version 0.16
-                          August 2nd, 2007
+                            Version 0.17
+                         October 04th, 2007
 
                Borislav Deianov <borislav@users.sf.net>
              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 109bd27..251110d 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -21,7 +21,7 @@
  *  02110-1301, USA.
  */
 
-#define IBM_VERSION "0.16"
+#define IBM_VERSION "0.17"
 #define TPACPI_SYSFS_VERSION 0x020000
 
 /*
-- 
1.5.3.4


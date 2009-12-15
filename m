From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 8/8] thinkpad-acpi: bump version to 0.24
Date: Tue, 15 Dec 2009 21:51:13 -0200
Message-ID: <1260921073-7686-9-git-send-email-hmh@hmh.eng.br>
References: <1260921073-7686-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:43384 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760874AbZLOXvV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 15 Dec 2009 18:51:21 -0500
In-Reply-To: <1260921073-7686-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    4 ++--
 drivers/platform/x86/thinkpad_acpi.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index b4ed30c..169091f 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
-                            Version 0.23
-                          April 10th, 2009
+                            Version 0.24
+                        December 11th,  2009
 
                Borislav Deianov <borislav@users.sf.net>
              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index c21c35e..af23525 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -21,7 +21,7 @@
  *  02110-1301, USA.
  */
 
-#define TPACPI_VERSION "0.23"
+#define TPACPI_VERSION "0.24"
 #define TPACPI_SYSFS_VERSION 0x020700
 
 /*
-- 
1.6.5.4


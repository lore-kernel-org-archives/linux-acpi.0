From: Len Brown <lenb@kernel.org>
Subject: [PATCH 168/171] ACPI: thinkpad-acpi: bump up version to 0.20
Date: Tue, 29 Apr 2008 04:44:33 -0400
Message-ID: <0ca9ee548a15a37519e978f6292427cbbadafedd.1209457073.git.len.brown@intel.com>
References: <1209458675-9757-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:29278 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757452AbYD2Ipe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 Apr 2008 04:45:34 -0400
In-Reply-To: <1209458675-9757-1-git-send-email-lenb@kernel.org>
In-Reply-To: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
References: <1071695f17daf050638e0bc550db647f8237c3bb.1209457069.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Full LED sysfs support, and the rest of the assorted minor fixes and
enhancements are a good reason to checkpoint a new version...

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/laptops/thinkpad-acpi.txt |    4 ++--
 drivers/misc/thinkpad_acpi.c            |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 27ca0f9..a2ea504 100644
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
index 22ba93c..76e3ae3 100644
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
1.5.5.1.99.gf0ec4


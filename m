From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 13/13] ACPI: thinkpad-acpi: bump up version to 0.22
Date: Sun, 11 Jan 2009 03:01:10 -0200
Message-ID: <1231650070-21722-14-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50094 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751149AbZAKFBT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sun, 11 Jan 2009 00:01:19 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: ibm-acpi-devel@lists.sourceforge.net, linux-acpi@vger.kernel.org, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

It is about time to bump up the version.

Features added since 0.21:  fan suspend/resume support, preserve radio
state across power off (for some radio types), built-in UWB radio
rfkill support and thermal alarm events support.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    6 +++---
 drivers/platform/x86/thinkpad_acpi.c    |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 91c0001..41bc99f 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
-                            Version 0.21
-                           May 29th, 2008
+                            Version 0.22
+                        November 23rd,  2008
 
                Borislav Deianov <borislav@users.sf.net>
              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
@@ -17,7 +17,7 @@ This driver used to be named ibm-acpi until kernel 2.6.21 and release
 0.13-20070314.  It used to be in the drivers/acpi tree, but it was
 moved to the drivers/misc tree and renamed to thinkpad-acpi for kernel
 2.6.22, and release 0.14.  It was moved to drivers/platform/x86 for
-kernel 2.6.29.
+kernel 2.6.29 and release 0.22.
 
 The driver is named "thinkpad-acpi".  In some places, like module
 names, "thinkpad_acpi" is used because of userspace issues.
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 886a430..bcbc051 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -21,7 +21,7 @@
  *  02110-1301, USA.
  */
 
-#define TPACPI_VERSION "0.21"
+#define TPACPI_VERSION "0.22"
 #define TPACPI_SYSFS_VERSION 0x020200
 
 /*
-- 
1.5.6.5


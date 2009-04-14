From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Subject: [PATCH 5/5] thinkpad-acpi: bump up version to 0.23
Date: Mon, 13 Apr 2009 23:44:14 -0300
Message-ID: <1239677054-3221-6-git-send-email-hmh@hmh.eng.br>
References: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:35749 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752439AbZDNCoX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 13 Apr 2009 22:44:23 -0400
In-Reply-To: <1239677054-3221-1-git-send-email-hmh@hmh.eng.br>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net, Henrique de Moraes Holschuh <hmh@hmh.eng.br>

Plenty of high-profile changes, so it deserves a new version number.

Features added since 0.22:
 *  Restrict unsafe LEDs
 *  New race-less brightness control strategy for IBM ThinkPads
 *  Disclose TGID of driver access from userspace (debug)
 *  Warn when deprecated functions are used

Other changes:
 *  Better debug messages in some subdrivers
 *  Removed "hotkey disable" support, since it breaks the driver
 *  Dropped "ibm-acpi" alias

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
---
 Documentation/laptops/thinkpad-acpi.txt |    4 ++--
 drivers/platform/x86/thinkpad_acpi.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/laptops/thinkpad-acpi.txt b/Documentation/laptops/thinkpad-acpi.txt
index 3d76507..e7e9a69 100644
--- a/Documentation/laptops/thinkpad-acpi.txt
+++ b/Documentation/laptops/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
-                            Version 0.22
-                        November 23rd,  2008
+                            Version 0.23
+                          April 10th, 2009
 
                Borislav Deianov <borislav@users.sf.net>
              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index caa774a..912be65 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -21,7 +21,7 @@
  *  02110-1301, USA.
  */
 
-#define TPACPI_VERSION "0.22"
+#define TPACPI_VERSION "0.23"
 #define TPACPI_SYSFS_VERSION 0x020300
 
 /*
-- 
1.6.2.1


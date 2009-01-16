From: Len Brown <lenb@kernel.org>
Subject: [PATCH 13/23] ACPI: thinkpad-acpi: bump up version to 0.22
Date: Fri, 16 Jan 2009 15:25:02 -0500
Message-ID: <aa2fbcec07b0d594808bc3058692395d24eba66e.1232137452.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:52853 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760006AbZAPUZf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:35 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK00MKYZE7KZV4@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:20 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

It is about time to bump up the version.

Features added since 0.21:  fan suspend/resume support, preserve radio
state across power off (for some radio types), built-in UWB radio
rfkill support and thermal alarm events support.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
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
1.5.6.6


From: Len Brown <lenb@kernel.org>
Subject: [PATCH 036/112] ACPI: thinkpad-acpi: bump up version to 0.18
Date: Thu,  7 Feb 2008 04:33:58 -0500
Message-ID: <50efd8310f4f532231b15c6bcb9007c99ac05466.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:32156 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753682AbYBGJgD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:36:03 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>

From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>

The NVRAM polling support for hot keys is reason enough to
bump up the version string.  Do it.

Signed-off-by: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 Documentation/thinkpad-acpi.txt |    4 ++--
 drivers/misc/thinkpad_acpi.c    |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/thinkpad-acpi.txt b/Documentation/thinkpad-acpi.txt
index 70d91a5..7c7bd47 100644
--- a/Documentation/thinkpad-acpi.txt
+++ b/Documentation/thinkpad-acpi.txt
@@ -1,7 +1,7 @@
 		     ThinkPad ACPI Extras Driver
 
-                            Version 0.17
-                         October 04th, 2007
+                            Version 0.18
+                         October 08th, 2007
 
                Borislav Deianov <borislav@users.sf.net>
              Henrique de Moraes Holschuh <hmh@hmh.eng.br>
diff --git a/drivers/misc/thinkpad_acpi.c b/drivers/misc/thinkpad_acpi.c
index 9ff9142..11ee444 100644
--- a/drivers/misc/thinkpad_acpi.c
+++ b/drivers/misc/thinkpad_acpi.c
@@ -21,7 +21,7 @@
  *  02110-1301, USA.
  */
 
-#define IBM_VERSION "0.17"
+#define IBM_VERSION "0.18"
 #define TPACPI_SYSFS_VERSION 0x020101
 
 /*
-- 
1.5.4.23.gef5b9


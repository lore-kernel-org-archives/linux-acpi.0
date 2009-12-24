From: Len Brown <lenb@kernel.org>
Subject: [PATCH 32/34] acer-wmi, msi-wmi: Remove needless DMI MODULE_ALIAS
Date: Thu, 24 Dec 2009 01:24:03 -0500
Message-ID: <4d5f177caf1ef78f5e7eaee75b66b4d534445682.1261635793.git.len.brown@intel.com>
References: <1261635845-18306-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173001pub.verizon.net ([206.46.173.1]:37630 "EHLO
	vms173001pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754953AbZLXTbJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 24 Dec 2009 14:31:09 -0500
Received: from localhost.localdomain ([unknown] [74.104.151.18])
 by vms173001.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KV600GDH8VGSH71@vms173001.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 24 Dec 2009 13:30:57 -0600 (CST)
In-reply-to: <1261635845-18306-1-git-send-email-lenb@kernel.org>
In-reply-to: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
References: <0ad3dc3af8ba028368263b190a7a270f8d5cf5ae.1261635793.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Len Brown <len.brown@intel.com>

From: Thomas Renninger <trenn@suse.de>

Now that we have WMI autoloading
the DMI matching is not needed anymore.

Signed-off-by: Thomas Renninger <trenn@suse.de>
Acked-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
Acked-by: Anisse Astier <anisse@astier.eu>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/acer-wmi.c |    3 ---
 drivers/platform/x86/msi-wmi.c  |   10 ----------
 2 files changed, 0 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 454970d..07d14df 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -96,9 +96,6 @@ struct acer_quirks {
 MODULE_ALIAS("wmi:67C3371D-95A3-4C37-BB61-DD47B491DAAB");
 MODULE_ALIAS("wmi:6AF4F258-B401-42fd-BE91-3D4AC2D7C0D3");
 
-/* Temporary workaround until the WMI sysfs interface goes in */
-MODULE_ALIAS("dmi:*:*Acer*:*:");
-
 /*
  * Interface capability flags
  */
diff --git a/drivers/platform/x86/msi-wmi.c b/drivers/platform/x86/msi-wmi.c
index 0c8fe14..7f77f90 100644
--- a/drivers/platform/x86/msi-wmi.c
+++ b/drivers/platform/x86/msi-wmi.c
@@ -34,16 +34,6 @@ MODULE_LICENSE("GPL");
 MODULE_ALIAS("wmi:551A1F84-FBDD-4125-91DB-3EA8F44F1D45");
 MODULE_ALIAS("wmi:B6F3EEF2-3D2F-49DC-9DE3-85BCE18C62F2");
 
-/* Temporary workaround until the WMI sysfs interface goes in
-		{ "svn", DMI_SYS_VENDOR },
-		{ "pn",  DMI_PRODUCT_NAME },
-		{ "pvr", DMI_PRODUCT_VERSION },
-		{ "rvn", DMI_BOARD_VENDOR },
-		{ "rn",  DMI_BOARD_NAME },
-*/
-
-MODULE_ALIAS("dmi:*:svnMICRO-STARINTERNATIONAL*:pnMS-6638:*");
-
 #define DRV_NAME "msi-wmi"
 #define DRV_PFX DRV_NAME ": "
 
-- 
1.6.0.6


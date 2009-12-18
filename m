From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH 1/2] x86 platform drivers, wmi: Remove needless dmi MODULE_ALIAS
Date: Fri, 18 Dec 2009 15:29:22 +0100
Message-ID: <1261146563-2228-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:57460 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753551AbZLRO35 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Dec 2009 09:29:57 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: Thomas Renninger <trenn@suse.de>, Carlos Corbacho <carlos@strangeworlds.co.uk>, Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org

wmi autoloading came in, so the dmi matching for autoloading
is not needed anymore.

CC: Carlos Corbacho <carlos@strangeworlds.co.uk>
CC: Matthew Garrett <mjg59@srcf.ucam.org>
CC: linux-acpi@vger.kernel.org
CC: Len Brown <lenb@kernel.org>

Signed-off-by: Thomas Renninger <trenn@suse.de>
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
1.6.3


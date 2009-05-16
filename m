From: Len Brown <lenb@kernel.org>
Subject: [PATCH 06/19] eeepc-laptop: fix wlan rfkill state change during init
Date: Sat, 16 May 2009 02:02:03 -0400
Message-ID: <fbc97e4c5c31ea198f912196b1379d7493362800.1242453625.git.len.brown@intel.com>
References: <1242453736-20763-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:28158 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753259AbZEPGCf (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 16 May 2009 02:02:35 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KJQ0060P3FYGA8A@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sat, 16 May 2009 01:02:28 -0500 (CDT)
In-reply-to: <1242453736-20763-1-git-send-email-lenb@kernel.org>
In-reply-to: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
References: <45cb50e646d1560eff01c5ad0f0df3c7fd6148dd.1242453625.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>

From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>

When an rfkill device is registered, the rfkill core will change its
state to the system default. So we need to prepare for state changes
*before* we register it. That means installing the eeepc-specific ACPI
callback which handles the hotplug of the wireless network adaptor.

This problem doesn't occur during normal operation.  You have to

1) Boot with wireless enabled. eeepc-laptop should load automatically.
2) modprobe -r eeepc-laptop
3) modprobe eeepc-laptop

On boot, the default rfkill state will be set to enabled.
With the current core code, step 2) will disable the wireless.
Therefore in step 3), the wireless will change state during registration,
from disabled to enabled.  But without this fix, the PCI device for the
wireless adaptor will not appear.

Signed-off-by: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Acked-by: Matthew Garrett <mjg@redhat.com>
Signed-off-by: Corentin Chary <corentincj@iksaif.net>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/platform/x86/eeepc-laptop.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x86/eeepc-laptop.c
index 6f54fd1..e21f7cd 100644
--- a/drivers/platform/x86/eeepc-laptop.c
+++ b/drivers/platform/x86/eeepc-laptop.c
@@ -649,6 +649,9 @@ static int eeepc_hotk_add(struct acpi_device *device)
 	if (ACPI_FAILURE(status))
 		printk(EEEPC_ERR "Error installing notify handler\n");
 
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
+	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
+
 	if (get_acpi(CM_ASL_WLAN) != -1) {
 		ehotk->eeepc_wlan_rfkill = rfkill_allocate(&device->dev,
 							   RFKILL_TYPE_WLAN);
@@ -704,9 +707,6 @@ static int eeepc_hotk_add(struct acpi_device *device)
 			goto bluetooth_fail;
 	}
 
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P6");
-	eeepc_register_rfkill_notifier("\\_SB.PCI0.P0P7");
-
 	return 0;
 
  bluetooth_fail:
-- 
1.6.0.6


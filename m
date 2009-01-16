From: Len Brown <lenb@kernel.org>
Subject: [PATCH 23/23] ACPI PCI hotplug: harden against panic regression
Date: Fri, 16 Jan 2009 15:25:12 -0500
Message-ID: <d45e0855488032ea62ec5638fb1dcd47367f8ddb.1232137453.git.len.brown@intel.com>
References: <1232137512-17327-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:63052 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759441AbZAPUZ0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 16 Jan 2009 15:25:26 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KDK00K1DZEC2K42@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 16 Jan 2009 14:25:25 -0600 (CST)
In-reply-to: <1232137512-17327-1-git-send-email-lenb@kernel.org>
In-reply-to: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
References: <9abf0eea877d6107d3a8a5c6913450e961fb7050.1232137452.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Len Brown <len.brown@intel.com>

From: James Bottomley <James.Bottomley@HansenPartnership.com>

ACPI hotplug panic with current git head
http://lkml.org/lkml/2009/1/10/136

Rather than reverting the entire commit that causes the crash:
e8c331e963c58b83db24b7d0e39e8c07f687dbc6
"PCI hotplug: introduce functions for ACPI slot detection"

simply harden against it while the changes to
the hotplug code on this particularl machine are understood.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Acked-by: Jesse Barnes <jbarnes@virtuousgeek.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index f09b101..803d9dd 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -266,6 +266,8 @@ static int detect_ejectable_slots(struct pci_bus *pbus)
 	int found = acpi_pci_detect_ejectable(pbus);
 	if (!found) {
 		acpi_handle bridge_handle = acpi_pci_get_bridge_handle(pbus);
+		if (!bridge_handle)
+			return 0;
 		acpi_walk_namespace(ACPI_TYPE_DEVICE, bridge_handle, (u32)1,
 				    is_pci_dock_device, (void *)&found, NULL);
 	}
-- 
1.5.6.6


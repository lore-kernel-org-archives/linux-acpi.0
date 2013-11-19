From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] PCI / hotplug / ACPI: Drop unused acpiphp_debug declaration
Date: Tue, 19 Nov 2013 16:15:35 +0200
Message-ID: <1384870535-20532-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40706 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750823Ab3KSOPy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 19 Nov 2013 09:15:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>

Commit bd950799d951 (PCI: acpiphp: Convert to dynamic debug) removed users
of acpiphp_debug variable and the variable itself but the declaration was
left in the header file. Drop this unused declaration.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/hotplug/acpiphp.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp.h b/drivers/pci/hotplug/acpiphp.h
index 26100f510b10..1592dbe4f904 100644
--- a/drivers/pci/hotplug/acpiphp.h
+++ b/drivers/pci/hotplug/acpiphp.h
@@ -176,7 +176,6 @@ u8 acpiphp_get_latch_status(struct acpiphp_slot *slot);
 u8 acpiphp_get_adapter_status(struct acpiphp_slot *slot);
 
 /* variables */
-extern bool acpiphp_debug;
 extern bool acpiphp_disabled;
 
 #endif /* _ACPIPHP_H */
-- 
1.8.4.3


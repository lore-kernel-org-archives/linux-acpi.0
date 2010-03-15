From: Len Brown <lenb@kernel.org>
Subject: [PATCH 16/34] acpiphp: Execute ACPI _REG method for hotadded devices
Date: Sun, 14 Mar 2010 21:40:55 -0400
Message-ID: <d06070509147c948a06056da619c9dc2ed349805.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:32880 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756538Ab0COB5o (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 14 Mar 2010 21:57:44 -0400
Received: from sony ([unknown] [192.102.209.1]) by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0KZA00MQQW40K7A0@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 14 Mar 2010 20:57:37 -0500 (CDT)
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
In-reply-to: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
References: <9593bd07ec8eaaa30aba4281b2b3273282fc344f.1268617225.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Shaohua Li <shaohua.li@intel.com>, Len Brown <len.brown@intel.com>

From: Shaohua Li <shaohua.li@intel.com>

Per ACPI spec, _ERG method should be executed before device driver
gets control for hotpluged device. Firmware might do some configuration
there. See http://bugzilla.kernel.org/show_bug.cgi?id=10805. In this
machine, _REG method of docked device will configure cardbus bridge.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Tested-by: Paul Martin <pm@debian.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/pci/hotplug/acpiphp_glue.c |   19 +++++++++++++++++++
 1 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index cb2fd01..b5dad9f 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -749,6 +749,24 @@ static int acpiphp_bus_trim(acpi_handle handle)
 	return retval;
 }
 
+static void acpiphp_set_acpi_region(struct acpiphp_slot *slot)
+{
+	struct acpiphp_func *func;
+	union acpi_object params[2];
+	struct acpi_object_list arg_list;
+
+	list_for_each_entry(func, &slot->funcs, sibling) {
+		arg_list.count = 2;
+		arg_list.pointer = params;
+		params[0].type = ACPI_TYPE_INTEGER;
+		params[0].integer.value = ACPI_ADR_SPACE_PCI_CONFIG;
+		params[1].type = ACPI_TYPE_INTEGER;
+		params[1].integer.value = 1;
+		/* _REG is optional, we don't care about if there is failure */
+		acpi_evaluate_object(func->handle, "_REG", &arg_list, NULL);
+	}
+}
+
 /**
  * enable_device - enable, configure a slot
  * @slot: slot to be enabled
@@ -805,6 +823,7 @@ static int __ref enable_device(struct acpiphp_slot *slot)
 	pci_bus_assign_resources(bus);
 	acpiphp_sanitize_bus(bus);
 	acpiphp_set_hpp_values(bus);
+	acpiphp_set_acpi_region(slot);
 	pci_enable_bridges(bus);
 	pci_bus_add_devices(bus);
 
-- 
1.7.0.2.201.g80978


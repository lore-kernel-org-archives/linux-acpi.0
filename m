From: Shaohua Li <shaohua.li@intel.com>
Subject: [PATCH] acpiphp: Execute ACPI _REG method for hotadded devices
Date: Thu, 25 Feb 2010 10:59:34 +0800
Message-ID: <1267066774-27764-1-git-send-email-shaohua.li@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:40580 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758841Ab0BYC7y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 24 Feb 2010 21:59:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: lenb@kernel.org, akpm@linux-foundation.org, pm@debian.org, Shaohua Li <shaohua.li@intel.com>

Per ACPI spec, _ERG method should be executed before device driver
gets control for hotpluged device. Firmware might do some configuration
there. See http://bugzilla.kernel.org/show_bug.cgi?id=10805. In this
machine, _REG method of docked device will configure cardbus bridge.

Signed-off-by: Shaohua Li <shaohua.li@intel.com>
Tested-by: Paul Martin <pm@debian.org>
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
1.6.3.3


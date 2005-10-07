From: Kristen Accardi <kristen.c.accardi@intel.com>
Subject: [patch 1/2] acpiphp: allocate resources for adapters with bridges
Date: Fri, 07 Oct 2005 10:45:46 -0700
Message-ID: <1128707147.11020.10.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030486AbVJGRqB@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: pcihpd-discuss@lists.sourceforge.net, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Cc: rajesh.shah@intel.com, greg@kroah.com, len.brown@intel.com
List-Id: linux-acpi@vger.kernel.org

Allocate resources for adapters with p2p bridges.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>

diff -uprN -X linux-2.6.14-rc2/Documentation/dontdiff linux-2.6.14-rc2/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.14-rc2-kca1/drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6.14-rc2/drivers/pci/hotplug/acpiphp_glue.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.14-rc2-kca1/drivers/pci/hotplug/acpiphp_glue.c	2005-09-28 10:43:15.000000000 -0700
@@ -58,6 +58,9 @@ static LIST_HEAD(bridge_list);
 
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
 static void handle_hotplug_event_func (acpi_handle, u32, void *);
+static void acpiphp_sanitize_bus(struct pci_bus *bus);
+static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
+
 
 /*
  * initialization & terminatation routines
@@ -207,6 +210,9 @@ register_slot(acpi_handle handle, u32 lv
 		slot->flags |= (SLOT_ENABLED | SLOT_POWEREDON);
 	}
 
+	/* store the handle in the slot for later. */
+	slot->handle = handle;
+
 	/* install notify handler */
 	status = acpi_install_notify_handler(handle,
 					     ACPI_SYSTEM_NOTIFY,
@@ -796,7 +802,12 @@ static int enable_device(struct acpiphp_
 		}
 	}
 
+	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
+	acpiphp_sanitize_bus(bus);
+	acpiphp_set_hpp_values(slot->handle, bus);
+	pci_enable_bridges(bus);
+	acpiphp_configure_ioapics(slot->handle);
 	pci_bus_add_devices(bus);
 
 	/* associate pci_dev to our representation */
diff -uprN -X linux-2.6.14-rc2/Documentation/dontdiff linux-2.6.14-rc2/drivers/pci/hotplug/acpiphp.h linux-2.6.14-rc2-kca1/drivers/pci/hotplug/acpiphp.h
--- linux-2.6.14-rc2/drivers/pci/hotplug/acpiphp.h	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.14-rc2-kca1/drivers/pci/hotplug/acpiphp.h	2005-09-28 10:43:15.000000000 -0700
@@ -119,6 +119,7 @@ struct acpiphp_slot {
 	struct list_head funcs;		/* one slot may have different
 					   objects (i.e. for each function) */
 	struct semaphore crit_sect;
+	acpi_handle handle;
 
 	u32		id;		/* slot id (serial #) for hotplug core */
 	u8		device;		/* pci device# */

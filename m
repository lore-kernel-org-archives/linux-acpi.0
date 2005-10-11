From: Kristen Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [Pcihpd-discuss] [patch 1/2] acpiphp: allocate resources for
 adapters with bridges
Date: Tue, 11 Oct 2005 16:53:02 -0700
Message-ID: <1129074782.15526.28.camel@whizzy>
References: <1128707147.11020.10.camel@whizzy>
	 <87mzlgkeil.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <87mzlgkeil.wl%muneda.takahiro-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: MUNEDA Takahiro <muneda.takahiro-+CUm20s59erQFUHtdCDX3A@public.gmane.org>
Cc: pcihpd-discuss-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, rajesh.shah-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Allocate resources for adapters with bridges on them.

Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
I changed the patch to not store the acpi_handle in the acpiphp_slot
structure, but grab it out of the device structure instead.  However, I
don't have an adapter that will really test to see if this works
properly, so if your adapter will work, then please give it a try and
let me know if it fails.

diff -uprN -X linux-2.6.14-rc3/Documentation/dontdiff linux-2.6.14-rc3.orig/drivers/pci/hotplug/acpiphp_glue.c linux-2.6.14-rc3/drivers/pci/hotplug/acpiphp_glue.c
--- linux-2.6.14-rc3.orig/drivers/pci/hotplug/acpiphp_glue.c	2005-08-28 16:41:01.000000000 -0700
+++ linux-2.6.14-rc3/drivers/pci/hotplug/acpiphp_glue.c	2005-10-11 16:30:58.000000000 -0700
@@ -58,6 +58,9 @@ static LIST_HEAD(bridge_list);
 
 static void handle_hotplug_event_bridge (acpi_handle, u32, void *);
 static void handle_hotplug_event_func (acpi_handle, u32, void *);
+static void acpiphp_sanitize_bus(struct pci_bus *bus);
+static void acpiphp_set_hpp_values(acpi_handle handle, struct pci_bus *bus);
+
 
 /*
  * initialization & terminatation routines
@@ -796,9 +799,14 @@ static int enable_device(struct acpiphp_
 		}
 	}
 
+	pci_bus_size_bridges(bus);
 	pci_bus_assign_resources(bus);
+	acpiphp_sanitize_bus(bus);
+	pci_enable_bridges(bus);
 	pci_bus_add_devices(bus);
-
+	acpiphp_set_hpp_values(DEVICE_ACPI_HANDLE(&bus->self->dev), bus);
+	acpiphp_configure_ioapics(DEVICE_ACPI_HANDLE(&bus->self->dev));
+		
 	/* associate pci_dev to our representation */
 	list_for_each (l, &slot->funcs) {
 		func = list_entry(l, struct acpiphp_func, sibling);



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl

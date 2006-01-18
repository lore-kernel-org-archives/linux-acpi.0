From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
Date: Wed, 18 Jan 2006 22:11:40 +0100
Message-ID: <20060118211140.GA2058@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy> <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:30120 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1160999AbWARVR3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 18 Jan 2006 16:17:29 -0500
Content-Disposition: inline
In-Reply-To: <1137609747.31839.6.camel@whizzy>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com, linux-acpi@vger.kernel.org


Few cleanups for acpiphp_glue, and spelling fix in warning. It still
does not use consistent function definitions, but lets pretentd it is
to fit into 80 columns.

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-mm/drivers/pci/hotplug/acpiphp_glue.c	2006-01-18 12:52:02.000000000 +0100
+++ linux-mm/drivers/pci/hotplug/acpiphp_glue.c	2006-01-18 22:09:08.000000000 +0100
@@ -91,14 +94,12 @@
 	acpi_handle tmp;
 
 	status = acpi_get_handle(handle, "_ADR", &tmp);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status))
 		return 0;
-	}
 
 	status = acpi_get_handle(handle, "_EJ0", &tmp);
-	if (ACPI_FAILURE(status)) {
+	if (ACPI_FAILURE(status))
 		return 0;
-	}
 
 	return 1;
 }
@@ -470,7 +473,7 @@
 			dbg("%s: _STA evaluation failure\n", __FUNCTION__);
 			return 0;
 		}
-		if ((tmp & ACPI_STA_FUNCTIONING) == 0)
+		if (!(tmp & ACPI_STA_FUNCTIONING))
 			/* don't register this object */
 			return 0;
 	}
@@ -503,12 +508,12 @@
 		return 0;
 	}
 
 	/* search P2P bridges under this host bridge */
 	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, handle, (u32)1,
 				     find_p2p_bridge, pci_bus, NULL);
 
 	if (ACPI_FAILURE(status))
-		warn("find_p2p_bridge faied (error code = 0x%x)\n",status);
+		warn("find_p2p_bridge failed (error code = 0x%x)\n", status);
 
 	return 0;
 }
@@ -587,7 +593,7 @@
 	}
 }
 
-static struct pci_dev * get_apic_pci_info(acpi_handle handle)
+static struct pci_dev *get_apic_pci_info(acpi_handle handle)
 {
 	struct acpi_pci_id id;
 	struct pci_bus *bus;
@@ -891,8 +897,8 @@
  * this slot and return the one that represents the given
  * pci_dev structure.
  */
-static struct acpiphp_func * get_func(struct acpiphp_slot *slot,
-					struct pci_dev *dev)
+static struct
+acpiphp_func *get_func(struct acpiphp_slot *slot, struct pci_dev *dev)
 {
 	struct list_head *l;
 	struct acpiphp_func *func;
@@ -912,8 +918,7 @@
 /** acpiphp_max_busnr - find the max reserved busnr for this bus
  *  @bus: the bus to scan
  */
-static unsigned char
-acpiphp_max_busnr(struct pci_bus *bus)
+static unsigned char acpiphp_max_busnr(struct pci_bus *bus)
 {
 	struct list_head *tmp;
 	unsigned char max, n;
@@ -1476,9 +1481,9 @@
 	if (is_root_bridge(handle)) {
 		acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
 				handle_hotplug_event_bridge, NULL);
-			(*count)++;
+		(*count)++;
 	}
-	return AE_OK ;
+	return AE_OK;
 }
 
 static struct acpi_pci_driver acpi_pci_hp_driver = {


-- 
Thanks, Sharp!

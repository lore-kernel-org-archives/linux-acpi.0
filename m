From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [Pcihpd-discuss] [PATCH] acpiphp - slot management fix - V2
Date: Tue, 14 Feb 2006 18:17:20 +0900
Message-ID: <43F1A020.8040706@jp.fujitsu.com>
References: <87acdrp5y9.wl%muneda.takahiro@jp.fujitsu.com>	<20060127041425.GA20453@kroah.com>	<87slr7k8qi.wl%muneda.takahiro@jp.fujitsu.com>	<20060129034502.GA7168@kroah.com>	<1138731618.18768.5.camel@whizzy>	<20060207201304.GA18648@kroah.com>	<1139599704.26632.53.camel@whizzy>	<874q34f0xb.wl%muneda.takahiro@jp.fujitsu.com> <87zmkue7kw.wl%muneda.takahiro@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:7127 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030525AbWBNJTY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Feb 2006 04:19:24 -0500
In-Reply-To: <87zmkue7kw.wl%muneda.takahiro@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: MUNEDA Takahiro <muneda.takahiro@jp.fujitsu.com>
Cc: Kristen Accardi <kristen.c.accardi@intel.com>, Greg KH <greg@kroah.com>, pavel@ucw.cz, pcihpd-discuss@lists.sourceforge.net, linux-acpi@vger.kernel.org, len.brown@intel.com

MUNEDA Takahiro wrote:
> -static void __exit cleanup_slots (void)
> +void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *acpiphp_slot)
>  {
>  	struct list_head *tmp, *n;
>  	struct slot *slot;
> +	int retval = 0;
>  
>  	list_for_each_safe (tmp, n, &slot_list) {
>  		/* memory will be freed in release_slot callback */
>  		slot = list_entry(tmp, struct slot, slot_list);
> +		if (slot->acpi_slot->sun != acpiphp_slot->sun)
> +			continue;
> +
> +		spin_lock(&list_lock);
>  		list_del(&slot->slot_list);
> -		pci_hp_deregister(slot->hotplug_slot);
> +		spin_unlock(&list_lock);
> +		info ("Slot [%s] unregistered\n", slot->hotplug_slot->name);
> +
> +		retval = pci_hp_deregister(slot->hotplug_slot);
> +		if (retval)
> +			err("pci_hp_deregister failed with error %d\n", retval);
>  	}
>  }

With your patch, I think this list_for_each_safe() loop becomes
needless and it should be removed. In addition, slot_list is no
longer needed.

Here is a sample patch against your patch. Note that I have not
tested it very much.

Thanks,
Kenji Kaneshige


 drivers/pci/hotplug/acpiphp.h      |    3 +--
 drivers/pci/hotplug/acpiphp_core.c |   32 ++++++++------------------------
 2 files changed, 9 insertions(+), 26 deletions(-)

Index: linux-2.6.16-rc2-mm1/drivers/pci/hotplug/acpiphp.h
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/pci/hotplug/acpiphp.h	2006-02-14 17:05:47.000000000 +0900
+++ linux-2.6.16-rc2-mm1/drivers/pci/hotplug/acpiphp.h	2006-02-14 18:02:38.000000000 +0900
@@ -61,8 +61,6 @@
  */
 struct slot {
 	struct hotplug_slot	*hotplug_slot;
-	struct list_head	slot_list;
-
 	struct acpiphp_slot	*acpi_slot;
 };
 
@@ -118,6 +116,7 @@
 	struct acpiphp_bridge *bridge;	/* parent */
 	struct list_head funcs;		/* one slot may have different
 					   objects (i.e. for each function) */
+	struct slot *slot;
 	struct mutex crit_sect;
 
 	u8		device;		/* pci device# */
Index: linux-2.6.16-rc2-mm1/drivers/pci/hotplug/acpiphp_core.c
===================================================================
--- linux-2.6.16-rc2-mm1.orig/drivers/pci/hotplug/acpiphp_core.c	2006-02-14 17:05:47.000000000 +0900
+++ linux-2.6.16-rc2-mm1/drivers/pci/hotplug/acpiphp_core.c	2006-02-14 18:02:50.000000000 +0900
@@ -44,9 +44,6 @@
 #include "pci_hotplug.h"
 #include "acpiphp.h"
 
-static LIST_HEAD(slot_list);
-static DEFINE_SPINLOCK(list_lock);
-
 #define MY_NAME	"acpiphp"
 
 static int debug;
@@ -379,6 +376,8 @@
 	slot->hotplug_slot->info->max_bus_speed = PCI_SPEED_UNKNOWN;
 	slot->hotplug_slot->info->cur_bus_speed = PCI_SPEED_UNKNOWN;
 
+	acpiphp_slot->slot = slot;
+
 	make_slot_name(slot);
 
 	retval = pci_hp_register(slot->hotplug_slot);
@@ -387,10 +386,6 @@
 		goto error_name;
  	}
 
-	/* add slot to our internal list */
-	spin_lock(&list_lock);
-	list_add(&slot->slot_list, &slot_list);
-	spin_unlock(&list_lock);
 	info("Slot [%s] registered\n", slot->hotplug_slot->name);
 
 	return 0;
@@ -409,25 +404,14 @@
 
 void acpiphp_unregister_hotplug_slot(struct acpiphp_slot *acpiphp_slot)
 {
-	struct list_head *tmp, *n;
-	struct slot *slot;
+	struct slot *slot = acpiphp_slot->slot;
 	int retval = 0;
 
-	list_for_each_safe (tmp, n, &slot_list) {
-		/* memory will be freed in release_slot callback */
-		slot = list_entry(tmp, struct slot, slot_list);
-		if (slot->acpi_slot->sun != acpiphp_slot->sun)
-			continue;
-
-		spin_lock(&list_lock);
-		list_del(&slot->slot_list);
-		spin_unlock(&list_lock);
-		info ("Slot [%s] unregistered\n", slot->hotplug_slot->name);
-
-		retval = pci_hp_deregister(slot->hotplug_slot);
-		if (retval)
-			err("pci_hp_deregister failed with error %d\n", retval);
-	}
+	info ("Slot [%s] unregistered\n", slot->hotplug_slot->name);
+
+	retval = pci_hp_deregister(slot->hotplug_slot);
+	if (retval)
+		err("pci_hp_deregister failed with error %d\n", retval);
 }
 
 


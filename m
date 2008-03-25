From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 11/16] PCI slot: Remove useless release handler (Not
	for mainline!)
Date: Mon, 24 Mar 2008 21:08:44 -0600
Message-ID: <20080325030844.GD11575@ldl.fc.hp.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com> <47E336FA.2060104@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:41807 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbYCYDIq (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Mar 2008 23:08:46 -0400
Content-Disposition: inline
In-Reply-To: <47E336FA.2060104@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

* Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>:
> The release() handler of struct pci_slot never be called because
> pci_hp_deregister() calls pci_slot_destroy() after setting
> slot->release with NULL. So we don't need release() handler of struct
> pci_slot. In addition, we don't need pci_slot_add_hotplug().

Thanks, this was a good change. I've tested and merged it.

I did make two small changes though:

> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> 
> ---
>  drivers/pci/hotplug/pci_hotplug_core.c |   15 -----------
>  drivers/pci/slot.c                     |   44 ---------------------------------
>  include/linux/pci.h                    |    3 --
>  3 files changed, 1 insertion(+), 61 deletions(-)
> 
> Index: linux-2.6.25-rc6/drivers/pci/slot.c
> ===================================================================
> --- linux-2.6.25-rc6.orig/drivers/pci/slot.c
> +++ linux-2.6.25-rc6/drivers/pci/slot.c
> @@ -67,9 +67,6 @@ static void pci_slot_release(struct kobj
>  
>  	list_del(&slot->list);
>  
> -	if (slot->release)
> -		slot->release(slot);
> -
>  	remove_sysfs_files(slot);
>  	kfree(slot);
>  }
> @@ -79,47 +76,6 @@ static struct kobj_type pci_slot_ktype =
>  	.release = &pci_slot_release,
>  };
>  
> -int pci_slot_add_hotplug(struct pci_bus *parent, int slot_nr,
> -			 void (*release)(struct pci_slot *))
> -{
> -	struct pci_slot *slot;
> -	int retval, found;
> -
> -	retval = found = 0;
> -
> -	down_write(&pci_bus_sem);
> -
> -	/* This slot should have already been created, so look for it. If
> -	 * we can't find it, return -EEXIST.
> -	 */
> -	list_for_each_entry(slot, &parent->slots, list) {
> -		if (slot->number == slot_nr) {
> -			found = 1;
> -			break;
> -		}
> -	}
> -
> -	if (!found) {
> -		pr_debug("%s: slot not found\n", __func__);
> -		retval = -EEXIST;
> -		goto out;
> -	}
> -
> -	if (slot->release) {
> -		pr_debug("%s: already claimed\n", __func__);
> -		retval = -EBUSY;
> -		goto out;
> -	}
> -
> -	pr_debug("%s: adding release function to %x:%d\n",
> -		 __func__, parent->number, slot_nr);
> -	slot->release = release;
> - out:
> -	up_write(&pci_bus_sem);
> -	return retval;
> -}
> -EXPORT_SYMBOL_GPL(pci_slot_add_hotplug);
> -
>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  				 const char *name)
>  {
> Index: linux-2.6.25-rc6/include/linux/pci.h
> ===================================================================
> --- linux-2.6.25-rc6.orig/include/linux/pci.h
> +++ linux-2.6.25-rc6/include/linux/pci.h
> @@ -135,7 +135,6 @@ struct pci_slot {
>  	struct hotplug_slot *hotplug;	/* Hotplug info (migrate over time) */
>  	unsigned char number;		/* PCI_SLOT(pci_dev->devfn) */
>  	struct kobject kobj;
> -	void (*release)(struct pci_slot *);
>  };
>  
>  /*
> @@ -494,8 +493,6 @@ struct pci_bus *pci_add_new_bus(struct p
>  				int busnr);
>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
>  				 const char *name);
> -int pci_slot_add_hotplug(struct pci_bus *parent, int slot_nr,
> -			 void (*release)(struct pci_slot *));
>  int pci_destroy_slot(struct pci_slot *slot);
>  int pci_scan_slot(struct pci_bus *bus, int devfn);
>  struct pci_dev *pci_scan_single_device(struct pci_bus *bus, int devfn);
> Index: linux-2.6.25-rc6/drivers/pci/hotplug/pci_hotplug_core.c
> ===================================================================
> --- linux-2.6.25-rc6.orig/drivers/pci/hotplug/pci_hotplug_core.c
> +++ linux-2.6.25-rc6/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -537,12 +537,6 @@ static struct hotplug_slot *get_slot_fro
>  	return NULL;
>  }
>  
> -static void hotplug_release(struct pci_slot *slot)
> -{
> -	struct hotplug_slot *hotplug = slot->hotplug;
> -	hotplug->release(hotplug);
> -}
> -
>  /**
>   * pci_hp_register - register a hotplug_slot with the PCI hotplug subsystem
>   * @slot: pointer to the &struct hotplug_slot to register
> @@ -576,12 +570,6 @@ int pci_hp_register(struct hotplug_slot 
>  	if (IS_ERR(pci_slot))
>  		return PTR_ERR(pci_slot);

This prevents multiple hotplug drivers from claiming the same
slot.

+       if (pci_slot->hotplug) {
+               dbg("%s: already claimed\n", __func__);
+               pci_destroy_slot(pci_slot);
+               return -EBUSY;

>  
> -	result = pci_slot_add_hotplug(bus, slot_nr, hotplug_release);
> -	if (result) {
> -		pci_destroy_slot(pci_slot);
> -		return result;
> -	}
> -
>  	slot->pci_slot = pci_slot;
>  	pci_slot->hotplug = slot;
>  
> @@ -631,8 +619,7 @@ int pci_hp_deregister(struct hotplug_slo
>  	fs_remove_slot(slot);
>  	dbg("Removed slot %s from the list\n", hotplug->name);
>  
> -	hotplug_release(slot);
> -	slot->release = NULL;
> +	hotplug->release(hotplug);

+       slot->hotplug = NULL;

The above is needed if pci_slot is loaded, and you wish to
repeatedly load/unload acpiphp/pciehp/other hp drivers.

Thanks,

/ac

>  	pci_destroy_slot(slot);
>  
>  	return 0;
> 
> 

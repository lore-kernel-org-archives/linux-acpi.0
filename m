From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH 12/16] PCI slot: Use .default_attrs for address file
	(Not for mainline!)
Date: Mon, 24 Mar 2008 21:31:11 -0600
Message-ID: <20080325033111.GA26434@ldl.fc.hp.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com> <47E3375B.4020606@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0007.atlanta.hp.com ([15.192.0.44]:24305 "EHLO
	g5t0007.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbYCYDbN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Mar 2008 23:31:13 -0400
Content-Disposition: inline
In-Reply-To: <47E3375B.4020606@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

* Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>:
> Use .default_attrs for 'address' file. This can simplify the code.

Thanks, merged.

/ac

> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> 
> ---
>  drivers/pci/slot.c |   36 +++++++++---------------------------
>  1 file changed, 9 insertions(+), 27 deletions(-)
> 
> Index: linux-2.6.25-rc6/drivers/pci/slot.c
> ===================================================================
> --- linux-2.6.25-rc6.orig/drivers/pci/slot.c
> +++ linux-2.6.25-rc6/drivers/pci/slot.c
> @@ -39,25 +39,6 @@ static ssize_t address_read_file(struct 
>  					slot->bus->number, slot->number);
>  }
>  
> -static struct pci_slot_attribute pci_slot_attr_address = {
> -	.attr = { .name = "address", .mode = S_IFREG | S_IRUGO },
> -	.show = address_read_file,
> -};
> -
> -static void remove_sysfs_files(struct pci_slot *slot)
> -{
> -	sysfs_remove_file(&slot->kobj, &pci_slot_attr_address.attr);
> -}
> -
> -static int create_sysfs_files(struct pci_slot *slot)
> -{
> -	int result;
> -
> -	result = sysfs_create_file(&slot->kobj, &pci_slot_attr_address.attr);
> -
> -	return result;
> -}
> -
>  static void pci_slot_release(struct kobject *kobj)
>  {
>  	struct pci_slot *slot = to_pci_slot(kobj);
> @@ -67,13 +48,21 @@ static void pci_slot_release(struct kobj
>  
>  	list_del(&slot->list);
>  
> -	remove_sysfs_files(slot);
>  	kfree(slot);
>  }
>  
> +static struct pci_slot_attribute pci_slot_attr_address =
> +	__ATTR(address, (S_IFREG | S_IRUGO), address_read_file, NULL);
> +
> +static struct attribute *pci_slot_default_attrs[] = {
> +	&pci_slot_attr_address.attr,
> +	NULL,
> +};
> +
>  static struct kobj_type pci_slot_ktype = {
>  	.sysfs_ops = &pci_slot_sysfs_ops,
>  	.release = &pci_slot_release,
> +	.default_attrs = pci_slot_default_attrs,
>  };
>  
>  struct pci_slot *pci_create_slot(struct pci_bus *parent, int slot_nr,
> @@ -114,10 +103,6 @@ struct pci_slot *pci_create_slot(struct 
>  		goto err;
>  	}
>  
> -	err = create_sysfs_files(slot);
> -	if (err)
> -		goto unregister;
> -
>  	INIT_LIST_HEAD(&slot->list);
>  	list_add(&slot->list, &parent->slots);
>  
> @@ -127,9 +112,6 @@ struct pci_slot *pci_create_slot(struct 
>   out:
>  	up_write(&pci_bus_sem);
>  	return slot;
> -
> - unregister:
> -	kobject_put(&slot->kobj);
>   err:
>  	kfree(slot);
>  	slot = ERR_PTR(err);
> 
> 

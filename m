From: Alex Chiang <achiang@hp.com>
Subject: Re: [PATCH  4/16][BUG] PCI slot: Add missing semaphore for slot
	release (Not for mainline!)
Date: Fri, 21 Mar 2008 10:57:52 -0600
Message-ID: <20080321165752.GI17292@ldl.fc.hp.com>
References: <20080318210539.GA30421@ldl.fc.hp.com> <47E33472.1000602@jp.fujitsu.com> <47E335AB.6020709@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:15241 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757073AbYCUQ5x (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 21 Mar 2008 12:57:53 -0400
Content-Disposition: inline
In-Reply-To: <47E335AB.6020709@jp.fujitsu.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Cc: Greg KH <gregkh@suse.de>, Gary Hade <garyhade@us.ibm.com>, Kristen Carlson Accardi <kristen.c.accardi@intel.com>, Matthew Wilcox <matthew@wil.cx>, warthog19@eaglescrag.net, rick.jones2@hp.com, linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, linux-acpi@vger.kernel.org

* Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>:
> Add missing pci_bus sem into pci_destroy_slot(). There is possible
> race condition because current code doesn't have any serialization
> in the destroy path.

Merged, thanks.

/ac

> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> 
> ---
>  drivers/pci/slot.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> Index: linux-2.6.25-rc6/drivers/pci/slot.c
> ===================================================================
> --- linux-2.6.25-rc6.orig/drivers/pci/slot.c
> +++ linux-2.6.25-rc6/drivers/pci/slot.c
> @@ -196,7 +196,9 @@ EXPORT_SYMBOL_GPL(pci_create_slot);
>  
>  int pci_destroy_slot(struct pci_slot *slot)
>  {
> +	down_write(&pci_bus_sem);
>  	kobject_put(&slot->kobj);
> +	up_write(&pci_bus_sem);
>  
>  	dbg("%s: decreased refcount to %d on %x:%d\n", __func__,
>  		slot->kobj.kref.refcount, slot->bus->number, slot->number);
> 
> 

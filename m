From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
Subject: Re: [PATCH] PCI/ACPI: fix wrong ref count handling in acpi_pci_bind()
Date: Thu, 28 May 2009 09:09:19 +0900
Message-ID: <4A1DD62F.50707@jp.fujitsu.com>
References: <4A1B32E3.7060801@jp.fujitsu.com> <200905260946.02184.bjorn.helgaas@hp.com> <20090526234148.GA12468@ldl.fc.hp.com> <4A1C8208.6090707@jp.fujitsu.com> <alpine.LFD.2.00.0905271756060.25587@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:51096 "EHLO
	fgwmail6.fujitsu.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759821AbZE1AJi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 27 May 2009 20:09:38 -0400
In-Reply-To: <alpine.LFD.2.00.0905271756060.25587@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Alex Chiang <achiang@hp.com>, Bjorn Helgaas <bjorn.helgaas@hp.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, linux acpi <linux-acpi@vger.kernel.org>

Thank you for updating the patch.
It looks good to me.

Thanks,
Kenji Kaneshige


Len Brown wrote:
>>From dacd2549ca61ddbdd1ed62a76ca95dea3f0e02c6 Mon Sep 17 00:00:00 2001
> From: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Date: Tue, 26 May 2009 09:08:03 +0900
> Subject: [PATCH] PCI/ACPI: fix wrong ref count handling in acpi_pci_bind()
> 
> The 'dev' field of struct acpi_pci_data is having a pointer to struct
> pci_dev without incrementing the reference counter. Because of this, I
> got the following kernel oops when I was doing some pci hotplug
> operations. This patch fixes this bug by replacing wrong hand-made
> pci_find_slot() with pci_get_slot() in acpi_pci_bind().
> 
>  BUG: unable to handle kernel NULL pointer dereference at 00000000000000e8
>  IP: [<ffffffff803f0e9b>] acpi_pci_unbind+0xb1/0xdd
> 
>  Call Trace:
>   [<ffffffff803ecee4>] acpi_bus_remove+0x54/0x68
>   [<ffffffff803ecf6d>] acpi_bus_trim+0x75/0xe3
>   [<ffffffffa0345ddd>] acpiphp_disable_slot+0x16d/0x1e0 [acpiphp]
>   [<ffffffffa03441f0>] disable_slot+0x20/0x60 [acpiphp]
>   [<ffffffff803cfc18>] power_write_file+0xc8/0x110
>   [<ffffffff803c6a54>] pci_slot_attr_store+0x24/0x30
>   [<ffffffff803469ce>] sysfs_write_file+0xce/0x140
>   [<ffffffff802e94e7>] vfs_write+0xc7/0x170
>   [<ffffffff802e9aa0>] sys_write+0x50/0x90
>   [<ffffffff8020bd6b>] system_call_fastpath+0x16/0x1b
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
> Reviewed-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> Reviewed-by: Alex Chiang <achiang@hp.com>
> Tested-by: Alex Chiang <achiang@hp.com>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> 
> as applied to the acpi tree...
> 
> cheers,
> -Len
> 
>  drivers/acpi/pci_bind.c |   24 ++++++------------------
>  1 files changed, 6 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/acpi/pci_bind.c b/drivers/acpi/pci_bind.c
> index 95650f8..bc46de3 100644
> --- a/drivers/acpi/pci_bind.c
> +++ b/drivers/acpi/pci_bind.c
> @@ -116,9 +116,6 @@ int acpi_pci_bind(struct acpi_device *device)
>  	struct acpi_pci_data *pdata;
>  	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>  	acpi_handle handle;
> -	struct pci_dev *dev;
> -	struct pci_bus *bus;
> -
>  
>  	if (!device || !device->parent)
>  		return -EINVAL;
> @@ -176,20 +173,9 @@ int acpi_pci_bind(struct acpi_device *device)
>  	 * Locate matching device in PCI namespace.  If it doesn't exist
>  	 * this typically means that the device isn't currently inserted
>  	 * (e.g. docking station, port replicator, etc.).
> -	 * We cannot simply search the global pci device list, since
> -	 * PCI devices are added to the global pci list when the root
> -	 * bridge start ops are run, which may not have happened yet.
>  	 */
> -	bus = pci_find_bus(data->id.segment, data->id.bus);
> -	if (bus) {
> -		list_for_each_entry(dev, &bus->devices, bus_list) {
> -			if (dev->devfn == PCI_DEVFN(data->id.device,
> -						    data->id.function)) {
> -				data->dev = dev;
> -				break;
> -			}
> -		}
> -	}
> +	data->dev = pci_get_slot(pdata->bus,
> +				PCI_DEVFN(data->id.device, data->id.function));
>  	if (!data->dev) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "Device %04x:%02x:%02x.%d not present in PCI namespace\n",
> @@ -259,9 +245,10 @@ int acpi_pci_bind(struct acpi_device *device)
>  
>        end:
>  	kfree(buffer.pointer);
> -	if (result)
> +	if (result) {
> +		pci_dev_put(data->dev);
>  		kfree(data);
> -
> +	}
>  	return result;
>  }
>  
> @@ -303,6 +290,7 @@ static int acpi_pci_unbind(struct acpi_device *device)
>  	if (data->dev->subordinate) {
>  		acpi_pci_irq_del_prt(data->id.segment, data->bus->number);
>  	}
> +	pci_dev_put(data->dev);
>  	kfree(data);
>  
>        end:



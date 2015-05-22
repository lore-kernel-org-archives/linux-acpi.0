From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Patch v3 5/7] PCI/ACPI: Consolidate common PCI host bridge code
 into ACPI core
Date: Fri, 22 May 2015 21:49:10 +0800
Message-ID: <555F33D6.3030907@linaro.org>
References: <1431593803-5213-1-git-send-email-jiang.liu@linux.intel.com> <1431593803-5213-6-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35168 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932279AbbEVNtW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 May 2015 09:49:22 -0400
Received: by pdea3 with SMTP id a3so20078914pde.2
        for <linux-acpi@vger.kernel.org>; Fri, 22 May 2015 06:49:22 -0700 (PDT)
In-Reply-To: <1431593803-5213-6-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Yijing Wang <wangyijing@huawei.com>, Len Brown <lenb@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org

On 2015=E5=B9=B405=E6=9C=8814=E6=97=A5 16:56, Jiang Liu wrote:
> Introduce common interface acpi_pci_root_create() and related data
> structures to create PCI root bus for ACPI PCI host bridges. It will
> be used to kill duplicated arch specific code for IA64 and x86. It ma=
y
> also help ARM64 in future.
>
> Tested-by: Tony Luck <tony.luck@intel.com>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>   drivers/acpi/pci_root.c  |  200 +++++++++++++++++++++++++++++++++++=
+++++++++++
>   include/linux/pci-acpi.h |   23 ++++++
>   2 files changed, 223 insertions(+)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 1b5569c092c6..22d0cb799ef1 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -656,6 +656,206 @@ static void acpi_pci_root_remove(struct acpi_de=
vice *device)
>   	kfree(root);
>   }
>
> +static void acpi_pci_root_validate_resources(struct device *dev,
> +					     struct list_head *resources,
> +					     unsigned long type)
> +{
> +	LIST_HEAD(list);
> +	struct resource *res1, *res2, *root =3D NULL;
> +	struct resource_entry *tmp, *entry, *entry2;
> +
> +	BUG_ON((type & (IORESOURCE_MEM | IORESOURCE_IO)) =3D=3D 0);
> +	root =3D (type & IORESOURCE_MEM) ? &iomem_resource : &ioport_resour=
ce;
> +
> +	list_splice_init(resources, &list);
> +	resource_list_for_each_entry_safe(entry, tmp, &list) {
> +		bool free =3D false;
> +		resource_size_t end;
> +
> +		res1 =3D entry->res;
> +		if (!(res1->flags & type))
> +			goto next;
> +
> +		/* Exclude non-addressable range or non-addressable portion */
> +		end =3D min(res1->end, root->end);
> +		if (end <=3D res1->start) {
> +			dev_info(dev, "host bridge window %pR (ignored, not CPU addressab=
le)\n",
> +				 res1);
> +			free =3D true;
> +			goto next;
> +		} else if (res1->end !=3D end) {
> +			dev_info(dev, "host bridge window %pR ([%#llx-%#llx] ignored, not=
 CPU addressable)\n",
> +				 res1, (unsigned long long)end + 1,
> +				 (unsigned long long)res1->end);
> +			res1->end =3D end;
> +		}
> +
> +		resource_list_for_each_entry(entry2, resources) {
> +			res2 =3D entry2->res;
> +			if (!(res2->flags & type))
> +				continue;
> +
> +			/*
> +			 * I don't like throwing away windows because then
> +			 * our resources no longer match the ACPI _CRS, but
> +			 * the kernel resource tree doesn't allow overlaps.
> +			 */
> +			if (resource_overlaps(res1, res2)) {
> +				res2->start =3D min(res1->start, res2->start);
> +				res2->end =3D max(res1->end, res2->end);
> +				dev_info(dev, "host bridge window expanded to %pR; %pR ignored\n=
",
> +					 res2, res1);
> +				free =3D true;
> +				goto next;
> +			}
> +		}
> +
> +next:
> +		resource_list_del(entry);
> +		if (free)
> +			resource_list_free_entry(entry);
> +		else
> +			resource_list_add_tail(entry, resources);
> +	}
> +}
> +
> +static int acpi_pci_probe_root_resources(struct acpi_pci_root_info *=
info)
> +{
> +	int ret;
> +	struct list_head *list =3D &info->resources;
> +	struct acpi_device *device =3D info->bridge;
> +	struct resource_entry *entry, *tmp;
> +	unsigned long flags;
> +
> +	flags =3D IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_MEM_8AND16BIT=
;
> +	ret =3D acpi_dev_get_resources(device, list,
> +				     acpi_dev_filter_resource_type_cb,
> +				     (void *)flags);
> +	if (ret < 0)
> +		dev_warn(&device->dev,
> +			 "failed to parse _CRS method, error code %d\n", ret);
> +	else if (ret =3D=3D 0)
> +		dev_dbg(&device->dev,
> +			"no IO and memory resources present in _CRS\n");
> +	else {
> +		resource_list_for_each_entry_safe(entry, tmp, list) {
> +			if (entry->res->flags & IORESOURCE_DISABLED)
> +				resource_list_destroy_entry(entry);
> +			else
> +				entry->res->name =3D info->name;
> +		}
> +		acpi_pci_root_validate_resources(&device->dev, list,
> +						 IORESOURCE_MEM);
> +		acpi_pci_root_validate_resources(&device->dev, list,
> +						 IORESOURCE_IO);
> +	}
> +
> +	return ret;
> +}
> +
> +static void pci_acpi_root_add_resources(struct acpi_pci_root_info *i=
nfo)
> +{
> +	struct resource_entry *entry, *tmp;
> +	struct resource *res, *conflict, *root =3D NULL;
> +
> +	resource_list_for_each_entry_safe(entry, tmp, &info->resources) {
> +		res =3D entry->res;
> +		if (res->flags & IORESOURCE_MEM)
> +			root =3D &iomem_resource;
> +		else if (res->flags & IORESOURCE_IO)
> +			root =3D &ioport_resource;
> +		else
> +			continue;
> +
> +		conflict =3D insert_resource_conflict(root, res);
> +		if (conflict) {
> +			dev_info(&info->bridge->dev,
> +				 "ignoring host bridge window %pR (conflicts with %s %pR)\n",
> +				 res, conflict->name, conflict);
> +			resource_list_destroy_entry(entry);
> +		}
> +	}
> +}
> +
> +static void __acpi_pci_root_release_info(struct acpi_pci_root_info *=
info)
> +{
> +	struct resource *res;
> +	struct resource_entry *entry, *tmp;
> +
> +	if (!info)
> +		return;
> +
> +	resource_list_for_each_entry_safe(entry, tmp, &info->resources) {
> +		res =3D entry->res;
> +		if (res->parent &&
> +		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +			release_resource(res);
> +		resource_list_destroy_entry(entry);
> +	}
> +
> +	info->ops->release_info(info);
> +}
> +
> +static void acpi_pci_root_release_info(struct pci_host_bridge *bridg=
e)
> +{
> +	struct resource *res;
> +	struct resource_entry *entry;
> +
> +	resource_list_for_each_entry(entry, &bridge->windows) {
> +		res =3D entry->res;
> +		if (res->parent &&
> +		    (res->flags & (IORESOURCE_MEM | IORESOURCE_IO)))
> +			release_resource(res);
> +	}
> +	__acpi_pci_root_release_info(bridge->release_data);
> +}
> +
> +struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
> +				     struct acpi_pci_root_ops *ops,
> +				     struct acpi_pci_root_info *info)
> +{
> +	int ret, busnum =3D root->secondary.start;
> +	struct acpi_device *device =3D root->device;
> +	struct pci_bus *bus;
> +
> +	info->controller.segment =3D root->segment;
> +	info->controller.node =3D acpi_get_node(device->handle);
> +	info->controller.companion =3D device;
> +	info->root =3D root;
> +	info->bridge =3D device;
> +	info->ops =3D ops;
> +	INIT_LIST_HEAD(&info->resources);
> +	snprintf(info->name, sizeof(info->name), "PCI Bus %04x:%02x",
> +		 info->controller.segment, busnum);
> +
> +	if (ops->init_info && ops->init_info(info))
> +		goto out_release_info;
> +	ret =3D acpi_pci_probe_root_resources(info);
> +	if (ops->prepare_resources)
> +		ret =3D ops->prepare_resources(info, ret);
> +	if (ret < 0)
> +		goto out_release_info;
> +	else if (ret > 0)
> +		pci_acpi_root_add_resources(info);
> +	pci_add_resource(&info->resources, &root->secondary);
> +
> +	bus =3D pci_create_root_bus(NULL, busnum, ops->pci_ops,
> +				  &info->controller, &info->resources);
> +	if (bus) {
> +		pci_scan_child_bus(bus);
> +		pci_set_host_bridge_release(to_pci_host_bridge(bus->bridge),
> +					    acpi_pci_root_release_info, info);
> +		if (info->controller.node !=3D NUMA_NO_NODE)
> +			dev_printk(KERN_DEBUG, &bus->dev, "on NUMA node %d\n",
> +				   info->controller.node);
> +		return bus;
> +	}
> +
> +out_release_info:
> +	__acpi_pci_root_release_info(info);
> +	return NULL;
> +}
> +
>   void __init acpi_pci_root_init(void)
>   {
>   	acpi_hest_init();
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index a965efa52152..685ccc4c3170 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -52,6 +52,29 @@ static inline acpi_handle acpi_pci_get_bridge_hand=
le(struct pci_bus *pbus)
>   	return ACPI_HANDLE(dev);
>   }
>
> +struct acpi_pci_root;
> +struct acpi_pci_root_ops;
> +
> +struct acpi_pci_root_info {
> +	struct pci_controller		controller;
> +	struct acpi_pci_root		*root;
> +	struct acpi_device		*bridge;
> +	struct acpi_pci_root_ops	*ops;
> +	struct list_head		resources;
> +	char				name[16];
> +};
> +
> +struct acpi_pci_root_ops {
> +	struct pci_ops *pci_ops;
> +	int (*init_info)(struct acpi_pci_root_info *info);
> +	void (*release_info)(struct acpi_pci_root_info *info);
> +	int (*prepare_resources)(struct acpi_pci_root_info *info, int statu=
s);
> +};
> +
> +extern struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *ro=
ot,
> +					    struct acpi_pci_root_ops *ops,
> +					    struct acpi_pci_root_info *info);
> +
>   void acpi_pci_add_bus(struct pci_bus *bus);
>   void acpi_pci_remove_bus(struct pci_bus *bus);

As long as you added my ARM64 struct pci_controller patch,

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

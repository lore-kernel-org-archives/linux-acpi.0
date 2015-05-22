From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: Re: [Patch v3 3/7] ia64/PCI: Use common struct resource_entry to
 replace struct iospace_resource
Date: Fri, 22 May 2015 21:46:38 +0800
Message-ID: <555F333E.10605@linaro.org>
References: <1431593803-5213-1-git-send-email-jiang.liu@linux.intel.com> <1431593803-5213-4-git-send-email-jiang.liu@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ia64-owner@vger.kernel.org>
In-Reply-To: <1431593803-5213-4-git-send-email-jiang.liu@linux.intel.com>
Sender: linux-ia64-owner@vger.kernel.org
To: Jiang Liu <jiang.liu@linux.intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <marc.zyngier@arm.com>, Yijing Wang <wangyijing@huawei.com>, Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>, Yinghai Lu <yinghai@kernel.org>
Cc: Lv Zheng <lv.zheng@intel.com>, "lenb @ kernel . org" <lenb@kernel.org>, LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, "x86 @ kernel . org" <x86@kernel.org>, linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On 2015=E5=B9=B405=E6=9C=8814=E6=97=A5 16:56, Jiang Liu wrote:
> Use common struct resource_entry to replace private
> struct iospace_resource.
>
> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> ---
>   arch/ia64/include/asm/pci.h |    5 -----
>   arch/ia64/pci/pci.c         |   17 ++++++++---------
>   2 files changed, 8 insertions(+), 14 deletions(-)
>
> diff --git a/arch/ia64/include/asm/pci.h b/arch/ia64/include/asm/pci.=
h
> index 52af5ed9f60b..5c10e0ec48d4 100644
> --- a/arch/ia64/include/asm/pci.h
> +++ b/arch/ia64/include/asm/pci.h
> @@ -83,11 +83,6 @@ extern int pci_mmap_legacy_page_range(struct pci_b=
us *bus,
>   #define pci_legacy_read platform_pci_legacy_read
>   #define pci_legacy_write platform_pci_legacy_write
>
> -struct iospace_resource {
> -	struct list_head list;
> -	struct resource res;
> -};
> -
>   struct pci_controller {
>   	struct acpi_device *companion;
>   	void *iommu;
> diff --git a/arch/ia64/pci/pci.c b/arch/ia64/pci/pci.c
> index 23689d4c37ae..4af1b52c7a44 100644
> --- a/arch/ia64/pci/pci.c
> +++ b/arch/ia64/pci/pci.c
> @@ -154,14 +154,14 @@ new_space (u64 phys_base, int sparse)
>   static int add_io_space(struct device *dev, struct pci_root_info *i=
nfo,
>   			struct resource_entry *entry)
>   {
> -	struct iospace_resource *iospace;
> +	struct resource_entry *iospace;
>   	struct resource *resource, *res =3D entry->res;
>   	char *name;
>   	unsigned long base, min, max, base_port;
>   	unsigned int sparse =3D 0, space_nr, len;
>
>   	len =3D strlen(info->name) + 32;
> -	iospace =3D kzalloc(sizeof(*iospace) + len, GFP_KERNEL);
> +	iospace =3D resource_list_create_entry(NULL, len);
>   	if (!iospace) {
>   		dev_err(dev, "PCI: No memory for %s I/O port space\n",
>   			info->name);
> @@ -190,7 +190,7 @@ static int add_io_space(struct device *dev, struc=
t pci_root_info *info,
>   	if (space_nr =3D=3D 0)
>   		sparse =3D 1;
>
> -	resource =3D &iospace->res;
> +	resource =3D iospace->res;
>   	resource->name  =3D name;
>   	resource->flags =3D IORESOURCE_MEM;
>   	resource->start =3D base + (sparse ? IO_SPACE_SPARSE_ENCODING(min)=
 : min);
> @@ -205,12 +205,12 @@ static int add_io_space(struct device *dev, str=
uct pci_root_info *info,
>   	entry->offset =3D base_port;
>   	res->start =3D min + base_port;
>   	res->end =3D max + base_port;
> -	list_add_tail(&iospace->list, &info->io_resources);
> +	resource_list_add_tail(iospace, &info->io_resources);
>
>   	return 0;
>
>   free_resource:
> -	kfree(iospace);
> +	resource_list_free_entry(iospace);
>   	return -ENOSPC;
>   }
>
> @@ -369,12 +369,11 @@ static void add_resources(struct pci_root_info =
*info, struct device *dev)
>   static void __release_pci_root_info(struct pci_root_info *info)
>   {
>   	struct resource *res;
> -	struct iospace_resource *iospace, *tmp;
>   	struct resource_entry *entry, *tentry;
>
> -	list_for_each_entry_safe(iospace, tmp, &info->io_resources, list) {
> -		release_resource(&iospace->res);
> -		kfree(iospace);
> +	resource_list_for_each_entry_safe(entry, tentry, &info->io_resource=
s) {
> +		release_resource(entry->res);
> +		resource_list_destroy_entry(entry);
>   	}
>
>   	resource_list_for_each_entry_safe(entry, tentry, &info->resources)=
 {


Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun
--
To unsubscribe from this list: send the line "unsubscribe linux-ia64" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

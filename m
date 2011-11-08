From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/9] ACPI, Record ACPI NVS regions
Date: Tue, 8 Nov 2011 08:40:00 -0700
Message-ID: <CAErSpo7XSi-xsLYmv7B0u2qmdjyGJ91gdOH7wPqFq5JYEo68OQ@mail.gmail.com>
References: <1320719974-3598-1-git-send-email-ying.huang@intel.com> <1320719974-3598-4-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1320719974-3598-4-git-send-email-ying.huang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 7, 2011 at 7:39 PM, Huang Ying <ying.huang@intel.com> wrote=
:
> Some firmware will access memory in ACPI NVS region via APEI. =A0That
> is, instructions in APEI ERST/EINJ table will read/write ACPI NVS
> region. =A0The original resource conflict checking in APEI code will
> check memory/ioport accessed by APEI via general resource management
> mechanism. =A0But ACPI NVS region is marked as busy already, so that =
the
> false resource conflict will prevent APEI ERST/EINJ to work.
>
> To fix this, this patch record ACPI NVS regions, so that we can avoid
> request resources for memory region inside it.

I don't really like these patches (3 & 4), as I mentioned before:
  https://lkml.org/lkml/2011/8/22/270
  https://lkml.org/lkml/2011/9/19/397

To recap, e820 currently marks everything except E820_RESERVED areas
as "BUSY" in the iomem_resource tree.  That basically means that RAM,
ACPI, and NVS are marked as BUSY.  Later APEI attempts a
request_mem_region() on a a resource, and it fails because e820 has
already marked it BUSY.

It makes sense for e820 to mark RAM as BUSY, because we we don't use
iomem_resource to manage it; we pass it all off to memblock and
eventually the regular memory allocator.  But from e820's point of
view, everything else (RESERVED, ACPI, NVS, etc) is just a clue  that
something uses that region and we shouldn't place anything else on top
of it.

We normally mark something BUSY when a driver calls request_region()
to indicate that it owns the region and any other requests for the
same region should fail.  I think it's a mistake for e820 to mark
things BUSY because it really is not the the owner of any of those
regions (except for RAM, because in that case e820 *is* essentially
taking ownership of RAM and passing it off to memblock).

I think a better solution for the APEI problem would be to have e820
leave non-RAM regions in iomem_resource, but not mark them BUSY, as in
this patch from Yinghai:

--- linux-2.6.orig/arch/x86/kernel/e820.c
+++ linux-2.6/arch/x86/kernel/e820.c
@@ -995,7 +995,8 @@ void __init e820_reserve_resources(void)
 		 * pcibios_resource_survey()
 		 */
 		if (e820.map[i].type !=3D E820_RESERVED || res->start < (1ULL<<20)) =
{
-			res->flags |=3D IORESOURCE_BUSY;
+			if (e820.map[i].type !=3D E820_NVS)
+				res->flags |=3D IORESOURCE_BUSY;
 			insert_resource(&iomem_resource, res);
 		}
 		res++;

That's much simpler than having e820 pretend to be the owner of NVS
regions, building an extra list of the NVS regions, and subtracting
them from the regions APEI needs to request ownership of.

Bjorn

> Signed-off-by: Huang Ying <ying.huang@intel.com>
> ---
> =A0arch/x86/kernel/e820.c | =A0 =A04 +--
> =A0drivers/acpi/Makefile =A0| =A0 =A03 +-
> =A0drivers/acpi/nvs.c =A0 =A0 | =A0 53 ++++++++++++++++++++++++++++++=
++++++++++++++++++-
> =A0include/linux/acpi.h =A0 | =A0 20 ++++++++++++------
> =A04 files changed, 70 insertions(+), 10 deletions(-)
>
> --- a/arch/x86/kernel/e820.c
> +++ b/arch/x86/kernel/e820.c
> @@ -714,7 +714,7 @@ void __init e820_mark_nosave_regions(uns
> =A0}
> =A0#endif
>
> -#ifdef CONFIG_HIBERNATION
> +#ifdef CONFIG_ACPI
> =A0/**
> =A0* Mark ACPI NVS memory region, so that we can save/restore it duri=
ng
> =A0* hibernation and the subsequent resume.
> @@ -727,7 +727,7 @@ static int __init e820_mark_nvs_memory(v
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct e820entry *ei =3D &e820.map[i];
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (ei->type =3D=3D E820_NVS)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 suspend_nvs_register(ei=
->addr, ei->size);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_nvs_register(ei->a=
ddr, ei->size);
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0return 0;
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -20,11 +20,12 @@ obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 +=3D acpi.o \
> =A0# All the builtin files are in the "acpi." module_param namespace.
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D osl.o =
utils.o reboot.o
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D atomic=
io.o
> +acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D nvs.o
>
> =A0# sleep related files
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D wakeup=
=2Eo
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D sleep.=
o
> -acpi-$(CONFIG_ACPI_SLEEP) =A0 =A0 =A0+=3D proc.o nvs.o
> +acpi-$(CONFIG_ACPI_SLEEP) =A0 =A0 =A0+=3D proc.o
>
>
> =A0#
> --- a/drivers/acpi/nvs.c
> +++ b/drivers/acpi/nvs.c
> @@ -15,6 +15,56 @@
> =A0#include <linux/acpi_io.h>
> =A0#include <acpi/acpiosxf.h>
>
> +/* ACPI NVS regions, APEI may use it */
> +
> +struct nvs_region {
> + =A0 =A0 =A0 __u64 phys_start;
> + =A0 =A0 =A0 __u64 size;
> + =A0 =A0 =A0 struct list_head node;
> +};
> +
> +static LIST_HEAD(nvs_region_list);
> +
> +#ifdef CONFIG_ACPI_SLEEP
> +static int suspend_nvs_register(unsigned long start, unsigned long s=
ize);
> +#else
> +static inline int suspend_nvs_register(unsigned long a, unsigned lon=
g b)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +#endif
> +
> +int acpi_nvs_register(__u64 start, __u64 size)
> +{
> + =A0 =A0 =A0 struct nvs_region *region;
> +
> + =A0 =A0 =A0 region =3D kmalloc(sizeof(*region), GFP_KERNEL);
> + =A0 =A0 =A0 if (!region)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
> + =A0 =A0 =A0 region->phys_start =3D start;
> + =A0 =A0 =A0 region->size =3D size;
> + =A0 =A0 =A0 list_add_tail(&region->node, &nvs_region_list);
> +
> + =A0 =A0 =A0 return suspend_nvs_register(start, size);
> +}
> +
> +int acpi_nvs_for_each_region(int (*func)(__u64 start, __u64 size, vo=
id *data),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0void *data)
> +{
> + =A0 =A0 =A0 int rc;
> + =A0 =A0 =A0 struct nvs_region *region;
> +
> + =A0 =A0 =A0 list_for_each_entry(region, &nvs_region_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D func(region->phys_start, region-=
>size, data);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (rc)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return rc;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +
> +#ifdef CONFIG_ACPI_SLEEP
> =A0/*
> =A0* Platforms, like ACPI, may want us to save some memory used by th=
em during
> =A0* suspend and to restore the contents of this memory during the su=
bsequent
> @@ -41,7 +91,7 @@ static LIST_HEAD(nvs_list);
> =A0* =A0 =A0 things so that the data from page-aligned addresses in t=
his region will
> =A0* =A0 =A0 be copied into separate RAM pages.
> =A0*/
> -int suspend_nvs_register(unsigned long start, unsigned long size)
> +static int suspend_nvs_register(unsigned long start, unsigned long s=
ize)
> =A0{
> =A0 =A0 =A0 =A0struct nvs_page *entry, *next;
>
> @@ -159,3 +209,4 @@ void suspend_nvs_restore(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (entry->data)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy(entry->kaddr, e=
ntry->data, entry->size);
> =A0}
> +#endif
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -306,6 +306,11 @@ extern acpi_status acpi_pci_osc_control_
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 u32 *mask, u32 req);
> =A0extern void acpi_early_init(void);
>
> +extern int acpi_nvs_register(__u64 start, __u64 size);
> +
> +extern int acpi_nvs_for_each_region(int (*func)(__u64, __u64, void *=
),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 void *data);
> +
> =A0#else =A0/* !CONFIG_ACPI */
>
> =A0#define acpi_disabled 1
> @@ -348,15 +353,18 @@ static inline int acpi_table_parse(char
> =A0{
> =A0 =A0 =A0 =A0return -1;
> =A0}
> -#endif /* !CONFIG_ACPI */
>
> -#ifdef CONFIG_ACPI_SLEEP
> -int suspend_nvs_register(unsigned long start, unsigned long size);
> -#else
> -static inline int suspend_nvs_register(unsigned long a, unsigned lon=
g b)
> +static inline int acpi_nvs_register(__u64 start, __u64 size)
> =A0{
> =A0 =A0 =A0 =A0return 0;
> =A0}
> -#endif
> +
> +static inline int acpi_nvs_for_each_region(int (*func)(__u64, __u64,=
 void *),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0void *data)
> +{
> + =A0 =A0 =A0 return 0;
> +}
> +
> +#endif /* !CONFIG_ACPI */
>
> =A0#endif /*_LINUX_ACPI_H*/
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] ACPI, APEI: Add RAM mapping support to ACPI
Date: Sat, 21 Jan 2012 13:38:27 -0700
Message-ID: <CAErSpo5jofU94+8p3h8_TZ2bCiSWGZKL57sZ311R9kC_HhqC7g@mail.gmail.com>
References: <20120121021318.14723.45698.stgit@amt.stowe> <20120121021330.14723.72537.stgit@amt.stowe>
 <CAErSpo5KDxkcMn3OrvujeSHhzF7PjG0hsYqMXe1HmpPJaLHvDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:34040 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751144Ab2AUUit convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 21 Jan 2012 15:38:49 -0500
Received: by lahc1 with SMTP id c1so946834lah.19
        for <linux-acpi@vger.kernel.org>; Sat, 21 Jan 2012 12:38:47 -0800 (PST)
In-Reply-To: <CAErSpo5KDxkcMn3OrvujeSHhzF7PjG0hsYqMXe1HmpPJaLHvDg@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Myron Stowe <myron.stowe@redhat.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, rjw@sisk.pl, ying.huang@intel.com, trenn@suse.de, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org

+cc Tony, linux-ia64

On Sat, Jan 21, 2012 at 8:04 AM, Bjorn Helgaas <bhelgaas@google.com> wr=
ote:
> On Fri, Jan 20, 2012 at 7:13 PM, Myron Stowe <myron.stowe@redhat.com>=
 wrote:
>> From: Myron Stowe <mstowe@redhat.com>
>>
>> This patch adds support for RAM to ACPI's mapping capabilities in or=
der
>> to support APEI error injection (EINJ) actions.
>>
>> This patch re-factors similar functionality introduced in commit
>> 76da3fb3575, bringing it into osl.c in preparation for removing
>> ./drivers/acpi/atomicio.[ch].
>>
>> Signed-off-by: Myron Stowe <myron.stowe@redhat.com>
>> ---
>>
>> =A0drivers/acpi/osl.c | =A0 36 ++++++++++++++++++++++++++++++++++--
>> =A01 files changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
>> index f363a55..8ee64ea 100644
>> --- a/drivers/acpi/osl.c
>> +++ b/drivers/acpi/osl.c
>> @@ -31,6 +31,7 @@
>> =A0#include <linux/kernel.h>
>> =A0#include <linux/slab.h>
>> =A0#include <linux/mm.h>
>> +#include <linux/highmem.h>
>> =A0#include <linux/pci.h>
>> =A0#include <linux/interrupt.h>
>> =A0#include <linux/kmod.h>
>> @@ -321,6 +322,37 @@ acpi_map_lookup_virt(void __iomem *virt, acpi_s=
ize size)
>> =A0 =A0 =A0 =A0return NULL;
>> =A0}
>>
>> +#ifndef CONFIG_IA64
>> +#define should_use_kmap(pfn) =A0 page_is_ram(pfn)
>> +#else
>> +/* ioremap will take care of cache attributes */
>> +#define should_use_kmap(pfn) =A0 0
>> +#endif
>> +
>> +static void __iomem *acpi_map(acpi_physical_address pg_off, unsigne=
d long pg_sz)
>> +{
>> + =A0 =A0 =A0 unsigned long pfn;
>> +
>> + =A0 =A0 =A0 pfn =3D pg_off >> PAGE_SHIFT;
>> + =A0 =A0 =A0 if (should_use_kmap(pfn)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pg_sz > PAGE_SIZE)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (void __iomem __force *)kmap(pf=
n_to_page(pfn));
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return acpi_os_ioremap(pg_off, pg_sz);
>
> This implies that ioremap() works differently on ia64 than on x86.
> Apparently one can ioremap() RAM on x86, but not on ia64. =A0Why is t=
his
> different? =A0Shouldn't we instead fix ioremap() on ia64 so it works =
the
> same as on x86?
>
> I looked at the ia64 ioremap(), and I can't see the reason it fails
> for RAM. =A0Huang, do you remember the details from 76da3fb3575?
>
>> +}
>> +
>> +static void acpi_unmap(acpi_physical_address pg_off, void __iomem *=
vaddr)
>> +{
>> + =A0 =A0 =A0 unsigned long pfn;
>> +
>> + =A0 =A0 =A0 pfn =3D pg_off >> PAGE_SHIFT;
>> + =A0 =A0 =A0 if (page_is_ram(pfn))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap(pfn_to_page(pfn));
>> + =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(vaddr);
>
> I hope we can resolve the ioremap() question so we don't need this
> patch at all. =A0But if we do need this, I don't like the asymmetry h=
ere
> -- on x86 RAM, I think we use ioremap() and kunmap(), which seems
> wrong. =A0We should be able to use ioremap() and iounmap().
>
>> +}
>> +
>> =A0void __iomem *__init_refok
>> =A0acpi_os_map_memory(acpi_physical_address phys, acpi_size size)
>> =A0{
>> @@ -353,7 +385,7 @@ acpi_os_map_memory(acpi_physical_address phys, a=
cpi_size size)
>>
>> =A0 =A0 =A0 =A0pg_off =3D round_down(phys, PAGE_SIZE);
>> =A0 =A0 =A0 =A0pg_sz =3D round_up(phys + size, PAGE_SIZE) - pg_off;
>> - =A0 =A0 =A0 virt =3D acpi_os_ioremap(pg_off, pg_sz);
>> + =A0 =A0 =A0 virt =3D acpi_map(pg_off, pg_sz);
>> =A0 =A0 =A0 =A0if (!virt) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mutex_unlock(&acpi_ioremap_lock);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(map);
>> @@ -384,7 +416,7 @@ static void acpi_os_map_cleanup(struct acpi_iore=
map *map)
>> =A0{
>> =A0 =A0 =A0 =A0if (!map->refcount) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0synchronize_rcu();
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(map->virt);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_unmap(map->phys, map->virt);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(map);
>> =A0 =A0 =A0 =A0}
>> =A0}
>>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

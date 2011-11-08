From: Myron Stowe <myron.stowe@gmail.com>
Subject: Re: [PATCH 6/9] ACPI, Add RAM mapping support to ACPI atomic IO support
Date: Tue, 8 Nov 2011 14:38:32 -0700
Message-ID: <CAL-B5D1z35ReG9dKVBLNkktrJ-c8OVspsCYTUAO16wCK1B_4dA@mail.gmail.com>
References: <1320719974-3598-1-git-send-email-ying.huang@intel.com>
	<1320719974-3598-7-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:51377 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750899Ab1KHVid convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 8 Nov 2011 16:38:33 -0500
In-Reply-To: <1320719974-3598-7-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org

On Mon, Nov 7, 2011 at 7:39 PM, Huang Ying <ying.huang@intel.com> wrote=
:
> On one of our testing machine, the following EINJ command lines:
>
> =A0# echo 0x10000000 > param1
> =A0# echo 0xfffffffffffff000 > param2
> =A0# echo 0x8 > error_type
> =A0# echo 1 > error_inject
>
> Will get:
>
> =A0echo: write error: Input/output error
>
> The EIO comes from:
>
> =A0 =A0rc =3D apei_exec_pre_map_gars(&trigger_ctx);
>
> The root cause is as follow. =A0Normally, ACPI atomic IO support is u=
sed
> to access IO memory. =A0But in EINJ of that machine, it is used to
> access RAM to trigger the injected error. =A0And the ioremap() called=
 by
> apei_exec_pre_map_gars() can not map the RAM.
>
> This patch add RAM mapping support to ACPI atomic IO support to
> satisfy EINJ requirement.
>
> Signed-off-by: Huang Ying <ying.huang@intel.com>
> Tested-by: Tony Luck <tony.luck@intel.com>
> ---
> =A0drivers/acpi/atomicio.c | =A0 34 ++++++++++++++++++++++++++++++---=
-
> =A01 file changed, 30 insertions(+), 4 deletions(-)
>

Hi Huang:

This patch collides with my series to remove atomicio.[ch]:
  https://mail.google.com/mail/?shva=3D1#label/linux-acpi+list/13380581=
2264a542
and I don't want such functionality to get lost if/when the removal ser=
ies
is accepted.  I'm interested in working with you, not against you, so w=
ould
you like me to do anything with respect to this patch within the osl.c =
based
mapping routines so this capability would not become lost?

The obvious choices would be for me to post a new patch, copying this
functionality into osl.c's mapping routines, that would apply on top of=
 the
removal series.  Another tact could be for me to do basically the same
thing but within the removal series (by adding this into it, and repost=
ing).
The latter tactic seems like it could be a constant problem if more cha=
nges
to atomicio occur during this interim period.  Of course you may have o=
ther
ideas here as how to progress.

This type of occurrence, among many others, is a good example of why we
need to get down to just one set of mapping routines as soon as possibl=
e.
During this interim period I'll try and monitor the linux-acpi-list
for future such
occurrences but if you could, please try and cc me on any future atomic=
io
modifications.

Thanks,
 Myron

> --- a/drivers/acpi/atomicio.c
> +++ b/drivers/acpi/atomicio.c
> @@ -32,6 +32,8 @@
> =A0#include <linux/rculist.h>
> =A0#include <linux/interrupt.h>
> =A0#include <linux/slab.h>
> +#include <linux/mm.h>
> +#include <linux/highmem.h>
> =A0#include <acpi/atomicio.h>
>
> =A0#define ACPI_PFX "ACPI: "
> @@ -97,6 +99,30 @@ static void __iomem *__acpi_try_ioremap(
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> +static void __iomem *acpi_map(phys_addr_t pg_off, unsigned long pg_s=
z)
> +{
> + =A0 =A0 =A0 unsigned long pfn;
> +
> + =A0 =A0 =A0 pfn =3D pg_off >> PAGE_SHIFT;
> + =A0 =A0 =A0 if (page_is_ram(pfn)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pg_sz > PAGE_SIZE)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return (void __iomem __force *)kmap(pfn=
_to_page(pfn));
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ioremap(pg_off, pg_sz);
> +}
> +
> +static void acpi_unmap(phys_addr_t pg_off, void __iomem *vaddr)
> +{
> + =A0 =A0 =A0 unsigned long pfn;
> +
> + =A0 =A0 =A0 pfn =3D pg_off >> PAGE_SHIFT;
> + =A0 =A0 =A0 if (page_is_ram(pfn))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kunmap(pfn_to_page(pfn));
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(vaddr);
> +}
> +
> =A0/*
> =A0* Used to pre-map the specified IO memory area. First try to find
> =A0* whether the area is already pre-mapped, if it is, increase the
> @@ -119,7 +145,7 @@ static void __iomem *acpi_pre_map(phys_a
>
> =A0 =A0 =A0 =A0pg_off =3D paddr & PAGE_MASK;
> =A0 =A0 =A0 =A0pg_sz =3D ((paddr + size + PAGE_SIZE - 1) & PAGE_MASK)=
 - pg_off;
> - =A0 =A0 =A0 vaddr =3D ioremap(pg_off, pg_sz);
> + =A0 =A0 =A0 vaddr =3D acpi_map(pg_off, pg_sz);
> =A0 =A0 =A0 =A0if (!vaddr)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return NULL;
> =A0 =A0 =A0 =A0map =3D kmalloc(sizeof(*map), GFP_KERNEL);
> @@ -135,7 +161,7 @@ static void __iomem *acpi_pre_map(phys_a
> =A0 =A0 =A0 =A0vaddr =3D __acpi_try_ioremap(paddr, size);
> =A0 =A0 =A0 =A0if (vaddr) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0spin_unlock_irqrestore(&acpi_iomaps_lo=
ck, flags);
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 iounmap(map->vaddr);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_unmap(pg_off, map->vaddr);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0kfree(map);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return vaddr;
> =A0 =A0 =A0 =A0}
> @@ -144,7 +170,7 @@ static void __iomem *acpi_pre_map(phys_a
>
> =A0 =A0 =A0 =A0return map->vaddr + (paddr - map->paddr);
> =A0err_unmap:
> - =A0 =A0 =A0 iounmap(vaddr);
> + =A0 =A0 =A0 acpi_unmap(pg_off, vaddr);
> =A0 =A0 =A0 =A0return NULL;
> =A0}
>
> @@ -177,7 +203,7 @@ static void acpi_post_unmap(phys_addr_t
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> =A0 =A0 =A0 =A0synchronize_rcu();
> - =A0 =A0 =A0 iounmap(map->vaddr);
> + =A0 =A0 =A0 acpi_unmap(map->paddr, map->vaddr);
> =A0 =A0 =A0 =A0kfree(map);
> =A0}
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V2 3/6] PCI, x86: use RCU list to protect mmconfig list
Date: Wed, 2 May 2012 16:31:00 -0600
Message-ID: <CAErSpo4S9V8fUJcbBHL4CPGzcVW768KiGsALdG78xD85feEvKw@mail.gmail.com>
References: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com> <1333988568-11282-4-git-send-email-jiang.liu@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:39128 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754451Ab2EBWbX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 2 May 2012 18:31:23 -0400
Received: by lahj13 with SMTP id j13so828218lah.19
        for <linux-acpi@vger.kernel.org>; Wed, 02 May 2012 15:31:21 -0700 (PDT)
In-Reply-To: <1333988568-11282-4-git-send-email-jiang.liu@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <liuj97@gmail.com>
Cc: Taku Izumi <izumi.taku@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Yinghai Lu <yinghai@kernel.org>, Jiang Liu <jiang.liu@huawei.com>, Keping Chen <chenkeping@huawei.com>, x86@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Mon, Apr 9, 2012 at 10:22 AM, Jiang Liu <liuj97@gmail.com> wrote:
> Use RCU list to protect mmconfig list from dynamic change
> when supporting PCI host bridge hotplug.

I'm not convinced this is safe.  But I'm not an RCU expert, so maybe
you can convince me :)

Documentation/RCU/checklist.txt says the update code still requires
mutual exclusion, and I don't see any in list_add_sorted() or its
callers.

MMCONFIG accesses are already protected by the pci_config_lock
spinlock, so I don't think the performance advantages of RCU really
gain us anything in this situation.

It would definitely be simpler to just hold pci_config_lock while
updating and searching the pci_mmcfg_list, but if there are issues
with that, you can educate me about what they are and why this RCU
code is correct.

Bjorn

> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
> ---
> =A0arch/x86/pci/mmconfig-shared.c | =A0 11 ++++++-----
> =A0arch/x86/pci/mmconfig_32.c =A0 =A0 | =A0 13 +++++++++++--
> =A0arch/x86/pci/mmconfig_64.c =A0 =A0 | =A0 13 +++++++++++--
> =A03 files changed, 28 insertions(+), 9 deletions(-)
>
> diff --git a/arch/x86/pci/mmconfig-shared.c b/arch/x86/pci/mmconfig-s=
hared.c
> index 5e2cd2a..3bcc361 100644
> --- a/arch/x86/pci/mmconfig-shared.c
> +++ b/arch/x86/pci/mmconfig-shared.c
> @@ -17,6 +17,7 @@
> =A0#include <linux/bitmap.h>
> =A0#include <linux/dmi.h>
> =A0#include <linux/slab.h>
> +#include <linux/rculist.h>
> =A0#include <asm/e820.h>
> =A0#include <asm/pci_x86.h>
> =A0#include <asm/acpi.h>
> @@ -45,20 +46,20 @@ static __init void free_all_mmcfg(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_mmconfig_remove(cfg);
> =A0}
>
> -static __init void list_add_sorted(struct pci_mmcfg_region *new)
> +static __devinit void list_add_sorted(struct pci_mmcfg_region *new)
> =A0{
> =A0 =A0 =A0 =A0struct pci_mmcfg_region *cfg;
>
> =A0 =A0 =A0 =A0/* keep list sorted by segment and starting bus number=
 */
> - =A0 =A0 =A0 list_for_each_entry(cfg, &pci_mmcfg_list, list) {
> + =A0 =A0 =A0 list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cfg->segment > new->segment ||
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(cfg->segment =3D=3D new->segm=
ent &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg->start_bus >=3D new->star=
t_bus)) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&new->lis=
t, &cfg->list);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail_rcu(&new-=
>list, &cfg->list);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0}
> - =A0 =A0 =A0 list_add_tail(&new->list, &pci_mmcfg_list);
> + =A0 =A0 =A0 list_add_tail_rcu(&new->list, &pci_mmcfg_list);
> =A0}
>
> =A0static __devinit struct pci_mmcfg_region *pci_mmconfig_alloc(int s=
egment,
> @@ -111,7 +112,7 @@ struct pci_mmcfg_region *pci_mmconfig_lookup(int =
segment, int bus)
> =A0{
> =A0 =A0 =A0 =A0struct pci_mmcfg_region *cfg;
>
> - =A0 =A0 =A0 list_for_each_entry(cfg, &pci_mmcfg_list, list)
> + =A0 =A0 =A0 list_for_each_entry_rcu(cfg, &pci_mmcfg_list, list)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cfg->segment =3D=3D segment &&
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cfg->start_bus <=3D bus && bus=
 <=3D cfg->end_bus)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return cfg;
> diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.c
> index 5372e86..5dad04a 100644
> --- a/arch/x86/pci/mmconfig_32.c
> +++ b/arch/x86/pci/mmconfig_32.c
> @@ -11,6 +11,7 @@
>
> =A0#include <linux/pci.h>
> =A0#include <linux/init.h>
> +#include <linux/rcupdate.h>
> =A0#include <asm/e820.h>
> =A0#include <asm/pci_x86.h>
> =A0#include <acpi/acpi.h>
> @@ -60,9 +61,12 @@ err: =A0 =A0 =A0 =A0 *value =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 rcu_read_lock();
> =A0 =A0 =A0 =A0base =3D get_base_addr(seg, bus, devfn);
> - =A0 =A0 =A0 if (!base)
> + =A0 =A0 =A0 if (!base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0raw_spin_lock_irqsave(&pci_config_lock, flags);
>
> @@ -80,6 +84,7 @@ err: =A0 =A0 =A0 =A0 =A0*value =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0raw_spin_unlock_irqrestore(&pci_config_lock, flags);
> + =A0 =A0 =A0 rcu_read_unlock();
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -93,9 +98,12 @@ static int pci_mmcfg_write(unsigned int seg, unsig=
ned int bus,
> =A0 =A0 =A0 =A0if ((bus > 255) || (devfn > 255) || (reg > 4095))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> + =A0 =A0 =A0 rcu_read_lock();
> =A0 =A0 =A0 =A0base =3D get_base_addr(seg, bus, devfn);
> - =A0 =A0 =A0 if (!base)
> + =A0 =A0 =A0 if (!base) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0raw_spin_lock_irqsave(&pci_config_lock, flags);
>
> @@ -113,6 +121,7 @@ static int pci_mmcfg_write(unsigned int seg, unsi=
gned int bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0raw_spin_unlock_irqrestore(&pci_config_lock, flags);
> + =A0 =A0 =A0 rcu_read_unlock();
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.c
> index 915a493..acc48c5 100644
> --- a/arch/x86/pci/mmconfig_64.c
> +++ b/arch/x86/pci/mmconfig_64.c
> @@ -9,6 +9,7 @@
> =A0#include <linux/init.h>
> =A0#include <linux/acpi.h>
> =A0#include <linux/bitmap.h>
> +#include <linux/rcupdate.h>
> =A0#include <asm/e820.h>
> =A0#include <asm/pci_x86.h>
>
> @@ -34,9 +35,12 @@ err: =A0 =A0 =A0 =A0 *value =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> + =A0 =A0 =A0 rcu_read_lock();
> =A0 =A0 =A0 =A0addr =3D pci_dev_base(seg, bus, devfn);
> - =A0 =A0 =A0 if (!addr)
> + =A0 =A0 =A0 if (!addr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0switch (len) {
> =A0 =A0 =A0 =A0case 1:
> @@ -49,6 +53,7 @@ err: =A0 =A0 =A0 =A0 =A0*value =3D -1;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*value =3D mmio_config_readl(addr + re=
g);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 rcu_read_unlock();
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> @@ -62,9 +67,12 @@ static int pci_mmcfg_write(unsigned int seg, unsig=
ned int bus,
> =A0 =A0 =A0 =A0if (unlikely((bus > 255) || (devfn > 255) || (reg > 40=
95)))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>
> + =A0 =A0 =A0 rcu_read_lock();
> =A0 =A0 =A0 =A0addr =3D pci_dev_base(seg, bus, devfn);
> - =A0 =A0 =A0 if (!addr)
> + =A0 =A0 =A0 if (!addr) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0switch (len) {
> =A0 =A0 =A0 =A0case 1:
> @@ -77,6 +85,7 @@ static int pci_mmcfg_write(unsigned int seg, unsign=
ed int bus,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmio_config_writel(addr + reg, value);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
> + =A0 =A0 =A0 rcu_read_unlock();
>
> =A0 =A0 =A0 =A0return 0;
> =A0}
> --
> 1.7.5.4
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

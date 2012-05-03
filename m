From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH V2 3/6] PCI, x86: use RCU list to protect mmconfig list
Date: Thu, 3 May 2012 10:34:14 -0600
Message-ID: <CAErSpo5R3-FQT9LmiPLmsTUrwxvASaWQUdEVpOqvLQ6Qme_g_Q@mail.gmail.com>
References: <1333988568-11282-1-git-send-email-jiang.liu@huawei.com>
 <1333988568-11282-4-git-send-email-jiang.liu@huawei.com> <CAErSpo4S9V8fUJcbBHL4CPGzcVW768KiGsALdG78xD85feEvKw@mail.gmail.com>
 <4FA22208.6070003@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:56691 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756569Ab2ECQeg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 3 May 2012 12:34:36 -0400
Received: by lahj13 with SMTP id j13so1380163lah.19
        for <linux-acpi@vger.kernel.org>; Thu, 03 May 2012 09:34:34 -0700 (PDT)
In-Reply-To: <4FA22208.6070003@huawei.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Jiang Liu <jiang.liu@huawei.com>
Cc: Jiang Liu <liuj97@gmail.com>, Taku Izumi <izumi.taku@jp.fujitsu.com>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Yinghai Lu <yinghai@kernel.org>, Keping Chen <chenkeping@huawei.com>, x86@vger.kernel.org, linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org

On Thu, May 3, 2012 at 12:13 AM, Jiang Liu <jiang.liu@huawei.com> wrote=
:
> Hi Bjorn,
> =A0 =A0 =A0 =A0Thanks for your comments!
> =A0 =A0 =A0 =A0I have thought about using pci_config_lock to serializ=
e
> access to the pci_mmcfg_list, but that may hurt MMCFG on x86_64
> systems because mmconfig_64.c supports concurrent access to
> the MMCFG space without holding the pci_config_lock. So I use
> RCU to avoid possible performance penalty for x86_64 systems.

Oh, right.  I only looked at mmconfig_32.c, which uses the lock, and
assumed _64.c was the same.  I think you're right to avoid introducing
locking where we didn't have it before.

> =A0 =A0 =A0 =A0There are two mechanisms to protect list_add_sorted()
> from concurrent updates. The first case is, list_add_sorted()
> may be called without holding any lock for serialization at
> early booting stages because the system is still in single-threaded
> mode. The second case is, pci_config_lock is used to serialize
> concurrent modification to the pci_mmcfg_list if list_add_sorted()
> is called at runtime.
> =A0 =A0 =A0 =A0The first case is cover by this patch, and the second =
case
> is covered by "[PATCH V2 5/6] PCI, x86: introduce
> pci_mmconfig_insert()/delete() for PCI root bridge hotplug".

How hard would it be to convert the first (early boot) mechanism to
use the second mechanism?  It'd be nicer if there were only one path
that we use both places, even if it means the early boot path acquires
a lock that is technically unnecessary.

> On 2012-5-3 6:31, Bjorn Helgaas wrote:
>>
>> On Mon, Apr 9, 2012 at 10:22 AM, Jiang Liu<liuj97@gmail.com> =A0wrot=
e:
>>>
>>> Use RCU list to protect mmconfig list from dynamic change
>>> when supporting PCI host bridge hotplug.
>>
>>
>> I'm not convinced this is safe. =A0But I'm not an RCU expert, so may=
be
>> you can convince me :)
>>
>> Documentation/RCU/checklist.txt says the update code still requires
>> mutual exclusion, and I don't see any in list_add_sorted() or its
>> callers.
>>
>> MMCONFIG accesses are already protected by the pci_config_lock
>> spinlock, so I don't think the performance advantages of RCU really
>> gain us anything in this situation.
>>
>> It would definitely be simpler to just hold pci_config_lock while
>> updating and searching the pci_mmcfg_list, but if there are issues
>> with that, you can educate me about what they are and why this RCU
>> code is correct.
>>
>> Bjorn
>>
>>> Signed-off-by: Jiang Liu<jiang.liu@huawei.com>
>>> ---
>>> =A0arch/x86/pci/mmconfig-shared.c | =A0 11 ++++++-----
>>> =A0arch/x86/pci/mmconfig_32.c =A0 =A0 | =A0 13 +++++++++++--
>>> =A0arch/x86/pci/mmconfig_64.c =A0 =A0 | =A0 13 +++++++++++--
>>> =A03 files changed, 28 insertions(+), 9 deletions(-)
>>>
>>> diff --git a/arch/x86/pci/mmconfig-shared.c
>>> b/arch/x86/pci/mmconfig-shared.c
>>> index 5e2cd2a..3bcc361 100644
>>> --- a/arch/x86/pci/mmconfig-shared.c
>>> +++ b/arch/x86/pci/mmconfig-shared.c
>>> @@ -17,6 +17,7 @@
>>> =A0#include<linux/bitmap.h>
>>> =A0#include<linux/dmi.h>
>>> =A0#include<linux/slab.h>
>>> +#include<linux/rculist.h>
>>> =A0#include<asm/e820.h>
>>> =A0#include<asm/pci_x86.h>
>>> =A0#include<asm/acpi.h>
>>> @@ -45,20 +46,20 @@ static __init void free_all_mmcfg(void)
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_mmconfig_remove(cfg);
>>> =A0}
>>>
>>> -static __init void list_add_sorted(struct pci_mmcfg_region *new)
>>> +static __devinit void list_add_sorted(struct pci_mmcfg_region *new=
)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct pci_mmcfg_region *cfg;
>>>
>>> =A0 =A0 =A0 =A0/* keep list sorted by segment and starting bus numb=
er */
>>> - =A0 =A0 =A0 list_for_each_entry(cfg,&pci_mmcfg_list, list) {
>>> + =A0 =A0 =A0 list_for_each_entry_rcu(cfg,&pci_mmcfg_list, list) {
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cfg->segment> =A0new->segment ||
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(cfg->segment =3D=3D new->se=
gment&&
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 cfg->start_bus>=3D new->sta=
rt_bus)) {
>>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail(&new->l=
ist,&cfg->list);
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_add_tail_rcu(&ne=
w->list,&cfg->list);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0}
>>> - =A0 =A0 =A0 list_add_tail(&new->list,&pci_mmcfg_list);
>>> + =A0 =A0 =A0 list_add_tail_rcu(&new->list,&pci_mmcfg_list);
>>> =A0}
>>>
>>> =A0static __devinit struct pci_mmcfg_region *pci_mmconfig_alloc(int
>>> segment,
>>> @@ -111,7 +112,7 @@ struct pci_mmcfg_region *pci_mmconfig_lookup(in=
t
>>> segment, int bus)
>>> =A0{
>>> =A0 =A0 =A0 =A0struct pci_mmcfg_region *cfg;
>>>
>>> - =A0 =A0 =A0 list_for_each_entry(cfg,&pci_mmcfg_list, list)
>>> + =A0 =A0 =A0 list_for_each_entry_rcu(cfg,&pci_mmcfg_list, list)
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (cfg->segment =3D=3D segment&&
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0cfg->start_bus<=3D bus&& =A0=
bus<=3D cfg->end_bus)
>>>
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return cfg;
>>> diff --git a/arch/x86/pci/mmconfig_32.c b/arch/x86/pci/mmconfig_32.=
c
>>> index 5372e86..5dad04a 100644
>>> --- a/arch/x86/pci/mmconfig_32.c
>>> +++ b/arch/x86/pci/mmconfig_32.c
>>> @@ -11,6 +11,7 @@
>>>
>>> =A0#include<linux/pci.h>
>>> =A0#include<linux/init.h>
>>> +#include<linux/rcupdate.h>
>>> =A0#include<asm/e820.h>
>>> =A0#include<asm/pci_x86.h>
>>> =A0#include<acpi/acpi.h>
>>> @@ -60,9 +61,12 @@ err: =A0 =A0 =A0 =A0 *value =3D -1;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> =A0 =A0 =A0 =A0}
>>>
>>> + =A0 =A0 =A0 rcu_read_lock();
>>> =A0 =A0 =A0 =A0base =3D get_base_addr(seg, bus, devfn);
>>> - =A0 =A0 =A0 if (!base)
>>> + =A0 =A0 =A0 if (!base) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0raw_spin_lock_irqsave(&pci_config_lock, flags);
>>>
>>> @@ -80,6 +84,7 @@ err: =A0 =A0 =A0 =A0 =A0*value =3D -1;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>>> + =A0 =A0 =A0 rcu_read_unlock();
>>>
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>> @@ -93,9 +98,12 @@ static int pci_mmcfg_write(unsigned int seg, uns=
igned
>>> int bus,
>>> =A0 =A0 =A0 =A0if ((bus> =A0255) || (devfn> =A0255) || (reg> =A0409=
5))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>>
>>> + =A0 =A0 =A0 rcu_read_lock();
>>> =A0 =A0 =A0 =A0base =3D get_base_addr(seg, bus, devfn);
>>> - =A0 =A0 =A0 if (!base)
>>> + =A0 =A0 =A0 if (!base) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0raw_spin_lock_irqsave(&pci_config_lock, flags);
>>>
>>> @@ -113,6 +121,7 @@ static int pci_mmcfg_write(unsigned int seg, un=
signed
>>> int bus,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> =A0 =A0 =A0 =A0}
>>> =A0 =A0 =A0 =A0raw_spin_unlock_irqrestore(&pci_config_lock, flags);
>>> + =A0 =A0 =A0 rcu_read_unlock();
>>>
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>> diff --git a/arch/x86/pci/mmconfig_64.c b/arch/x86/pci/mmconfig_64.=
c
>>> index 915a493..acc48c5 100644
>>> --- a/arch/x86/pci/mmconfig_64.c
>>> +++ b/arch/x86/pci/mmconfig_64.c
>>> @@ -9,6 +9,7 @@
>>> =A0#include<linux/init.h>
>>> =A0#include<linux/acpi.h>
>>> =A0#include<linux/bitmap.h>
>>> +#include<linux/rcupdate.h>
>>> =A0#include<asm/e820.h>
>>> =A0#include<asm/pci_x86.h>
>>>
>>> @@ -34,9 +35,12 @@ err: =A0 =A0 =A0 =A0 *value =3D -1;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> =A0 =A0 =A0 =A0}
>>>
>>> + =A0 =A0 =A0 rcu_read_lock();
>>> =A0 =A0 =A0 =A0addr =3D pci_dev_base(seg, bus, devfn);
>>> - =A0 =A0 =A0 if (!addr)
>>> + =A0 =A0 =A0 if (!addr) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto err;
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0switch (len) {
>>> =A0 =A0 =A0 =A0case 1:
>>> @@ -49,6 +53,7 @@ err: =A0 =A0 =A0 =A0 =A0*value =3D -1;
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*value =3D mmio_config_readl(addr + =
reg);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> =A0 =A0 =A0 =A0}
>>> + =A0 =A0 =A0 rcu_read_unlock();
>>>
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>> @@ -62,9 +67,12 @@ static int pci_mmcfg_write(unsigned int seg, uns=
igned
>>> int bus,
>>> =A0 =A0 =A0 =A0if (unlikely((bus> =A0255) || (devfn> =A0255) || (re=
g> =A04095)))
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>>
>>> + =A0 =A0 =A0 rcu_read_lock();
>>> =A0 =A0 =A0 =A0addr =3D pci_dev_base(seg, bus, devfn);
>>> - =A0 =A0 =A0 if (!addr)
>>> + =A0 =A0 =A0 if (!addr) {
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 rcu_read_unlock();
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>>> + =A0 =A0 =A0 }
>>>
>>> =A0 =A0 =A0 =A0switch (len) {
>>> =A0 =A0 =A0 =A0case 1:
>>> @@ -77,6 +85,7 @@ static int pci_mmcfg_write(unsigned int seg, unsi=
gned
>>> int bus,
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mmio_config_writel(addr + reg, value=
);
>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>>> =A0 =A0 =A0 =A0}
>>> + =A0 =A0 =A0 rcu_read_unlock();
>>>
>>> =A0 =A0 =A0 =A0return 0;
>>> =A0}
>>> --
>>> 1.7.5.4
>>>
>>
>> .
>>
>
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

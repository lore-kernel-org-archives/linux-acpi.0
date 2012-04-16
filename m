From: huang ying <huang.ying.caritas@gmail.com>
Subject: Re: [RFC PATCH] PCIe: Add PCIe runtime D3cold support
Date: Mon, 16 Apr 2012 16:58:58 +0800
Message-ID: <CAC=cRTNYGGq2ncJr7mvEOm2udqXsAD3T9T=5Tafue_jrjAWCug@mail.gmail.com>
References: <4F8790F6.5080408@intel.com>
	<201204132141.58063.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:56286 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752009Ab2DPI67 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Apr 2012 04:58:59 -0400
In-Reply-To: <201204132141.58063.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>, bhelgaas@google.com, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, Lin Ming <ming.m.lin@intel.com>, Zhang Rui <rui.zhang@intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>

Hi,

On Sat, Apr 14, 2012 at 3:41 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> Hi,
>
> On Friday, April 13, 2012, Yan, Zheng wrote:
>> Hi all,
>>
>> This patch adds PCIe runtime D3cold support, namely cut power supply=
 for functions
>> beneath a PCIe port when they all have entered D3. A device in D3col=
d can only
>> generate wake event through the WAKE# pin. Because we can not access=
 to a device's
>> configure space while it's in D3cold, pme_poll is disabled for devic=
es in D3cold.
>>
>> Any comment will be appreciated.
>>
>> Signed-off-by: Zheng Yan <zheng.z.yan@intel.com>
>> ---
>> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
>> index 0f150f2..e210e8cb 100644
>> --- a/drivers/pci/pci-acpi.c
>> +++ b/drivers/pci/pci-acpi.c
>> @@ -224,7 +224,7 @@ static int acpi_pci_set_power_state(struct pci_d=
ev *dev, pci_power_t state)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D1] =3D ACPI_S=
TATE_D1,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D2] =3D ACPI_S=
TATE_D2,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D3hot] =3D ACP=
I_STATE_D3,
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D3cold] =3D ACPI_ST=
ATE_D3
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 [PCI_D3cold] =3D ACPI_ST=
ATE_D3_COLD
>> =C2=A0 =C2=A0 =C2=A0 };
>> =C2=A0 =C2=A0 =C2=A0 int error =3D -EINVAL;
>>
>
> Please don't use that ACPI_STATE_D3_COLD thing, it's not defined corr=
ectly.
>
> We should define ACPI_STATE_D3_COLD =3D=3D ACPI_STATE_D3 and add ACPI=
_STATE_D3_HOT
> instead. =C2=A0I'll prepare a patch for that over the weekend if no o=
ne has done
> that already.
>
>> @@ -296,7 +296,8 @@ static void acpi_pci_propagate_run_wake(struct p=
ci_bus *bus, bool enable)
>>
>> =C2=A0static int acpi_pci_run_wake(struct pci_dev *dev, bool enable)
>> =C2=A0{
>> - =C2=A0 =C2=A0 if (dev->pme_interrupt)
>> + =C2=A0 =C2=A0 /* PME interrupt isn't available in the D3cold case =
*/
>> + =C2=A0 =C2=A0 if (dev->pme_interrupt && !dev->runtime_d3cold)
>
> This whole thing is wrong. =C2=A0First off, I don't think that the ru=
ntime_d3cold
> flag makes any sense. =C2=A0We already cover that in dev->pme_support=
=2E

PCIe devices and PCIe root port may have proper PME interrupt support
(that is, dev->pme_interrupt =3D true), but the process of remote wakeu=
p
from D3cold is as follow:

1) In D3cold, the power of the main link is turned off, aux power is
provided (PCIe L2 link state)
2) Device detect condition to resume, then assert #WAKE pin
2) ACPI circuit linked with #WAKE pin, and will generate a GPE for that
3) GPE handler will resume device with ACPI (via _PS3 and _PR0), the
power of the main link is turned on, after a while, link goes into L0
state
4) The PME message is sent to root port, pme interrupt generated

So, for deivce, dev->pme_interrupt =3D true and dev->pme_support
advocate it support PME in D3cold.  But we still need ACPI to setup
run wake for the device.

So we need a way to inform acpi_pci_run_wake(), one way is using a
flag, there is other ways such as adding another parameter to
acpi_pci_run_wake() to tell it which power state to go.

> Second, pme_interrupt means that the _root_ _port_, not the device it=
self will
> trigger an interrupt whenever the device sends the PME message to it =
(which
> very well may happen for a device in D3_cold woken up by an external =
signal).

As above, that may happend after ACPI GPE.

>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!acpi_pm_device_run_wake(&dev->dev, enable)=
)
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 8156744..bc16869 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -731,8 +731,8 @@ int pci_set_power_state(struct pci_dev *dev, pci=
_power_t state)
>> =C2=A0 =C2=A0 =C2=A0 int error;
>>
>
> Guys, please. =C2=A0Never, _ever_, touch pci_set_power_state() withou=
t discussing
> your ideas with someone who knows how it works and _why_ it works thi=
s way.

This patch is sent as RFC, I think this is to call for discussing
instead of merging, isn't it?

> The problem here is that you can't program a PCI device into D3_cold,=
 so it
> doesn't even make sense to have a helper for that.

We need to program ACPI to make the PCI device go into D3_cold.  That
is called in this function.

pci_set_power_sate
  -> __pci_complete_power_transition
    -> pci_platform_power_transition

>> =C2=A0 =C2=A0 =C2=A0 /* bound the state we're entering */
>> - =C2=A0 =C2=A0 if (state > PCI_D3hot)
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state =3D PCI_D3hot;
>> + =C2=A0 =C2=A0 if (state > PCI_D3cold)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state =3D PCI_D3cold;
>> =C2=A0 =C2=A0 =C2=A0 else if (state < PCI_D0)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 state =3D PCI_D0;
>> =C2=A0 =C2=A0 =C2=A0 else if ((state =3D=3D PCI_D1 || state =3D=3D P=
CI_D2) && pci_no_d1d2(dev))
>> @@ -750,7 +750,8 @@ int pci_set_power_state(struct pci_dev *dev, pci=
_power_t state)
>> =C2=A0 =C2=A0 =C2=A0 if (state =3D=3D PCI_D3hot && (dev->dev_flags &=
 PCI_DEV_FLAGS_NO_D3))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
>>
>> - =C2=A0 =C2=A0 error =3D pci_raw_set_power_state(dev, state);
>> + =C2=A0 =C2=A0 error =3D pci_raw_set_power_state(dev, state > PCI_D=
3hot ?
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 PCI_D3hot :=
 state);
>>
>> =C2=A0 =C2=A0 =C2=A0 if (!__pci_complete_power_transition(dev, state=
))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error =3D 0;
>> @@ -1482,6 +1483,17 @@ bool pci_pme_capable(struct pci_dev *dev, pci=
_power_t state)
>> =C2=A0 =C2=A0 =C2=A0 return !!(dev->pme_support & (1 << state));
>> =C2=A0}
>>
>> +static void pci_pme_poll_wakeup(struct pci_dev *dev)
>> +{
>> + =C2=A0 =C2=A0 struct pci_dev *bridge =3D dev->bus->self;
>> +
>> + =C2=A0 =C2=A0 /* don't poll the pme bit if parent is in low power =
state */
>> + =C2=A0 =C2=A0 if (bridge && bridge->current_state !=3D PCI_D0)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
>> +
>> + =C2=A0 =C2=A0 pci_pme_wakeup(dev, NULL);
>> +}
>
> This one actually makes some sense, although it might be better to pu=
t the
> test into pci_pme_wakeup() itself.
>
>> +
>> =C2=A0static void pci_pme_list_scan(struct work_struct *work)
>> =C2=A0{
>> =C2=A0 =C2=A0 =C2=A0 struct pci_pme_device *pme_dev, *n;
>> @@ -1490,7 +1502,7 @@ static void pci_pme_list_scan(struct work_stru=
ct *work)
>> =C2=A0 =C2=A0 =C2=A0 if (!list_empty(&pci_pme_list)) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_for_each_entry=
_safe(pme_dev, n, &pci_pme_list, list) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (pme_dev->dev->pme_poll) {
>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_pme_wakeup(pme_dev->dev, NULL);
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pci_pme_poll_wakeup(pme_dev->dev);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 } else {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 list_del(&pme_dev->list);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 kfree(pme_dev);
>> @@ -1608,6 +1620,10 @@ int __pci_enable_wake(struct pci_dev *dev, pc=
i_power_t state,
>> =C2=A0 =C2=A0 =C2=A0 if (enable) {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 int error;
>>
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (runtime && state >=3D=
 PCI_D3cold)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev->runtime_d3cold =3D true;
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 dev->runtime_d3cold =3D false;
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (pci_pme_capable=
(dev, state))
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 pci_pme_active(dev, true);
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else
>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portd=
rv_pci.c
>> index e0610bd..d66b7e9 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -11,11 +11,13 @@
>> =C2=A0#include <linux/kernel.h>
>> =C2=A0#include <linux/errno.h>
>> =C2=A0#include <linux/pm.h>
>> +#include <linux/pm_runtime.h>
>> =C2=A0#include <linux/init.h>
>> =C2=A0#include <linux/pcieport_if.h>
>> =C2=A0#include <linux/aer.h>
>> =C2=A0#include <linux/dmi.h>
>> =C2=A0#include <linux/pci-aspm.h>
>> +#include <linux/delay.h>
>>
>> =C2=A0#include "portdrv.h"
>> =C2=A0#include "aer/aerdrv.h"
>> @@ -99,6 +101,25 @@ static int pcie_port_resume_noirq(struct device =
*dev)
>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> +static int pcie_port_runtime_suspend(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 struct pci_dev *pdev =3D to_pci_dev(dev);
>> +
>> + =C2=A0 =C2=A0 pci_save_state(pdev);
>
> Are you sure this is sufficient?

Maybe we need to pay attention to the pcie port drivers?  Run ->runtime=
_

>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> +static int pcie_port_runtime_resume(struct device *dev)
>> +{
>> + =C2=A0 =C2=A0 struct pci_dev *pdev =3D to_pci_dev(dev);
>> +
>> + =C2=A0 =C2=A0 pci_restore_state(pdev);
>> + =C2=A0 =C2=A0 if (pdev->runtime_d3cold)
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 msleep(100);
>
> What's _that_ supposed to do?

When resume from d3cold, PCIe main link will be powered on again, it
will take quite some time before the main link go into L0 state.
Otherwise, accessing devices under the port may return wrong result.

>> +
>> + =C2=A0 =C2=A0 return 0;
>> +}
>> +
>> =C2=A0static const struct dev_pm_ops pcie_portdrv_pm_ops =3D {
>> =C2=A0 =C2=A0 =C2=A0 .suspend =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D pcie_po=
rt_device_suspend,
>> =C2=A0 =C2=A0 =C2=A0 .resume =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D pcie_po=
rt_device_resume,
>> @@ -107,6 +128,8 @@ static const struct dev_pm_ops pcie_portdrv_pm_o=
ps =3D {
>> =C2=A0 =C2=A0 =C2=A0 .poweroff =C2=A0 =C2=A0 =C2=A0 =3D pcie_port_de=
vice_suspend,
>> =C2=A0 =C2=A0 =C2=A0 .restore =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D pcie_po=
rt_device_resume,
>> =C2=A0 =C2=A0 =C2=A0 .resume_noirq =C2=A0 =3D pcie_port_resume_noirq=
,
>> + =C2=A0 =C2=A0 .runtime_suspend =3D pcie_port_runtime_suspend,
>> + =C2=A0 =C2=A0 .runtime_resume =3D pcie_port_runtime_resume,
>> =C2=A0};
>>
>> =C2=A0#define PCIE_PORTDRV_PM_OPS =C2=A0(&pcie_portdrv_pm_ops)
>> @@ -144,12 +167,14 @@ static int __devinit pcie_portdrv_probe(struct=
 pci_dev *dev,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return status;
>>
>> =C2=A0 =C2=A0 =C2=A0 pci_save_state(dev);
>> + =C2=A0 =C2=A0 pm_runtime_put_noidle(&dev->dev);
>
> What's the purpose of this?

I think this is needed by PCI runtime PM support.  Before ->probe,
pm_runtime_get_xxx() is executed on device.

>> =C2=A0 =C2=A0 =C2=A0 return 0;
>> =C2=A0}
>>
>> =C2=A0static void pcie_portdrv_remove(struct pci_dev *dev)
>> =C2=A0{
>> + =C2=A0 =C2=A0 pm_runtime_get_noresume(&dev->dev);
>> =C2=A0 =C2=A0 =C2=A0 pcie_port_device_remove(dev);
>> =C2=A0 =C2=A0 =C2=A0 pci_disable_device(dev);
>> =C2=A0}
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index e444f5b..b41d9a1 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -281,6 +281,7 @@ struct pci_dev {
>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0no_d1d2:1; =C2=A0 =C2=
=A0 =C2=A0/* Only allow D0 and D3 */
>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0mmio_always_on:1; =C2=
=A0 =C2=A0 =C2=A0 /* disallow turning off io/mem
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0decoding during bar sizing */
>> + =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0runtime_d3cold:1;
>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0wakeup_prepared:1;
>> =C2=A0 =C2=A0 =C2=A0 unsigned int =C2=A0 =C2=A0d3_delay; =C2=A0 =C2=A0=
 =C2=A0 /* D3->D0 transition time in ms */
>
> OK
>
> So now please tell me what exactly you want to achieve and why you wa=
nt to do
> that in the first place.

Best Regards,
Huang Ying
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

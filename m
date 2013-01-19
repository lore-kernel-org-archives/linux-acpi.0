From: Yijing Wang <wangyijing0307@gmail.com>
Subject: Re: [RFC PATCH v5 7/8] PCI/PCIe: add "pci=nopciehp" to disable PCIe
 native hotplug
Date: Sat, 19 Jan 2013 09:56:24 +0800
Message-ID: <50F9FD48.20509@gmail.com>
References: <1358525267-14268-1-git-send-email-jiang.liu@huawei.com> <1358525267-14268-8-git-send-email-jiang.liu@huawei.com> <CAErSpo6E0SrY8_JOU6pmrCt9opfKe_jJ6b0E0daNAbpX5KtFuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <CAErSpo6E0SrY8_JOU6pmrCt9opfKe_jJ6b0E0daNAbpX5KtFuQ@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jiang Liu <liuj97@gmail.com>, "Rafael J . Wysocki" <rjw@sisk.pl>, Jiang Liu <jiang.liu@huawei.com>, Yinghai Lu <yinghai@kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, Yijing Wang <wangyijing@huawei.com>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Toshi Kani <toshi.kani@hp.com>, Myron Stowe <myron.stowe@redhat.com>
List-Id: linux-acpi@vger.kernel.org

=E4=BA=8E 2013-01-19 1:35, Bjorn Helgaas =E5=86=99=E9=81=93:
> On Fri, Jan 18, 2013 at 9:07 AM, Jiang Liu <liuj97@gmail.com> wrote:
>> If user specifies "pci=3Dnopciehp" on kernel boot command line, OSPM
>> won't claim PCIe native hotplug service from firmware and no PCIe
>> port devices will be created for PCIe native hotplug service.
>=20
> Why do we need this option?
>=20
> If I understand correctly, there are machines where it *looks* like w=
e
> should use pciehp, but pciehp doesn't work because we don't get the
> interrupts we expect.  On those machines, we have to use acpiphp
> instead.  It seems like many Dell XPS laptops have this issue with
> ExpressCard slots, e.g.,
> https://bugzilla.kernel.org/show_bug.cgi?id=3D40802 .

What about use modprobe pciehp pciehp_poll_mode=3D1?
If just cannot receive the interrupt, maybe this module parameter will =
fix it.

>=20
> If you want "pci=3Dnopciehp" as a way for users to deal with this
> problem by forcing the use of acpiphp, I object.  Windows manages to
> make these slots work without having users do anything special, so we
> should be able to do it, too.

In fact, pcie native hotplug may not be implemented perfectly,
for example, I found some x86 machines pcie native hotplug slots that h=
ave problems
with latch register. After inserted a pci card, the latch still report =
latch open state.
So we cannot use pciehp to hotplug, But this problem cannot detect whil=
e system bootup or
load pciehp module. And now kernel force to use pciehp if pci slotcap h=
as hotplug capable.
So I agree as Yinghai said users should have choice to choose hotplug m=
odule to use.

>=20
>> Signed-off-by: Jiang Liu <jiang.liu@huawei.com>
>> ---
>>  Documentation/kernel-parameters.txt |    2 ++
>>  drivers/acpi/pci_root.c             |    3 ++-
>>  drivers/pci/pci.c                   |    2 ++
>>  drivers/pci/pcie/portdrv_core.c     |    5 +++--
>>  drivers/pci/pcie/portdrv_pci.c      |    3 +++
>>  include/linux/pci.h                 |    9 +++++++++
>>  6 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/kernel-parameters.txt b/Documentation/ker=
nel-parameters.txt
>> index 9776f06..28dd0ad 100644
>> --- a/Documentation/kernel-parameters.txt
>> +++ b/Documentation/kernel-parameters.txt
>> @@ -2106,6 +2106,8 @@ bytes respectively. Such letter suffixes can a=
lso be entirely omitted.
>>                 noaer           [PCIE] If the PCIEAER kernel config =
parameter is
>>                                 enabled, this kernel boot option can=
 be used to
>>                                 disable the use of PCIE advanced err=
or reporting.
>> +               nopciehp        [PCIE] this kernel boot option can b=
e used to
>> +                               disable PCIe native hotplug.
>>                 nodomains       [PCI] Disable support for multiple P=
CI
>>                                 root domains (aka PCI segments, in A=
CPI-speak).
>>                 nommconf        [X86] Disable use of MMCONFIG for PC=
I
>> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
>> index c6200ff..c37eedb 100644
>> --- a/drivers/acpi/pci_root.c
>> +++ b/drivers/acpi/pci_root.c
>> @@ -551,8 +551,9 @@ static int __devinit acpi_pci_root_add(struct ac=
pi_device *device)
>>         if (!pcie_ports_disabled
>>             && (flags & ACPI_PCIE_REQ_SUPPORT) =3D=3D ACPI_PCIE_REQ_=
SUPPORT) {
>>                 flags =3D OSC_PCI_EXPRESS_CAP_STRUCTURE_CONTROL
>> -                       | OSC_PCI_EXPRESS_NATIVE_HP_CONTROL
>>                         | OSC_PCI_EXPRESS_PME_CONTROL;
>> +               if (!pcie_native_hotplug_disabled)
>> +                       flags |=3D OSC_PCI_EXPRESS_NATIVE_HP_CONTROL=
;
>>
>>                 if (pci_aer_available()) {
>>                         if (aer_acpi_firmware_first())
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index 2f8f4c6..34b2c83 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -3869,6 +3869,8 @@ static int __init pci_setup(char *str)
>>                                 pci_no_msi();
>>                         } else if (!strcmp(str, "noaer")) {
>>                                 pci_no_aer();
>> +                       } else if (!strcmp(str, "nopciehp")) {
>> +                               pcie_no_native_hotplug();
>>                         } else if (!strncmp(str, "realloc=3D", 8)) {
>>                                 pci_realloc_get_opt(str + 8);
>>                         } else if (!strncmp(str, "realloc", 7)) {
>> diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/port=
drv_core.c
>> index ed129b4..e7e1679 100644
>> --- a/drivers/pci/pcie/portdrv_core.c
>> +++ b/drivers/pci/pcie/portdrv_core.c
>> @@ -263,8 +263,9 @@ static int get_port_device_capability(struct pci=
_dev *dev)
>>
>>         err =3D pcie_port_platform_notify(dev, &cap_mask);
>>         if (!pcie_ports_auto) {
>> -               cap_mask =3D PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVI=
CE_HP
>> -                               | PCIE_PORT_SERVICE_VC;
>> +               cap_mask =3D PCIE_PORT_SERVICE_PME | PCIE_PORT_SERVI=
CE_VC;
>> +               if (!pcie_native_hotplug_disabled)
>> +                       cap_mask |=3D PCIE_PORT_SERVICE_HP;
>>                 if (pci_aer_available())
>>                         cap_mask |=3D PCIE_PORT_SERVICE_AER;
>>         } else if (err) {
>> diff --git a/drivers/pci/pcie/portdrv_pci.c b/drivers/pci/pcie/portd=
rv_pci.c
>> index 0761d90..018cee0 100644
>> --- a/drivers/pci/pcie/portdrv_pci.c
>> +++ b/drivers/pci/pcie/portdrv_pci.c
>> @@ -40,6 +40,9 @@ bool pcie_ports_disabled;
>>   */
>>  bool pcie_ports_auto =3D true;
>>
>> +/* If set, the PCIe native hotplug will not be used. */
>> +bool pcie_native_hotplug_disabled;
>> +
>>  static int __init pcie_port_setup(char *str)
>>  {
>>         if (!strncmp(str, "compat", 6)) {
>> diff --git a/include/linux/pci.h b/include/linux/pci.h
>> index 12e5447..715e17b 100644
>> --- a/include/linux/pci.h
>> +++ b/include/linux/pci.h
>> @@ -1138,9 +1138,18 @@ extern int pci_msi_enabled(void);
>>  #ifdef CONFIG_PCIEPORTBUS
>>  extern bool pcie_ports_disabled;
>>  extern bool pcie_ports_auto;
>> +extern bool pcie_native_hotplug_disabled;
>> +
>> +static inline void pcie_no_native_hotplug(void)
>> +{
>> +       pcie_native_hotplug_disabled =3D true;
>> +}
>>  #else
>>  #define pcie_ports_disabled    true
>>  #define pcie_ports_auto                false
>> +#define pcie_native_hotplug_disabled   true
>> +
>> +static inline void pcie_no_native_hotplug(void) { }
>>  #endif
>>
>>  #ifndef CONFIG_PCIEASPM
>> --
>> 1.7.9.5
>>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" =
in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

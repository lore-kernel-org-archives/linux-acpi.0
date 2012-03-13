From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 23/37] PCI, ACPI: Add pci_root_hp hot add hotplug notification
Date: Mon, 12 Mar 2012 21:22:16 -0600
Message-ID: <CAErSpo5cCC4HySedQ85BFKkPQ0VuYWX+NTjZLd4GpcATh1ix3g@mail.gmail.com>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org> <1331362837-10740-24-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1331362837-10740-24-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Sat, Mar 10, 2012 at 12:00 AM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> It is from acpiphp_glue.c
>
> How to use it?
> Find out root bus number to acpi root name mapping from dmesg or /sys
>
> =A0echo "\_SB.PCIB 0" > /proc/acpi/sci/notify
> to add it back

Nope.  That might be a way to exercise this for debug purposes (and it
only works when /proc/acpi/sci/notify is compiled in), but we
definitely don't want normal users to deal with ACPI pathnames like
this.

Most of this functionality belongs in the ACPI core, not here.  The
core should be handling these notify events and turning them into
=2Eadd() and .remove() calls to the driver.

But since the ACPI core doesn't do that yet, we have to do it in the
driver, like we do for CPU, memory, etc.  That part is fine.  But I
think it at least belongs *in* the driver, i.e., in pci_root.c, not in
a new pci_root_hp.c file.

There definitely should not be another acpi_walk_namespace() and
another list of ACPI host bridges.  The core *does* already walk the
namespace and call acpi_pci_root_add() for us.  And the driver already
has a list of host bridges (acpi_pci_roots).

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
> =A0drivers/acpi/Makefile =A0 =A0 =A0| =A0 =A01 +
> =A0drivers/acpi/pci_root_hp.c | =A0237 ++++++++++++++++++++++++++++++=
++++++++++++++
> =A02 files changed, 238 insertions(+), 0 deletions(-)
> =A0create mode 100644 drivers/acpi/pci_root_hp.c
>
> diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
> index 1567028..bc6e53f 100644
> --- a/drivers/acpi/Makefile
> +++ b/drivers/acpi/Makefile
> @@ -36,6 +36,7 @@ acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0+=3D processor_core.o
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D ec.o
> =A0acpi-$(CONFIG_ACPI_DOCK) =A0 =A0 =A0 +=3D dock.o
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D pci_ro=
ot.o pci_link.o pci_irq.o pci_bind.o
> +acpi-$(CONFIG_HOTPLUG) =A0 =A0 =A0 =A0 +=3D pci_root_hp.o
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D power.=
o
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D event.=
o
> =A0acpi-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 +=3D sysfs.=
o
> diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
> new file mode 100644
> index 0000000..dc11e81
> --- /dev/null
> +++ b/drivers/acpi/pci_root_hp.c
> @@ -0,0 +1,237 @@
> +/*
> + * Separated from drivers/pci/hotplug/acpiphp_glue.c
> + * =A0 =A0 only support root bridge
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +
> +#include <linux/kernel.h>
> +#include <linux/pci.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/acpi.h>
> +
> +static LIST_HEAD(acpi_root_bridge_list);
> +struct acpi_root_bridge {
> + =A0 =A0 =A0 struct list_head list;
> + =A0 =A0 =A0 acpi_handle handle;
> + =A0 =A0 =A0 u32 flags;
> +};
> +
> +/* bridge flags */
> +#define ROOT_BRIDGE_HAS_EJ0 =A0 =A0(0x00000002)
> +#define ROOT_BRIDGE_HAS_PS3 =A0 =A0(0x00000080)
> +
> +#define ACPI_STA_FUNCTIONING =A0 (0x00000008)
> +
> +static struct acpi_root_bridge *acpi_root_handle_to_bridge(acpi_hand=
le handle)
> +{
> + =A0 =A0 =A0 struct acpi_root_bridge *bridge;
> +
> + =A0 =A0 =A0 list_for_each_entry(bridge, &acpi_root_bridge_list, lis=
t)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (bridge->handle =3D=3D handle)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return bridge;
> +
> + =A0 =A0 =A0 return NULL;
> +}
> +
> +/* allocate and initialize host bridge data structure */
> +static void add_acpi_root_bridge(acpi_handle handle)
> +{
> + =A0 =A0 =A0 struct acpi_root_bridge *bridge;
> + =A0 =A0 =A0 acpi_handle dummy_handle;
> + =A0 =A0 =A0 acpi_status status;
> +
> + =A0 =A0 =A0 /* if the bridge doesn't have _STA, we assume it is alw=
ays there */
> + =A0 =A0 =A0 status =3D acpi_get_handle(handle, "_STA", &dummy_handl=
e);
> + =A0 =A0 =A0 if (ACPI_SUCCESS(status)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned long long tmp;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_evaluate_integer(handle=
, "_STA", NULL, &tmp);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "%s: =
_STA evaluation failure\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if ((tmp & ACPI_STA_FUNCTIONING) =3D=3D=
 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* don't register this =
object */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 bridge =3D kzalloc(sizeof(struct acpi_root_bridge), GFP=
_KERNEL);
> + =A0 =A0 =A0 if (!bridge)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 bridge->handle =3D handle;
> +
> + =A0 =A0 =A0 if (ACPI_SUCCESS(acpi_get_handle(handle, "_EJ0", &dummy=
_handle)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bridge->flags |=3D ROOT_BRIDGE_HAS_EJ0;
> + =A0 =A0 =A0 if (ACPI_SUCCESS(acpi_get_handle(handle, "_PS3", &dummy=
_handle)))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bridge->flags |=3D ROOT_BRIDGE_HAS_PS3;
> +
> + =A0 =A0 =A0 list_add(&bridge->list, &acpi_root_bridge_list);
> +}
> +
> +struct acpi_root_hp_work {
> + =A0 =A0 =A0 struct work_struct work;
> + =A0 =A0 =A0 acpi_handle handle;
> + =A0 =A0 =A0 u32 type;
> + =A0 =A0 =A0 void *context;
> +};
> +
> +static void alloc_acpi_root_hp_work(acpi_handle handle, u32 type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 void *context,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 void (*func)(struct work_struct *work))
> +{
> + =A0 =A0 =A0 struct acpi_root_hp_work *hp_work;
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 hp_work =3D kmalloc(sizeof(*hp_work), GFP_KERNEL);
> + =A0 =A0 =A0 if (!hp_work)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 hp_work->handle =3D handle;
> + =A0 =A0 =A0 hp_work->type =3D type;
> + =A0 =A0 =A0 hp_work->context =3D context;
> +
> + =A0 =A0 =A0 INIT_WORK(&hp_work->work, func);
> + =A0 =A0 =A0 ret =3D queue_work(kacpi_hotplug_wq, &hp_work->work);
> + =A0 =A0 =A0 if (!ret)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(hp_work);
> +}
> +
> +/* Program resources in newly inserted bridge */
> +static void acpi_root_configure_bridge(acpi_handle handle)
> +{
> + =A0 =A0 =A0 struct acpi_pci_root *root =3D acpi_pci_find_root(handl=
e);
> +
> + =A0 =A0 =A0 pci_assign_unassigned_bus_resources(root->bus);
> +}
> +
> +static void handle_root_bridge_insertion(acpi_handle handle)
> +{
> + =A0 =A0 =A0 struct acpi_device *device, *pdevice;
> + =A0 =A0 =A0 acpi_handle phandle;
> + =A0 =A0 =A0 int ret_val;
> +
> + =A0 =A0 =A0 acpi_get_parent(handle, &phandle);
> + =A0 =A0 =A0 if (acpi_bus_get_device(phandle, &pdevice)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "no parent device, as=
suming NULL\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 pdevice =3D NULL;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (!acpi_bus_get_device(handle, &device)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* check if =A0pci root_bus is removed =
*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct acpi_pci_root *root =3D acpi_dri=
ver_data(device);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (pci_find_bus(root->segment, root->s=
econdary.start))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "bus exists... trim\n=
");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* this shouldn't be in here, so remove
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* the bus then re-add it...
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret_val =3D acpi_bus_trim(device, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "acpi_bus_trim return=
 %x\n", ret_val);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (acpi_bus_add(&device, pdevice, handle, ACPI_BUS_TYP=
E_DEVICE)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "cannot add bridge to a=
cpi list\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 acpi_root_configure_bridge(handle);
> + =A0 =A0 =A0 if (acpi_bus_start(device))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "cannot start bridge\n"=
);
> +}
> +
> +static void _handle_hotplug_event_root(struct work_struct *work)
> +{
> + =A0 =A0 =A0 struct acpi_root_bridge *bridge;
> + =A0 =A0 =A0 char objname[64];
> + =A0 =A0 =A0 struct acpi_buffer buffer =3D { .length =3D sizeof(objn=
ame),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 .pointer =3D objname };
> + =A0 =A0 =A0 struct acpi_root_hp_work *hp_work;
> + =A0 =A0 =A0 acpi_handle handle;
> + =A0 =A0 =A0 u32 type;
> +
> + =A0 =A0 =A0 hp_work =3D container_of(work, struct acpi_root_hp_work=
, work);
> + =A0 =A0 =A0 handle =3D hp_work->handle;
> + =A0 =A0 =A0 type =3D hp_work->type;
> +
> + =A0 =A0 =A0 bridge =3D acpi_root_handle_to_bridge(handle);
> +
> + =A0 =A0 =A0 acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> +
> + =A0 =A0 =A0 switch (type) {
> + =A0 =A0 =A0 case ACPI_NOTIFY_BUS_CHECK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* bus enumerate */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "%s: Bus check notify=
 on %s\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objn=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bridge) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_root_bridge_inse=
rtion(handle);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_acpi_root_bridge(ha=
ndle);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 case ACPI_NOTIFY_DEVICE_CHECK:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* device check */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "%s: Device check not=
ify on %s\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objn=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!bridge) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_root_bridge_inse=
rtion(handle);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 add_acpi_root_bridge(ha=
ndle);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> +
> + =A0 =A0 =A0 default:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "notify_handler: un=
known event type 0x%x for %s\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0type=
, objname);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 kfree(hp_work); /* allocated in handle_hotplug_event_br=
idge */
> +}
> +
> +static void handle_hotplug_event_root(acpi_handle handle, u32 type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 void *context)
> +{
> + =A0 =A0 =A0 alloc_acpi_root_hp_work(handle, type, context,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 _handle=
_hotplug_event_root);
> +}
> +
> +static acpi_status __init
> +find_root_bridges(acpi_handle handle, u32 lvl, void *context, void *=
*rv)
> +{
> + =A0 =A0 =A0 char objname[64];
> + =A0 =A0 =A0 struct acpi_buffer buffer =3D { .length =3D sizeof(objn=
ame),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 .pointer =3D objname };
> + =A0 =A0 =A0 int *count =3D (int *)context;
> +
> + =A0 =A0 =A0 if (!acpi_is_root_bridge(handle))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return AE_OK;
> +
> + =A0 =A0 =A0 (*count)++;
> +
> + =A0 =A0 =A0 acpi_get_name(handle, ACPI_FULL_PATHNAME, &buffer);
> +
> + =A0 =A0 =A0 acpi_install_notify_handler(handle, ACPI_SYSTEM_NOTIFY,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_=
hotplug_event_root, NULL);
> + =A0 =A0 =A0 printk(KERN_DEBUG "acpi root: %s notify handler install=
ed\n", objname);
> +
> + =A0 =A0 =A0 add_acpi_root_bridge(handle);
> +
> + =A0 =A0 =A0 return AE_OK;
> +}
> +
> +static int __init acpi_pci_root_hp_init(void)
> +{
> + =A0 =A0 =A0 int num =3D 0;
> +
> + =A0 =A0 =A0 acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ACPI_UINT32_MAX, find_root_bridges, NUL=
L, &num, NULL);
> +
> + =A0 =A0 =A0 printk(KERN_DEBUG "Found %d acpi root devices\n", num);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +subsys_initcall(acpi_pci_root_hp_init);
> --
> 1.7.7
>

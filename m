From: Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 24/37] PCI, ACPI: Add pci_root_hp hot removal
 notification support.
Date: Mon, 12 Mar 2012 21:25:45 -0600
Message-ID: <CAErSpo6g3pei2+oW0wLEpytBTh6wGTyzo28oVVzFECxZdta+FA@mail.gmail.com>
References: <1331362837-10740-1-git-send-email-yinghai@kernel.org> <1331362837-10740-25-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:59079 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759022Ab2CMD0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 12 Mar 2012 23:26:06 -0400
Received: by mail-lpp01m010-f46.google.com with SMTP id j13so72626lah.19
        for <linux-acpi@vger.kernel.org>; Mon, 12 Mar 2012 20:26:05 -0700 (PDT)
In-Reply-To: <1331362837-10740-25-git-send-email-yinghai@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Yinghai Lu <yinghai@kernel.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, x86 <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org

On Sat, Mar 10, 2012 at 12:00 AM, Yinghai Lu <yinghai@kernel.org> wrote=
:
> Add missing hot_remove support for root device.
>
> How to use it?
> Find out root bus number to acpi root name mapping from dmesg or /sys
>
> =A0echo "\_SB.PCIB 3" > /proc/acpi/sci/notify
> to remove root bus

Same comments as before: this is definitely NOT the way users should
use this.  If you want to do that for debugging the ACPI notification
path, fine, but the normal way is for the platform to generate this
notification.  I think the normal way for users to manually remove an
ACPI device should be something like:

    echo 1 > /sys/devices/LNXSYSTM:00/device:00/PNP0A08:00/remove

just like we do for PCI devices.

> Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-acpi@vger.kernel.org
> ---
> =A0drivers/acpi/pci_root_hp.c | =A0 61 ++++++++++++++++++++++++++++++=
++++++++++++++
> =A01 files changed, 61 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/acpi/pci_root_hp.c b/drivers/acpi/pci_root_hp.c
> index dc11e81..f5585f5 100644
> --- a/drivers/acpi/pci_root_hp.c
> +++ b/drivers/acpi/pci_root_hp.c
> @@ -73,6 +73,12 @@ static void add_acpi_root_bridge(acpi_handle handl=
e)
> =A0 =A0 =A0 =A0list_add(&bridge->list, &acpi_root_bridge_list);
> =A0}
>
> +static void remove_acpi_root_bridge(struct acpi_root_bridge *bridge)
> +{
> + =A0 =A0 =A0 list_del(&bridge->list);
> + =A0 =A0 =A0 kfree(bridge);
> +}
> +
> =A0struct acpi_root_hp_work {
> =A0 =A0 =A0 =A0struct work_struct work;
> =A0 =A0 =A0 =A0acpi_handle handle;
> @@ -142,6 +148,55 @@ static void handle_root_bridge_insertion(acpi_ha=
ndle handle)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_ERR "cannot start bridge\n=
");
> =A0}
>
> +static int acpi_root_evaluate_object(acpi_handle handle, char *cmd, =
int val)
> +{
> + =A0 =A0 =A0 acpi_status status;
> + =A0 =A0 =A0 struct acpi_object_list arg_list;
> + =A0 =A0 =A0 union acpi_object arg;
> +
> + =A0 =A0 =A0 arg_list.count =3D 1;
> + =A0 =A0 =A0 arg_list.pointer =3D &arg;
> + =A0 =A0 =A0 arg.type =3D ACPI_TYPE_INTEGER;
> + =A0 =A0 =A0 arg.integer.value =3D val;
> +
> + =A0 =A0 =A0 status =3D acpi_evaluate_object(handle, cmd, &arg_list,=
 NULL);
> + =A0 =A0 =A0 if (ACPI_FAILURE(status)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s: %s to %d faile=
d\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__fu=
nc__, cmd, val);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 return 0;

This function really has nothing to do with host bridges.  Are you
sure there's no generic function you can use instead?

> +}
> +
> +static void handle_root_bridge_removal(acpi_handle handle,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct acpi_root_bridge *bridge)
> +{
> + =A0 =A0 =A0 u32 flags =3D 0;
> + =A0 =A0 =A0 struct acpi_device *device;
> +
> + =A0 =A0 =A0 if (bridge) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 flags =3D bridge->flags;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 remove_acpi_root_bridge(bridge);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (!acpi_bus_get_device(handle, &device)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 int ret_val =3D acpi_bus_trim(device, 1=
);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "acpi_bus_trim return=
 %x\n", ret_val);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (flags & ROOT_BRIDGE_HAS_PS3) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_status status;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 status =3D acpi_evaluate_object(handle,=
 "_PS3", NULL, NULL);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ACPI_FAILURE(status))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_WARNING "%s=
: _PS3 failed\n", __func__);
> + =A0 =A0 =A0 }
> + =A0 =A0 =A0 if (flags & ROOT_BRIDGE_HAS_EJ0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 acpi_root_evaluate_object(handle, "_EJ0=
", 1);
> +}
> +
> =A0static void _handle_hotplug_event_root(struct work_struct *work)
> =A0{
> =A0 =A0 =A0 =A0struct acpi_root_bridge *bridge;
> @@ -182,6 +237,12 @@ static void _handle_hotplug_event_root(struct wo=
rk_struct *work)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
>
> + =A0 =A0 =A0 case ACPI_NOTIFY_EJECT_REQUEST:
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* request device eject */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_DEBUG "%s: Device eject not=
ify on %s\n", __func__,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0objn=
ame);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 handle_root_bridge_removal(handle, brid=
ge);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk(KERN_WARNING "notify_handler: u=
nknown event type 0x%x for %s\n",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 type,=
 objname);
> --
> 1.7.7
>
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

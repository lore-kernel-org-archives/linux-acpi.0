From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH] EeePC 1005PE rfkill fix
Date: Thu, 28 Jan 2010 14:26:14 +0100
Message-ID: <71cd59b01001280526m54ddbd82t7803629a2149fa2c@mail.gmail.com>
References: <201001281253.54878.paul@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:42565 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751628Ab0A1N0Q convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 28 Jan 2010 08:26:16 -0500
In-Reply-To: <201001281253.54878.paul@codesourcery.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Paul Brook <paul@codesourcery.com>
Cc: acpi4asus-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux acpi <linux-acpi@vger.kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>

On Thu, Jan 28, 2010 at 1:53 PM, Paul Brook <paul@codesourcery.com> wro=
te:
> The EeePC 1005PE has the wireless card on PCI bus 2.
>
> Signed-off-by: Paul Brook <paul@codesourcery.com>
> ---
> Same as before, but without mail client mangling the patch.
>
> I couldn't figure out a smart way of figuring out the correct bus, so=
 I
> hardcoded the device name. lspci and acpi dumps available at
> http://www.pbrook80.webspace.virginmedia.com/
>
> My guess is that the 1005HA is configured similarly, however I don't =
have
> hardware to test. The preceding comments imply that the 1005HA does n=
ot
> require the pci hotplug bits. On my 1005PE the hotplug bits are defin=
itely
> required (the device stops responding when the rfkill is activated), =
we just
> need to make sure we disable the right bus. PCI bus 1 contains the wi=
red
> Ethernet controller.
>
> =A0drivers/platform/x86/eeepc-laptop.c | =A0 15 ++++++++++++---
> =A01 files changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x=
86/eeepc-laptop.c
> index e2be6bb..6b53701 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -161,6 +161,7 @@ struct eeepc_laptop {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 by this BIOS */
> =A0 =A0 =A0 =A0bool cpufv_disabled;
> =A0 =A0 =A0 =A0bool hotplug_disabled;
> + =A0 =A0 =A0 int hotplug_bus;
> =A0 =A0 =A0 =A0u16 event_count[128]; =A0 =A0 =A0 =A0 =A0 /* count for=
 each event */
>
> =A0 =A0 =A0 =A0struct platform_device *platform_device;
> @@ -585,9 +586,10 @@ static void eeepc_rfkill_hotplug(struct eeepc_la=
ptop *eeepc)
> =A0 =A0 =A0 =A0mutex_lock(&eeepc->hotplug_lock);
>
> =A0 =A0 =A0 =A0if (eeepc->hotplug_slot) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_find_bus(0, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 bus =3D pci_find_bus(0, eeepc->hotplug_=
bus);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!bus) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("Unable to f=
ind PCI bus 1?\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_warning("Unable to f=
ind PCI bus %d?\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
eeepc->hotplug_bus);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0goto out_unlock;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> @@ -695,7 +697,7 @@ static struct hotplug_slot_ops eeepc_hotplug_slot=
_ops =3D {
> =A0static int eeepc_setup_pci_hotplug(struct eeepc_laptop *eeepc)
> =A0{
> =A0 =A0 =A0 =A0int ret =3D -ENOMEM;
> - =A0 =A0 =A0 struct pci_bus *bus =3D pci_find_bus(0, 1);
> + =A0 =A0 =A0 struct pci_bus *bus =3D pci_find_bus(0, eeepc->hotplug_=
bus);
>
> =A0 =A0 =A0 =A0if (!bus) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err("Unable to find wifi PCI bus\n"=
);
> @@ -1281,6 +1283,13 @@ static void eeepc_dmi_check(struct eeepc_lapto=
p *eeepc)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0eeepc->hotplug_disabled =3D true;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_info("wlan hotplug disabled\n");
> =A0 =A0 =A0 =A0}
> +
> + =A0 =A0 =A0 /* The eeepc 1005PE has the wireless chip on the second=
 PCIe bus. =A0*/
> + =A0 =A0 =A0 if (strcmp(model, "1005PE") =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 eeepc->hotplug_bus =3D 2;
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 eeepc->hotplug_bus =3D 1;
> + =A0 =A0 =A0 }
> =A0}
>
> =A0static void cmsg_quirk(struct eeepc_laptop *eeepc, int cm, const c=
har *name)
> --
> 1.6.6

Hi Paul,
=46irst did you try your patch with an updated bios ?
It's weird that 1005HA and 1005PE don't have the same behavior :/.
Any objection about this patch someone ?
If not, I'll add it to acpi4asus tree, but it may not be included in 2.=
6.33.
Thanks,

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

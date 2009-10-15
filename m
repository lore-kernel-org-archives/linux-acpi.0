From: Corentin Chary <corentin.chary@gmail.com>
Subject: Re: [PATCH 6/8] eeepc-laptop: Prevent a panic when disabling RT2860
	wireless when associated
Date: Thu, 15 Oct 2009 09:05:55 +0000
Message-ID: <71cd59b00910150205o1c17d7aase0167848e1360659@mail.gmail.com>
References: <68b92b567c0c5e6f4d0b264d438f97ee5ccbdccc.1255582742.git.len.brown@intel.com>
	 <1255582783-16088-1-git-send-email-lenb@kernel.org>
	 <b56ab33d68638e6aafdbfc694025e8354a628f49.1255582742.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:49249 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932098AbZJOJGd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2009 05:06:33 -0400
Received: by yxe17 with SMTP id 17so869033yxe.33
        for <linux-acpi@vger.kernel.org>; Thu, 15 Oct 2009 02:05:56 -0700 (PDT)
In-Reply-To: <b56ab33d68638e6aafdbfc694025e8354a628f49.1255582742.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Darren Salt <linux@youmustbejoking.demon.co.uk>, Len Brown <len.brown@intel.com>

On Thu, Oct 15, 2009 at 4:59 AM, Len Brown <lenb@kernel.org> wrote:
> From: Darren Salt <linux@youmustbejoking.demon.co.uk>
>
> This works around what I think is actually a bug in rt2860sta which i=
s
> triggered when the hardware "disappears" from beneath the driver, i.e=
=2E when
> wireless is toggled off via ACPI. It does so by ensuring that the rfk=
ill
> soft-block flag is set before the hardware is disabled.
>
> I do not know whether this patch is required if rt2800pci is in use i=
nstead
> of rt2860sta; at the time of submission of this patch, I've not been =
able to
> test this.
>
> (Ref. http://bugzilla.kernel.org/show_bug.cgi?id=3D13390)
>
> Signed-off-by: Darren Salt <linux@youmustbejoking.demon.co.uk>
> Signed-off-by: Len Brown <len.brown@intel.com>
> ---
> =A0drivers/platform/x86/eeepc-laptop.c | =A0 27 +++++++++++++++++++--=
------
> =A01 files changed, 19 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/platform/x86/eeepc-laptop.c b/drivers/platform/x=
86/eeepc-laptop.c
> index 789d6ae..d379e74 100644
> --- a/drivers/platform/x86/eeepc-laptop.c
> +++ b/drivers/platform/x86/eeepc-laptop.c
> @@ -150,6 +150,8 @@ struct eeepc_hotk {
> =A0/* The actual device the driver binds to */
> =A0static struct eeepc_hotk *ehotk;
>
> +static void eeepc_rfkill_hotplug(bool real);
> +
> =A0/* Platform device/driver */
> =A0static int eeepc_hotk_thaw(struct device *device);
> =A0static int eeepc_hotk_restore(struct device *device);
> @@ -343,7 +345,16 @@ static bool eeepc_wlan_rfkill_blocked(void)
> =A0static int eeepc_rfkill_set(void *data, bool blocked)
> =A0{
> =A0 =A0 =A0 =A0unsigned long asl =3D (unsigned long)data;
> - =A0 =A0 =A0 return set_acpi(asl, !blocked);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 if (asl !=3D CM_ASL_WLAN)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return set_acpi(asl, !blocked);
> +
> + =A0 =A0 =A0 /* hack to avoid panic with rt2860sta */
> + =A0 =A0 =A0 if (blocked)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeepc_rfkill_hotplug(false);
> + =A0 =A0 =A0 ret =3D set_acpi(asl, !blocked);
> + =A0 =A0 =A0 return ret;
> =A0}
>
> =A0static const struct rfkill_ops eeepc_rfkill_ops =3D {
> @@ -643,13 +654,13 @@ static int eeepc_get_adapter_status(struct hotp=
lug_slot *hotplug_slot,
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void eeepc_rfkill_hotplug(void)
> +static void eeepc_rfkill_hotplug(bool real)
> =A0{
> =A0 =A0 =A0 =A0struct pci_dev *dev;
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> - =A0 =A0 =A0 bool blocked =3D eeepc_wlan_rfkill_blocked();
> + =A0 =A0 =A0 bool blocked =3D real ? eeepc_wlan_rfkill_blocked() : t=
rue;
>
> - =A0 =A0 =A0 if (ehotk->wlan_rfkill)
> + =A0 =A0 =A0 if (real && ehotk->wlan_rfkill)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfkill_set_sw_state(ehotk->wlan_rfkill=
, blocked);
>
> =A0 =A0 =A0 =A0mutex_lock(&ehotk->hotplug_lock);
> @@ -692,7 +703,7 @@ static void eeepc_rfkill_notify(acpi_handle handl=
e, u32 event, void *data)
> =A0 =A0 =A0 =A0if (event !=3D ACPI_NOTIFY_BUS_CHECK)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 eeepc_rfkill_hotplug();
> + =A0 =A0 =A0 eeepc_rfkill_hotplug(true);
> =A0}
>
> =A0static void eeepc_hotk_notify(struct acpi_device *device, u32 even=
t)
> @@ -850,7 +861,7 @@ static int eeepc_hotk_restore(struct device *devi=
ce)
> =A0{
> =A0 =A0 =A0 =A0/* Refresh both wlan rfkill state and pci hotplug */
> =A0 =A0 =A0 =A0if (ehotk->wlan_rfkill)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeepc_rfkill_hotplug();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeepc_rfkill_hotplug(true);
>
> =A0 =A0 =A0 =A0if (ehotk->bluetooth_rfkill)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfkill_set_sw_state(ehotk->bluetooth_r=
fkill,
> @@ -993,7 +1004,7 @@ static void eeepc_rfkill_exit(void)
> =A0 =A0 =A0 =A0 * Refresh pci hotplug in case the rfkill state was ch=
anged after
> =A0 =A0 =A0 =A0 * eeepc_unregister_rfkill_notifier()
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 eeepc_rfkill_hotplug();
> + =A0 =A0 =A0 eeepc_rfkill_hotplug(true);
> =A0 =A0 =A0 =A0if (ehotk->hotplug_slot)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_hp_deregister(ehotk->hotplug_slot)=
;
>
> @@ -1109,7 +1120,7 @@ static int eeepc_rfkill_init(struct device *dev=
)
> =A0 =A0 =A0 =A0 * Refresh pci hotplug in case the rfkill state was ch=
anged during
> =A0 =A0 =A0 =A0 * setup.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 eeepc_rfkill_hotplug();
> + =A0 =A0 =A0 eeepc_rfkill_hotplug(true);
>
> =A0exit:
> =A0 =A0 =A0 =A0if (result && result !=3D -ENODEV)
> --
> 1.6.0.6
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>

Hi Len,
I sent you a revert request 2 days ago for this patch, Darren reported
some problems with it.
You may have missed it, it can be found at:
http://marc.info/?l=3Dlinux-acpi&m=3D125542258501548&w=3D2 .
Is it still time to revert ?
Thanks,

--=20
Corentin Chary
http://xf.iksaif.net
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

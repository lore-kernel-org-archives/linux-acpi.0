From: Corentin Chary <corentin.chary-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 2.6.32-rc3] Prevent a panic when
	disabling RT2860 wireless when associated
Date: Tue, 6 Oct 2009 23:18:36 +0200
Message-ID: <71cd59b00910061418o6a9e3e65n6365972ee0980780@mail.gmail.com>
References: <mpro.kr41l600vf1lc0bg3.linux@youmustbejoking.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <mpro.kr41l600vf1lc0bg3.linux-Ym6Ivm/Ks7B65+NM0QMiFAbYiX8G1TQY9dF7HbQ/qKg@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=acpi4asus-user>
List-Post: <mailto:acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi4asus-user>,
	<mailto:acpi4asus-user-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Errors-To: acpi4asus-user-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: corentincj-EjuBZuxMvz2sTnJN9+BGXg@public.gmane.org, acpi4asus-user-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Darren Salt <linux-Ym6Ivm/Ks7B65+NM0QMiFAbYiX8G1TQY9dF7HbQ/qKg@public.gmane.org>
Cc: linux acpi <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alan Jenkins <alan-jenkins-cCz0Lq7MMjm9FHfhHBbuYA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, Oct 6, 2009 at 10:43 PM, Darren Salt
<linux-Ym6Ivm/Ks7B65+NM0QMiFAbYiX8G1TQY9dF7HbQ/qKg@public.gmane.org> wrote:
> This works around what I think is actually a bug in rt2860sta which is
> triggered when the hardware "disappears" from beneath the driver, i.e. wh=
en
> wireless is toggled off via ACPI. It does so by ensuring that the rfkill
> soft-block flag is set before the hardware is disabled.
>
> I do not know whether this patch is required if rt2800pci is in use inste=
ad
> of rt2860sta; at the time of submission of this patch, I've not been able=
 to
> test this.
>
> (Ref. http://bugzilla.kernel.org/show_bug.cgi?id=3D13390)
>
> Signed-off-by: Darren Salt <linux-Ym6Ivm/Ks7B65+NM0QMiFAbYiX8G1TQY9dF7HbQ/qKg@public.gmane.org>
>
> --- a/drivers/platform/x86/eeepc-laptop.c =A0 =A0 =A0 2009-10-06 02:03:33=
.656944837 +0100
> +++ b/drivers/platform/x86/eeepc-laptop.c =A0 =A0 =A0 2009-10-06 03:03:15=
.693022131 +0100
> @@ -150,6 +150,8 @@ struct eeepc_hotk {
> =A0/* The actual device the driver binds to */
> =A0static struct eeepc_hotk *ehotk;
>
> +static void eeepc_rfkill_hotplug(bool real);
> +
> =A0/* Platform device/driver */
> =A0static int eeepc_hotk_thaw(struct device *device);
> =A0static int eeepc_hotk_restore(struct device *device);
> @@ -343,7 +345,16 @@ static bool eeepc_wlan_rfkill_blocked(vo
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
> @@ -643,13 +654,13 @@ static int eeepc_get_adapter_status(stru
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> -static void eeepc_rfkill_hotplug(void)
> +static void eeepc_rfkill_hotplug(bool real)
> =A0{
> =A0 =A0 =A0 =A0struct pci_dev *dev;
> =A0 =A0 =A0 =A0struct pci_bus *bus;
> - =A0 =A0 =A0 bool blocked =3D eeepc_wlan_rfkill_blocked();
> + =A0 =A0 =A0 bool blocked =3D real ? eeepc_wlan_rfkill_blocked() : true;
>
> - =A0 =A0 =A0 if (ehotk->wlan_rfkill)
> + =A0 =A0 =A0 if (real && ehotk->wlan_rfkill)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfkill_set_sw_state(ehotk->wlan_rfkill, bl=
ocked);
>
> =A0 =A0 =A0 =A0mutex_lock(&ehotk->hotplug_lock);
> @@ -692,7 +703,7 @@ static void eeepc_rfkill_notify(acpi_han
> =A0 =A0 =A0 =A0if (event !=3D ACPI_NOTIFY_BUS_CHECK)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return;
>
> - =A0 =A0 =A0 eeepc_rfkill_hotplug();
> + =A0 =A0 =A0 eeepc_rfkill_hotplug(true);
> =A0}
>
> =A0static void eeepc_hotk_notify(struct acpi_device *device, u32 event)
> @@ -850,7 +861,7 @@ static int eeepc_hotk_restore(struct dev
> =A0{
> =A0 =A0 =A0 =A0/* Refresh both wlan rfkill state and pci hotplug */
> =A0 =A0 =A0 =A0if (ehotk->wlan_rfkill)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeepc_rfkill_hotplug();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 eeepc_rfkill_hotplug(true);
>
> =A0 =A0 =A0 =A0if (ehotk->bluetooth_rfkill)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rfkill_set_sw_state(ehotk->bluetooth_rfkil=
l,
> @@ -993,7 +1004,7 @@ static void eeepc_rfkill_exit(void)
> =A0 =A0 =A0 =A0 * Refresh pci hotplug in case the rfkill state was change=
d after
> =A0 =A0 =A0 =A0 * eeepc_unregister_rfkill_notifier()
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 eeepc_rfkill_hotplug();
> + =A0 =A0 =A0 eeepc_rfkill_hotplug(true);
> =A0 =A0 =A0 =A0if (ehotk->hotplug_slot)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pci_hp_deregister(ehotk->hotplug_slot);
>
> @@ -1109,7 +1120,7 @@ static int eeepc_rfkill_init(struct devi
> =A0 =A0 =A0 =A0 * Refresh pci hotplug in case the rfkill state was change=
d during
> =A0 =A0 =A0 =A0 * setup.
> =A0 =A0 =A0 =A0 */
> - =A0 =A0 =A0 eeepc_rfkill_hotplug();
> + =A0 =A0 =A0 eeepc_rfkill_hotplug(true);
>
> =A0exit:
> =A0 =A0 =A0 =A0if (result && result !=3D -ENODEV)
>
> --
> | Darren Salt =A0 =A0 =A0 =A0 =A0 =A0| linux at youmustbejoking | nr. Ash=
ington, | Doon
> | using Debian GNU/Linux | or ds =A0 =A0,demon,co,uk =A0 =A0| Northumberl=
and | Army
> | + Lobby friends, family, business, government. =A0 =A0WE'RE KILLING THE=
 PLANET.
>
> Insanity is just a state of mind.
>

Hi,
Did you test this patch with other hardware ?
Can't we fix that directly in rt2860sta ?
Thanks,

-- =

Corentin Chary
http://xf.iksaif.net

---------------------------------------------------------------------------=
---
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay =

ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference

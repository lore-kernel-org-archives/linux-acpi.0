From: Vikram Dhillon <opensolarisdev@gmail.com>
Subject: Re: [PATCH 16/21] toshiba_bluetooth: Use struct dev_pm_ops for power management
Date: Sun, 24 Jun 2012 08:40:02 -0400
Message-ID: <CAK7t_7Vfgqps+iavyQmXhj+CwSoBOEkCyFhTo_mXnC3stQtxDw@mail.gmail.com>
References: <201206232306.06602.rjw@sisk.pl>
	<201206232318.18196.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201206232318.18196.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM list <linux-pm@vger.kernel.org>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, Eric Piel <eric.piel@tremplin-utc.net>, Mattia Dongili <malattia@linux.it>, Harald Welte <laforge@gnumonks.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, Jun 23, 2012 at 5:18 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Make the toshiba_bluetooth driver define its PM callbacks through
> a struct dev_pm_ops object rather than by using legacy PM hooks
> in struct acpi_device_ops.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =A0drivers/platform/x86/toshiba_bluetooth.c | =A0 10 ++++++----
> =A01 file changed, 6 insertions(+), 4 deletions(-)
>
> Index: linux/drivers/platform/x86/toshiba_bluetooth.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/platform/x86/toshiba_bluetooth.c
> +++ linux/drivers/platform/x86/toshiba_bluetooth.c
> @@ -34,7 +34,6 @@ MODULE_LICENSE("GPL");
> =A0static int toshiba_bt_rfkill_add(struct acpi_device *device);
> =A0static int toshiba_bt_rfkill_remove(struct acpi_device *device, in=
t type);
> =A0static void toshiba_bt_rfkill_notify(struct acpi_device *device, u=
32 event);
> -static int toshiba_bt_resume(struct acpi_device *device);
>
> =A0static const struct acpi_device_id bt_device_ids[] =3D {
> =A0 =A0 =A0 =A0{ "TOS6205", 0},
> @@ -42,6 +41,9 @@ static const struct acpi_device_id bt_de
> =A0};
> =A0MODULE_DEVICE_TABLE(acpi, bt_device_ids);
>
> +static int toshiba_bt_resume(struct device *dev);
> +static SIMPLE_DEV_PM_OPS(toshiba_bt_pm, NULL, toshiba_bt_resume);
> +
> =A0static struct acpi_driver toshiba_bt_rfkill_driver =3D {
> =A0 =A0 =A0 =A0.name =3D =A0 =A0 =A0 =A0 "Toshiba BT",
> =A0 =A0 =A0 =A0.class =3D =A0 =A0 =A0 =A0"Toshiba",
> @@ -50,9 +52,9 @@ static struct acpi_driver toshiba_bt_rfk
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.add =3D=
 =A0 =A0 =A0 =A0 =A0toshiba_bt_rfkill_add,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.remov=
e =3D =A0 =A0 =A0 toshiba_bt_rfkill_remove,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.notif=
y =3D =A0 =A0 =A0 toshiba_bt_rfkill_notify,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 .resume=
 =3D =A0 =A0 =A0 toshiba_bt_resume,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0},
> =A0 =A0 =A0 =A0.owner =3D =A0 =A0 =A0 =A0THIS_MODULE,
> + =A0 =A0 =A0 .drv.pm =3D =A0 =A0 =A0 &toshiba_bt_pm,
> =A0};
>
>
> @@ -88,9 +90,9 @@ static void toshiba_bt_rfkill_notify(str
> =A0 =A0 =A0 =A0toshiba_bluetooth_enable(device->handle);
> =A0}
>
> -static int toshiba_bt_resume(struct acpi_device *device)
> +static int toshiba_bt_resume(struct device *dev)
> =A0{
> - =A0 =A0 =A0 return toshiba_bluetooth_enable(device->handle);
> + =A0 =A0 =A0 return toshiba_bluetooth_enable(to_acpi_device(dev)->ha=
ndle);
> =A0}
>
> =A0static int toshiba_bt_rfkill_add(struct acpi_device *device)
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/

Looks good, will look into the other struct patch (#11) tomorrow.

Reviewed-by: Vikram Dhillon <opensolarisdev@gmail.com>

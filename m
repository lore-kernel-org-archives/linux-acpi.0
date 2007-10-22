From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: [PATCH] Add bluetooth support to toshiba-acpi driver
Date: Mon, 22 Oct 2007 06:30:19 +0400
Message-ID: <20071022023023.07D74983989@smtp05.mtu.ru>
References: <20071021173529.GH1880@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754118AbXJVCag@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jonathan McDowell <noodles@earth.li>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Jonathan McDowell wrote:

> This patch adds bluetooth support to the toshiba-acpi driver. I have
> tried to follow the same format for the /proc/acpi/toshiba/bluetooth
> file as followed in the thinkpad-acpi driver. In the long term the
> rfkill infrastructure looks like the way forward for this functionali=
ty,
> but at present it doesn't seem to be suitable.
>=20

Would it be possible (make sense) to add config option for that? There =
are
probably a bunch of older models out there that do not have BT at all (=
I am
owner of such one).

Thank you

-andrey

> Traditionally the userland "toshset" program would have been used to
> enable bluetooth, but this requires either CONFIG_TOSHIBA or a patche=
d
> toshiba-acpi to emulate the /dev/toshiba device. Also toshset doesn't
> currently run in 64bit mode.
>=20
> Patch has been successfully tested on a Port=E9g=E9 R200 (in 32bit mo=
de) and
> an R500 (in 64bit mode).
>=20
> Signed-Off-By: Jonathan McDowell <noodles@earth.li>
>=20
> -----
> --- drivers/acpi/toshiba_acpi.c.orig  2007-10-21 18:29:01.000000000 +=
0100
> +++ drivers/acpi/toshiba_acpi.c       2007-10-21 18:15:34.000000000 +=
0100
> @@ -33,7 +33,7 @@
>   *
>   */
> =20
> -#define TOSHIBA_ACPI_VERSION "0.18"
> +#define TOSHIBA_ACPI_VERSION "0.19"
>  #define PROC_INTERFACE_VERSION       1
> =20
>  #include <linux/kernel.h>
> @@ -55,6 +55,7 @@ MODULE_LICENSE("GPL");
>  #define MY_ERR KERN_ERR MY_LOGPREFIX
>  #define MY_NOTICE KERN_NOTICE MY_LOGPREFIX
>  #define MY_INFO KERN_INFO MY_LOGPREFIX
> +#define strlencmp(a,b) (strncmp((a), (b), strlen(b)))
> =20
>  /* Toshiba ACPI method paths */
>  #define METHOD_LCD_BRIGHTNESS        "\\_SB_.PCI0.VGA_.LCD_._BCM"
> @@ -90,6 +91,7 @@ MODULE_LICENSE("GPL");
>  #define HCI_VIDEO_OUT                        0x001c
>  #define HCI_HOTKEY_EVENT             0x001e
>  #define HCI_LCD_BRIGHTNESS           0x002a
> +#define HCI_BLUETOOTH                        0x0056
> =20
>  /* field definitions */
>  #define HCI_LCD_BRIGHTNESS_BITS              3
> @@ -482,6 +484,129 @@ static unsigned long write_keys(const ch
>  return count;
>  }
> =20
> +static int toshiba_bluetooth_present(void)
> +{
> +     u32 hci_result;
> +     u32 value;
> +
> +     hci_read1(HCI_BLUETOOTH, &value, &hci_result);
> +     if (hci_result =3D=3D HCI_SUCCESS) {
> +             return (value & 0x0f) =3D=3D 0x0f;
> +     } else
> +             return -EFAULT;
> +}
> +
> +static int toshiba_bluetooth_get(void)
> +{
> +     u32 in[HCI_WORDS];
> +     u32 out[HCI_WORDS];
> +     acpi_status status;
> +
> +     in[0] =3D HCI_GET;
> +     in[1] =3D HCI_BLUETOOTH;
> +     in[2] =3D 0;
> +     in[3] =3D 1;
> +     status =3D hci_raw(in, out);
> +     if (status !=3D AE_OK) {
> +             printk(MY_ERR "Error checking Bluetooth device status.\=
n");
> +             return -EIO;
> +     }
> +
> +     /* 0x1 =3D=3D switch on, 0x40 =3D=3D attached, 0x80 =3D=3D powe=
r on */
> +     return (out[2] & 0xC1) =3D=3D 0xC1;
> +}
> +
> +static int toshiba_bluetooth_set(int state)
> +{
> +     u32 in[HCI_WORDS];
> +     u32 out[HCI_WORDS];
> +     acpi_status status;
> +
> +     switch (state) {
> +     case 0:
> +             in[0] =3D HCI_SET;
> +             in[1] =3D HCI_BLUETOOTH;
> +             in[2] =3D 0;
> +             in[3] =3D 0x40;
> +             status =3D hci_raw(in, out);
> +             if (status !=3D AE_OK) {
> +                     printk(MY_ERR "Error detaching Bluetooth device=
=2E\n");
> +                     return -EIO;
> +             }
> +
> +             in[0] =3D HCI_SET;
> +             in[1] =3D HCI_BLUETOOTH;
> +             in[2] =3D 0;
> +             in[3] =3D 0x80;
> +             status =3D hci_raw(in, out);
> +             if (status !=3D AE_OK) {
> +                     printk(MY_ERR "Error deactivating Bluetooth dev=
ice.\n");
> +                     return -EIO;
> +             }
> +             break;
> +     case 1:
> +             in[0] =3D HCI_SET;
> +             in[1] =3D HCI_BLUETOOTH;
> +             in[2] =3D 1;
> +             in[3] =3D 0x80;
> +             status =3D hci_raw(in, out);
> +             if (status !=3D AE_OK) {
> +                     printk(MY_ERR "Error activating Bluetooth devic=
e.\n");
> +                     return -EIO;
> +             }
> +
> +             in[0] =3D HCI_SET;
> +             in[1] =3D HCI_BLUETOOTH;
> +             in[2] =3D 1;
> +             in[3] =3D 0x40;
> +             status =3D hci_raw(in, out);
> +             if (status !=3D AE_OK) {
> +                     printk(MY_ERR "Error attaching Bluetooth device=
=2E\n");
> +                     return -EIO;
> +             }
> +             break;
> +     default:
> +             printk(MY_ERR "Unknown state for Bluetooth.\n");
> +     };
> +
> +     return 0;
> +}
> +
> +static char *read_bluetooth(char *p)
> +{
> +     int value =3D toshiba_bluetooth_get();
> +
> +     if (!toshiba_bluetooth_present()) {
> +             p +=3D sprintf(p, "status:\t\tnot supported\n");
> +     } else if (value >=3D 0) {
> +             p +=3D sprintf(p, "status:\t\t%s\n",
> +                             value ? "enabled" : "disabled");
> +             p +=3D sprintf(p, "commands:\tenable, disable\n");
> +     } else {
> +             printk(MY_ERR "Error reading bluetooth status.\n");
> +     }
> +
> +     return p;
> +}
> +
> +static unsigned long write_bluetooth(const char *buffer, unsigned lo=
ng
> count) +{
> +     int ret ;
> +
> +     if (!toshiba_bluetooth_present()) {
> +             ret =3D -ENODEV;
> +     } else if (strlencmp(buffer, "enable") =3D=3D 0) {
> +             toshiba_bluetooth_set(1);
> +             ret =3D count;
> +     } else if (strlencmp(buffer, "disable") =3D=3D 0) {
> +             toshiba_bluetooth_set(0);
> +             ret =3D count;
> +     } else {
> +             ret =3D -EINVAL;
> +     }
> +     return ret;
> +}
> +
>  static char *read_version(char *p)
>  {
>  p +=3D sprintf(p, "driver:                  %s\n", TOSHIBA_ACPI_VERS=
ION);
> @@ -496,6 +621,7 @@ static char *read_version(char *p)
>  #define PROC_TOSHIBA         "toshiba"
> =20
>  static ProcItem proc_items[] =3D {
> +     {"bluetooth", read_bluetooth, write_bluetooth},
>  {"lcd", read_lcd, write_lcd},
>  {"video", read_video, write_video},
>  {"fan", read_fan, write_fan},
> -----
>=20
> J.
>=20

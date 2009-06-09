From: Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH 2/2] toshiba-acpi: Support TOS1900-type devices
Date: Tue, 9 Jun 2009 10:42:00 -0600
Message-ID: <74962ea30906090942r43d374e7ra00e5056eca040a8@mail.gmail.com>
References: <20090331214749.GD29489@srcf.ucam.org>
	 <20090331221107.GA30383@srcf.ucam.org>
	 <74962ea30903311519s2fb6087fxfe8859e3c570ac99@mail.gmail.com>
	 <20090331230217.GA31599@srcf.ucam.org>
	 <74962ea30904010950u31fbdca3w51eafb9b7ec1ca73@mail.gmail.com>
	 <20090401165345.GA13939@srcf.ucam.org>
	 <74962ea30904011003o354e8780ya5e9ac1a6a579084@mail.gmail.com>
	 <20090401170708.GA14167@srcf.ucam.org>
	 <74962ea30904011013v5ffa0620y1f1aefa2c84e1ce@mail.gmail.com>
	 <20090602140357.GA13548@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bw0-f213.google.com ([209.85.218.213]:61481 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751655AbZFIQmA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 9 Jun 2009 12:42:00 -0400
In-Reply-To: <20090602140357.GA13548@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, dsilvers@simtec.co.uk, toshiba_acpi@memebeam.org, linux-kernel@vger.kernel.org

Hi there:

Sorry for the late reply, lotsa work lately.

On Tue, Jun 2, 2009 at 8:03 AM, Matthew Garrett<mjg59@srcf.ucam.org> wr=
ote:
> Ok. From looking at your DSDT I'm still a little bit confused, but
> anyway. As far as I can tell the correct way to drive TOS1900-type
> devices is to call ENAB (which doesn't do anything on your machine) a=
nd
> then call the INFO method when we receive notifications. Your DSDT
> includes a NTFY method that doesn't appear to be called from anywhere=
=2E
> The path that we should be following is the one triggered by the _Q43
> EC query, which then generates a notification and flags that there's =
a
> hotkey waiting. The INFO method then unflags that, saves the value of
> TOHK and writes a zero into there.
>

Indeed, thats how I managed to see where the hotkeys were being "stored=
"
in my first attempts at getting hotkeys working on my Toshiba model.

However, everytime you poll the INFO method, the TECF variable receives
a zero, so the next time you want to poll the INFO method, you
receive a zero also, unless you "activate" the TECF variable again
perhaps tru' _Q43 or by directly writing a one into it.

> So, from what I can tell, the following patch should work for you
> (against clean upstream). If it doesn't then we need to figure out
> what's happening when you press a hotkey in the first place.
>

Not at all, the patch per se doesn't do anything on my model, even if
I activate the HCI Hotkey Events call 0x1E.

Just when I activate that HCI command the hotkeys start being "stored"
on the TOHK variable, however, not even w/ that patch you sent I'm
not able to get any events reported.


So, in my point of view and the experiments w/ the code I've been
doing here's the workflow that I found to be partially working:

1. Activate Hotkey Events call 0x1E.
2. It activates something internally causing Hotkey Events being
   stored in TOHK.
3. Whenever I press an Fn-Key combo let's say Fn-Esc, the actual key ge=
ts
   stored in TOHK, in this case 0x101, but just lasting a couple second=
s
   (or even less...), it seems it's volatile.
4. Polling TOHK via the INFO method or directly gets me the actual hotk=
ey,
   but again, must real quick since it will disappear (I used 100 ms po=
lling).
5. Figure out a way of getting those Hotkey Events in a nice manner...
   I managed to get them, but sometimes I got them repeated due to the
   polling timer...


Saludos
Azael


> commit 6edd24bf5ef664e8ac8d5f53774cb9ada8b11a37
> Author: Matthew Garrett <mjg@redhat.com>
> Date: =C2=A0 Fri Mar 6 00:25:45 2009 +0000
>
> =C2=A0 =C2=A0toshiba-acpi: Add support for hotkey notifications
>
> =C2=A0 =C2=A0Calling the ENAB method on Toshiba laptops results in no=
tifications being
> =C2=A0 =C2=A0sent when laptop hotkeys are pressed. This patch simply =
calls that method
> =C2=A0 =C2=A0and sets up an input device if it's successful.
>
> =C2=A0 =C2=A0Signed-off-by: Matthew Garrett <mjg@redhat.com>
>
> diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x=
86/toshiba_acpi.c
> index 9f18726..45c1fb0 100644
> --- a/drivers/platform/x86/toshiba_acpi.c
> +++ b/drivers/platform/x86/toshiba_acpi.c
> @@ -46,6 +46,7 @@
> =C2=A0#include <linux/platform_device.h>
> =C2=A0#include <linux/rfkill.h>
> =C2=A0#include <linux/input-polldev.h>
> +#include <linux/input.h>
>
> =C2=A0#include <asm/uaccess.h>
>
> @@ -62,9 +63,10 @@ MODULE_LICENSE("GPL");
>
> =C2=A0/* Toshiba ACPI method paths */
> =C2=A0#define METHOD_LCD_BRIGHTNESS =C2=A0"\\_SB_.PCI0.VGA_.LCD_._BCM=
"
> -#define METHOD_HCI_1 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "\\_SB_.VALD=
=2EGHCI"
> -#define METHOD_HCI_2 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 "\\_SB_.VALZ=
=2EGHCI"
> +#define TOSH_INTERFACE_1 =C2=A0 =C2=A0 =C2=A0 "\\_SB_.VALD"
> +#define TOSH_INTERFACE_2 =C2=A0 =C2=A0 =C2=A0 "\\_SB_.VALZ"
> =C2=A0#define METHOD_VIDEO_OUT =C2=A0 =C2=A0 =C2=A0 "\\_SB_.VALX.DSSX=
"
> +#define GHCI_METHOD =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0".GHCI"
>
> =C2=A0/* Toshiba HCI interface definitions
> =C2=A0*
> @@ -116,6 +118,37 @@ static const struct acpi_device_id toshiba_devic=
e_ids[] =3D {
> =C2=A0};
> =C2=A0MODULE_DEVICE_TABLE(acpi, toshiba_device_ids);
>
> +struct key_entry {
> + =C2=A0 =C2=A0 =C2=A0 char type;
> + =C2=A0 =C2=A0 =C2=A0 u16 code;
> + =C2=A0 =C2=A0 =C2=A0 u16 keycode;
> +};
> +
> +enum {KE_KEY, KE_END};
> +
> +static struct key_entry toshiba_acpi_keymap[] =C2=A0=3D {
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x101, KEY_MUTE},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x13b, KEY_COFFEE},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x13c, KEY_BATTERY},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x13d, KEY_SLEEP},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x13e, KEY_SUSPEND},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x13f, KEY_SWITCHVIDEOMODE},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x140, KEY_BRIGHTNESSDOWN},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x141, KEY_BRIGHTNESSUP},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x142, KEY_WLAN},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x143, KEY_PROG1},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0x17f, KEY_BRIGHTNESSDOWN},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0xb05, KEY_PROG2},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0xb06, KEY_WWW},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0xb07, KEY_MAIL},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0xb30, KEY_STOP},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0xb31, KEY_PREVIOUSSONG},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0xb32, KEY_NEXTSONG},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0xb33, KEY_PLAYPAUSE},
> + =C2=A0 =C2=A0 =C2=A0 {KE_KEY, 0xb5a, KEY_MEDIA},
> + =C2=A0 =C2=A0 =C2=A0 {KE_END, 0, 0},
> +};
> +
> =C2=A0/* utility
> =C2=A0*/
>
> @@ -252,6 +285,8 @@ struct toshiba_acpi_dev {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct platform_device *p_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct rfkill *rfk_dev;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct input_polled_dev *poll_dev;
> + =C2=A0 =C2=A0 =C2=A0 struct input_dev *hotkey_dev;
> + =C2=A0 =C2=A0 =C2=A0 acpi_handle handle;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *bt_name;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0const char *rfk_name;
> @@ -700,6 +735,154 @@ static struct backlight_ops toshiba_backlight_d=
ata =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .update_status =C2=A0=3D set_lcd_status,
> =C2=A0};
>
> +static struct key_entry *toshiba_acpi_get_entry_by_scancode(int code=
)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct key_entry *key;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (key =3D toshiba_acpi_keymap; key->type !=3D=
 KE_END; key++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (code =3D=3D ke=
y->code)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return key;
> +
> + =C2=A0 =C2=A0 =C2=A0 return NULL;
> +}
> +
> +static struct key_entry *toshiba_acpi_get_entry_by_keycode(int code)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct key_entry *key;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (key =3D toshiba_acpi_keymap; key->type !=3D=
 KE_END; key++)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (code =3D=3D ke=
y->keycode && key->type =3D=3D KE_KEY)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 return key;
> +
> + =C2=A0 =C2=A0 =C2=A0 return NULL;
> +}
> +
> +static int toshiba_acpi_getkeycode(struct input_dev *dev, int scanco=
de,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int *keycode)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct key_entry *key =3D toshiba_acpi_get_ent=
ry_by_scancode(scancode);
> +
> + =C2=A0 =C2=A0 =C2=A0 if (key && key->type =3D=3D KE_KEY) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *keycode =3D key->=
keycode;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +}
> +
> +static int toshiba_acpi_setkeycode(struct input_dev *dev, int scanco=
de,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int keycode)
> +{
> + =C2=A0 =C2=A0 =C2=A0 struct key_entry *key;
> + =C2=A0 =C2=A0 =C2=A0 int old_keycode;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (keycode < 0 || keycode > KEY_MAX)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +
> + =C2=A0 =C2=A0 =C2=A0 key =3D toshiba_acpi_get_entry_by_scancode(sca=
ncode);
> + =C2=A0 =C2=A0 =C2=A0 if (key && key->type =3D=3D KE_KEY) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 old_keycode =3D ke=
y->keycode;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key->keycode =3D k=
eycode;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(keycode, d=
ev->keybit);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!toshiba_acpi_=
get_entry_by_keycode(old_keycode))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 clear_bit(old_keycode, dev->keybit);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return -EINVAL;
> +}
> +
> +static void toshiba_acpi_notify(acpi_handle handle, u32 event, void =
**data)
> +{
> + =C2=A0 =C2=A0 =C2=A0 u32 hci_result, value;
> + =C2=A0 =C2=A0 =C2=A0 struct key_entry *key;
> +
> + =C2=A0 =C2=A0 =C2=A0 if (event !=3D 0x80)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 do {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hci_read1(HCI_SYST=
EM_EVENT, &value, &hci_result);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (hci_result =3D=
=3D HCI_SUCCESS) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 if (value =3D=3D 0x100)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 else if (!(value & 0x80)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 key =3D toshiba_acpi_get_entry_by_s=
cancode
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (value)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!key) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(=
MY_INFO "Unknown key %x\n",
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0value);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continu=
e;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(toshiba_acpi.hotke=
y_dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0key->keycode, 1);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(toshiba_acpi.hotkey_dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_report_key(toshiba_acpi.hotke=
y_dev,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0key->keycode, 0);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_sync(toshiba_acpi.hotkey_dev)=
;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else if (hci_res=
ult =3D=3D HCI_NOT_SUPPORTED) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 /* This is a workaround for an unresolved issue on
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* some machines where system events sporadically
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0* become disabled. */
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 hci_write1(HCI_SYSTEM_EVENT, 1, &hci_result);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(MY_NOTICE "Re-enabled hotkeys\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
> + =C2=A0 =C2=A0 =C2=A0 } while (hci_result !=3D HCI_EMPTY);
> +}
> +
> +static int toshiba_acpi_setup_keyboard(char *device)
> +{
> + =C2=A0 =C2=A0 =C2=A0 acpi_status status;
> + =C2=A0 =C2=A0 =C2=A0 acpi_handle handle;
> + =C2=A0 =C2=A0 =C2=A0 int result;
> + =C2=A0 =C2=A0 =C2=A0 const struct key_entry *key;
> +
> + =C2=A0 =C2=A0 =C2=A0 status =3D acpi_get_handle(NULL, device, &hand=
le);
> + =C2=A0 =C2=A0 =C2=A0 if (ACPI_FAILURE(status)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(MY_INFO "Un=
able to get notification device\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 toshiba_acpi.handle =3D handle;
> +
> + =C2=A0 =C2=A0 =C2=A0 status =3D acpi_evaluate_object(handle, "ENAB"=
, NULL, NULL);
> + =C2=A0 =C2=A0 =C2=A0 if (ACPI_FAILURE(status)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(MY_INFO "Un=
able to enable hotkeys\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 status =3D acpi_install_notify_handler (handle=
, ACPI_DEVICE_NOTIFY,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 toshiba_acpi_notify, NULL);
> + =C2=A0 =C2=A0 =C2=A0 if (ACPI_FAILURE(status)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(MY_INFO "Un=
able to install hotkey notification\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENODEV;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 toshiba_acpi.hotkey_dev =3D input_allocate_dev=
ice();
> + =C2=A0 =C2=A0 =C2=A0 if (!toshiba_acpi.hotkey_dev) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(MY_INFO "Un=
able to register input device\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return -ENOMEM;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 toshiba_acpi.hotkey_dev->name =3D "Toshiba inp=
ut device";
> + =C2=A0 =C2=A0 =C2=A0 toshiba_acpi.hotkey_dev->phys =3D device;
> + =C2=A0 =C2=A0 =C2=A0 toshiba_acpi.hotkey_dev->id.bustype =3D BUS_HO=
ST;
> + =C2=A0 =C2=A0 =C2=A0 toshiba_acpi.hotkey_dev->getkeycode =3D toshib=
a_acpi_getkeycode;
> + =C2=A0 =C2=A0 =C2=A0 toshiba_acpi.hotkey_dev->setkeycode =3D toshib=
a_acpi_setkeycode;
> +
> + =C2=A0 =C2=A0 =C2=A0 for (key =3D toshiba_acpi_keymap; key->type !=3D=
 KE_END; key++) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(EV_KEY, to=
shiba_acpi.hotkey_dev->evbit);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 set_bit(key->keyco=
de, toshiba_acpi.hotkey_dev->keybit);
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 result =3D input_register_device(toshiba_acpi.=
hotkey_dev);
> + =C2=A0 =C2=A0 =C2=A0 if (result) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(MY_INFO "Un=
able to register input device\n");
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return result;
> + =C2=A0 =C2=A0 =C2=A0 }
> +
> + =C2=A0 =C2=A0 =C2=A0 return 0;
> +}
> +
> =C2=A0static void toshiba_acpi_exit(void)
> =C2=A0{
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (toshiba_acpi.poll_dev) {
> @@ -707,12 +890,18 @@ static void toshiba_acpi_exit(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0input_free_pol=
led_device(toshiba_acpi.poll_dev);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0}
>
> + =C2=A0 =C2=A0 =C2=A0 if (toshiba_acpi.hotkey_dev)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 input_unregister_d=
evice(toshiba_acpi.hotkey_dev);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (toshiba_acpi.rfk_dev)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rfkill_unregis=
ter(toshiba_acpi.rfk_dev);
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (toshiba_backlight_device)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0backlight_devi=
ce_unregister(toshiba_backlight_device);
>
> + =C2=A0 =C2=A0 =C2=A0 acpi_remove_notify_handler(toshiba_acpi.handle=
, ACPI_DEVICE_NOTIFY,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0toshiba_acpi_notify);
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0remove_device();
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (toshiba_proc_dir)
> @@ -736,11 +925,15 @@ static int __init toshiba_acpi_init(void)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV=
;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0/* simple device detection: look for HCI m=
ethod */
> - =C2=A0 =C2=A0 =C2=A0 if (is_valid_acpi_path(METHOD_HCI_1))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method_hci =3D MET=
HOD_HCI_1;
> - =C2=A0 =C2=A0 =C2=A0 else if (is_valid_acpi_path(METHOD_HCI_2))
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method_hci =3D MET=
HOD_HCI_2;
> - =C2=A0 =C2=A0 =C2=A0 else
> + =C2=A0 =C2=A0 =C2=A0 if (is_valid_acpi_path(TOSH_INTERFACE_1 GHCI_M=
ETHOD)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method_hci =3D TOS=
H_INTERFACE_1 GHCI_METHOD;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (toshiba_acpi_s=
etup_keyboard(TOSH_INTERFACE_1))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(MY_INFO "Unable to activate hotkeys\n");
> + =C2=A0 =C2=A0 =C2=A0 } else if (is_valid_acpi_path(TOSH_INTERFACE_2=
 GHCI_METHOD)) {
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 method_hci =3D TOS=
H_INTERFACE_2 GHCI_METHOD;
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (toshiba_acpi_s=
etup_keyboard(TOSH_INTERFACE_2))
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 printk(MY_INFO "Unable to activate hotkeys\n");
> + =C2=A0 =C2=A0 =C2=A0 } else
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -ENODEV=
;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0printk(MY_INFO "Toshiba Laptop ACPI Extras=
 version %s\n",
>
> --
> Matthew Garrett | mjg59@srcf.ucam.org
>



--=20
-- El mundo apesta y vosotros apestais tambien --
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

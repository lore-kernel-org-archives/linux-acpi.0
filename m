From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 5/7] Make the driver use MSC_SCAN and a setkeycode and getkeycode key table.
Date: Mon, 16 Jul 2007 09:22:28 -0400
Message-ID: <d120d5000707160622v7b62eeb5sd962e6e96dafdfec@mail.gmail.com>
References: <1184520879452-git-send-email-malattia@linux.it>
	 <1184520879991-git-send-email-malattia@linux.it>
	 <11845208793336-git-send-email-malattia@linux.it>
	 <11845208793678-git-send-email-malattia@linux.it>
	 <11845208794064-git-send-email-malattia@linux.it>
	 <11845208791511-git-send-email-malattia@linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from wa-out-1112.google.com ([209.85.146.180]:2664 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758289AbXGPNW3 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 16 Jul 2007 09:22:29 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1570048wah
        for <linux-acpi@vger.kernel.org>; Mon, 16 Jul 2007 06:22:28 -0700 (PDT)
In-Reply-To: <11845208791511-git-send-email-malattia@linux.it>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mattia Dongili <malattia@linux.it>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, Stelian Pop <stelian@popies.net>, Richard Hughes <richard@hughsie.com>

Hi Mattia,

On 7/15/07, Mattia Dongili <malattia@linux.it> wrote:
> +static int sony_laptop_input_keycode_map[] = {
> +       KEY_RESERVED,    /* no event... */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_DOWN */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_UP */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_DOWN_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_UP_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_RELEASED */

Jogdial events are never passed through key_dev, do they? If so then
we should not allow remapping them as it is pointless. EVCSKEYCODE
shoudl return -EINVAL wehn trying to remap them.

> +       KEY_CAMERA,     /* SONYPI_EVENT_CAPTURE_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_CAPTURE_RELEASED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_CAPTURE_PARTIALPRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_CAPTURE_PARTIALRELEASED */
> +       KEY_FN_ESC,     /* SONYPI_EVENT_FNKEY_ESC */
> +       KEY_FN_F1,      /* SONYPI_EVENT_FNKEY_F1 */
> +       KEY_FN_F2,      /* SONYPI_EVENT_FNKEY_F2 */
> +       KEY_FN_F3,      /* SONYPI_EVENT_FNKEY_F3 */
> +       KEY_FN_F4,      /* SONYPI_EVENT_FNKEY_F4 */
> +       KEY_FN_F5,      /* SONYPI_EVENT_FNKEY_F5 */
> +       KEY_FN_F6,      /* SONYPI_EVENT_FNKEY_F6 */
> +       KEY_FN_F7,      /* SONYPI_EVENT_FNKEY_F7 */
> +       KEY_FN_F8,      /* SONYPI_EVENT_FNKEY_F8 */
> +       KEY_FN_F9,      /* SONYPI_EVENT_FNKEY_F9 */
> +       KEY_FN_F10,     /* SONYPI_EVENT_FNKEY_F10 */
> +       KEY_FN_F11,     /* SONYPI_EVENT_FNKEY_F11 */
> +       KEY_FN_F12,     /* SONYPI_EVENT_FNKEY_F12 */
> +       KEY_FN_F1,      /* SONYPI_EVENT_FNKEY_1 */
> +       KEY_FN_F2,      /* SONYPI_EVENT_FNKEY_2 */
> +       KEY_FN_D,       /* SONYPI_EVENT_FNKEY_D */
> +       KEY_FN_E,       /* SONYPI_EVENT_FNKEY_E */
> +       KEY_FN_F,       /* SONYPI_EVENT_FNKEY_F */
> +       KEY_FN_S,       /* SONYPI_EVENT_FNKEY_S */
> +       KEY_FN_B,       /* SONYPI_EVENT_FNKEY_B */
> +       KEY_BLUE,       /* SONYPI_EVENT_BLUETOOTH_PRESSED */

KEY_BLUE is a blue-colored key on some Remote Controls. You want
KEY_BLUETOOTH here.

> +       KEY_PROG1,      /* SONYPI_EVENT_PKEY_P1 */
> +       KEY_PROG2,      /* SONYPI_EVENT_PKEY_P2 */
> +       KEY_PROG3,      /* SONYPI_EVENT_PKEY_P3 */
> +       KEY_BACK,       /* SONYPI_EVENT_BACK_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_LID_CLOSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_LID_OPENED */

EV_SW/SW_LID unless LID events are delivered through ACPI (in which
case we should hide these events completely).

> +       KEY_BLUE,       /* SONYPI_EVENT_BLUETOOTH_ON */
> +       KEY_BLUE,       /* SONYPI_EVENT_BLUETOOTH_OFF */

KEY_BLUETOOTH.

> +       KEY_HELP,       /* SONYPI_EVENT_HELP_PRESSED */
> +       KEY_FN,         /* SONYPI_EVENT_FNKEY_ONLY */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_FAST_DOWN */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_FAST_UP */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_FAST_DOWN_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_FAST_UP_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_VFAST_DOWN */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_VFAST_UP */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_VFAST_DOWN_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_JOGDIAL_VFAST_UP_PRESSED */
> +       KEY_ZOOM,       /* SONYPI_EVENT_ZOOM_PRESSED */
> +       BTN_THUMB,      /* SONYPI_EVENT_THUMBPHRASE_PRESSED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_MEYE_FACE */
> +       KEY_RESERVED,   /* SONYPI_EVENT_MEYE_OPPOSITE */
> +       KEY_RESERVED,   /* SONYPI_EVENT_MEMORYSTICK_INSERT */
> +       KEY_RESERVED,   /* SONYPI_EVENT_MEMORYSTICK_EJECT */
> +       KEY_RESERVED,   /* SONYPI_EVENT_ANYBUTTON_RELEASED */
> +       KEY_RESERVED,   /* SONYPI_EVENT_BATTERY_INSERT */
> +       KEY_RESERVED,   /* SONYPI_EVENT_BATTERY_REMOVE */
> +       KEY_RESERVED,   /* SONYPI_EVENT_FNKEY_RELEASED */

Do we really want let userspace remap this event?

> +       KEY_WLAN,       /* SONYPI_EVENT_WIRELESS_ON */
> +       KEY_WLAN,       /* SONYPI_EVENT_WIRELESS_OFF */
>  };
>
>  /* release buttons after a short delay if pressed */
> @@ -204,7 +229,6 @@ static void sony_laptop_report_input_event(u8 event)
>        struct input_dev *jog_dev = sony_laptop_input.jog_dev;
>        struct input_dev *key_dev = sony_laptop_input.key_dev;
>        struct sony_laptop_keypress kp = { NULL };
> -       int i;
>
>        if (event == SONYPI_EVENT_FNKEY_RELEASED) {
>                /* Nothing, not all VAIOs generate this event */
> @@ -233,17 +257,20 @@ static void sony_laptop_report_input_event(u8 event)
>                break;
>
>        default:
> -               for (i = 0; sony_laptop_inputkeys[i].sonypiev; i++)
> -                       if (event == sony_laptop_inputkeys[i].sonypiev) {
> -                               kp.dev = key_dev;
> -                               kp.key = sony_laptop_inputkeys[i].inputev;
> -                               break;
> -                       }
> +               if (event > ARRAY_SIZE (sony_laptop_input_keycode_map)) {
> +                       dprintk("sony_laptop_report_input_event, event not known: %d\n", event);
> +                       break;
> +               }
> +               kp.key = sony_laptop_input_keycode_map[event];
> +               if (kp.key != KEY_UNKNOWN)
> +                       kp.dev = key_dev;
>                break;
>        }
>
>        if (kp.dev) {
>                input_report_key(kp.dev, kp.key, 1);
> +               /* we emit the scancode so we can always remap the key */
> +               input_event(kp.dev, EV_MSC, MSC_SCAN, event);

Looks like whitespace damage here...

-- 
Dmitry

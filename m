From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
Subject: Re: [PATCH v4] dell-wmi: Support new hotkeys on the XPS 13 9350
 (Skylake)
Date: Wed, 20 Jan 2016 20:40:50 +0100
Message-ID: <20160120194050.GL7192@pali>
References: <a343d7d11816d86d04c51505f6e33c5b99086ff6.1453244706.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <a343d7d11816d86d04c51505f6e33c5b99086ff6.1453244706.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Matthew Garrett <mjg59@srcf.ucam.org>, Linux ACPI <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>, Jon Eyolfson <jon@eyl.io>
List-Id: linux-acpi@vger.kernel.org

On Tuesday 19 January 2016 15:07:47 Andy Lutomirski wrote:
> The XPS 13 9350 sends WMI keypress events that aren't enumerated in
> the DMI table.  Add a table listing them.  To avoid breaking things
> that worked before, these un-enumerated hotkeys won't be used if the
> DMI table maps them to something else.
>=20
> FWIW, it appears that the DMI table may be a legacy thing and we
> might want to rethink how we handle events in general.  As an
> example, a whole lot of things map to KEY_PROG3 via the DMI table.
>=20
> So far, this doesn't send keypress events for any of the new
> events.  Depnding on whether we figure out exactly what needs to
> happen to get the wireless button working in time for Linux 4.5,
> we might want to temporarily handle it in dell-wmi.
>=20
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Looks good,

Reviewed-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>

> ---
>=20
> This applies after the dmi-walk fix.
>=20
> Notes:
>     Changes from v3:
>      - Rebase in top of interface version stuff.  (This changes conte=
xt
>        but not any diff lines.)
>     Changes from v2:
>      - Factor check for already-known scancodes into a helper.
>      - Un-abbreviate comments.
>      - Fix off-by-one.
>      - Rebase on top of of dmi_walk fixes.
>    =20
>     Changes from v1:
>      - The new hotkey code matches reality better.
>      - Don't send key events for the new hotkeys.
>=20
> drivers/platform/x86/dell-wmi.c | 71 ++++++++++++++++++++++++++++++++=
+++++----
>  1 file changed, 64 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/d=
ell-wmi.c
> index 3e30f77b70e1..afb7150bf2c1 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -168,6 +168,30 @@ static const u16 bios_to_linux_keycode[256] __in=
itconst =3D {
>  	[255]	=3D KEY_PROG3,
>  };
> =20
> +/*
> + * These are applied if the 0xB2 DMI hotkey table is present and doe=
sn't
> + * override them.
> + */
> +static const struct key_entry dell_wmi_extra_keymap[] __initconst =3D=
 {
> +	/* Fn-lock */
> +	{ KE_IGNORE, 0x151, { KEY_RESERVED } },
> +
> +	/* Change keyboard illumination */
> +	{ KE_IGNORE, 0x152, { KEY_KBDILLUMTOGGLE } },
> +
> +	/*
> +	 * Radio disable (notify only -- there is no model for which the
> +	 * WMI event is supposed to trigger an action).
> +	 */
> +	{ KE_IGNORE, 0x153, { KEY_RFKILL } },
> +
> +	/* RGB keyboard backlight control */
> +	{ KE_IGNORE, 0x154, { KEY_RESERVED } },
> +
> +	/* Stealth mode toggle */
> +	{ KE_IGNORE, 0x155, { KEY_RESERVED } },
> +};
> +
>  static struct input_dev *dell_wmi_input_dev;
> =20
>  static void dell_wmi_process_key(int reported_key)
> @@ -339,13 +363,27 @@ static void dell_wmi_notify(u32 value, void *co=
ntext)
>  	kfree(obj);
>  }
> =20
> +static bool have_scancode(u32 scancode, const struct key_entry *keym=
ap, int len)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < len; i++)
> +		if (keymap[i].code =3D=3D scancode)
> +			return true;
> +
> +	return false;
> +}
> +
>  static void __init handle_dmi_entry(const struct dmi_header *dm,
> +
>  				    void *opaque)
> +
>  {
>  	struct dell_dmi_results *results =3D opaque;
>  	struct dell_bios_hotkey_table *table;
> +	int hotkey_num, i, pos =3D 0;
>  	struct key_entry *keymap;
> -	int hotkey_num, i;
> +	int num_bios_keys;
> =20
>  	if (results->err || results->keymap)
>  		return;		/* We already found the hotkey table. */
> @@ -369,7 +407,8 @@ static void __init handle_dmi_entry(const struct =
dmi_header *dm,
>  		return;
>  	}
> =20
> -	keymap =3D kcalloc(hotkey_num + 1, sizeof(struct key_entry), GFP_KE=
RNEL);
> +	keymap =3D kcalloc(hotkey_num + ARRAY_SIZE(dell_wmi_extra_keymap) +=
 1,
> +			 sizeof(struct key_entry), GFP_KERNEL);
>  	if (!keymap) {
>  		results->err =3D -ENOMEM;
>  		return;
> @@ -397,14 +436,32 @@ static void __init handle_dmi_entry(const struc=
t dmi_header *dm,
>  		}
> =20
>  		if (keycode =3D=3D KEY_KBDILLUMTOGGLE)
> -			keymap[i].type =3D KE_IGNORE;
> +			keymap[pos].type =3D KE_IGNORE;
>  		else
> -			keymap[i].type =3D KE_KEY;
> -		keymap[i].code =3D bios_entry->scancode;
> -		keymap[i].keycode =3D keycode;
> +			keymap[pos].type =3D KE_KEY;
> +		keymap[pos].code =3D bios_entry->scancode;
> +		keymap[pos].keycode =3D keycode;
> +
> +		pos++;
> +	}
> +
> +	num_bios_keys =3D pos;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(dell_wmi_extra_keymap); i++) {
> +		const struct key_entry *entry =3D &dell_wmi_extra_keymap[i];
> +
> +		/*
> +		 * Check if we've already found this scancode.  This takes
> +		 * quadratic time, but it doesn't matter unless the list
> +		 * of extra keys gets very long.
> +		 */
> +		if (!have_scancode(entry->code, keymap, num_bios_keys)) {
> +			keymap[pos] =3D *entry;
> +			pos++;
> +		}
>  	}
> =20
> -	keymap[hotkey_num].type =3D KE_END;
> +	keymap[pos].type =3D KE_END;
> =20
>  	results->keymap =3D keymap;
>  }

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

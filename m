From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH v2 3/3] dell-wmi: Improve unknown hotkey handling
Date: Thu, 3 Dec 2015 15:38:56 -0800
Message-ID: <20151203233856.GC1800@malice.jf.intel.com>
References: <cover.1448931589.git.luto@kernel.org>
 <b409d60963f81611e398b492a73ffd998414cd68.1448931589.git.luto@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <b409d60963f81611e398b492a73ffd998414cd68.1448931589.git.luto@kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Andy Lutomirski <luto@kernel.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
List-Id: linux-acpi@vger.kernel.org

On Mon, Nov 30, 2015 at 05:02:01PM -0800, Andy Lutomirski wrote:
> If DMI lists a hotkey that we don't recognize, log and ignore it
> instead of trying to map it to keycode 0.  I haven't seen this happen=
,
> but it will help maintain the key map in the future and it will help
> avoid sending bogus events.
>=20
> This also improves the message that we log when we get an unknown key
> event.
>=20
> Signed-off-by: Andy Lutomirski <luto@kernel.org>
> ---

Please include the individual patch changelogs here under --- in the pa=
tch
itself - this helps me build confidence that I am indeed looking at the=
 right
patch and the expected changes are here.

Pali, this appears to have the one change you asked for (0x%x instead o=
f %d).
I've added the Reviewed-by: Pali Roh=E1r <pali.rohar@gmail.com> you pro=
vided
previously pending this change.

Queued to testing, thanks.

>  drivers/platform/x86/dell-wmi.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/d=
ell-wmi.c
> index baff658a3621..7c3ebda811ca 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -118,6 +118,7 @@ struct dell_bios_hotkey_table {
> =20
>  static const struct dell_bios_hotkey_table *dell_bios_hotkey_table;
> =20
> +/* Uninitialized entries here are KEY_RESERVED =3D=3D 0. */
>  static const u16 bios_to_linux_keycode[256] __initconst =3D {
>  	[0]	=3D KEY_MEDIA,
>  	[1]	=3D KEY_NEXTSONG,
> @@ -191,7 +192,8 @@ static void dell_wmi_process_key(int reported_key=
)
>  	key =3D sparse_keymap_entry_from_scancode(dell_wmi_input_dev,
>  						reported_key);
>  	if (!key) {
> -		pr_info("Unknown key %x pressed\n", reported_key);
> +		pr_info("Unknown key with scancode 0x%x pressed\n",
> +			reported_key);
>  		return;
>  	}
> =20
> @@ -350,9 +352,24 @@ static const struct key_entry * __init dell_wmi_=
prepare_new_keymap(void)
>  	for (i =3D 0; i < hotkey_num; i++) {
>  		const struct dell_bios_keymap_entry *bios_entry =3D
>  					&dell_bios_hotkey_table->keymap[i];
> -		u16 keycode =3D bios_entry->keycode < 256 ?
> -				    bios_to_linux_keycode[bios_entry->keycode] :
> -				    KEY_RESERVED;
> +
> +		/* Uninitialized entries are 0 aka KEY_RESERVED. */
> +		u16 keycode =3D (bios_entry->keycode <
> +			       ARRAY_SIZE(bios_to_linux_keycode)) ?
> +			bios_to_linux_keycode[bios_entry->keycode] :
> +			KEY_RESERVED;
> +		BUILD_BUG_ON(KEY_RESERVED !=3D 0);
> +
> +		/*
> +		 * Log if we find an entry in the DMI table that we don't
> +		 * understand.  If this happens, we should figure out what
> +		 * the entry means and add it to bios_to_linux_keycode.
> +		 */
> +		if (keycode =3D=3D KEY_RESERVED) {
> +			pr_info("firmware scancode 0x%x maps to unrecognized keycode 0x%x=
\n",
> +				bios_entry->scancode, bios_entry->keycode);
> +			continue;
> +		}
> =20
>  		if (keycode =3D=3D KEY_KBDILLUMTOGGLE)
>  			keymap[pos].type =3D KE_IGNORE;
> --=20
> 2.5.0
>=20
>=20

--=20
Darren Hart
Intel Open Source Technology Center

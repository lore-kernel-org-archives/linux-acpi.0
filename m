From: Darren Hart <dvhart@infradead.org>
Subject: Re: [PATCH] dell-wmi: Fix access out of memory
Date: Mon, 29 Sep 2014 14:30:29 -0700
Message-ID: <20140929213028.GB34181@vmdeb7>
References: <1411996251-13455-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1411996251-13455-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, rjw@rjwysocki.net
List-Id: linux-acpi@vger.kernel.org

On Mon, Sep 29, 2014 at 03:10:51PM +0200, Pali Roh=E1r wrote:
> Without this patch driver dell-wmi is trying to access elements of dy=
namically
> allocated array without checking array size. This can lead to memory =
corruption
> or kernel panic. This patch adds missing checks for array size.
>=20
> Signed-off-by: Pali Roh=E1r <pali.rohar@gmail.com>

Looks good to me. Rafael, any concerns?

Cc: linux-acpi

> ---
> This patch should be probably applied to stable kernel trees as it fi=
xing
> possible memory corruption.
> ---
>  drivers/platform/x86/dell-wmi.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/platform/x86/dell-wmi.c b/drivers/platform/x86/d=
ell-wmi.c
> index 390e8e3..25721bf 100644
> --- a/drivers/platform/x86/dell-wmi.c
> +++ b/drivers/platform/x86/dell-wmi.c
> @@ -163,18 +163,24 @@ static void dell_wmi_notify(u32 value, void *co=
ntext)
>  		const struct key_entry *key;
>  		int reported_key;
>  		u16 *buffer_entry =3D (u16 *)obj->buffer.pointer;
> +		int buffer_size =3D obj->buffer.length/2;
> =20
> -		if (dell_new_hk_type && (buffer_entry[1] !=3D 0x10)) {
> +		if (buffer_size >=3D 2 && dell_new_hk_type && buffer_entry[1] !=3D=
 0x10) {
>  			pr_info("Received unknown WMI event (0x%x)\n",
>  				buffer_entry[1]);
>  			kfree(obj);
>  			return;
>  		}
> =20
> -		if (dell_new_hk_type || buffer_entry[1] =3D=3D 0x0)
> +		if (buffer_size >=3D 3 && (dell_new_hk_type || buffer_entry[1] =3D=
=3D 0x0))
>  			reported_key =3D (int)buffer_entry[2];
> -		else
> +		else if (buffer_size >=3D 2)
>  			reported_key =3D (int)buffer_entry[1] & 0xffff;
> +		else {
> +			pr_info("Received unknown WMI event\n");
> +			kfree(obj);
> +			return;
> +		}
> =20
>  		key =3D sparse_keymap_entry_from_scancode(dell_wmi_input_dev,
>  							reported_key);
> --=20
> 1.7.9.5
>=20
>=20

--=20
Darren Hart
Intel Open Source Technology Center

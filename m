From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [FIX PATCH] ACPI / PM: Add Sony Vaio VPCEB1S1E to nonvs blacklist.
Date: Wed, 21 Nov 2012 01:47:05 +0100
Message-ID: <2373207.0huVJLJSvf@vostro.rjw.lan>
References: <1352338425-4830-1-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:56786 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752254Ab2KUAmi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 20 Nov 2012 19:42:38 -0500
In-Reply-To: <1352338425-4830-1-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-acpi@vger.kernel.org, swilmet@gnome.org, stable@vger.kernel.org

On Thursday, November 08, 2012 09:33:45 AM Lan Tianyu wrote:
> Sony Vaio VPCEB1S1E does not resume correctly without
> acpi_sleep=3Dnonvs, so add it to the ACPI sleep blacklist.
>=20
> https://bugzilla.kernel.org/show_bug.cgi?id=3D48781

Applied to the linux-next branch of the linux-pm.git tree as v3.8 mater=
ial.

Thanks,
Rafael


> Reported-by: S=C3=A9bastien Wilmet <swilmet@gnome.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
> ---
>  drivers/acpi/sleep.c |    8 ++++++++
>  1 file changed, 8 insertions(+)
>=20
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index fdcdbb6..847ed55 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -519,6 +519,14 @@ static struct dmi_system_id __initdata acpisleep=
_dmi_table[] =3D {
>  	},
>  	{
>  	.callback =3D init_nvs_nosave,
> +	.ident =3D "Sony Vaio VPCEB1S1E",
> +	.matches =3D {
> +		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
> +		DMI_MATCH(DMI_PRODUCT_NAME, "VPCEB1S1E"),
> +		},
> +	},
> +	{
> +	.callback =3D init_nvs_nosave,
>  	.ident =3D "Sony Vaio VGN-FW520F",
>  	.matches =3D {
>  		DMI_MATCH(DMI_SYS_VENDOR, "Sony Corporation"),
>=20
--=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

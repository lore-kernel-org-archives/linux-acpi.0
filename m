From: Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2] ACPI: Clarify resource conflict message
Date: Mon, 21 Sep 2009 10:25:40 +0200
Message-ID: <200909211025.40605.jdelvare@suse.de>
References: <200909081531.46716.jdelvare@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38286 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753570AbZIUIZi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 04:25:38 -0400
In-Reply-To: <200909081531.46716.jdelvare@suse.de>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>
Cc: Thomas Renninger <trenn@suse.de>, Alan Jenkins <sourcejedi.lkml@googlemail.com>

Len, Rui, can you please push this patch upstream quickly? We get
more and more reports about this, and an improved wording would
definitely help.

Thanks.

Le mardi 08 septembre 2009, Jean Delvare a =C3=A9crit=C2=A0:
> From: Jean Delvare <jdelvare@suse.de>
> Subject: ACPI: Clarify resource conflict message
>=20
> The message "ACPI: Device needs an ACPI driver" is misleading. The
> device _may_ need an ACPI driver, if the BIOS implemented a custom
> API for the device in question (which, AFAIK, can't be checked.) If
> not, then either a generic ACPI driver may be used (for example
> "thermal"), or nothing can be done (other than a white list).
>=20
> I propose to reword the message to:
>=20
> ACPI: If an ACPI driver is available for this device, you should use
> it instead of the native driver
>=20
> which I think is more correct. Comments and suggestions welcome.
>=20
> I also added a message warning about possible problems and system
> instability when users pass acpi_enforce_resources=3Dlax, as suggeste=
d
> by Len.
>=20
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> Cc: Zhang Rui <rui.zhang@intel.com>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Thomas Renninger <trenn@suse.de>
> Cc: Alan Jenkins <sourcejedi.lkml@googlemail.com>
> ---
> Len, if you are satisfied with the wording, any chance to have this
> patch in 2.6.31? Thanks.
>=20
>  drivers/acpi/osl.c |    8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>=20
> --- linux-2.6.31-rc9.orig/drivers/acpi/osl.c	2009-09-08 09:46:51.0000=
00000 +0200
> +++ linux-2.6.31-rc9/drivers/acpi/osl.c	2009-09-08 13:56:53.000000000=
 +0200
> @@ -1182,7 +1182,13 @@ int acpi_check_resource_conflict(struct
>  			       res_list_elem->name,
>  			       (long long) res_list_elem->start,
>  			       (long long) res_list_elem->end);
> -			printk(KERN_INFO "ACPI: Device needs an ACPI driver\n");
> +			if (acpi_enforce_resources =3D=3D ENFORCE_RESOURCES_LAX)
> +				printk(KERN_NOTICE "ACPI: This conflict may"
> +				       " cause random problems and system"
> +				       " instability\n");
> +			printk(KERN_INFO "ACPI: If an ACPI driver is available"
> +			       " for this device, you should use it instead of"
> +			       " the native driver\n");
>  		}
>  		if (acpi_enforce_resources =3D=3D ENFORCE_RESOURCES_STRICT)
>  			return -EBUSY;
>=20



--=20
Jean Delvare
Suse L3
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

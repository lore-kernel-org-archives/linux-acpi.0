From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/3] [2.6.25-rc5] Fix a memory overflow bug when copying NULL internal package element object to external.
Date: Tue, 11 Mar 2008 23:53:20 -0400
Message-ID: <200803112353.20659.lenb@kernel.org>
References: <1205280376.8194.44.camel@linux-2bdv.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:57975 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751587AbYCLDxh convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 11 Mar 2008 23:53:37 -0400
In-Reply-To: <1205280376.8194.44.camel@linux-2bdv.site>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: trenn@suse.de
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Zhang, Rui" <rui.zhang@intel.com>, ming.m.lin@intel.com

this one is already in via bugzilla 10132.

thanks,
-Len

On Tuesday 11 March 2008, Thomas Renninger wrote:
> From: Lin Ming <ming.m.lin@intel.com>
>=20
> Fix a memory overflow bug when copying
> NULL internal package element object to external.
>=20
> Signed-off-by: Lin Ming <ming.m.lin@intel.com>
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> =EF=BB=BFTested-by: Thomas Renninger <trenn@suse.de>
>=20
> ---
>  drivers/acpi/utilities/utobject.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: linux-2.6/drivers/acpi/utilities/utobject.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/utilities/utobject.c
> +++ linux-2.6/drivers/acpi/utilities/utobject.c
> @@ -432,7 +432,7 @@ acpi_ut_get_simple_object_size(union acp
>  	 * element -- which is legal)
>  	 */
>  	if (!internal_object) {
> -		*obj_length =3D 0;
> +		*obj_length =3D sizeof(union acpi_object);
>  		return_ACPI_STATUS(AE_OK);
>  	}
> =20
>=20
>=20
>=20
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

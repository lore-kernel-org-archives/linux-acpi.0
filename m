From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] ACPI: update AC status before exporting it
Date: Wed, 19 Nov 2008 09:27:53 +0800
Message-ID: <1227058073.15014.258.camel@rzhang-dt>
References: <1227057852.15014.256.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:27112 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751116AbYKSB2Y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Nov 2008 20:28:24 -0500
In-Reply-To: <1227057852.15014.256.camel@rzhang-dt>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, Alexey Starikovskiy <astarikovskiy@suse.de>, lukaszwojdyla@gmail.com

On Wed, 2008-11-19 at 09:24 +0800, Zhang, Rui wrote:
> sometimes the AC status is not updated in time,
> i.e. no AC event when AC is plugged/unplugged.
> In this case, we need to update its status before exporting it.
> http://bugzilla.kernel.org/show_bug.cgi?id=3D12035
>=20
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> CC: Alexey Starikovskiy <astarikovskiy@suse.de>

Tested-by: =C5=81ukasz Wojdy=C5=82a <lukaszwojdyla@gmail.com>

> ---
>  drivers/acpi/ac.c |    6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> Index: linux-2.6/drivers/acpi/ac.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-2.6.orig/drivers/acpi/ac.c
> +++ linux-2.6/drivers/acpi/ac.c
> @@ -87,6 +87,7 @@ struct acpi_ac {
>  	unsigned long long state;
>  };
> =20
> +static int acpi_ac_get_state(struct acpi_ac *ac);
>  #define to_acpi_ac(x) container_of(x, struct acpi_ac, charger);
> =20
>  #ifdef CONFIG_ACPI_PROCFS_POWER
> @@ -103,15 +104,18 @@ static int get_ac_property(struct power_
>  			   enum power_supply_property psp,
>  			   union power_supply_propval *val)
>  {
> +	int result;
>  	struct acpi_ac *ac =3D to_acpi_ac(psy);
> +
>  	switch (psp) {
>  	case POWER_SUPPLY_PROP_ONLINE:
> +		result =3D acpi_ac_get_state(ac);
>  		val->intval =3D ac->state;
>  		break;
>  	default:
>  		return -EINVAL;
>  	}
> -	return 0;
> +	return result;
>  }
> =20
>  static enum power_supply_property ac_props[] =3D {
>=20
>=20

--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

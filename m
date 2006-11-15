From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Wed, 15 Nov 2006 13:56:52 -0800
Message-ID: <200611151356.52985.david-b@pacbell.net>
References: <200611142303.47325.david-b@pacbell.net> <200611150248.12578.len.brown@intel.com> <455B28B2.4010707@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp110.sbc.mail.mud.yahoo.com ([68.142.198.209]:58526 "HELO
	smtp110.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1162073AbWKOXpP (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 15 Nov 2006 18:45:15 -0500
In-Reply-To: <455B28B2.4010707@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Wednesday 15 November 2006 6:48 am, Alexey Starikovskiy wrote:
> ec1.patch
>=20
>=20
> Always enable GPE after return from notify handler.
>=20
> From: =A0Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
>=20
>=20
> ---

Yes, this seems to resolve the regression as well as Len's ec_intr=3D0 =
boot param.

IMO this should get merged into 2.6.19 ASAP ...


> =A0drivers/acpi/ec.c | =A0 =A02 --
> =A01 files changed, 0 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
> index e6d4b08..937eafc 100644
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -465,8 +465,6 @@ static u32 acpi_ec_gpe_handler(void *dat
> =A0
> =A0=A0=A0=A0=A0=A0=A0=A0if (value & ACPI_EC_FLAG_SCI) {
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0status =3D acpi_os_ex=
ecute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0return status =3D=3D AE=
_OK ?
> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0 =A0ACPI_INTERRUPT_=
HANDLED : ACPI_INTERRUPT_NOT_HANDLED;
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
> =A0=A0=A0=A0=A0=A0=A0=A0return status =3D=3D AE_OK ?
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

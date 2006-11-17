From: David Brownell <david-b@pacbell.net>
Subject: Re: 2.6.19-rc5 nasty ACPI regression, AE_TIME errors
Date: Thu, 16 Nov 2006 22:22:43 -0800
Message-ID: <200611162222.44836.david-b@pacbell.net>
References: <200611142303.47325.david-b@pacbell.net> <200611151710.26570.david-b@pacbell.net> <455C8696.80508@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp114.sbc.mail.mud.yahoo.com ([68.142.198.213]:53342 "HELO
	smtp114.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1162404AbWKQGWs (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 17 Nov 2006 01:22:48 -0500
In-Reply-To: <455C8696.80508@linux.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <alexey.y.starikovskiy@linux.intel.com>
Cc: Len Brown <lenb@kernel.org>, Linux Kernel list <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org

On Thursday 16 November 2006 7:41 am, Alexey Starikovskiy wrote:
> --- a/drivers/acpi/ec.c
> +++ b/drivers/acpi/ec.c
> @@ -467,8 +467,8 @@ static u32 acpi_ec_gpe_handler(void *dat
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0status =3D acpi_os_ex=
ecute(OSL_EC_BURST_HANDLER, acpi_ec_gpe_query, ec);
> =A0=A0=A0=A0=A0=A0=A0=A0}
> =A0=A0=A0=A0=A0=A0=A0=A0acpi_enable_gpe(NULL, ec->gpe_bit, ACPI_ISR);
> -=A0=A0=A0=A0=A0=A0=A0return status =3D=3D AE_OK ?
> -=A0=A0=A0=A0=A0=A0=A0 =A0 =A0ACPI_INTERRUPT_HANDLED : ACPI_INTERRUPT=
_NOT_HANDLED;
> +=A0=A0=A0=A0=A0=A0=A0WARN_ON(ACPI_FAILURE(status));
> +=A0=A0=A0=A0=A0=A0=A0return ACPI_INTERRUPT_HANDLED;
> =A0}
> =A0

Strange ... applying this on top of the previous patch seems to work
much better, but that WARN_ON hasn't triggered.  At least, not yet.
Updating to RC6, with your two patches installed...

- Dave
-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

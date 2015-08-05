From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi, property: Export acpi_dev_prop_read_single call.
Date: Wed, 05 Aug 2015 15:48:17 +0200
Message-ID: <5621301.c1YGTkGNQk@vostro.rjw.lan>
References: <1438729319-9146-1-git-send-email-ddaney.cavm@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:58117 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751239AbbHENVM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Aug 2015 09:21:12 -0400
In-Reply-To: <1438729319-9146-1-git-send-email-ddaney.cavm@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: David Daney <ddaney.cavm@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Robert Richter <rrichter@cavium.com>, David Daney <david.daney@cavium.com>

On Tuesday, August 04, 2015 04:01:59 PM David Daney wrote:
> From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> 
> Fixes the following build error when building drivers as modules:
> 
>  ERROR: "acpi_dev_prop_read_single" [drivers/net/phy/mdio-octeon.ko] undefined!
>  ERROR: "acpi_dev_prop_read_single" [drivers/net/ethernet/cavium/thunder/thunder_bgx.ko] undefined!

Can you please tell me why the drivers in question use that function
directly, although they aren't supposed to?

Clearly, their authors had not tried to build them as modules or they
would have noticed the problem at the development stage already.

What would be wrong with using the generic device properties API instead?


> Reported-by: Andreas Schwab <schwab@suse.de>
> Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  drivers/acpi/property.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> index 7836e2e..237e3c5 100644
> --- a/drivers/acpi/property.c
> +++ b/drivers/acpi/property.c
> @@ -432,6 +432,7 @@ int acpi_dev_prop_read_single(struct acpi_device *adev, const char *propname,
>  	}
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(acpi_dev_prop_read_single);
>  
>  static int acpi_copy_property_array_u8(const union acpi_object *items, u8 *val,
>  				       size_t nval)
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

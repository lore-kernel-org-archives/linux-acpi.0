From: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] ACPI: Flag use of ACPI and ACPI idioms for power
 supplies to regulator API
Date: Mon, 27 Jan 2014 09:25:09 +0100
Message-ID: <20140127092509.24844e25@endymion.delvare>
References: <1390782734-10131-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from zoneX.GCU-Squad.org ([194.213.125.0]:8817 "EHLO
	services.gcu-squad.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751069AbaA0IZV (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 27 Jan 2014 03:25:21 -0500
In-Reply-To: <1390782734-10131-1-git-send-email-broonie@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linaro-kernel@lists.linaro.org, Guenter Roeck <linux@roeck-us.net>, Mark Brown <broonie@linaro.org>

On Mon, 27 Jan 2014 00:32:14 +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> There is currently no facility in ACPI to express the hookup of voltage
> regulators, the expectation is that the regulators that exist in the
> system will be handled transparently by firmware if they need software
> control at all. This means that if for some reason the regulator API is
> enabled on such a system it should assume that any supplies that devices
> need are provided by the system at all relevant times without any software
> intervention.
> 
> Tell the regulator core to make this assumption by calling
> regulator_has_full_constraints(). Do this as soon as we know we are using
> ACPI so that the information is available to the regulator core as early
> as possible. This will cause the regulator core to pretend that there is
> an always on regulator supplying any supply that is requested but that has
> not otherwise been mapped which is the behaviour expected on a system with
> ACPI.
> 
> Should the ability to specify regulators be added in future revisions of
> ACPI then once we have support for ACPI mappings in the kernel the same
> assumptions will apply. It is also likely that systems will default to a
> mode of operation which does not require any interpretation of these
> mappings in order to be compatible with existing operating system releases
> so it should remain safe to make these assumptions even if the mappings
> exist but are not supported by the kernel.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/acpi/bus.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
> index 384da5ab5955..fcb59c21c68d 100644
> --- a/drivers/acpi/bus.c
> +++ b/drivers/acpi/bus.c
> @@ -33,6 +33,7 @@
>  #include <linux/proc_fs.h>
>  #include <linux/acpi.h>
>  #include <linux/slab.h>
> +#include <linux/regulator/machine.h>
>  #ifdef CONFIG_X86
>  #include <asm/mpspec.h>
>  #endif
> @@ -509,6 +510,14 @@ void __init acpi_early_init(void)
>  		goto error0;
>  	}
>  
> +	/*
> +	 * If the system is using ACPI then we can be reasonably
> +	 * confident that any regulators are managed by the firmware
> +	 * so tell the regulator core it has everything it needs to
> +	 * know.
> +	 */
> +	regulator_has_full_constraints();
> +
>  	return;
>  
>        error0:

I think it makes sense to have this included in stable kernel trees?

Thanks,
-- 
Jean Delvare

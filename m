From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH] acpi: Fix proper return code for function acpi_gsi_to_irq
Date: Tue, 11 Jul 2017 18:46:36 +0100
Message-ID: <20170711174636.GA31526@red-moon>
References: <20170711164543.23439-1-msalter@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:47692 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932462AbdGKRo5 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 11 Jul 2017 13:44:57 -0400
Content-Disposition: inline
In-Reply-To: <20170711164543.23439-1-msalter@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Salter <msalter@redhat.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Marc Zyngier <marc.zyngier@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

On Tue, Jul 11, 2017 at 12:45:43PM -0400, Mark Salter wrote:
> The function acpi_gsi_to_irq must return 0 on success as the caller
> ghes_probe expects an 0 for success. This change also matches x86
> implementation.
> 
> This patch was submitted around 4.5 timeframe but wasn't pushed because
> it didn't fix a real problem. Now that RAS/GHES patches are in kernel,
> this fixes an error seen on a Mustang (arm64) platform:

Nit: I think you can rephrase the log, ie it is a bug and you are fixing
it, that's it.

>     GHES: Failed to map GSI to IRQ for generic hardware error source: 2
>     GHES: probe of GHES.2 failed with error 81
> 
> Signed-off-by: Tuan Phan <tphan@apm.com>
> Signed-off-by: Loc Ho <lho@apm.com>
> [rebased to v4.12-rc]
> Signed-off-by: Mark Salter <msalter@redhat.com>
> ---
>  drivers/acpi/irq.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

> diff --git a/drivers/acpi/irq.c b/drivers/acpi/irq.c
> index 830299a..7c352cb 100644
> --- a/drivers/acpi/irq.c
> +++ b/drivers/acpi/irq.c
> @@ -24,7 +24,7 @@ static struct fwnode_handle *acpi_gsi_domain_id;
>   *
>   * irq location updated with irq value [>0 on success, 0 on failure]
>   *
> - * Returns: linux IRQ number on success (>0)
> + * Returns: 0 on success
>   *          -EINVAL on failure
>   */
>  int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
> @@ -37,7 +37,7 @@ int acpi_gsi_to_irq(u32 gsi, unsigned int *irq)
>  	 * *irq == 0 means no mapping, that should
>  	 * be reported as a failure
>  	 */
> -	return (*irq > 0) ? *irq : -EINVAL;
> +	return (*irq > 0) ? 0 : -EINVAL;
>  }
>  EXPORT_SYMBOL_GPL(acpi_gsi_to_irq);
>  
> -- 
> 2.9.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

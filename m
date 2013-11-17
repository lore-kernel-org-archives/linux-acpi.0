From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 10/12] ACPI: ACPI_FADT_C2_MP_SUPPORTED must be ignored in HW reduced mode
Date: Sun, 17 Nov 2013 23:24:07 +0100
Message-ID: <3195949.CaCUDbNC4B@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-11-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59428 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751267Ab3KQWLd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 17:11:33 -0500
In-Reply-To: <1384047382-20623-11-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:20 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>

-ENOCHANGELOG

> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/processor_idle.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index e2bd0bf..262b84b 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -290,7 +290,8 @@ static int acpi_processor_get_power_info_fadt(struct acpi_processor *pr)
>  	 * Check for P_LVL2_UP flag before entering C2 and above on
>  	 * an SMP system.
>  	 */
> -	if ((num_online_cpus() > 1) &&
> +	if (!acpi_gbl_reduced_hardware &&
> +	    (num_online_cpus() > 1) &&
>  	    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
>  		return -ENODEV;
>  #endif

Patch [8/12] added code to avoid calling this function for acpi_gbl_reduced_hardware
set at all, so isn't the check added here actually useless?

> @@ -965,7 +966,8 @@ static int acpi_processor_setup_cpuidle_cx(struct acpi_processor *pr,
>  			continue;
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
> +		if (!acpi_gbl_reduced_hardware &&
> +		    (cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
>  		    !pr->flags.has_cst &&
>  		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
>  			continue;
> @@ -1020,7 +1022,8 @@ static int acpi_processor_setup_cpuidle_states(struct acpi_processor *pr)
>  			continue;
>  
>  #ifdef CONFIG_HOTPLUG_CPU
> -		if ((cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
> +		if (!acpi_gbl_reduced_hardware &&
> +		    (cx->type != ACPI_STATE_C1) && (num_online_cpus() > 1) &&
>  		    !pr->flags.has_cst &&
>  		    !(acpi_gbl_FADT.flags & ACPI_FADT_C2_MP_SUPPORTED))
>  			continue;
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

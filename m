From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 01/11] acpi: enable C3 Power State on Dell Inspiron 8200
Date: Thu, 19 Jun 2008 00:14:26 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806190012590.3613@localhost.localdomain>
References: <200806092322.m59NMHuG013955@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173005pub.verizon.net ([206.46.173.5]:42376 "EHLO
	vms173005pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbYFSEOm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 19 Jun 2008 00:14:42 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173005.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2O008FEZGX5SME@vms173005.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 18 Jun 2008 23:07:46 -0500 (CDT)
In-reply-to: <200806092322.m59NMHuG013955@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, dag@bakke.com, arjan@infradead.org

NAK.

Dell told me they disabled C3 on this box on purpose.
If there is a measurable power saving case to over-ride Dell
and no sign of a stability issue, please re-open bugzilla 8703.

thanks,
-len

On Mon, 9 Jun 2008, akpm@linux-foundation.org wrote:

> From: Dag Bakke <dag@bakke.com>
> 
> Taken from http://bugzilla.kernel.org/show_bug.cgi?id=8703
> 
> [akpm@linux-foundation.org: fix warning]
> Cc: Arjan van de Ven <arjan@infradead.org>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/processor_idle.c |   23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff -puN drivers/acpi/processor_idle.c~acpi-enable-c3-power-state-on-dell-inspiron-8200 drivers/acpi/processor_idle.c
> --- a/drivers/acpi/processor_idle.c~acpi-enable-c3-power-state-on-dell-inspiron-8200
> +++ a/drivers/acpi/processor_idle.c
> @@ -103,6 +103,8 @@ static unsigned int latency_factor __rea
>  module_param(latency_factor, uint, 0644);
>  #endif
>  
> +static int forced_c3;
> +
>  /*
>   * IBM ThinkPad R40e crashes mysteriously when going into C2 or C3.
>   * For now disable this. Probably a bug somewhere else.
> @@ -123,6 +125,19 @@ static int set_max_cstate(const struct d
>  	return 0;
>  }
>  
> +/*
> + * Some (Dell) machines set the C3 latency to a value which effectively says:
> + * "Don't use C3." Still, C3 works if we force it.
> + * This enables C3 on Dell Inspiron 8200 machines.
> + */
> +static int dmi_force_c3(const struct dmi_system_id *id)
> +{
> +	forced_c3 = 1;
> +	printk(KERN_NOTICE PREFIX "%s detected - Force enabling C3.",
> +			id->ident);
> +	return 0;
> +}
> +
>  /* Actually this shouldn't be __cpuinitdata, would be better to fix the
>     callers to only run once -AK */
>  static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
> @@ -181,6 +196,9 @@ static struct dmi_system_id __cpuinitdat
>  	  DMI_MATCH(DMI_BIOS_VENDOR,"Phoenix Technologies LTD"),
>  	  DMI_MATCH(DMI_BIOS_VERSION,"SHE845M0.86C.0013.D.0302131307")},
>  	 (void *)2},
> +	{ dmi_force_c3, "Dell Inspiron 8200", {
> +	  DMI_MATCH(DMI_SYS_VENDOR,"Dell Computer Corporation"),
> +	  DMI_MATCH(DMI_PRODUCT_NAME,"Inspiron 8200") }, NULL},
>  	{},
>  };
>  
> @@ -1050,11 +1068,12 @@ static void acpi_processor_power_verify_
>  	 * C3 latency must be less than or equal to 1000
>  	 * microseconds.
>  	 */
> -	else if (cx->latency > ACPI_PROCESSOR_MAX_C3_LATENCY) {
> +	if (cx->latency > ACPI_PROCESSOR_MAX_C3_LATENCY && !forced_c3) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  				  "latency too large [%d]\n", cx->latency));
>  		return;
> -	}
> +	} else if (forced_c3)
> +		cx->latency = ACPI_PROCESSOR_MAX_C3_LATENCY;
>  
>  	/*
>  	 * PIIX4 Erratum #18: We don't support C3 when Type-F (fast)
> _
> 

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 02/12] ACPI: bus master reload not supported in reduced HW mode
Date: Sun, 17 Nov 2013 22:56:08 +0100
Message-ID: <2902248.9mmxm8tccy@vostro.rjw.lan>
References: <1384047382-20623-1-git-send-email-al.stone@linaro.org> <1384047382-20623-3-git-send-email-al.stone@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:60977 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751324Ab3KQVnd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 17 Nov 2013 16:43:33 -0500
In-Reply-To: <1384047382-20623-3-git-send-email-al.stone@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: al.stone@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Al Stone <ahs3@redhat.com>

On Saturday, November 09, 2013 06:36:12 PM al.stone@linaro.org wrote:
> From: Al Stone <ahs3@redhat.com>
> 
> Remove the saving and restoring of bus master reload registers in
> suspend/resume when in reduces HW mode; according to the spec, no
> such registers should exist
> 
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>  drivers/acpi/processor_idle.c | 8 +++++++-
>  include/acpi/acpixf.h         | 6 ++++++
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
> index 35c8f2b..28079a6 100644
> --- a/drivers/acpi/processor_idle.c
> +++ b/drivers/acpi/processor_idle.c
> @@ -210,6 +210,7 @@ static void lapic_timer_state_broadcast(struct acpi_processor *pr,
>  #endif
>  
>  #ifdef CONFIG_PM_SLEEP
> +#if (!ACPI_REDUCED_HARDWARE)

Why don't you use #ifndef CONFIG_ACPI_REDUCED_HARDWARE here?

And I believe we don't need acpi_processor_syscore_ops in that case at all?

So why don't you put the whole section under

#if (IS_ENABLED(CONFIG_PM_SLEEP) && !IS_ENABLED(CONFIG_ACPI_REDUCED_HARDWARE)) ?

>  static u32 saved_bm_rld;
>  
>  static int acpi_processor_suspend(void)
> @@ -228,6 +229,11 @@ static void acpi_processor_resume(void)
>  
>  	acpi_write_bit_register(ACPI_BITREG_BUS_MASTER_RLD, saved_bm_rld);
>  }
> +#else
> +/* Bus master reload is not supported in reduced HW mode. */
> +static int acpi_processor_suspend(void) { return 0; }
> +static void acpi_processor_resume(void) { return; }
> +#endif /* (!ACPI_REDUCED_HARDWARE) */
>  
>  static struct syscore_ops acpi_processor_syscore_ops = {
>  	.suspend = acpi_processor_suspend,

I'm not sure why you think that the changes below belong to this patch?

> @@ -605,7 +611,7 @@ static int acpi_processor_power_verify(struct acpi_processor *pr)
>  		case ACPI_STATE_C2:
>  			if (!cx->address)
>  				break;
> -			cx->valid = 1; 
> +			cx->valid = 1;
>  			break;
>  
>  		case ACPI_STATE_C3:
> diff --git a/include/acpi/acpixf.h b/include/acpi/acpixf.h
> index d8f9457..27ef69b 100644
> --- a/include/acpi/acpixf.h
> +++ b/include/acpi/acpixf.h
> @@ -99,6 +99,9 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
>  #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
>  	prototype;
>  
> +#define ACPI_HW_DEPENDENT_RETURN_INT(prototype) \
> +	prototype;
> +
>  #else
>  #define ACPI_HW_DEPENDENT_RETURN_STATUS(prototype) \
>  	static ACPI_INLINE prototype {return(AE_NOT_CONFIGURED);}
> @@ -109,6 +112,9 @@ extern u8 acpi_gbl_disable_ssdt_table_load;
>  #define ACPI_HW_DEPENDENT_RETURN_VOID(prototype) \
>  	static ACPI_INLINE prototype {return;}
>  
> +#define ACPI_HW_DEPENDENT_RETURN_INT(prototype) \
> +	static ACPI_INLINE prototype {return 0;}
> +
>  #endif				/* !ACPI_REDUCED_HARDWARE */
>  
>  /*
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

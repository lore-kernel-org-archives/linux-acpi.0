From: Pavel Machek <pavel-AlSwsSmVLrQ@public.gmane.org>
Subject: Re: [PATCH] Fix ACPI passive thermal management
Date: Sun, 20 Nov 2005 23:50:33 +0000
Message-ID: <20051120235032.GH2556@spitz.ucw.cz>
References: <200511192223.00151.luming.yu@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <200511192223.00151.luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: Yu Luming <luming.yu-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: akpm-3NddpPZAyC0@public.gmane.org, acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, len.brown-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, alexey.y.starikovskiy-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, trenn-l3A5Bk7waGM@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi!

> Fix issue: passive mode is not left, once entered
> http://bugzilla.kernel.org/show_bug.cgi?id=3410


For this big patch, I believe you should provide longer description.

> @@ -259,19 +257,25 @@ int acpi_processor_set_thermal_limit(acp
>  		/* if going down: T-states first, P-states later */
>  
>  		if (pr->flags.throttling) {
> -			if (tx == 0)
> +			if (tx == 0) {
> +                                max_tx_px = 1;
>  				ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  						  "At minimum throttling state\n"));

Please fix indentation

>  		result = acpi_thermal_cpufreq_decrease(pr->id);
> -		if (result == -ERANGE)
> +		if (result) {
> +			// We only could get -ERANGE, 1 or 0.
> +			// In the first two cases we reached max freq again.
>  			ACPI_DEBUG_PRINT((ACPI_DB_INFO,
>  					  "At minimum performance state\n"));

...and avoid C++ comments.

> @@ -290,8 +294,10 @@ int acpi_processor_set_thermal_limit(acp
>  				  pr->limit.thermal.px, pr->limit.thermal.tx));
>  	} else
>  		result = 0;
> -
> -	return_VALUE(result);
> +	if (max_tx_px)
> +		return_VALUE(1);
> +	else
> +		return_VALUE(result);
>  }
>  

What kind of ninja mutant calling convention is this?

> diff --git a/drivers/acpi/thermal.c b/drivers/acpi/thermal.c
> --- a/drivers/acpi/thermal.c
> +++ b/drivers/acpi/thermal.c
> @@ -72,7 +72,7 @@
>  #define _COMPONENT		ACPI_THERMAL_COMPONENT
>  ACPI_MODULE_NAME("acpi_thermal")
>  
> -    MODULE_AUTHOR("Paul Diefenbaugh");
> +MODULE_AUTHOR("Paul Diefenbaugh");
>  MODULE_DESCRIPTION(ACPI_THERMAL_DRIVER_NAME);
>  MODULE_LICENSE("GPL");
>  

Nice catch, but this is not fixing thermal, right? How much of other stuff is unrelated?

> @@ -556,12 +556,25 @@ static int acpi_thermal_passive(struct a
>  								 handles[i],
>  								 ACPI_PROCESSOR_LIMIT_INCREMENT);
>  		/* Cooling off? */
> -		else if (trend < 0)
> +		else if (trend < 0) {
>  			for (i = 0; i < passive->devices.count; i++)
> -				acpi_processor_set_thermal_limit(passive->
> -								 devices.
> -								 handles[i],
> -								 ACPI_PROCESSOR_LIMIT_DECREMENT);
> +				// assume that we are on highest freq/lowest thrott
> +				// and can leave passive mode, even in error case
> +				if (!acpi_processor_set_thermal_limit(
> +					    passive->devices.handles[i],
> +					    ACPI_PROCESSOR_LIMIT_DECREMENT))
> +					result = 0;
> +			// Leave cooling mode, even if the temp might higher than trip point.
> +			// This is because some machines might have long thermal polling 
> frequencies
> +			// (tsp) defined. We will fall back into passive mode in next cycle 
> (probably quicker)

It would be nice to at least fit comments into 80 columns.


							Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         



-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click

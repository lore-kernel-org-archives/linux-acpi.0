From: "Yu, Luming" <luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Patch: enable runtime GPEs before calling _WAK method
Date: Wed, 30 Mar 2005 14:58:32 +0800
Message-ID: <200503301458.32410.luming.yu@intel.com>
References: <1111883655.11677.59.camel@tyrosine>
Reply-To: luming.yu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain;
  charset="gb18030"
Content-Transfer-Encoding: 7bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <1111883655.11677.59.camel@tyrosine>
Content-Disposition: inline
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: Matthew Garrett <mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

It's very likely. But we still need to dig more  from DSDT.
Ususally, we are confused by interpreter glitch, so we need to make sure 
interpreter works well.

On Sunday 27 March 2005 08:34, Matthew Garrett wrote:
> The following patch enables runtime GPEs before calling _WAK. This
> appears to be needed for resume from disk to work properly on an HP 6220
> - without it, if the fan state has changed between suspend and resume,
> kacpid consumes 100% of the CPU time and the fan speed remains constant.
>
> >From playing with this, I assume that it's because the _WAK method
>
> triggers an event that isn't handled because the GPEs haven't been
> enabled.
>
> diff -ur build-386/drivers/acpi/hardware/hwsleep.c
> build-686/drivers/acpi/hardware/hwsleep.c ---
> build-386/drivers/acpi/hardware/hwsleep.c	2005-03-17 20:40:58.000000000
> +0000 +++ build-686/drivers/acpi/hardware/hwsleep.c	2005-03-26
> 23:48:29.000000000 +0000 @@ -543,12 +543,6 @@
>  		ACPI_REPORT_ERROR (("Method _BFS failed, %s\n", acpi_format_exception
> (status))); }
>
> -	status = acpi_evaluate_object (NULL, METHOD_NAME__WAK, &arg_list, NULL);
> -	if (ACPI_FAILURE (status) && status != AE_NOT_FOUND) {
> -		ACPI_REPORT_ERROR (("Method _WAK failed, %s\n", acpi_format_exception
> (status))); -	}
> -	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
> -
>  	/*
>  	 * Restore the GPEs:
>  	 * 1) Disable/Clear all GPEs
> @@ -565,6 +559,12 @@
>  		return_ACPI_STATUS (status);
>  	}
>
> +	status = acpi_evaluate_object (NULL, METHOD_NAME__WAK, &arg_list, NULL);
> +	if (ACPI_FAILURE (status) && status != AE_NOT_FOUND) {
> +		ACPI_REPORT_ERROR (("Method _WAK failed, %s\n", acpi_format_exception
> (status))); +	}
> +	/* TBD: _WAK "sometimes" returns stuff - do we want to look at it? */
> +
>  	/* Enable power button */
>
>  	(void)
> acpi_set_register(acpi_gbl_fixed_event_info[ACPI_EVENT_POWER_BUTTON].enable
>_register_id,

-- 
Thanks,
Luming


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

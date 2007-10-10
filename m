From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI:avoid printing the error message that processor device is not present
Date: Tue, 9 Oct 2007 23:43:40 -0400
Message-ID: <200710092343.40843.lenb@kernel.org>
References: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:58495 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750856AbXJJDnz (ORCPT <rfc822;Linux-acpi@vger.kernel.org>);
	Tue, 9 Oct 2007 23:43:55 -0400
In-Reply-To: <1191814518.3830.2.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: Linux-acpi@vger.kernel.org

On Sunday 07 October 2007 23:35, Zhao Yakui wrote:
> Subject: ACPI: avoid printing the info that processor device is not present
> From: Zhao Yakui  <yakui.zhao@intel.com>
> 
> Four processors are defined in the DSDT table, which means that quad-core cpu
> is supported. But dual-core cpu is installed on the system. In the
> initialization OS will check whether the defined processor exists. If it 
> doesn't exist, it will print the info that processor device is not present.
> The above error message has no effect on the system but it will mislead us.
> So it is unnecessary to print the error message when disabling acpi debug.

SuSE ships with ACPI_DEBUG enabled by default.
Can we get smarter about this -- say by checking against
the processors that we expect to be present?

thanks,
-Len

> http://bugzilla.kernel.org/show_bug.cgi?id=8630
> 
> Signed-off-by: Zhao Yakui  <yakui.zhao@intel.com>
> ---
>  drivers/acpi/processor_core.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.23-rc7/drivers/acpi/processor_core.c
> ===================================================================
> --- linux-2.6.23-rc7.orig/drivers/acpi/processor_core.c
> +++ linux-2.6.23-rc7/drivers/acpi/processor_core.c
> @@ -813,7 +813,9 @@ static int is_processor_present(acpi_han
>  
>  	status = acpi_evaluate_integer(handle, "_STA", NULL, &sta);
>  	if (ACPI_FAILURE(status) || !(sta & ACPI_STA_DEVICE_PRESENT)) {
> -		ACPI_EXCEPTION((AE_INFO, status, "Processor Device is not present"));
> +		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +			"%s :Processor Device is not present",
> +			acpi_format_exception(status)));
>  		return 0;
>  	}
>  	return 1;
> 

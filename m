From: yakui_zhao <yakui.zhao@intel.com>
Subject: Re: [PATCH] ACPI: get_throttling_state() cannot be larger
	state_count
Date: Thu, 12 Feb 2009 10:35:26 +0800
Message-ID: <1234406126.3652.61.camel@localhost.localdomain>
References: <49932BF4.2010005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17705 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756561AbZBLCXt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 11 Feb 2009 21:23:49 -0500
In-Reply-To: <49932BF4.2010005@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Roel Kluin <roel.kluin@gmail.com>
Cc: "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On Thu, 2009-02-12 at 03:50 +0800, Roel Kluin wrote:
   In fact the function of acpi_get_throttling_state will be used only
when the _PTC(throttling object) exists. The status argument will be
compared with the _TSS package. In theory it will be found in the _TSS
package and the corresponding T-state will be obtained. 

But from the program logic it will be OK.

acked-by: <yakui.zhao@intel.com>

Thanks.    
> With for(i = 0; i < n; i++) { ... } i reaches n.
> 
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> diff --git a/drivers/acpi/processor_throttling.c b/drivers/acpi/processor_throttling.c
> index d278381..6feb9ab 100644
> --- a/drivers/acpi/processor_throttling.c
> +++ b/drivers/acpi/processor_throttling.c
> @@ -785,7 +785,7 @@ static int acpi_get_throttling_state(struct acpi_processor *pr,
>  		if (tx->control == value)
>  			break;
>  	}
> -	if (i > pr->throttling.state_count)
> +	if (i >= pr->throttling.state_count)
>  		i = -1;
>  	return i;
>  }
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


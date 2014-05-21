From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 6/7 v3] trace, eMCA: Add a knob to adjust where to save
 event log
Date: Wed, 21 May 2014 13:06:31 +0200
Message-ID: <20140521110630.GG21205@pd.tnic>
References: <1400142646-10127-1-git-send-email-gong.chen@linux.intel.com>
 <1400142646-10127-7-git-send-email-gong.chen@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:51544 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751366AbaEULGx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 May 2014 07:06:53 -0400
Content-Disposition: inline
In-Reply-To: <1400142646-10127-7-git-send-email-gong.chen@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Chen, Gong" <gong.chen@linux.intel.com>
Cc: tony.luck@intel.com, m.chehab@samsung.com, linux-acpi@vger.kernel.org

On Thu, May 15, 2014 at 04:30:45AM -0400, Chen, Gong wrote:
> To avoid saving two copies for one H/W event, add a new
> file under debugfs to control how to save event log.
> Once this file is opened, the perf/trace will be used,
> in the meanwhile, kernel will stop to print event log
> to the console. On the other hand, if this file is closed,
> kernel will print event log to the console again.
> 
> v3 -> v2: minor adjustment to make flow cleanly.
> v2 -> v1: move counter operation from *read* to *open*.
> 
> Signed-off-by: Chen, Gong <gong.chen@linux.intel.com>
> ---
>  drivers/acpi/acpi_extlog.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_extlog.c b/drivers/acpi/acpi_extlog.c
> index b1dcb5b..c1dab37 100644
> --- a/drivers/acpi/acpi_extlog.c
> +++ b/drivers/acpi/acpi_extlog.c
> @@ -12,6 +12,7 @@
>  #include <linux/cper.h>
>  #include <linux/ratelimit.h>
>  #include <linux/edac.h>
> +#include <linux/ras.h>
>  #include <asm/cpu.h>
>  #include <asm/mce.h>
>  
> @@ -185,7 +186,11 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  	estatus->block_status = 0;
>  
>  	tmp = (struct acpi_generic_status *)elog_buf;
> -	print_extlog_rcd(NULL, tmp, cpu);
> +
> +	if (ras_userspace_consumers() == 0) {

	if (!ras_userspace_consumers())

> +		print_extlog_rcd(NULL, tmp, cpu);
> +		goto out;
> +	}
>  
>  	/* log event via trace */
>  	err_count++;
> @@ -202,6 +207,7 @@ static int extlog_print(struct notifier_block *nb, unsigned long val,
>  					  gdata->error_severity, mem_err);
>  	}
>  
> +out:
>  	return NOTIFY_STOP;
>  }
>  
> -- 
> 2.0.0.rc0
> 
> 

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--

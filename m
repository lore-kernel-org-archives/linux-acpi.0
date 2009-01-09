From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/6] acpi: check _PSS invalidation when BIOS report _PSS
 with 0x80000000
Date: Fri, 09 Jan 2009 16:01:47 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0901091559120.16697@localhost.localdomain>
References: <200901092017.n09KH9OP014905@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:58205 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756484AbZAIVBw (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Jan 2009 16:01:52 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0KD800MCL2F19E73@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 09 Jan 2009 15:01:50 -0600 (CST)
In-reply-to: <200901092017.n09KH9OP014905@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, youquan.song@intel.com, venkatesh.pallipadi@intel.com

I recall nacking this one some time ago.

ACPI_PROCESSOR_PSS_INVALID is fantasy.
Can't we be smarter about detecting and handling
BIOS bugs, and not pretend that the specification
tells us that this particular bit pattern is invalid (it does not)
What happens when the next BIOS gives us 0x40000000?

thanks
Len Brown, Intel Open Source Technology Center

On Fri, 9 Jan 2009, akpm@linux-foundation.org wrote:

> From: Youquan, Song <youquan.song@intel.com>
> 
> When cpu frequencey scaling is disabled, some BIOSes report _PSS with all
> 0x80000000.  If the kernel treats this case as valid, the kernel will boot
> crash when load cpufreq govenors.
> 
> So in order to cover more buggy BIOSs, the patch just check _PSS core
> frequency invalidation.
> 
> Signed-off-by: Youquan, Song <youquan.song@intel.com>
> Signed-off-by: Pallipadi, Venkatesh <venkatesh.pallipadi@intel.com>
> Cc: Len Brown <lenb@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  drivers/acpi/processor_perflib.c |    9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff -puN drivers/acpi/processor_perflib.c~acpi-check-_pss-invalidation-when-bios-report-_pss-with-all-0x80000000 drivers/acpi/processor_perflib.c
> --- a/drivers/acpi/processor_perflib.c~acpi-check-_pss-invalidation-when-bios-report-_pss-with-all-0x80000000
> +++ a/drivers/acpi/processor_perflib.c
> @@ -50,6 +50,7 @@
>  #define ACPI_PROCESSOR_CLASS		"processor"
>  #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
>  #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
> +#define ACPI_PROCESSOR_PSS_INVALID	0x80000000
>  ACPI_MODULE_NAME("processor_perflib");
>  
>  static DEFINE_MUTEX(performance_mutex);
> @@ -324,6 +325,14 @@ static int acpi_processor_get_performanc
>  			kfree(pr->performance->states);
>  			goto end;
>  		}
> +
> +		if (px->core_frequency == ACPI_PROCESSOR_PSS_INVALID) {
> +			printk(KERN_ERR PREFIX
> +				    "P-states disabled in the BIOS\n");
> +			result = -EFAULT;
> +			kfree(pr->performance->states);
> +			goto end;
> +		}
>  	}
>  
>        end:
> _
> 

From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 1/2] acpi: check _PSS invalidation when BIOS report _PSS
 with 0x80000000
Date: Fri, 12 Dec 2008 01:22:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812120121370.27968@localhost.localdomain>
References: <200812111700.mBBH0BQt017390@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:40524 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751933AbYLLGXA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 12 Dec 2008 01:23:00 -0500
Received: from localhost.localdomain ([96.237.168.40])
 by vms173007.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0KBR004GW30AZ8U1@vms173007.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 12 Dec 2008 00:21:47 -0600 (CST)
In-reply-to: <200812111700.mBBH0BQt017390@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, youquan.song@intel.com, venkatesh.pallipadi@intel.com

Lets not apply this to 2.6.28, as it doesn't seem urgent and I'm not
yet convinced this is the best workaround.  If I'm wrong on both
of those counts, we can apply it to stable later.

-- 
Len Brown, Intel Open Source Technology Center

On Thu, 11 Dec 2008, akpm@linux-foundation.org wrote:

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

From: Len Brown <lenb@kernel.org>
Subject: Re: [patch 2/8] acpi: check _PSS invalidation when BIOS report _PSS
 with 0x80000000
Date: Sun, 15 Mar 2009 23:22:37 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903152321430.30317@localhost.localdomain>
References: <200903041955.n24JtPSM027990@imap1.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:23451 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZCPDXC (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 15 Mar 2009 23:23:02 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms173003.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KGK006R4XDR3KC7@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Sun, 15 Mar 2009 22:22:39 -0500 (CDT)
In-reply-to: <200903041955.n24JtPSM027990@imap1.linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: akpm@linux-foundation.org
Cc: linux-acpi@vger.kernel.org, youquan.song@intel.com, venkatesh.pallipadi@intel.com

NAK -- per previous discussion on the list.

This patch is not the right way to address this issue,
which is reported here, BTW:

https://bugzilla.redhat.com/show_bug.cgi?id=467941
--
Len Brown, Intel Open Source Technology Center

On Wed, 4 Mar 2009, akpm@linux-foundation.org wrote:

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
> @@ -42,6 +42,7 @@
>  #define ACPI_PROCESSOR_CLASS		"processor"
>  #define ACPI_PROCESSOR_FILE_PERFORMANCE	"performance"
>  #define _COMPONENT		ACPI_PROCESSOR_COMPONENT
> +#define ACPI_PROCESSOR_PSS_INVALID	0x80000000
>  ACPI_MODULE_NAME("processor_perflib");
>  
>  static DEFINE_MUTEX(performance_mutex);
> @@ -316,6 +317,14 @@ static int acpi_processor_get_performanc
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

From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 2/8] ACPI: cpufreq: remove dupilcated #include
Date: Tue, 07 Apr 2009 01:40:39 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0904070140150.5698@localhost.localdomain>
References: <1239009406-3048-1-git-send-email-weiyi.huang@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:37275 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751577AbZDGFkm (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 7 Apr 2009 01:40:42 -0400
In-reply-to: <1239009406-3048-1-git-send-email-weiyi.huang@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Weiyi <weiyi.huang@gmail.com>
Cc: cpufreq@vger.kernel.org, linux-acpi@vger.kernel.org

applied

(and cpufreq@vger.kernel.org cc'd)

thanks,
Len Brown, Intel Open Source Technology Center

On Mon, 6 Apr 2009, Huang Weiyi wrote:

> Remove dupilicated #include in arch/x86/kernel/cpu/cpufreq/longhaul.c.
> 
> Signed-off-by: Huang Weiyi <weiyi.huang@gmail.com>
> ---
>  arch/x86/kernel/cpu/cpufreq/longhaul.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/cpufreq/longhaul.c b/arch/x86/kernel/cpu/cpufreq/longhaul.c
> index 0bd48e6..ce2ed3e 100644
> --- a/arch/x86/kernel/cpu/cpufreq/longhaul.c
> +++ b/arch/x86/kernel/cpu/cpufreq/longhaul.c
> @@ -33,7 +33,6 @@
>  #include <linux/timex.h>
>  #include <linux/io.h>
>  #include <linux/acpi.h>
> -#include <linux/kernel.h>
>  
>  #include <asm/msr.h>
>  #include <acpi/processor.h>
> -- 
> 1.6.1.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

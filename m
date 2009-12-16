From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH]acpi cpuidle: Fix kernel oops when tickless is not enabled
Date: Wed, 16 Dec 2009 04:32:48 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0912160431280.30935@localhost.localdomain>
References: <20091216141721.GA27614@youquan-linux.bj.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173015pub.verizon.net ([206.46.173.15]:50992 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754408AbZLPJcu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Dec 2009 04:32:50 -0500
Received: from localhost.localdomain ([74.104.151.18])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 6.3-7.04 (built Sep 26 2008; 32bit))
 with ESMTPA id <0KUQ00GW0NUPMKTR@vms173015.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Wed, 16 Dec 2009 03:32:50 -0600 (CST)
In-reply-to: <20091216141721.GA27614@youquan-linux.bj.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Youquan,Song" <youquan.song@linux.intel.com>
Cc: venkatesh.pallipadi@intel.com, kent.liu@intel.com, chaohong.guo@intel.com, jane.lv@intel.com, youquan.song@intel.com, linux-acpi@vger.kernel.org

Um, the purpose of the ladder governor is to handle the legacy tickfull
case, and this patch defeats that.

Can you share the actual failure?

thanks,
Len Brown, Intel Open Source Technology Center

On Wed, 16 Dec 2009, Youquan,Song wrote:

> Current kernel, if tickless is disabled,cpuidle governor ladder is built in,
>  the kernel will boot oops on Boxboro-EX. 
> 
> After check in driver/cpuidle/Kconfig, menu governor built in kernel depends 
> on tickless,but ladder governor has no such dependency.
> 
> This patch add depnencey for ladder governor, so when tickless is disabled,
>  ladder governor will not be built in.
> 
> This is workround patch and the complete fix need be done at tickless. 
> 
> Signed-off-by: Youquan, Song <youquan.song@intel.com>
> ---
> 
> diff --git a/drivers/cpuidle/Kconfig b/drivers/cpuidle/Kconfig
> index 7dbc4a8..78d6d74 100644
> --- a/drivers/cpuidle/Kconfig
> +++ b/drivers/cpuidle/Kconfig
> @@ -11,7 +11,7 @@ config CPU_IDLE
>  
>  config CPU_IDLE_GOV_LADDER
>  	bool
> -	depends on CPU_IDLE
> +	depends on CPU_IDLE && NO_HZ
>  	default y
>  
>  config CPU_IDLE_GOV_MENU
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

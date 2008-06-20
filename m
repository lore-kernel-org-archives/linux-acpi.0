From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH1/4] ACPI : Disable the C2C3_FFH access mode if MWAIT is
 unsupported
Date: Fri, 20 Jun 2008 02:32:52 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806200232470.22284@localhost.localdomain>
References: <1213684799.19901.9.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173003pub.verizon.net ([206.46.173.3]:50924 "EHLO
	vms173003pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbYFTGdR (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 20 Jun 2008 02:33:17 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms173003.mailsrvcs.net
 (Sun Java System Messaging Server 6.2-6.01 (built Apr  3 2006))
 with ESMTPA id <0K2R00ARH0UW9ZI2@vms173003.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Fri, 20 Jun 2008 01:32:57 -0500 (CDT)
In-reply-to: <1213684799.19901.9.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org


applied.

thanks,
-Len

On Tue, 17 Jun 2008, Zhao Yakui wrote:

> Subject: ACPI: Disable the C2C3_FFH access mode if MWAIT is unsupported
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
>    After the following commit is merged, C2C3_FFH mode will be enabled and 
> passed into the _PDC object. If the BIOS thinks that MWAIT is supported and
> the CPU doesn't support MWAIT, the incorrect power states will be returned 
> by the _CST object. So it will be better to disable C2C3_FFH access mode 
> if MWAIT is unsupported.
>  
> commit 991528d7348667924176f3e29addea0675298944
> Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Mon Sep 25 16:28:13 2006 -0700
> 
>     ACPI: Processor native C-states using MWAIT
> 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> ---
>  arch/x86/kernel/acpi/processor.c |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> Index: linux-2.6/arch/x86/kernel/acpi/processor.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/acpi/processor.c
> +++ linux-2.6/arch/x86/kernel/acpi/processor.c
> @@ -61,6 +61,12 @@ static void init_intel_pdc(struct acpi_p
>  	if (cpu_has(c, X86_FEATURE_ACPI))
>  		buf[2] |= ACPI_PDC_T_FFH;
>  
> +	/*
> +	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled
> +	 */
> +	if (!cpu_has(c, X86_FEATURE_MWAIT))
> +		buf[2] &= ~(ACPI_PDC_C_C2C3_FFH);
> +
>  	obj->type = ACPI_TYPE_BUFFER;
>  	obj->buffer.length = 12;
>  	obj->buffer.pointer = (u8 *) buf;
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

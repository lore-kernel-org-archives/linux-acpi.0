From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI : Disable the C2C3_FFH access mode if MWAIT is
 unsupported
Date: Thu, 05 Jun 2008 01:35:41 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0806050130220.4914@localhost.localdomain>
References: <1212637455.10730.8.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms046pub.verizon.net ([206.46.252.46]:64008 "EHLO
	vms046pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751528AbYFEFfx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Jun 2008 01:35:53 -0400
Received: from localhost.localdomain ([72.93.254.151])
 by vms046.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K1Z00K4I67JXFIA@vms046.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 05 Jun 2008 00:35:43 -0500 (CDT)
In-reply-to: <1212637455.10730.8.camel@yakui_zhao.sh.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org



On Thu, 5 Jun 2008, Zhao Yakui wrote:

> Subject: ACPI: Disable the C2C3_FFH access mode if MWAIT is unsupported
> From: Zhao Yakui <yakui.zhao@intel.com>
> 
>    After the following commit is merged, C2C3_FFH mode will be enabled and 
> passed into the _PDC object. But because MWAIT is unsupported on some laptops, 
> the different power states will be returned by the _CST object.
> Maybe it will be better to disable C2C3_FFH access mode if MWAIT is unsupported.
>  
> commit 991528d7348667924176f3e29addea0675298944
> Author: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
> Date:   Mon Sep 25 16:28:13 2006 -0700
> 
>     ACPI: Processor native C-states using MWAIT
 
> http://bugzilla.kernel.org/show_bug.cgi?id=10807

Interesting bug report. 
Unfortunately, it is a BIOS bug that the BIOS exposes C3
when the OS doesn't support MWAIT, but neglects to expose
C3 when the OS does support MWAIT. 

This patch will have no effect on the system in the bug report.
Indeed, it would benefit only a system with a BIOS that thinks
it has MWAIT support but a CPU that thinks it doesn't...

probably good hygine to do this, but I don't think it will
help anything.

I think the fix for the machine in bug 10807 is to
have a bootparam that disables mwait support,
say "idle=!mwait" and a DMI entry for that box
that invokes it to work around the BIOS bug.

thanks,
-Len
 
> Signed-off-by: Zhao Yakui <yakui.zhao@intel.com>
> Signed-off-by: Li Shaohua <shaohua.li@intel.com>
> 
> ---
>  arch/x86/kernel/acpi/processor.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> Index: linux-2.6/arch/x86/kernel/acpi/processor.c
> ===================================================================
> --- linux-2.6.orig/arch/x86/kernel/acpi/processor.c
> +++ linux-2.6/arch/x86/kernel/acpi/processor.c
> @@ -43,6 +43,11 @@ static void init_intel_pdc(struct acpi_p
>  	buf[0] = ACPI_PDC_REVISION_ID;
>  	buf[1] = 1;
>  	buf[2] = ACPI_PDC_C_CAPABILITY_SMP;
> +	/*
> +	 * If mwait/monitor is unsupported, C2/C3_FFH will be disabled.
> +	 */
> +	if (!cpu_has(c, X86_FEATURE_MWAIT))
> +		buf[2] &= ~ACPI_PDC_C_C2C3_FFH;
>  
>  	/*
>  	 * The default of PDC_SMP_T_SWCOORD bit is set for intel x86 cpu so
> 
> 




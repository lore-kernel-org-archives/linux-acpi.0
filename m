From: Li Shaohua <shaohua.li@intel.com>
Subject: Re: [PATCH 4/6]cpu state clean after hot remove
Date: Thu, 21 Apr 2005 11:36:26 +0800
Message-ID: <1114054585.26501.4.camel@sli10-desk.sh.intel.com>
References: <1113283859.27646.430.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261203AbVDUDj1@vger.kernel.org>
In-Reply-To: <1113283859.27646.430.camel@sli10-desk.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: ACPI-DEV <acpi-devel@lists.sourceforge.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>, Zwane Mwaikambo <zwane@linuxpower.ca>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 2005-04-12 at 13:31, Li Shaohua wrote:
> @@ -1052,7 +1086,7 @@ static void __init smp_boot_cpus(unsigne
>  		if (max_cpus <= cpucount+1)
>  			continue;
>  
> -		if (do_boot_cpu(apicid))
> +		if ((cpu = alloc_cpu_id() > 0) && do_boot_cpu(apicid, cpu))
>  			printk("CPU #%d not responding - cannot use it.\n",
>  								apicid);
>  		else
Oops, there is a typo in the patch. Andrew, please apply below patch
against above patch. Sorry for the inconvenience.

Thanks,
Shaohua
---

 linux-2.6.11-root/arch/i386/kernel/smpboot.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN arch/i386/kernel/smpboot.c~smpboot arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~smpboot	2005-04-21 11:27:53.913041424 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-21 11:28:44.103411328 +0800
@@ -1166,7 +1166,7 @@ static void __init smp_boot_cpus(unsigne
 		if (max_cpus <= cpucount+1)
 			continue;
 
-		if ((cpu = alloc_cpu_id() > 0) && do_boot_cpu(apicid, cpu))
+		if (((cpu = alloc_cpu_id()) <= 0) || do_boot_cpu(apicid, cpu))
 			printk("CPU #%d not responding - cannot use it.\n",
 								apicid);
 		else
_

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: acpi-cpufreq oddness
Date: Fri, 18 Aug 2006 13:45:17 -0700
Message-ID: <20060818134517.A22660@unix-os.sc.intel.com>
References: <EB12A50964762B4D8111D55B764A84547771E4@scsmsx413.amr.corp.intel.com> <20060818190454.GB18750@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.21]:51298 "EHLO
	orsmga101.jf.intel.com") by vger.kernel.org with ESMTP
	id S964918AbWHRU5u (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Aug 2006 16:57:50 -0400
Content-Disposition: inline
In-Reply-To: <20060818190454.GB18750@redhat.com>; from davej@redhat.com on Fri, Aug 18, 2006 at 03:04:54PM -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Dave Jones <davej@redhat.com>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>, "Brown, Len" <len.brown@intel.com>, linux-acpi@vger.kernel.org, cpufreq@lists.linux.org.uk

On Fri, Aug 18, 2006 at 03:04:54PM -0400, Dave Jones wrote:
> On Fri, Aug 18, 2006 at 11:59:26AM -0700, Pallipadi, Venkatesh wrote:
> 
>  > >I don't have handy access to a git tree at the moment, and 
>  > >I've forgotten
>  > >the history of the recent changes here.
>  > >
>  > >Alexey/Len, any ideas whats going on here?
>  > >
>  > >		Dave
>  > >
>  > 
>  > Does the error say "Invalid _PSD data" or something similar. Seems to be
>  > a side-effect of earlier software co-ordination patchset. If this is the
>  > error you are seeing, I will send in a quick patch to fix it.
> 
> No, there's nothing in dmesg.
> This is from the perror() in modprobe printing out the human-readable form
> of -EINVAL
> 
> An strace shows ..
> 
> init_module(0x8287a88, 16244, "")       = -1 EINVAL (Invalid argument)
> write(2, "FATAL: Error inserting acpi_cpuf"..., 139FATAL: Error inserting acpi_cpufreq (/lib/modules/2.6.17-1.2571.fc6/kernel/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.ko): Invalid argument
> 
> 
> 		Dave
> 
> 
> -- 
> http://www.codemonkey.org.uk

EINVAL is actually coming from early_init call and the return value of that
call should be ignored. Attached patch resolves the issue.

Thanks,
Venki


Ignore the return value of early_init_acpi(), as it can give false error
messages. If there is something really wrong, then register_driver will fail
cleanly with EINVAL later.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.18-rc4/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ linux-2.6.18-rc4/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -567,16 +567,11 @@ static struct cpufreq_driver acpi_cpufre
 static int __init
 acpi_cpufreq_init (void)
 {
-	int                     result = 0;
-
 	dprintk("acpi_cpufreq_init\n");
 
-	result = acpi_cpufreq_early_init_acpi();
+	acpi_cpufreq_early_init_acpi();
 
-	if (!result)
- 		result = cpufreq_register_driver(&acpi_cpufreq_driver);
-	
-	return (result);
+ 	return cpufreq_register_driver(&acpi_cpufreq_driver);
 }
 
 

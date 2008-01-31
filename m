From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: RE: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Thu, 31 Jan 2008 12:11:01 -0800
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEE72037E@orsmsx423.amr.corp.intel.com>
References: <200801301116.44902.rjw@sisk.pl><924EFEDD5F540B4284297C4DC59F3DEE7202A0@orsmsx423.amr.corp.intel.com><87tzkt96cn.fsf@paris.hilman.org><924EFEDD5F540B4284297C4DC59F3DEE7202F5@orsmsx423.amr.corp.intel.com> <87fxwd92wl.fsf@paris.hilman.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:25668 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756136AbYAaUNs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 15:13:48 -0500
Content-class: urn:content-classes:message
In-Reply-To: <87fxwd92wl.fsf@paris.hilman.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Kevin Hilman <khilman@mvista.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>


Len,

Please include this along with your other cpuidle patches for 2.6.25.

Thanks,
Venki

Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

>-----Original Message-----
>From: Kevin Hilman [mailto:khilman@mvista.com] 
>Sent: Thursday, January 31, 2008 12:06 PM
>To: Pallipadi, Venkatesh
>Cc: Len Brown; ACPI Devel Maling List
>Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
>
>[Updated patch pased on suggestions from Venkatesh.]
>
>Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
>SMP-only, and gives error on non supported CPU.
>
>Signed-off-by: Kevin Hilman <khilman@mvista.com>
>
>diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>index d2fabe7..762d878 100644
>--- a/drivers/cpuidle/cpuidle.c
>+++ b/drivers/cpuidle/cpuidle.c
>@@ -18,6 +18,14 @@
> 
> #include "cpuidle.h"
> 
>+#if !defined(CONFIG_SMP)
>+#define cpuidle_kick_cpus()	do { } while (0)
>+#elif defined(CONFIG_X86)
>+#define cpuidle_kick_cpus()	cpu_idle_wait()
>+#else
>+#error "Arch needs cpu_idle_wait() equivalent here"
>+#endif
>+
> DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> 
> DEFINE_MUTEX(cpuidle_lock);
>@@ -82,7 +90,7 @@ void cpuidle_uninstall_idle_handler(void)
> {
> 	if (enabled_devices && (pm_idle != pm_idle_old)) {
> 		pm_idle = pm_idle_old;
>-		cpu_idle_wait();
>+		cpuidle_kick_cpus();
> 	}
> }
> 
>

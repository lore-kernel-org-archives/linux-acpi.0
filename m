From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Thu, 31 Jan 2008 12:05:30 -0800
Message-ID: <87fxwd92wl.fsf@paris.hilman.org>
References: <200801301116.44902.rjw@sisk.pl>
	<924EFEDD5F540B4284297C4DC59F3DEE7202A0@orsmsx423.amr.corp.intel.com>
	<87tzkt96cn.fsf@paris.hilman.org>
	<924EFEDD5F540B4284297C4DC59F3DEE7202F5@orsmsx423.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:45989 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbYAaUFb (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 15:05:31 -0500
In-Reply-To: <924EFEDD5F540B4284297C4DC59F3DEE7202F5@orsmsx423.amr.corp.intel.com> (Venkatesh Pallipadi's message of "Thu\, 31 Jan 2008 11\:15\:29 -0800")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

[Updated patch pased on suggestions from Venkatesh.]

Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
SMP-only, and gives error on non supported CPU.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d2fabe7..762d878 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -18,6 +18,14 @@
 
 #include "cpuidle.h"
 
+#if !defined(CONFIG_SMP)
+#define cpuidle_kick_cpus()	do { } while (0)
+#elif defined(CONFIG_X86)
+#define cpuidle_kick_cpus()	cpu_idle_wait()
+#else
+#error "Arch needs cpu_idle_wait() equivalent here"
+#endif
+
 DEFINE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
 
 DEFINE_MUTEX(cpuidle_lock);
@@ -82,7 +90,7 @@ void cpuidle_uninstall_idle_handler(void)
 {
 	if (enabled_devices && (pm_idle != pm_idle_old)) {
 		pm_idle = pm_idle_old;
-		cpu_idle_wait();
+		cpuidle_kick_cpus();
 	}
 }
 

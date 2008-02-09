From: Venki Pallipadi <venkatesh.pallipadi@intel.com>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Fri, 8 Feb 2008 17:05:44 -0800
Message-ID: <20080209010544.GA19576@linux-os.sc.intel.com>
References: <200801301116.44902.rjw@sisk.pl> <871w7x5utp.fsf@paris.hilman.org> <200802010240.36693.rjw@sisk.pl> <200801312240.47405.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23813 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754407AbYBIBHU (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 8 Feb 2008 20:07:20 -0500
Content-Disposition: inline
In-Reply-To: <200801312240.47405.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Kevin Hilman <khilman@mvista.com>, "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

On Thu, Jan 31, 2008 at 10:40:46PM -0500, Len Brown wrote:
> Applied w/ Rafael's comment fixes included.
> 
> thanks,
> -Len

Len pointed out that the last posted version of this patch gave compile error
on IA64. So, here goes yet another rewrite of the patch.

[PATCH] CPU_IDLE: Compile fix for non x86 arch
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Convert cpu_idle_wait() to cpuidle_kick_cpus() which is
SMP-only, and gives error on non supported CPU.

Changes from last patch sent by Kevin:
Moved the definition of kick_cpus back to cpuidle.c from cpuidle.h:
* Having it in .h gives #error on archs which includes the header file without
  actually having CPU_IDLE configured. To make it work in .h, we need one more
  #ifdef around that code which makes it messy.
* Also, the function is only called from one file. So, it can be in declared
  statically in .c rather than making it available to everyone who includes
  the .h file.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Kevin Hilman <khilman@mvista.com>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
Index: linux-2.6.25-rc/arch/x86/Kconfig
===================================================================
--- linux-2.6.25-rc.orig/arch/x86/Kconfig
+++ linux-2.6.25-rc/arch/x86/Kconfig
@@ -105,6 +105,9 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	def_bool n
 
+config ARCH_HAS_CPU_IDLE_WAIT
+	def_bool y
+
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
Index: linux-2.6.25-rc/drivers/cpuidle/cpuidle.c
===================================================================
--- linux-2.6.25-rc.orig/drivers/cpuidle/cpuidle.c
+++ linux-2.6.25-rc/drivers/cpuidle/cpuidle.c
@@ -27,6 +27,17 @@ static void (*pm_idle_old)(void);
 
 static int enabled_devices;
 
+#if defined(CONFIG_ARCH_HAS_CPU_IDLE_WAIT)
+static void cpuidle_kick_cpus(void)
+{
+	cpu_idle_wait();
+}
+#elif defined(CONFIG_SMP)
+# error "Arch needs cpu_idle_wait() equivalent here"
+#else /* !CONFIG_ARCH_HAS_CPU_IDLE_WAIT && !CONFIG_SMP */
+static void cpuidle_kick_cpus(void) {}
+#endif
+
 /**
  * cpuidle_idle_call - the main idle loop
  *
@@ -83,7 +94,7 @@ void cpuidle_uninstall_idle_handler(void
 {
 	if (enabled_devices && (pm_idle != pm_idle_old)) {
 		pm_idle = pm_idle_old;
-		cpu_idle_wait();
+		cpuidle_kick_cpus();
 	}
 }
 

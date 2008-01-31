From: Kevin Hilman <khilman@mvista.com>
Subject: Re: [linux-pm] [PATCH] CPUidle: compile fix for non-x86
Date: Thu, 31 Jan 2008 13:33:58 -0800
Message-ID: <87myql7k8p.fsf@paris.hilman.org>
References: <200801301116.44902.rjw@sisk.pl> <200801312126.06816.rjw@sisk.pl>
	<87zlul7mgz.fsf@paris.hilman.org> <200801312203.16737.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.158]:23528 "EHLO
	gateway-1237.mvista.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757582AbYAaVeA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 31 Jan 2008 16:34:00 -0500
In-Reply-To: <200801312203.16737.rjw@sisk.pl> (Rafael J. Wysocki's message of "Thu\, 31 Jan 2008 22\:03\:16 +0100")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>

[ Another update based on Rafael's suggestions. ]

Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
SMP-only, and gives error on non supported CPU.

Signed-off-by: Kevin Hilman <khilman@mvista.com>

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 80b7ba4..a3e8ef4 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -105,6 +105,9 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	def_bool n
 
+config ARCH_HAS_CPU_IDLE_WAIT
+	def_bool y
+
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d2fabe7..794962d 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -82,7 +82,7 @@ void cpuidle_uninstall_idle_handler(void)
 {
 	if (enabled_devices && (pm_idle != pm_idle_old)) {
 		pm_idle = pm_idle_old;
-		cpu_idle_wait();
+		cpuidle_kick_cpus();
 	}
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index c4e0016..23f063a 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -72,6 +72,19 @@ cpuidle_set_statedata(struct cpuidle_state *state, void *data)
 	state->driver_data = data;
 }
 
+#ifdef CONFIG_SMP
+#ifdef ARCH_HAS_CPU_IDLE_WAIT
+static inline void cpuidle_kick_cpus(void)
+{
+	cpu_idle_wait()
+}
+#else /* !ARCH_HAS_CPU_IDLE_WAIT */
+#error "Arch needs cpu_idle_wait() equivalent here"
+#endif /* !ARCH_HAS_CPU_IDLE_WAIT */
+#else /* !CONFIG_SMP */
+static inline void cpuidle_kick_cpus(void) {}
+#endif /* !CONFIG_SMP */
+
 struct cpuidle_state_kobj {
 	struct cpuidle_state *state;
 	struct completion kobj_unregister;

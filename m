From: Len Brown <lenb@kernel.org>
Subject: [PATCH 031/112] cpuidle: build fix for non-x86
Date: Thu,  7 Feb 2008 04:33:53 -0500
Message-ID: <f757397097d0713c949af76dccabb65a2785782e.1202376824.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:42392 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753724AbYBGJf6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:35:58 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Kevin Hilman <khilman@mvista.com>, Len Brown <len.brown@intel.com>

From: Kevin Hilman <khilman@mvista.com>

Convert cpu_idle_wait() to cpuidle_kick_cpus() macro which is
SMP-only, and gives error on non supported CPU.

Signed-off-by: Kevin Hilman <khilman@mvista.com>
Acked-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/Kconfig          |    3 +++
 drivers/cpuidle/cpuidle.c |    2 +-
 include/linux/cpuidle.h   |   13 +++++++++++++
 3 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 368864d..37d1297 100644
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
index 16a5154..cb95f5a 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -72,6 +72,19 @@ cpuidle_set_statedata(struct cpuidle_state *state, void *data)
 	state->driver_data = data;
 }
 
+#ifdef CONFIG_SMP
+#ifdef CONFIG_ARCH_HAS_CPU_IDLE_WAIT
+static inline void cpuidle_kick_cpus(void)
+{
+	cpu_idle_wait();
+}
+#else /* !CONFIG_ARCH_HAS_CPU_IDLE_WAIT */
+#error "Arch needs cpu_idle_wait() equivalent here"
+#endif /* !CONFIG_ARCH_HAS_CPU_IDLE_WAIT */
+#else /* !CONFIG_SMP */
+static inline void cpuidle_kick_cpus(void) {}
+#endif /* !CONFIG_SMP */
+
 struct cpuidle_state_kobj {
 	struct cpuidle_state *state;
 	struct completion kobj_unregister;
-- 
1.5.4.23.gef5b9


From: Len Brown <lenb@kernel.org>
Subject: [PATCH 111/112] Revert "cpuidle: build fix for non-x86"
Date: Thu,  7 Feb 2008 04:35:13 -0500
Message-ID: <9b7131542178f5f948e4bb6bea6e1c545e697b06.1202376825.git.len.brown@intel.com>
References: <1202376914-21030-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga10.intel.com ([192.55.52.92]:44102 "EHLO
	fmsmga102.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758616AbYBGJhE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Feb 2008 04:37:04 -0500
In-Reply-To: <1202376914-21030-1-git-send-email-lenb@kernel.org>
In-Reply-To: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
References: <4169c45f179e285feac6bcf25f4bd0db6b109bab.1202376823.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

This reverts commit f757397097d0713c949af76dccabb65a2785782e.
which ironically broke the ia64 build
---
 arch/x86/Kconfig          |    3 ---
 drivers/cpuidle/cpuidle.c |    2 +-
 include/linux/cpuidle.h   |   13 -------------
 3 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3954ae9..fd42650 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -98,9 +98,6 @@ config ARCH_HAS_ILOG2_U32
 config ARCH_HAS_ILOG2_U64
 	def_bool n
 
-config ARCH_HAS_CPU_IDLE_WAIT
-	def_bool y
-
 config GENERIC_CALIBRATE_DELAY
 	def_bool y
 
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d868d73..2c4b2d4 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -83,7 +83,7 @@ void cpuidle_uninstall_idle_handler(void)
 {
 	if (enabled_devices && (pm_idle != pm_idle_old)) {
 		pm_idle = pm_idle_old;
-		cpuidle_kick_cpus();
+		cpu_idle_wait();
 	}
 }
 
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index c8eb8c7..385d45b 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -73,19 +73,6 @@ cpuidle_set_statedata(struct cpuidle_state *state, void *data)
 	state->driver_data = data;
 }
 
-#ifdef CONFIG_SMP
-#ifdef CONFIG_ARCH_HAS_CPU_IDLE_WAIT
-static inline void cpuidle_kick_cpus(void)
-{
-	cpu_idle_wait();
-}
-#else /* !CONFIG_ARCH_HAS_CPU_IDLE_WAIT */
-#error "Arch needs cpu_idle_wait() equivalent here"
-#endif /* !CONFIG_ARCH_HAS_CPU_IDLE_WAIT */
-#else /* !CONFIG_SMP */
-static inline void cpuidle_kick_cpus(void) {}
-#endif /* !CONFIG_SMP */
-
 struct cpuidle_state_kobj {
 	struct cpuidle_state *state;
 	struct completion kobj_unregister;
-- 
1.5.4.23.gef5b9


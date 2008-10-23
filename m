From: Len Brown <lenb@kernel.org>
Subject: [PATCH 053/122] cpuidle: upon BIOS bug,
 default to default_idle rather than polling
Date: Thu, 23 Oct 2008 02:38:27 -0400
Message-ID: <89cedfefca1d446ee2598fd3bcbb23ee3802e26a.1224743917.git.len.brown@intel.com>
References: <1224743976-31033-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms042pub.verizon.net ([206.46.252.42]:51267 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754137AbYJWGkK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 23 Oct 2008 02:40:10 -0400
Received: from localhost.localdomain ([96.237.168.40])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0K9600GO4IIP6G05@vms042.mailsrvcs.net> for
 linux-acpi@vger.kernel.org; Thu, 23 Oct 2008 01:40:01 -0500 (CDT)
In-reply-to: <1224743976-31033-1-git-send-email-lenb@kernel.org>
In-reply-to: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
References: <a0ad05c75aa362c91f4d9cd91ff375a739574dd8.1224743916.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

http://bugzilla.kernel.org/show_bug.cgi?id=11345

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/Kconfig          |    3 +++
 drivers/cpuidle/cpuidle.c |    4 ++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index ed92864..f8caf04 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -123,6 +123,9 @@ config GENERIC_TIME_VSYSCALL
 config ARCH_HAS_CPU_RELAX
 	def_bool y
 
+config ARCH_HAS_DEFAULT_IDLE
+	def_bool y
+
 config ARCH_HAS_CACHE_LINE_SIZE
 	def_bool y
 
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index eb2cade..bb6e3b3 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -56,7 +56,11 @@ static void cpuidle_idle_call(void)
 		if (pm_idle_old)
 			pm_idle_old();
 		else
+#if defined(CONFIG_ARCH_HAS_DEFAULT_IDLE)
+			default_idle();
+#else
 			local_irq_enable();
+#endif
 		return;
 	}
 
-- 
1.5.5.1


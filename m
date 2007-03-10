From: Len Brown <lenb@kernel.org>
Subject: [PATCH 08/22] cpu_idle: fix build break
Date: Fri,  9 Mar 2007 23:00:45 -0500
Message-ID: <1173499267122-git-send-email-lenb@kernel.org>
References: <11734992592550-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.89]:27693 "EHLO
	fmsmga101.fm.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1945892AbXCJEBJ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 9 Mar 2007 23:01:09 -0500
In-Reply-To: <11734992592550-git-send-email-lenb@kernel.org>
Message-Id: <bc17374e69a621c9b7f6f9624c9248f3b8e8503d.1173498653.git.len.brown@intel.com>
In-Reply-To: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
References: <941b1971a405f95537bc6f9a738e737eb2186e45.1173498647.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

This patch fixes a build breakage with !CONFIG_HOTPLUG_CPU and
CONFIG_CPU_IDLE.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/cpuidle/cpuidle.c |    6 +-----
 1 files changed, 1 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index dc626d9..4d2071e 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -189,10 +189,6 @@ static struct sysdev_driver cpuidle_sysdev_driver = {
 	.remove		= cpuidle_remove_device,
 };
 
-#ifdef CONFIG_SMP
-
-#ifdef CONFIG_HOTPLUG_CPU
-
 static int cpuidle_cpu_callback(struct notifier_block *nfb,
 					unsigned long action, void *hcpu)
 {
@@ -224,7 +220,7 @@ static struct notifier_block __cpuinitdata cpuidle_cpu_notifier =
     .notifier_call = cpuidle_cpu_callback,
 };
 
-#endif /* CONFIG_HOTPLUG_CPU */
+#ifdef CONFIG_SMP
 
 static void smp_callback(void *v)
 {
-- 
1.5.0.3.310.g05ef5

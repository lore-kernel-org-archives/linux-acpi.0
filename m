From: Len Brown <lenb@kernel.org>
Subject: [PATCH 4/8] ACPI: Reintroduce run time configurable max_cstate for !CPU_IDLE case
Date: Fri, 11 Jan 2008 15:11:30 -0500
Message-ID: <5b3f0e6c1c9638b11a1063bf93c60a0766550b02.1200082104.git.len.brown@intel.com>
References: <1200082294-29742-1-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([143.182.124.22]:42738 "EHLO
	azsmga101.ch.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754429AbYAKUke (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 Jan 2008 15:40:34 -0500
In-Reply-To: <1200082294-29742-1-git-send-email-lenb@kernel.org>
In-Reply-To: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
References: <2c838197751db19d08a00e633e33dce23a69fb0c.1200082103.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Venki Pallipadi <venkatesh.pallipadi@intel.com>, Mark Lord <lkml@rtr.ca>, Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>

From: Venki Pallipadi <venkatesh.pallipadi@intel.com>

This was writeable in 2.6.23 but the cpuidle merge made it read-only.  But
some people's scripts (ie: Mark's) were writing to it.

As an unhappy compromise, make max_cstate writeable again if the kernel was
configured without CONFIG_CPU_IDLE.

http://bugzilla.kernel.org/show_bug.cgi?id=9683

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Mark Lord <lkml@rtr.ca>
Cc: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 2fe34cc..2235f4e 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -76,7 +76,11 @@ static void (*pm_idle_save) (void) __read_mostly;
 #define PM_TIMER_TICKS_TO_US(p)		(((p) * 1000)/(PM_TIMER_FREQUENCY/1000))
 
 static unsigned int max_cstate __read_mostly = ACPI_PROCESSOR_MAX_POWER;
+#ifdef CONFIG_CPU_IDLE
 module_param(max_cstate, uint, 0000);
+#else
+module_param(max_cstate, uint, 0644);
+#endif
 static unsigned int nocst __read_mostly;
 module_param(nocst, uint, 0000);
 
-- 
1.5.4.rc2.84.gf85fd


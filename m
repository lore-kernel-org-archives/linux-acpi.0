From: akpm@linux-foundation.org
Subject: [patch 3/3] drivers/idle/intel_idle.c: remove redundant local_irq_disable() call
Date: Tue, 10 Jan 2012 15:48:21 -0800
Message-ID: <20120110234821.E8BF5100270@wpzn3.hot.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ASCII
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yx0-f202.google.com ([209.85.213.202]:37800 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751647Ab2AJXsW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 10 Jan 2012 18:48:22 -0500
Received: by mail-yx0-f202.google.com with SMTP id m5so19127yen.1
        for <linux-acpi@vger.kernel.org>; Tue, 10 Jan 2012 15:48:22 -0800 (PST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: len.brown@intel.com, linux-acpi@vger.kernel.org, akpm@linux-foundation.org, yanmin_zhang@linux.intel.com, mingmingx.zhang@intel.com, shaohua.li@intel.com

From: Yanmin Zhang <yanmin_zhang@linux.intel.com>
Subject: drivers/idle/intel_idle.c: remove redundant local_irq_disable() call

irq disabling happens earlier in process_32.c:cpu_idle.  Basically,
cpuidle_state->enter is called, cpu irq is disabled.  cpuidle_state->enter
would turn on irq when exiting.

intel_idle doesn't follow this assumption.  Although it doesn't cause real
issue, it misleads developers.  Remove the call to local_irq_disable() at
entry.

[akpm@linux-foundation.org: add comment]
Signed-off-by: mzha38X <mingmingx.zhang@intel.com>
Cc: "Li, Shaohua" <shaohua.li@intel.com>
Cc: "Brown, Len" <len.brown@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/idle/intel_idle.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/idle/intel_idle.c~drivers-idle-intel_idlec-remove-redundant-local_irq_disable-call drivers/idle/intel_idle.c
--- a/drivers/idle/intel_idle.c~drivers-idle-intel_idlec-remove-redundant-local_irq_disable-call
+++ a/drivers/idle/intel_idle.c
@@ -232,6 +232,7 @@ static int get_driver_data(int cstate)
  * @drv: cpuidle driver
  * @index: index of cpuidle state
  *
+ * Must be called under local_irq_disable().
  */
 static int intel_idle(struct cpuidle_device *dev,
 		struct cpuidle_driver *drv, int index)
@@ -247,8 +248,6 @@ static int intel_idle(struct cpuidle_dev
 
 	cstate = (((eax) >> MWAIT_SUBSTATE_SIZE) & MWAIT_CSTATE_MASK) + 1;
 
-	local_irq_disable();
-
 	/*
 	 * leave_mm() to avoid costly and often unnecessary wakeups
 	 * for flushing the user TLB's associated with the active mm.
_

From: Len Brown <lenb@kernel.org>
Subject: [PATCH 2/4] ACPI: cpuidle: port idle timer suspend/resume workaround to cpuidle
Date: Wed, 10 Oct 2007 01:07:48 -0400
Message-ID: <1191992870-15009-3-git-send-email-lenb@kernel.org>
References: <1191992870-15009-1-git-send-email-lenb@kernel.org>
 <1191992870-15009-2-git-send-email-lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:32478 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751463AbXJJFHy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 10 Oct 2007 01:07:54 -0400
In-Reply-To: <1191992870-15009-2-git-send-email-lenb@kernel.org>
Message-Id: <e196441bdf2dbf0526b28a6829c39557c236d611.1191992618.git.len.brown@intel.com>
In-Reply-To: <4f86d3a8e297205780cca027e974fd5f81064780.1191992618.git.len.brown@intel.com>
References: <4f86d3a8e297205780cca027e974fd5f81064780.1191992618.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

Some timers stop during C2 and C3, and so there are various
generations of timer broadcast workarounds to deal with that.
But that (already complex) code gets confused during suspend.

As it is unlikely that deep C-states would save much power
during the actual suspend/resume process anyway, deep C-states
were disabled via the addition of .suspend/.resume hooks
in to the ACPI processor driver.

Here that workaround is ported to the cpuidle version of
the ACPI idle loop.  Technically, ACPI could un-register
itself from cpuidle on .suspend, but that code path
is currently quite cumbersome.  So instead,
we simply invoke C1 from the C2 and C3 handlers
for the duration of .suspend/.resume.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/processor_idle.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 99da6a7..0cad56c 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -1416,6 +1416,9 @@ static int acpi_idle_enter_simple(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return 0;
 
+	if (acpi_idle_suspend)
+		return(acpi_idle_enter_c1(dev, state));
+
 	if (pr->flags.bm_check)
 		acpi_idle_update_bm_rld(pr, cx);
 
@@ -1477,6 +1480,9 @@ static int acpi_idle_enter_bm(struct cpuidle_device *dev,
 	if (unlikely(!pr))
 		return 0;
 
+	if (acpi_idle_suspend)
+		return(acpi_idle_enter_c1(dev, state));
+
 	local_irq_disable();
 	current_thread_info()->status &= ~TS_POLLING;
 	/*
-- 
1.5.3.4.206.g58ba4

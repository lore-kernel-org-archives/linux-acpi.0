From: Thomas Renninger <trenn@suse.de>
Subject: [PATCH] intel idle: Make idle driver more robust
Date: Sun,  4 Dec 2011 22:17:29 +0100
Message-ID: <1323033449-44076-1-git-send-email-trenn@suse.de>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:42777 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751753Ab1LDVSZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 4 Dec 2011 16:18:25 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Bruno Friedmann <bruno@ioda-net.ch>

kvm -cpu host passes the original cpuid info to the guest.

Latest kvm version seem to return true for mwait_leaf cpuid
function on recent Intel CPUs. But it does not return mwait
C-states (mwait_substates), instead zero is returned.

While real CPUs seem to always return non-zero values, the intel
idle driver should not get active in kvm (mwait_substates == 0)
case and bail out.
Otherwise a Null pointer exception will happen later when the
cpuidle subsystem tries to get active:
[0.984807] BUG: unable to handle kernel NULL pointer dereference at (null)
[0.984807] IP: [<(null)>] (null)
...
[0.984807][<ffffffff8143cf34>] ? cpuidle_idle_call+0xb4/0x340
[0.984807][<ffffffff8159e7bc>] ? __atomic_notifier_call_chain+0x4c/0x70
[0.984807][<ffffffff81001198>] ? cpu_idle+0x78/0xd0

Reference:
https://bugzilla.novell.com/show_bug.cgi?id=726296


Signed-off-by: Thomas Renninger <trenn@suse.de>
CC: Bruno Friedmann <bruno@ioda-net.ch>
CC: Len Brown <lenb@kernel.org>
---
 drivers/idle/intel_idle.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 5be9d59..8473d1f 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -347,7 +347,8 @@ static int intel_idle_probe(void)
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &mwait_substates);
 
 	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED) ||
-		!(ecx & CPUID5_ECX_INTERRUPT_BREAK))
+	    !(ecx & CPUID5_ECX_INTERRUPT_BREAK) ||
+	    !mwait_substates)
 			return -ENODEV;
 
 	pr_debug(PREFIX "MWAIT substates: 0x%x\n", mwait_substates);
-- 
1.7.6.1


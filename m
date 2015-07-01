From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH] ARM64 / SMP: Switch pr_err() to pr_debug() for disabled GICC entry
Date: Wed,  1 Jul 2015 21:37:23 +0800
Message-ID: <1435757843-13236-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f169.google.com ([209.85.192.169]:35784 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754214AbbGANhi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Jul 2015 09:37:38 -0400
Received: by pdbci14 with SMTP id ci14so26042027pdb.2
        for <linux-acpi@vger.kernel.org>; Wed, 01 Jul 2015 06:37:37 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, linux-acpi@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>

It is normal that firmware presents GICC entry or entries (processors)
with disabled flag in ACPI MADT, taking a system of 16 cpus for example,
ACPI firmware may present 8 enabled first with another 8 cpus disabled
in MADT, the disabled cpus can be hot-added later.

Firmware may also present more cpus than the hardware actually has, but
disabled the unused ones, and easily enable it when the hardware has such
cpus to make the firmware code scalable.

So that's not an error for disabled cpus in MADT, we can switch
pr_err() to pr_debug() instead.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4b2121b..5caf04a 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -402,7 +402,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 	}
 
 	if (!(processor->flags & ACPI_MADT_ENABLED)) {
-		pr_err("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
+		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
 		return;
 	}
 
-- 
1.9.1


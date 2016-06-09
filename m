From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH 8/8] MAINTAINERS: Tweak ARM PMU maintainers
Date: Thu,  9 Jun 2016 17:23:33 -0500
Message-ID: <1465511013-10742-9-git-send-email-jeremy.linton@arm.com>
References: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:34804 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752031AbcFIWXj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 9 Jun 2016 18:23:39 -0400
In-Reply-To: <1465511013-10742-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, will.deacon@arm.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, catalin.marinas@arm.com, peterz@infradead.org, mingo@redhat.com, acme@kernel.org, alexander.shishkin@linux.intel.com, mlangsdorf@redhat.com

Update the ARM PMU file list, and add the arm mailing list.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed42cb6..cd1f9d9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -878,12 +878,13 @@ ARM PMU PROFILING AND DEBUGGING
 M:	Will Deacon <will.deacon@arm.com>
 R:	Mark Rutland <mark.rutland@arm.com>
 S:	Maintained
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 F:	arch/arm*/kernel/perf_*
 F:	arch/arm/oprofile/common.c
 F:	arch/arm*/kernel/hw_breakpoint.c
 F:	arch/arm*/include/asm/hw_breakpoint.h
 F:	arch/arm*/include/asm/perf_event.h
-F:	drivers/perf/arm_pmu.c
+F:	drivers/perf/arm_pmu*
 F:	include/linux/perf/arm_pmu.h
 
 ARM PORT
-- 
2.5.5


From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v7 9/9] MAINTAINERS: Tweak ARM PMU maintainers
Date: Tue, 23 Aug 2016 15:48:00 -0500
Message-ID: <1471985280-2243-10-git-send-email-jeremy.linton@arm.com>
References: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:41024 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755682AbcHWUsG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 23 Aug 2016 16:48:06 -0400
In-Reply-To: <1471985280-2243-1-git-send-email-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: mark.rutland@arm.com, will.deacon@arm.com, punit.agrawal@arm.com, linux-acpi@vger.kernel.org, mlangsdorf@redhat.com, steve.capper@arm.com

Update the ARM PMU file list, and add the arm mailing list.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bbe4b1..d293270 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -905,12 +905,13 @@ ARM PMU PROFILING AND DEBUGGING
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


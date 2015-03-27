From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 1/2] ARM64 / ACPI: Ignore the return error value of acpi_map_gic_cpu_interface()
Date: Fri, 27 Mar 2015 20:14:35 +0800
Message-ID: <1427458476-20140-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f181.google.com ([209.85.192.181]:35146 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbC0MPI (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2015 08:15:08 -0400
Received: by pdbop1 with SMTP id op1so94909113pdb.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2015 05:15:07 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>

MADT table scannig will stopped once it gets the errors
returned by the handler, which is acpi_map_gic_cpu_interface()
in for ARM64, so Ignore the return error value to search for
all enabled CPUs for SMP init.

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 arch/arm64/kernel/acpi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/acpi.c b/arch/arm64/kernel/acpi.c
index 07649e4..c263cba 100644
--- a/arch/arm64/kernel/acpi.c
+++ b/arch/arm64/kernel/acpi.c
@@ -181,7 +181,8 @@ acpi_parse_gic_cpu_interface(struct acpi_subtable_header *header,
 		return -EINVAL;
 
 	acpi_table_print_madt_entry(header);
-	return acpi_map_gic_cpu_interface(processor);
+	acpi_map_gic_cpu_interface(processor);
+	return 0;
 }
 
 /* Parse GIC cpu interface entries in MADT for SMP init */
-- 
1.9.1


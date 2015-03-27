From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 1/2] ARM64 / ACPI: Ignore the return error value of acpi_map_gic_cpu_interface()
Date: Fri, 27 Mar 2015 21:55:06 +0800
Message-ID: <1427464513-14414-3-git-send-email-hanjun.guo@linaro.org>
References: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427464513-14414-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

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

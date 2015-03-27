From: Hanjun Guo <hanjun.guo@linaro.org>
Subject: [PATCH 6/7] ACPI / processor: return specific error instead of -1
Date: Fri, 27 Mar 2015 22:02:27 +0800
Message-ID: <1427464948-14564-7-git-send-email-hanjun.guo@linaro.org>
References: <1427464948-14564-1-git-send-email-hanjun.guo@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1427464948-14564-1-git-send-email-hanjun.guo@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Will Deacon <will.deacon@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Sudeep Holla <Sudeep.Holla@arm.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, Hanjun Guo <hanjun.guo@linaro.org>
List-Id: linux-acpi@vger.kernel.org

Since invalid_logical_cpuid() can check error values, so
return specific error instead of -1 for acpi_map_cpuid().

Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 drivers/acpi/processor_core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b1ec78b..fd4140d 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -215,12 +215,12 @@ int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id)
 		 * Ignores phys_id and always returns 0 for the processor
 		 * handle with acpi id 0 if nr_cpu_ids is 1.
 		 * This should be the case if SMP tables are not found.
-		 * Return -1 for other CPU's handle.
+		 * Return -EINVAL for other CPU's handle.
 		 */
 		if (nr_cpu_ids <= 1 && acpi_id == 0)
 			return acpi_id;
 		else
-			return -1;
+			return -EINVAL;
 	}
 
 #ifdef CONFIG_SMP
@@ -233,7 +233,7 @@ int acpi_map_cpuid(phys_cpuid_t phys_id, u32 acpi_id)
 	if (phys_id == 0)
 		return phys_id;
 #endif
-	return -1;
+	return -ENODEV;
 }
 
 int acpi_get_cpuid(acpi_handle handle, int type, u32 acpi_id)
-- 
1.9.1

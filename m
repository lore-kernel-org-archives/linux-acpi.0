From: Jeremy Linton <jeremy.linton@arm.com>
Subject: [RFC 1/4] drivers: base: cacheinfo: Add support for ACPI based firmware tables
Date: Fri,  4 Aug 2017 19:11:56 -0500
Message-ID: <20170805001159.12769-2-jeremy.linton@arm.com>
References: <20170805001159.12769-1-jeremy.linton@arm.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:32980 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753318AbdHEAMB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 4 Aug 2017 20:12:01 -0400
In-Reply-To: <20170805001159.12769-1-jeremy.linton@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: linux-acpi@vger.kernel.org, sudeep.holla@arm.com, hanjun.guo@linaro.org, lorenzo.pieralisi@arm.com, will.deacon@arm.com, catalin.marinas@arm.com

The /sys cache entries should support ACPI/PPTT generated cache
topology information. Lets detect ACPI systems and call
an arch specific cache_setup_acpi() routine to update the hardware
probed cache topology.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/base/cacheinfo.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index eb3af27..44fa374 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -215,6 +215,11 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 }
 #endif
 
+int __weak cache_setup_acpi(unsigned int cpu)
+{
+	return -ENOTSUPP;
+}
+
 static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -225,11 +230,11 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	if (this_cpu_ci->cpu_map_populated)
 		return 0;
 
-	if (of_have_populated_dt())
+	if (!acpi_disabled)
+		ret = cache_setup_acpi(cpu);
+	else if (of_have_populated_dt())
 		ret = cache_setup_of_node(cpu);
-	else if (!acpi_disabled)
-		/* No cache property/hierarchy support yet in ACPI */
-		ret = -ENOTSUPP;
+
 	if (ret)
 		return ret;
 
@@ -286,7 +291,7 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 
 static void cache_override_properties(unsigned int cpu)
 {
-	if (of_have_populated_dt())
+	if (acpi_disabled && of_have_populated_dt())
 		return cache_of_override_properties(cpu);
 }
 
-- 
2.9.4


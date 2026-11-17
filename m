Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953508;
	b=BdAniPnqjGX+UACLZDxUGQhTrsIKay++TF2EcEEcwjXloBYixQwrocuhxjIt2wyay7Ew
	 IBmQD9UWkQQmu4yEe5sBVP3J3uopl1Gl/b+QfWCqtQFPeiTHs5PCYkCc9lLd+tZmJ4Kpg
	 yNYKdIO2Egu8MXQawvpPsEXv4NS3e0sfuR5ADkfn1DMl1dQq0AYw3qe2rH1O1Wmx/j+n2
	 EOrqjWhoWmVjhas1whteIbrudXoSCz5Z58M0DGXgtWYtO4Sjbt6nh4Jaugo463mGRjXvt
	 Ww/3fMAoRFeQ2Ysq+uBw3REkwU/ymO2q2ZeMMPGS65dTAI/+ZGKKycqizZLJBx5WITA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953508;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cunW1Leskp2/ovidYACJ0+k0VRx49i91WrRF3nADF10=;
	b=O2VkATG3p15cqxgIgdtVltXxkLkJ2hxxPaMG4Xfl4fAOAzwJjpwQJxrmbkCroAEQj4c+
	 N6MCA0pJ6SpTEyWSCiw5jCiLUn/VS7H7ZnYPYAn0zypwhOe5AmlqUgrGwu7IY+LAWJ7Tr
	 GSHefXpYkm2Yte/ogdyD87/8q3CYeb5pPWMp6iKmRJ5B9c6zLH+vnLuddiEP3Zt0QEZCw
	 O1DCxzlsCdnD/iXTH1OFmwDew5+ljEQ+xLBEzHcK2va5SJ7ya/sa+3t0fCOBYnywWIQ3H
	 /6dJZCEoA6xP5t6mKv9iS+0a5hp75Mro6s9i0gwS4X0lbH/yks6KUaFTZ3/fvwFHL8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9W3LMxe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE415606A33D;
	Tue, 17 Nov 2026 22:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9W3LMxe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8FE51F000C7;
	Tue, 17 Nov 2026 22:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953508;
	bh=cunW1Leskp2/ovidYACJ0+k0VRx49i91WrRF3nADF10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e9W3LMxeQeERg2rjPrcvNqVvfVvL6hNuK1Vg2WVzG1qI6s+8W6UKIBzcw4hU/MDI2
	 licPONDf8nfNDyHL/yGdllET2Tn47m+vYKmLUsosQ2F4mZuUgSh+rnGHRTmbdXqUil
	 OUyxuyWRRI3iadIB4isKuo1xy0P1SuyV5YNkYf6AhLBTSy3VbGKL9fSp0wWVooDAsE
	 6iMSDQLRT6dnswwCRsKXuVo+zP4MQKby041MmVpWnRFvuKmkBh9KFYmvtuKM9JGPVh
	 orJsKMUSg1WCS/6pxcGkhWiFKFAwLJQzXhBLY/oFIUfDGtRA1awzwDVPh4ey8rv98m
	 UMRGO/YziudPQ==
From: "Drew Fustini (Tenstorrent)" <fustini@kernel.org>
Date: Tue, 17 Nov 2026 14:11:29 -0800
Subject: [PATCH 3/3] riscv_cbqri: Bind to RQSC platform devices
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-acpi-rqsc-v1-3-381ce645751e@kernel.org>
References: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
In-Reply-To: <20261117-acpi-rqsc-v1-0-381ce645751e@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Atish Patra <atish.patra@linux.dev>, 
 Anup Patel <anup.patel@oss.qualcomm.com>, 
 Chen Pei <cp0613@linux.alibaba.com>, yunhui cui <cuiyunhui@bytedance.com>, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <radim.krcmar@oss.qualcomm.com>, 
 Zeng Heng <zengheng@picoheart.com>, 
 Conor Dooley <conor.dooley@microchip.com>, Ben Horgan <ben.horgan@arm.com>, 
 James Morse <james.morse@arm.com>, Tony Luck <tony.luck@intel.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>, 
 Gong Shuai <gong.shuai@sanechips.com.cn>, Gong Shuai <gsh517@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Samuel Holland <samuel.holland@sifive.com>, guo.wenjia23@zte.com.cn, 
 liu.qingtao2@zte.com.cn, Dave Martin <Dave.Martin@arm.com>, 
 Babu Moger <babu.moger@amd.com>, Fenghua Yu <fenghuay@nvidia.com>, 
 Peter Newman <peternewman@google.com>, 
 Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>, 
 Jonathan Cameron <jic23@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, linux-acpi@vger.kernel.org, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 "Drew Fustini (Tenstorrent)" <fustini@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=7565; i=fustini@kernel.org;
 h=from:subject:message-id; bh=aYgoa7KXLUK+oRj4yg5rNhVW5cvj32VihPir+GkzWTk=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWT9uagoaXQ8LE/tTWyyTcwVvgbr812yDxifppXxzq5yO
 vFK74pmRykLgxgXg6yYIsumD3kXlniFfl0w/8U2mDmsTCBDGLg4BWAiMg6MDIcCly7+161Q3Fnz
 YVI98/1vd7g2Hejqi+BiiJ0iFOZ83JuRYXPjNUWFpZMdd/2IWhznN/uw8/bJT7rm1/O3X17u/bK
 hlgEA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Let the capacity controller driver probe the "cbqri-capacity" platform
devices created from the RQSC table. The cache is named by its PPTT
Cache ID and the PPTT gives its level. Select ACPI_RQSC so the table is
parsed and drop the OF dependency.

No change for device tree systems.

Signed-off-by: Drew Fustini (Tenstorrent) <fustini@kernel.org>
---
 drivers/resctrl/Kconfig          |  11 ++--
 drivers/resctrl/cbqri_capacity.c | 111 ++++++++++++++++++++++++++++-----------
 2 files changed, 87 insertions(+), 35 deletions(-)

diff --git a/drivers/resctrl/Kconfig b/drivers/resctrl/Kconfig
index 844dfd75e2aa..491c867f8c5c 100644
--- a/drivers/resctrl/Kconfig
+++ b/drivers/resctrl/Kconfig
@@ -35,6 +35,7 @@ config ARM64_MPAM_RESCTRL_FS
 menuconfig RISCV_CBQRI
 	bool "RISC-V CBQRI support"
 	depends on RISCV && RISCV_ISA_SSQOSID
+	select ACPI_RQSC if ACPI
 	select ARCH_HAS_CPU_RESCTRL
 	default y
 	help
@@ -47,14 +48,14 @@ if RISCV_CBQRI
 
 config RISCV_CBQRI_CAPACITY
 	bool "RISC-V CBQRI cache capacity-allocation controller"
-	depends on OF
 	help
 	  Enable driver for a RISC-V CBQRI capacity controller that
-	  governs a CPU cache, matching the "riscv,cbqri-capacity-controller"
-	  compatible. The controller's cache phandle gives the cache level and
-	  id, which the driver registers as a resctrl cache-allocation resource.
+	  governs a CPU cache, described in device tree by the
+	  "riscv,cbqri-capacity-controller" compatible or in ACPI by the RQSC
+	  table. The firmware description gives the cache level and id, which
+	  the driver registers as a resctrl cache-allocation resource.
 
-	  Say N unless your device tree describes a CBQRI capacity controller.
+	  Say N unless your firmware describes a CBQRI capacity controller.
 
 endif
 
diff --git a/drivers/resctrl/cbqri_capacity.c b/drivers/resctrl/cbqri_capacity.c
index 6f3d06c4f74b..7013f1a50ffd 100644
--- a/drivers/resctrl/cbqri_capacity.c
+++ b/drivers/resctrl/cbqri_capacity.c
@@ -3,11 +3,14 @@
  * Platform driver for a RISC-V CBQRI capacity controller that backs a CPU
  * cache. The controller is described in device tree by the generic
  * "riscv,cbqri-capacity-controller" compatible together with a phandle to the
- * cache node it governs. The driver hands it to the CBQRI core, which probes
- * the capabilities register and exposes a controller that supports allocation
- * as the resctrl cache allocation resource for that cache.
+ * cache node it governs, or in ACPI by the RQSC table, whose parser creates a
+ * "cbqri-capacity" platform device that carries the PPTT Cache ID of the
+ * cache. The driver hands it to the CBQRI core, which probes the capabilities
+ * register and exposes a controller that supports allocation as the resctrl
+ * cache allocation resource for that cache.
  */
 
+#include <linux/acpi.h>
 #include <linux/cacheinfo.h>
 #include <linux/cpu.h>
 #include <linux/device-id/of.h>
@@ -15,45 +18,32 @@
 #include <linux/ioport.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/riscv_cbqri.h>
 #include <linux/types.h>
 
-static int cbqri_capacity_probe(struct platform_device *pdev)
+static int cbqri_capacity_of_cache(struct device *dev, u32 *cache_level,
+				   u32 *cache_id)
 {
-	struct device *dev = &pdev->dev;
-	struct cbqri_controller_info info = {};
 	struct device_node *cache_np;
-	struct resource *res;
-	void __iomem *base;
-	u32 rcid_count, cache_level, cache_id;
 	bool found = false;
 	int cpu, ret;
 
-	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
-
-	ret = of_property_read_u32(dev->of_node, "riscv,cbqri-rcid", &rcid_count);
-	if (ret) {
-		dev_err(dev, "missing riscv,cbqri-rcid\n");
-		return ret;
-	}
-
 	cache_np = of_parse_phandle(dev->of_node, "riscv,cbqri-cache", 0);
 	if (!cache_np) {
 		dev_err(dev, "missing riscv,cbqri-cache phandle\n");
 		return -EINVAL;
 	}
 
-	ret = of_property_read_u32(cache_np, "cache-level", &cache_level);
+	ret = of_property_read_u32(cache_np, "cache-level", cache_level);
 	if (ret) {
 		dev_err(dev, "%pOF: missing cache-level\n", cache_np);
 		goto out_put;
 	}
 
-	if (cache_level != 2 && cache_level != 3) {
+	if (*cache_level != 2 && *cache_level != 3) {
 		dev_err(dev, "%pOF: unsupported cache-level %u\n",
-			cache_np, cache_level);
+			cache_np, *cache_level);
 		ret = -EINVAL;
 		goto out_put;
 	}
@@ -73,10 +63,10 @@ static int cbqri_capacity_probe(struct platform_device *pdev)
 	 */
 	cpus_read_lock();
 	for_each_online_cpu(cpu) {
-		struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, cache_level);
+		struct cacheinfo *ci = get_cpu_cacheinfo_level(cpu, *cache_level);
 
 		if (ci && ci->fw_token == cache_np) {
-			cache_id = ci->id;
+			*cache_id = ci->id;
 			found = true;
 			break;
 		}
@@ -85,11 +75,74 @@ static int cbqri_capacity_probe(struct platform_device *pdev)
 
 	if (!found) {
 		dev_err(dev, "%pOF: no online hart reports an L%u cache with a cache id for this node\n",
-			cache_np, cache_level);
+			cache_np, *cache_level);
 		ret = -ENODEV;
-		goto out_put;
 	}
 
+out_put:
+	of_node_put(cache_np);
+	return ret;
+}
+
+/*
+ * The RQSC table names the cache by its PPTT Cache ID, which the table parser
+ * passes on in the riscv,cbqri-cache-id property. cacheinfo takes the cache
+ * id from the same PPTT field, and the PPTT gives the level of the cache.
+ */
+static int cbqri_capacity_acpi_cache(struct device *dev, u32 *cache_level,
+				     u32 *cache_id)
+{
+	int level, ret;
+
+	ret = device_property_read_u32(dev, "riscv,cbqri-cache-id", cache_id);
+	if (ret) {
+		dev_err(dev, "missing riscv,cbqri-cache-id\n");
+		return ret;
+	}
+
+	level = find_acpi_cache_level_from_id(*cache_id);
+	if (level < 0) {
+		dev_err(dev, "no PPTT cache with Cache ID %u\n", *cache_id);
+		return level;
+	}
+
+	if (level != 2 && level != 3) {
+		dev_err(dev, "unsupported cache level %d for Cache ID %u\n",
+			level, *cache_id);
+		return -EINVAL;
+	}
+
+	*cache_level = level;
+
+	return 0;
+}
+
+static int cbqri_capacity_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cbqri_controller_info info = {};
+	struct resource *res;
+	void __iomem *base;
+	u32 rcid_count, cache_level, cache_id;
+	int ret;
+
+	base = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	ret = device_property_read_u32(dev, "riscv,cbqri-rcid", &rcid_count);
+	if (ret) {
+		dev_err(dev, "missing riscv,cbqri-rcid\n");
+		return ret;
+	}
+
+	if (dev->of_node)
+		ret = cbqri_capacity_of_cache(dev, &cache_level, &cache_id);
+	else
+		ret = cbqri_capacity_acpi_cache(dev, &cache_level, &cache_id);
+	if (ret)
+		return ret;
+
 	info.type = CBQRI_CONTROLLER_TYPE_CAPACITY;
 	info.base = base;
 	info.addr = res->start;
@@ -101,15 +154,13 @@ static int cbqri_capacity_probe(struct platform_device *pdev)
 	ret = riscv_cbqri_register_cc(&info);
 	if (ret) {
 		dev_err(dev, "failed to register capacity controller: %d\n", ret);
-		goto out_put;
+		return ret;
 	}
 
 	dev_info(dev, "registered L%u capacity controller at %pa (cache_id=%u, rcid=%u)\n",
 		 cache_level, &info.addr, cache_id, rcid_count);
 
-out_put:
-	of_node_put(cache_np);
-	return ret;
+	return 0;
 }
 
 static const struct of_device_id cbqri_capacity_of_match[] = {

-- 
2.43.0


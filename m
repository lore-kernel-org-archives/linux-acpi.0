Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953507;
	b=UTDv3f91lyJaA4qFb9RUfclGP4WpwowmfblxsLGqgQtFfl5/KLNvTnxm2EnCO+QtBS53
	 MLuJtYaQp47Nj2zwMEM6nQKyRsu4PMKTLfs9okEgpudZfji52M9MPUiiIHpdCmR+7mMwd
	 h/MXkY+Hl/ImLm44j47xqKiRjwRDmMmq+mKwDYqW9GUd9tNwWglTxVKhY2Dn0vF3bv24L
	 L9zrJh81wMzhGBBYw5I33dU0tfHMBesvf0nN6IDhv4ehnH9xSE+id/TXqd5r6IVdq8MhD
	 3lJVtmrVI/tNft0e6PUMu1rlrUXhvEkDa4kBTE4PZ330QdnKwdx1JuYVWCbQGBSLylg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953507;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ygV5qjVh+HJDOgZR1o7P1NzmP0UicWQJHq7Y5HypT+8=;
	b=gt+wmc1QWJGnuv/ABBVYBhyYoqQ2hemHkUAmRRJt28ilBIXHrL66qWH786GS1/jIp/ry
	 dfpmLCjgIuKvd20CZFOoQNY0UToWzJ4/sjC7GDBhMZieoTEMGagBNEbyQqqH2JhMO75Sd
	 W6GcjmunS2I9bB1/CFo/ugLTLZU3DJ6tctK1S8tRr/C4NgOD/dPXV1h6YsuvjUsyDK5Fb
	 A+Xfan1MDrRuC4Ib/mCH9KH2vJ9bQI42gqIfuUMj2ck3JHD7kLbEoFPOAGCNuQMcr2zrT
	 1dsQayP1UkVZLQxYsF0qbkmbVTNNKHJa27khjZAD0ZrSd3bfn4AGmdi5lbRZfOzSWQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="LGCfrl/U";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11AC606A880;
	Tue, 17 Nov 2026 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LGCfrl/U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C147D1F000CD;
	Tue, 17 Nov 2026 22:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794953507;
	bh=ygV5qjVh+HJDOgZR1o7P1NzmP0UicWQJHq7Y5HypT+8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=LGCfrl/UztGOOU8JYp+0GrVHMZuOnD3k66z4WMnIaKhm//jBCJmDcG9Nkel/6tcUs
	 ZKQPxmWHiHi8U6GWKpuIr8aUjb8gxyQMXDy8xYFs6EZG1cvCywMsbcwHGMMquSGTwH
	 8cYfsiqtJNoyjuLp1GUTueYhe9h/DqhyCqFGt+B/kgWNv56XoziLeSEeiuWhWtlQt2
	 3GPTyQbFbPyo6pjhnI+DiHDc8lj2HEJ/QsnVFsGfsfTwjXmAkEW7wutbr9SIaqhurE
	 H2x3/2OO9JefoOHR4VCjBpkRMFgwS6tOlgLot71fcz1/2IgMHn94vUHekZRYVQreSc
	 F5wN48H1yrz6A==
From: "Drew Fustini (Tenstorrent)" <fustini@kernel.org>
Date: Tue, 17 Nov 2026 14:11:28 -0800
Subject: [PATCH 2/3] ACPI: RISC-V: Enumerate CBQRI controllers from the
 RQSC table
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
Message-Id: <20261117-acpi-rqsc-v1-2-381ce645751e@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8556; i=fustini@kernel.org;
 h=from:subject:message-id; bh=AcTtL2gh59MgYv8NvQNEWmqualurjTfftcDkA1X4XF4=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWT9uaj4KuX7FZYpiWXzVnpa7WM8WFfpbHPxsbLk7yfr+
 lY6zO5/11HKwiDGxSArpsiy6UPehSVeoV8XzH+xDWYOKxPIEAYuTgGYyNvTjAznt7zVTF/ldPse
 Q8ns4NZc8acBa9quPFf5vmKiZ/25NW0mDP99zj3Q4mRNcJFdsYH7QfOZu9KTlk8zal7z9tUKUSe
 r99/ZAQ==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Walk the RQSC table at ACPI init and create a platform device for each
CBQRI controller, so one platform driver can serve device tree and ACPI
systems. Nothing selects ACPI_RQSC until the CBQRI driver can bind to
these devices.

Signed-off-by: Drew Fustini (Tenstorrent) <fustini@kernel.org>
---
 drivers/acpi/riscv/Kconfig  |   3 +
 drivers/acpi/riscv/Makefile |   1 +
 drivers/acpi/riscv/init.c   |   2 +
 drivers/acpi/riscv/init.h   |   1 +
 drivers/acpi/riscv/rqsc.c   | 210 ++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 217 insertions(+)

diff --git a/drivers/acpi/riscv/Kconfig b/drivers/acpi/riscv/Kconfig
index 046296a18d00..2f2304bf0681 100644
--- a/drivers/acpi/riscv/Kconfig
+++ b/drivers/acpi/riscv/Kconfig
@@ -5,3 +5,6 @@
 
 config ACPI_RIMT
 	bool
+
+config ACPI_RQSC
+	bool
diff --git a/drivers/acpi/riscv/Makefile b/drivers/acpi/riscv/Makefile
index 1284a076fa88..b4bcfa4826d8 100644
--- a/drivers/acpi/riscv/Makefile
+++ b/drivers/acpi/riscv/Makefile
@@ -3,3 +3,4 @@ obj-y					+= rhct.o init.o irq.o
 obj-$(CONFIG_ACPI_PROCESSOR_IDLE)	+= cpuidle.o
 obj-$(CONFIG_ACPI_CPPC_LIB)		+= cppc.o
 obj-$(CONFIG_ACPI_RIMT)			+= rimt.o
+obj-$(CONFIG_ACPI_RQSC)			+= rqsc.o
diff --git a/drivers/acpi/riscv/init.c b/drivers/acpi/riscv/init.c
index 7c00f7995e86..9fdd5f1bcc5f 100644
--- a/drivers/acpi/riscv/init.c
+++ b/drivers/acpi/riscv/init.c
@@ -12,4 +12,6 @@ void __init acpi_arch_init(void)
 	riscv_acpi_init_gsi_mapping();
 	if (IS_ENABLED(CONFIG_ACPI_RIMT))
 		riscv_acpi_rimt_init();
+	if (IS_ENABLED(CONFIG_ACPI_RQSC))
+		riscv_acpi_rqsc_init();
 }
diff --git a/drivers/acpi/riscv/init.h b/drivers/acpi/riscv/init.h
index 1680aa2aaf23..176459e356b7 100644
--- a/drivers/acpi/riscv/init.h
+++ b/drivers/acpi/riscv/init.h
@@ -3,3 +3,4 @@
 
 void __init riscv_acpi_init_gsi_mapping(void);
 void __init riscv_acpi_rimt_init(void);
+void __init riscv_acpi_rqsc_init(void);
diff --git a/drivers/acpi/riscv/rqsc.c b/drivers/acpi/riscv/rqsc.c
new file mode 100644
index 000000000000..262fd5755d29
--- /dev/null
+++ b/drivers/acpi/riscv/rqsc.c
@@ -0,0 +1,210 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Create a platform device for each CBQRI controller described by the ACPI
+ * RISC-V Quality of Service Controllers (RQSC) table.
+ */
+
+#define pr_fmt(fmt) "ACPI: RQSC: " fmt
+
+#include <linux/acpi.h>
+#include <linux/bug.h>
+#include <linux/cleanup.h>
+#include <linux/err.h>
+#include <linux/ioport.h>
+#include <linux/mm.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/wordpart.h>
+
+#include "init.h"
+#include "rqsc.h"
+
+static struct platform_device * __init
+rqsc_add_device(unsigned int idx, const struct acpi_rqsc_controller *ctrl,
+		const struct acpi_rqsc_resource *res)
+{
+	bool is_cc = ctrl->type == ACPI_RQSC_CONTROLLER_TYPE_CAPACITY;
+	struct platform_device *pdev __free(platform_device_put) =
+		platform_device_alloc(is_cc ? "cbqri-capacity" : "cbqri-bandwidth",
+				      idx);
+	phys_addr_t addr = ctrl->address.address;
+	/* The GAS carries no length, so claim up to the end of the page. */
+	struct resource mem = DEFINE_RES_MEM(addr, PAGE_SIZE - offset_in_page(addr));
+	/* rcid, mcid, cache id and a sentinel */
+	struct property_entry props[4] = {};
+	unsigned int n = 0;
+	int ret;
+
+	if (!pdev)
+		return ERR_PTR(-ENOMEM);
+
+	ret = platform_device_add_resources(pdev, &mem, 1);
+	if (ret)
+		return ERR_PTR(ret);
+
+	props[n++] = PROPERTY_ENTRY_U32("riscv,cbqri-rcid", ctrl->rcid_count);
+	props[n++] = PROPERTY_ENTRY_U32("riscv,cbqri-mcid", ctrl->mcid_count);
+	if (is_cc)
+		props[n++] = PROPERTY_ENTRY_U32("riscv,cbqri-cache-id",
+						lower_32_bits(res->id1));
+	else
+		set_dev_node(&pdev->dev, pxm_to_node(lower_32_bits(res->id1)));
+
+	ret = device_create_managed_software_node(&pdev->dev, props, NULL);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = platform_device_add(pdev);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return_ptr(pdev);
+}
+
+/*
+ * Check the one resource the controller is described with. A capacity
+ * controller names a processor cache by PPTT Cache ID, a bandwidth
+ * controller a memory range by SRAT proximity domain. Both IDs are
+ * the low 32 bits of Resource ID 1, the upper half is reserved.
+ */
+static bool __init rqsc_resource_ok(const struct acpi_rqsc_controller *ctrl,
+				    const struct acpi_rqsc_resource *res,
+				    phys_addr_t addr)
+{
+	u8 want_type, want_id_type;
+
+	if (ctrl->type == ACPI_RQSC_CONTROLLER_TYPE_CAPACITY) {
+		want_type = ACPI_RQSC_RESOURCE_TYPE_CACHE;
+		want_id_type = ACPI_RQSC_RESOURCE_ID_TYPE_PROCESSOR_CACHE;
+	} else {
+		want_type = ACPI_RQSC_RESOURCE_TYPE_MEMORY;
+		want_id_type = ACPI_RQSC_RESOURCE_ID_TYPE_MEMORY_RANGE;
+	}
+
+	if (res->type != want_type || res->id_type != want_id_type) {
+		pr_warn("controller at %pa: resource type %u id type %u does not match controller type %u, skipping\n",
+			&addr, res->type, res->id_type, ctrl->type);
+		return false;
+	}
+
+	return true;
+}
+
+static void __init rqsc_parse(const struct acpi_table_rqsc *rqsc)
+{
+	const void *end = (const void *)rqsc + rqsc->header.length;
+	const struct acpi_rqsc_controller *ctrl = (const void *)(rqsc + 1);
+	unsigned int idx = 0, added = 0;
+
+	while ((const void *)ctrl < end) {
+		const struct acpi_rqsc_resource *res = (const void *)(ctrl + 1);
+		struct platform_device *pdev;
+		phys_addr_t addr;
+
+		/*
+		 * The controller structure must fit and stay inside the
+		 * table. Anything else is corruption and the remaining
+		 * entries cannot be trusted.
+		 */
+		if ((const void *)ctrl + sizeof(*ctrl) > end ||
+		    ctrl->length < sizeof(*ctrl) ||
+		    (const void *)ctrl + ctrl->length > end) {
+			pr_err("entry %u is malformed, stopping\n", idx);
+			break;
+		}
+
+		addr = ctrl->address.address;
+
+		if (ctrl->type != ACPI_RQSC_CONTROLLER_TYPE_CAPACITY &&
+		    ctrl->type != ACPI_RQSC_CONTROLLER_TYPE_BANDWIDTH) {
+			pr_warn("controller at %pa: unknown type %u, skipping\n",
+				&addr, ctrl->type);
+			goto next;
+		}
+
+		if (ctrl->address.space_id != ACPI_ADR_SPACE_SYSTEM_MEMORY || !addr) {
+			pr_warn("entry %u: no usable register interface address, skipping\n",
+				idx);
+			goto next;
+		}
+
+		if (!ctrl->rcid_count && !ctrl->mcid_count) {
+			pr_warn("controller at %pa: no RCIDs and no MCIDs, skipping\n",
+				&addr);
+			goto next;
+		}
+
+		if (!ctrl->num_resources ||
+		    ctrl->length < sizeof(*ctrl) + sizeof(*res) ||
+		    res->length < sizeof(*res)) {
+			pr_warn("controller at %pa: no usable resource, skipping\n",
+				&addr);
+			goto next;
+		}
+
+		if (ctrl->num_resources > 1)
+			pr_warn("controller at %pa: %u resources, using the first\n",
+				&addr, ctrl->num_resources);
+
+		if (!rqsc_resource_ok(ctrl, res, addr))
+			goto next;
+
+		pdev = rqsc_add_device(idx, ctrl, res);
+		if (IS_ERR(pdev)) {
+			pr_warn("controller at %pa: failed to add device: %pe\n",
+				&addr, pdev);
+			goto next;
+		}
+
+		added++;
+next:
+		ctrl = (const void *)ctrl + ctrl->length;
+		idx++;
+	}
+
+	if (idx != rqsc->num_controllers)
+		pr_warn("table announces %u controllers, found %u\n",
+			rqsc->num_controllers, idx);
+
+	if (added)
+		pr_info("%u CBQRI controllers\n", added);
+	else
+		pr_warn("no usable CBQRI controller\n");
+}
+
+void __init riscv_acpi_rqsc_init(void)
+{
+	struct acpi_table_header *table __free(acpi_put_table) = NULL;
+	acpi_status status;
+
+	BUILD_BUG_ON(sizeof(struct acpi_rqsc_resource) != 20);
+	BUILD_BUG_ON(sizeof(struct acpi_rqsc_controller) != 24);
+	BUILD_BUG_ON(sizeof(struct acpi_table_rqsc) != 40);
+
+	status = acpi_get_table(ACPI_SIG_RQSC, 0, &table);
+	if (status == AE_NOT_FOUND)
+		return;
+
+	if (ACPI_FAILURE(status)) {
+		pr_err("failed to get table: %s\n",
+		       acpi_format_exception(status));
+		return;
+	}
+
+	/*
+	 * A later revision could extend the fixed header, which would
+	 * shift the first controller structure. Stop rather than guess.
+	 */
+	if (table->revision != ACPI_RQSC_REVISION) {
+		pr_err("table revision %u, expected %u\n",
+		       table->revision, ACPI_RQSC_REVISION);
+		return;
+	}
+
+	if (table->length < sizeof(struct acpi_table_rqsc)) {
+		pr_err("table truncated: length %u\n", table->length);
+		return;
+	}
+
+	rqsc_parse((const struct acpi_table_rqsc *)table);
+}

-- 
2.43.0


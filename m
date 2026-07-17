Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C171379C2E;
	Fri, 17 Jul 2026 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270699; cv=none; b=SNO+5vYuaAcXX4w0dtjpma/kIqhxCiAGbm2U0GGHHZ5bWJaIJgddlsoODbf/P6rEt9dlZa8Bw2XDaLUVnGiKsJ5oxUtSpkHNECGg1lpRU43SC7pm92nsQm2RPTFNgBZypDAx5nzoY52yTe5d9kD6BN9U9C6LBI3evBhvsb3o5hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270699; c=relaxed/simple;
	bh=7hRA0dProPOutyB2IiNvsAo+dWkQqnYN8bcnIHOQuo8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OCs2n99QrjIhsgNO69mjjz8/0it1yfP8gqVvI2Gj1nwG8TkINVeDJ59aDh4kjPPKjPwArbErwptU3/cpo4HcxDjeUOQNldd9zjigRaasrIOH4rgWOdHTUsvMInaST5A7Itdu3WC+t4haRb9OPVm6qO3Yz8ZuON/oC288dNIWw/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Axz+tWz1lqKHYEAA--.17546S3;
	Fri, 17 Jul 2026 14:44:38 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHsdMz1lqgcoPAA--.43739S3;
	Fri, 17 Jul 2026 14:44:37 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn
Subject: [PATCH v2 1/4] ACPI: LoongArch: Add acpi_arch_[late]_init()
Date: Fri, 17 Jul 2026 14:37:10 +0800
Message-Id: <20260717063713.3638059-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260717063713.3638059-1-maobibo@loongson.cn>
References: <20260717063713.3638059-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHsdMz1lqgcoPAA--.43739S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

LoongArch IOMMU scanning flow is similar with virtio-iommu,
there is early init and late_init. In early init function, PCI
ACS is enabled if there is IOMMU table, and late_init is called
after PCI device scanning, where IOVT table scanning function is
executed.

Here add acpi_arch_init() and acpi_arch_late_init() API on LoongArch,
now they are both empty, In the future, IOVT table parsing will be
added.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/Makefile           |  2 +-
 drivers/acpi/bus.c              |  2 ++
 drivers/acpi/loongarch/Makefile |  2 ++
 drivers/acpi/loongarch/init.c   | 11 +++++++++++
 include/linux/acpi.h            |  1 +
 5 files changed, 17 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/loongarch/Makefile
 create mode 100644 drivers/acpi/loongarch/init.c

diff --git a/drivers/acpi/Makefile b/drivers/acpi/Makefile
index d1b0affb844f..91584a3c1e01 100644
--- a/drivers/acpi/Makefile
+++ b/drivers/acpi/Makefile
@@ -131,6 +131,6 @@ obj-y				+= dptf/
 obj-$(CONFIG_ARM64)		+= arm64/
 
 obj-$(CONFIG_ACPI_VIOT)		+= viot.o
-
+obj-$(CONFIG_LOONGARCH)		+= loongarch/
 obj-$(CONFIG_RISCV)		+= riscv/
 obj-$(CONFIG_X86)		+= x86/
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a30a904f6535..5f6924b9e29d 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1571,6 +1571,7 @@ struct kobject *acpi_kobj;
 EXPORT_SYMBOL_GPL(acpi_kobj);
 
 void __weak __init acpi_arch_init(void) { }
+void __weak __init acpi_arch_late_init(void) { }
 
 static int __init acpi_init(void)
 {
@@ -1609,6 +1610,7 @@ static int __init acpi_init(void)
 	acpi_wakeup_device_init();
 	acpi_debugger_init();
 	acpi_setup_sb_notify_handler();
+	acpi_arch_late_init();
 	acpi_viot_init();
 	return 0;
 }
diff --git a/drivers/acpi/loongarch/Makefile b/drivers/acpi/loongarch/Makefile
new file mode 100644
index 000000000000..d3764139dfaf
--- /dev/null
+++ b/drivers/acpi/loongarch/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-y					+= init.o
diff --git a/drivers/acpi/loongarch/init.c b/drivers/acpi/loongarch/init.c
new file mode 100644
index 000000000000..b11aa5c7d928
--- /dev/null
+++ b/drivers/acpi/loongarch/init.c
@@ -0,0 +1,11 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/acpi.h>
+
+void __init acpi_arch_init(void)
+{
+}
+
+void __init acpi_arch_late_init(void)
+{
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 60ab50cb8930..c6a180341c2d 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1617,6 +1617,7 @@ static inline int acpi_pptt_get_cpumask_from_cache_id(u32 cache_id,
 #endif
 
 void acpi_arch_init(void);
+void acpi_arch_late_init(void);
 
 #ifdef CONFIG_ACPI_PCC
 void acpi_init_pcc(void);
-- 
2.39.3


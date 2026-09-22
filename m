Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5122541460;
	Tue, 22 Sep 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790079506; cv=none; b=bURetWaEMUojm5I9/V77rlD/hYmeaRFevWgNLhL5XATuq1fBHrYKO3zQWGNpI4ElAnY9GcRpl5BzF+KLWs0pPlSglSWDhhxBhZ1AO4TNnzgrcF2/cvqGdh9PTP70d7UcmXu6wX3oTgZRqL9dlwR+L4jMYLSHsru/C/sRtIRSKSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790079506; c=relaxed/simple;
	bh=hg8WJ1umGhHtMg7e2zKZXqIrOo/tFdLKj9L+KyJYFvs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aVtN8bJ/miYSkff9zuK8P7n1G2GrUw7EfLoc8tW8qrnlXSwh25kYo5mrRbogOrFOPz7NOdrzhqes5wTV77Txlu6kTCc99vrjU3S6TEBzUAEbq+SlmH5o2meId7gubntc5SvrCPqFphfT6JWD7Chr+MotC5uCfBeeM4AKbv0OTGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxXdIMcrJqRKAOAA--.42879S3;
	Tue, 22 Sep 2026 20:18:20 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJBx6c0LcrJqysAjAA--.44690S2;
	Tue, 22 Sep 2026 20:18:19 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn
Subject: [PATCH v4 0/4] ACPI: LoongArch: Add IOVT table support
Date: Tue, 22 Sep 2026 20:10:54 +0800
Message-Id: <20260922121058.972734-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBx6c0LcrJqysAjAA--.44690S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

I/O Virtualization Table is ACPI table for LoongArch IOMMU devices, it
is merged on ACPI Spec 6.6, and it can be located at
  https://www.loongson.cn/uploads/images/2024110517404135188.LoongArch-IO-Virtualization-Table-Specification.pdf

Here add IOVT table parsing on LoongArch system, it is for LoongArch
IOMMU driver use in future.
---
v3 ... v4:
  1. Move kernel option ACPI_IOVT from patch 4 to patch 2.
  2. Move function call with iovt_iommu_configure_id() before function
     viot_iommu_configure() in acpi_iommu_configure_id().
  3. Rename LoongArch with LOONGARCH like other architecture in file
     MAINTAINERS.
  4. Set Huacai as one of Maintainers.

v2 ... v3:
  1. Add separate patch with header file include/linux/acpi_iovt.h,
     after it is merged in acpica tree.
  2. Modify patch set since macro name is changed in acpi_iovt.h
  3. Merge patch 1 and patch 2 together.

v1 ... v2:
  1. Reorganize the patch, patch 1/4 are merged, patch 3/5/6 are merged,
     add patch 2/8 are merged together.
  2. Enrich error printk information in iovt_get_pci_iommu_fwnode().
---
Bibo Mao (4):
  ACPICA: actbl2.h: Add bit constants of the Flags field in the IOVT
    IOMMU structure
  ACPI: LoongArch: Add acpi_arch_[late]_init()
  ACPI: scan: Add support for LoongArch in acpi_iommu_configure_id()
  MAINTAINERS: Add entry for drivers/acpi/loongarch

 MAINTAINERS                     |   9 +
 arch/loongarch/Kconfig          |   1 +
 drivers/acpi/Kconfig            |   4 +
 drivers/acpi/Makefile           |   2 +-
 drivers/acpi/bus.c              |   2 +
 drivers/acpi/loongarch/Kconfig  |   7 +
 drivers/acpi/loongarch/Makefile |   3 +
 drivers/acpi/loongarch/init.c   |  16 ++
 drivers/acpi/loongarch/init.h   |   5 +
 drivers/acpi/loongarch/iovt.c   | 280 ++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c             |   3 +
 include/acpi/actbl2.h           |   7 +
 include/linux/acpi.h            |   1 +
 include/linux/acpi_iovt.h       |  13 ++
 14 files changed, 352 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/loongarch/Kconfig
 create mode 100644 drivers/acpi/loongarch/Makefile
 create mode 100644 drivers/acpi/loongarch/init.c
 create mode 100644 drivers/acpi/loongarch/init.h
 create mode 100644 drivers/acpi/loongarch/iovt.c
 create mode 100644 include/linux/acpi_iovt.h


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.39.3


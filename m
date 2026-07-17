Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019DC349CF6;
	Fri, 17 Jul 2026 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270699; cv=none; b=oiYzskF3AwniIJsJ1D7GoJkhEjjBf0F0s1yUHxxMt1ZwW7vZv9cm341yNNrffy7sjcbm5Vnf/caEWFi43w55DQyOkS88rONjWqqjINqOeGDHJkh0kVYoNNW6eUTpyOkzxAWw2NyskAb3iO92j2A9ZIYrPTxHB75xLm5FyFw7KLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270699; c=relaxed/simple;
	bh=PWk78jdsrVyqdUbPvOkXeaRKpOQyl1T0Uzx+NdiZg5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UBEminj0Zca3lsjCA0eL3meUNWxNn+GrGsDEaLplhPj7sgCG4i8T0tnyq/5Ny5qp8hBJQLYgrhkRpH1yzW1gWUuXj8KwT8Vc7mnRaBf7IQAYnBe0LCDJSPaeh3Ef3xC3yL/7z0HSyyXWaUGqEksyhpjze2e5HnIbBkYjTTtqztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8Cx7+tVz1lqJHYEAA--.17771S3;
	Fri, 17 Jul 2026 14:44:37 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxHsdMz1lqgcoPAA--.43739S2;
	Fri, 17 Jul 2026 14:44:29 +0800 (CST)
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
Subject: [PATCH v2 0/4] ACPI: LoongArch: Add IOVT table support
Date: Fri, 17 Jul 2026 14:37:09 +0800
Message-Id: <20260717063713.3638059-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJAxHsdMz1lqgcoPAA--.43739S2
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
v1 ... v2:
  1. Reorganize the patch, patch 1/4 are merged, patch 3/5/6 are merged,
     add patch 2/8 are merged together.
  2. Enrich error printk information in iovt_get_pci_iommu_fwnode(). 
---
Bibo Mao (4):
  ACPI: LoongArch: Add acpi_arch_[late]_init()
  ACPI: LoongArch: Add IOVT device entry table scanning
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
 include/acpi/actbl2.h           |   3 +
 include/linux/acpi.h            |   1 +
 include/linux/acpi_iovt.h       |  13 ++
 14 files changed, 348 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/loongarch/Kconfig
 create mode 100644 drivers/acpi/loongarch/Makefile
 create mode 100644 drivers/acpi/loongarch/init.c
 create mode 100644 drivers/acpi/loongarch/init.h
 create mode 100644 drivers/acpi/loongarch/iovt.c
 create mode 100644 include/linux/acpi_iovt.h


base-commit: 58717b2a1365d06c8c64b72aa948541b53fe31eb
-- 
2.39.3


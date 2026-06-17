Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F5E3BE65C;
	Wed, 17 Jun 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682525; cv=none; b=M1YIEW1TgXgo1CefHlAmlXPs2YstZXVrFMbXCexkCTsuB4V5gwisQIdPYkRM/hHWIQHB3ya6R3KeX2uZvvm60jtlY8eggjqyZ63eO26mzjYl8X2UhlknrN3O7P6otNV5mxfzqgH360tkQh2bGxuZpJfjQM6Pe+9R+07B9DCwyN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682525; c=relaxed/simple;
	bh=9Uxmgg2wE06uYzgvYK8LAQZagMuNLok1sCbpF4nurvk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bM213jWqmDzCFMpTllTZbIv67XoqpGxXw1jSp3lk2X5BoaGqa+Ce4w/PEQZ3+JTgHuA412VvhHzCR0uHHSgQq8YhIQjxpQdg57QuvaBKhLR9NzlMh7d1cEBXD8thKsRSJ36NFh6qyCejiAjdS2+j0x8rybDknAOsR/zJf2masPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxhulSUTJqvQ4VAA--.54911S3;
	Wed, 17 Jun 2026 15:48:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxvsJOUTJqnQupAA--.58263S2;
	Wed, 17 Jun 2026 15:48:30 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Saket Dumbre <saket.dumbre@intel.com>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn,
	bibo.mao@gmail.com
Subject: [PATCH 0/8] ACPI: LoongArch: Add IOVT table support
Date: Wed, 17 Jun 2026 15:48:21 +0800
Message-Id: <20260617074829.2396638-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvsJOUTJqnQupAA--.58263S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

I/O Virtualization Table is ACPI table for LoongArch IOMMU devices, it
is merged on ACPI Spec 6.6, and it can be located at
  https://www.loongson.cn/uploads/images/2024110517404135188.LoongArch-IO-Virtualization-Table-Specification.pdf

Here add IOVT table parsing on LoongArch system, it is for use about
LoongArch IOMMU driver in future.

Bibo Mao (8):
  ACPI: LoongArch: Add acpi_arch_init() support
  ACPI: LoongArch: Add ACPI_IOVT option
  ACPI: LoongArch: Enable pci acs function if acpi iovt tables exist
  ACPI: LoongArch: Add acpi_arch_late_init support
  ACPI: LoongArch: Scan IOMMU devices in IOVT table
  ACPI: LoongArch: Add iovt device entry table scanning
  ACPI: scan: Add support for LoongArch in acpi_iommu_configure_id()
  MAINTAINERS: Add entry for drivers/acpi/loongarch

 MAINTAINERS                     |   9 ++
 arch/loongarch/Kconfig          |   1 +
 drivers/acpi/Kconfig            |   4 +
 drivers/acpi/Makefile           |   2 +-
 drivers/acpi/bus.c              |   2 +
 drivers/acpi/loongarch/Kconfig  |   7 +
 drivers/acpi/loongarch/Makefile |   3 +
 drivers/acpi/loongarch/init.c   |  16 ++
 drivers/acpi/loongarch/init.h   |   5 +
 drivers/acpi/loongarch/iovt.c   | 274 ++++++++++++++++++++++++++++++++
 drivers/acpi/scan.c             |   3 +
 include/acpi/actbl2.h           |   3 +
 include/linux/acpi.h            |   1 +
 include/linux/acpi_iovt.h       |  13 ++
 14 files changed, 342 insertions(+), 1 deletion(-)
 create mode 100644 drivers/acpi/loongarch/Kconfig
 create mode 100644 drivers/acpi/loongarch/Makefile
 create mode 100644 drivers/acpi/loongarch/init.c
 create mode 100644 drivers/acpi/loongarch/init.h
 create mode 100644 drivers/acpi/loongarch/iovt.c
 create mode 100644 include/linux/acpi_iovt.h


base-commit: 6b5a2b7d9bc156e505f09e698d85d6a1547c1206
-- 
2.39.3


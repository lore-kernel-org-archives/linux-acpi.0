Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4DCE3191BA;
	Wed, 17 Jun 2026 07:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682525; cv=none; b=gREpyrRhTS7zYU+SFtjG2vEy6LWwl1Yp+kV+NMrFBRKtOvcAGQvtWSDUN5m4eq09HQ1X10bXvFDYMs/sdHBOPEhB2OCm1a3iTYsHJcbFC0uRmCwameNLgv7KtDfzkMzOqWG03FvJx82vPocXALZw4PotDSEhPHXITpAcE4poN8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682525; c=relaxed/simple;
	bh=KmBEdJaasad1iH/j/Df48b0Na5QULU48rgWWqNRBbpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YXQ9/2nRDSYKVcdoDfjEWkR+DVtZD1TWFSoW0peXC85iTrG6XotU2DBIrjqGJqQUvsaBSBnmw764tdxxjY9rzeUaZAnl27KbVj6Fe8ayoexPJcvHX6NlO63xjx3ut1POHQ4sJqbFLlfvKy3lD4QUk98mtvhd0BcWAS1MoZjnXU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxlnhSUTJqvw4VAA--.30420S3;
	Wed, 17 Jun 2026 15:48:34 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxvsJOUTJqnQupAA--.58263S3;
	Wed, 17 Jun 2026 15:48:33 +0800 (CST)
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
Subject: [PATCH 1/8] ACPI: LoongArch: Add acpi_arch_init() support
Date: Wed, 17 Jun 2026 15:48:22 +0800
Message-Id: <20260617074829.2396638-2-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260617074829.2396638-1-maobibo@loongson.cn>
References: <20260617074829.2396638-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJCxvsJOUTJqnQupAA--.58263S3
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

Add acpi_arch_init() API on LoongArch, now it is empty.
In the future, IOVT table parsing will be added.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 drivers/acpi/Makefile           | 2 +-
 drivers/acpi/loongarch/Makefile | 2 ++
 drivers/acpi/loongarch/init.c   | 7 +++++++
 3 files changed, 10 insertions(+), 1 deletion(-)
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
index 000000000000..7008e50b3e9d
--- /dev/null
+++ b/drivers/acpi/loongarch/init.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/acpi.h>
+
+void __init acpi_arch_init(void)
+{
+}
-- 
2.39.3


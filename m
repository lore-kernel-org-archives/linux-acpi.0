Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E453B9DAC;
	Wed, 17 Jun 2026 07:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781682526; cv=none; b=ne1xeJGIBiOZHklOQfQ3poxAFOUZOIqL0L4/e8tXYHH4LldVp0GLLotMcO85OIWFVDFBk+IN8Tf64TXeVksXpyr5LlkUxfvd8z6bWttw26EtkIrhbEfVH4CUzfb5ddBz3eK12oHPvV/1/XFn9gtdXJRJpC3LIUBV9g/j9FAs+nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781682526; c=relaxed/simple;
	bh=anlFCHDTrDxUv5RszMYvwk8Tjj5yiDFn3EV+mjIEexk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MODyww2+7wu/L/kUBSCraG5Jah4BYOg1xIBJ8B0IKa6zIvF9Z0aMj4jq8qnQ0nmc3xa7u/Q2X+ZrED4obchAmRNgQ5qXYhQyIVj+YA7mWbj7dOkq670lrxW89YoInPXi1qMMvJV5BfAolPDY19lcrSLcA3IL+vJlAd7H04IfawY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8AxAutTUTJqxQ4VAA--.55364S3;
	Wed, 17 Jun 2026 15:48:35 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJCxvsJOUTJqnQupAA--.58263S4;
	Wed, 17 Jun 2026 15:48:34 +0800 (CST)
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
Subject: [PATCH 2/8] ACPI: LoongArch: Add ACPI_IOVT option
Date: Wed, 17 Jun 2026 15:48:23 +0800
Message-Id: <20260617074829.2396638-3-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJCxvsJOUTJqnQupAA--.58263S4
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

ACPI_IOVT is acpi table with IOMMU device on LoongArch system, here
option ACPI_IOVT is added. And empty function acpi_iovt_init() is
added and called in acpi_arch_init().

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 arch/loongarch/Kconfig          | 1 +
 drivers/acpi/Kconfig            | 4 ++++
 drivers/acpi/loongarch/Kconfig  | 7 +++++++
 drivers/acpi/loongarch/Makefile | 1 +
 drivers/acpi/loongarch/init.c   | 3 +++
 drivers/acpi/loongarch/init.h   | 4 ++++
 drivers/acpi/loongarch/iovt.c   | 7 +++++++
 7 files changed, 27 insertions(+)
 create mode 100644 drivers/acpi/loongarch/Kconfig
 create mode 100644 drivers/acpi/loongarch/init.h
 create mode 100644 drivers/acpi/loongarch/iovt.c

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 3f69c5d7e48e..6f0b6b539c0b 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -6,6 +6,7 @@ config LOONGARCH
 	select ACPI_GENERIC_GSI if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_HOTPLUG_CPU if ACPI_PROCESSOR && HOTPLUG_CPU
+	select ACPI_IOVT if ACPI
 	select ACPI_PPTT if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_BINFMT_ELF_STATE
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f165d14cf61a..192e6f18eda1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -550,6 +550,10 @@ if ARM64
 source "drivers/acpi/arm64/Kconfig"
 endif
 
+if LOONGARCH
+source "drivers/acpi/loongarch/Kconfig"
+endif
+
 if RISCV
 source "drivers/acpi/riscv/Kconfig"
 endif
diff --git a/drivers/acpi/loongarch/Kconfig b/drivers/acpi/loongarch/Kconfig
new file mode 100644
index 000000000000..91ba3c35b9bf
--- /dev/null
+++ b/drivers/acpi/loongarch/Kconfig
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# ACPI Configuration for LOONGARCH
+#
+
+config ACPI_IOVT
+	bool
diff --git a/drivers/acpi/loongarch/Makefile b/drivers/acpi/loongarch/Makefile
index d3764139dfaf..c338d3102fc1 100644
--- a/drivers/acpi/loongarch/Makefile
+++ b/drivers/acpi/loongarch/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y					+= init.o
+obj-$(CONFIG_ACPI_IOVT)			+= iovt.o
diff --git a/drivers/acpi/loongarch/init.c b/drivers/acpi/loongarch/init.c
index 7008e50b3e9d..9233f6c1cb55 100644
--- a/drivers/acpi/loongarch/init.c
+++ b/drivers/acpi/loongarch/init.c
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include <linux/acpi.h>
+#include "init.h"
 
 void __init acpi_arch_init(void)
 {
+	if (IS_ENABLED(CONFIG_ACPI_IOVT))
+		acpi_iovt_init();
 }
diff --git a/drivers/acpi/loongarch/init.h b/drivers/acpi/loongarch/init.h
new file mode 100644
index 000000000000..070ea187bfae
--- /dev/null
+++ b/drivers/acpi/loongarch/init.h
@@ -0,0 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/init.h>
+
+void __init acpi_iovt_init(void);
diff --git a/drivers/acpi/loongarch/iovt.c b/drivers/acpi/loongarch/iovt.c
new file mode 100644
index 000000000000..793ed13a2cef
--- /dev/null
+++ b/drivers/acpi/loongarch/iovt.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include "init.h"
+
+void __init acpi_iovt_init(void)
+{
+}
-- 
2.39.3


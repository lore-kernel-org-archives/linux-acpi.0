Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8803C109E;
	Fri, 17 Jul 2026 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270714; cv=none; b=eqRtgv2X+kauiHgnDFW8lkrX/qAOXLfeHGMYpbw4MqbTqguPRL7oMDoHfaEQJSJQbgAm1in0AfMqnnyEdmCNXXgtLvekGvlornrziBgFt34p7Al3s53UnKVMauuk2G9Q7q83sbmsuAOcO25sga1ycoekAis/7Xhk7YajxAfSQ5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270714; c=relaxed/simple;
	bh=WOL0l221EVL0EQLvBdanmj6khszyikYykIOgdHGUeiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gGoIZoNzjEK0WgzRC6mhdWOTOORDWBLYHov4JyjpyMWTPylGglZdGpK7MUMFVPdyn+Ro0RtXQo57gs5YojlSVuNG9Vz0mItalIM5BfMENkZ1lsWuyoVLyNal0zDjjY3qLOhmdGs/5vrv4xyo8JKechQ6ZA/Rw4MUgyWswlLJJyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8BxyvBaz1lqNnYEAA--.17765S3;
	Fri, 17 Jul 2026 14:44:42 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJAxDcVYz1lqiMoPAA--.17706S2;
	Fri, 17 Jul 2026 14:44:40 +0800 (CST)
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
Subject: [PATCH v2 4/4] MAINTAINERS: Add entry for drivers/acpi/loongarch
Date: Fri, 17 Jul 2026 14:37:13 +0800
Message-Id: <20260717063713.3638059-5-maobibo@loongson.cn>
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
X-CM-TRANSID:qMiowJAxDcVYz1lqiMoPAA--.17706S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

ACPI defines few LoongArch specific tables which need parsing code
added in drivers/acpi/loongarch. Add maintainer entries for this newly
created folder.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 MAINTAINERS            | 9 +++++++++
 arch/loongarch/Kconfig | 1 +
 2 files changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ce5c5185c773..d741f87fcf8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -348,6 +348,15 @@ S:	Maintained
 F:	drivers/acpi/riscv/
 F:	include/linux/acpi_rimt.h
 
+ACPI FOR LoongArch (ACPI/LoongArch)
+M:	Bibo Mao <maobibo@loongson.cn>
+R:	Huacai Chen <chenhuacai@kernel.org>
+L:	linux-acpi@vger.kernel.org
+L:	loongarch@lists.linux.dev
+S:	Maintained
+F:	drivers/acpi/loongarch/
+F:	include/linux/acpi_iovt.h
+
 ACPI PCC(Platform Communication Channel) MAILBOX DRIVER
 M:	Sudeep Holla <sudeep.holla@kernel.org>
 L:	linux-acpi@vger.kernel.org
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index d8d252325017..ee3d591ace04 100644
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
-- 
2.39.3


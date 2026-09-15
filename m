Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0A41D208;
	Tue, 15 Sep 2026 03:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443250; cv=none; b=uHjxpQ0V2iyoVDQLGxYA3IYgOzFdR4kHyM/hVzFsacB/xpBQ6TT4xi2sZoojsBvkR8LBxibtOVt32hcycFSIkXKVRmsFbUxPBnaMMKslDgjWl9JfxHmk+k7hXMTY56w+kg+8kWYCZp7jDhJ3hQfqvjyM4agoq318LeDaIHMqsXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443250; c=relaxed/simple;
	bh=d/PzSr+pBWwRCmGUUPhTcFzuPPuRKZn8WKjlMX5ulvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JWi9kgI5vww039xEJNa0ikvu6GtQWdL/f73Rf9DdfAIoHjlD25N/Siw+el9v/EwEWtCuZXi8J//8B5CW7ATYuUrsKeqLEw/jNBbj5NsnF+wFFh2c3LpecwQbA+LOKDzDR5BHNiQhz9ze5Va7ap4jT7fCnWgrtkp3CL2tbK6w0/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxTtOnvKhquREMAA--.34799S3;
	Tue, 15 Sep 2026 11:33:59 +0800 (CST)
Received: from localhost.localdomain (unknown [10.2.5.213])
	by front1 (Coremail) with SMTP id qMiowJDxDc+mvKhqk90gAA--.37043S2;
	Tue, 15 Sep 2026 11:33:58 +0800 (CST)
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
Subject: [PATCH v3 4/4] MAINTAINERS: Add entry for drivers/acpi/loongarch
Date: Tue, 15 Sep 2026 11:26:27 +0800
Message-Id: <20260915032627.2796747-5-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20260915032627.2796747-1-maobibo@loongson.cn>
References: <20260915032627.2796747-1-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJDxDc+mvKhqk90gAA--.37043S2
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
index c2414447892c..e19be0c1654e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -347,6 +347,15 @@ S:	Maintained
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
index 2067d1f2ad7a..d7f8e4fec952 100644
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


From: Aleksey Makarov <aleksey.makarov@linaro.org>
Subject: [PATCH v4 4/5] ACPI: table upgrade: introduce ARCH_HAS_ACPI_TABLE_UPGRADE
Date: Mon, 20 Jun 2016 13:56:12 +0300
Message-ID: <20160620105615.15538-5-aleksey.makarov@linaro.org>
References: <20160620105615.15538-1-aleksey.makarov@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-lf0-f41.google.com ([209.85.215.41]:34742 "EHLO
	mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753311AbcFTK5i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 20 Jun 2016 06:57:38 -0400
Received: by mail-lf0-f41.google.com with SMTP id h129so34324520lfh.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jun 2016 03:56:41 -0700 (PDT)
In-Reply-To: <20160620105615.15538-1-aleksey.makarov@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Aleksey Makarov <aleksey.makarov@linaro.org>, Graeme Gregory <graeme.gregory@linaro.org>, Jon Masters <jcm@redhat.com>, "Zheng, Lv" <lv.zheng@intel.com>, Mark Rutland <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org

We want to use the table upgrade feature in ARM64.
Introduce a new configuration option that allows that.

Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
---
 arch/x86/Kconfig     | 1 +
 drivers/acpi/Kconfig | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 39f8277..bb73293 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -22,6 +22,7 @@ config X86
 	select ANON_INODES
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_DISCARD_MEMBLOCK
+	select ARCH_HAS_ACPI_TABLE_UPGRADE if ACPI
 	select ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index f98c328..1cde30b 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -314,9 +314,12 @@ config ACPI_CUSTOM_DSDT
 	bool
 	default ACPI_CUSTOM_DSDT_FILE != ""
 
+config ARCH_HAS_ACPI_TABLE_UPGRADE
+	def_bool n
+
 config ACPI_TABLE_UPGRADE
 	bool "Allow upgrading ACPI tables via initrd"
-	depends on BLK_DEV_INITRD && X86
+	depends on BLK_DEV_INITRD && ARCH_HAS_ACPI_TABLE_UPGRADE
 	default y
 	help
 	  This option provides functionality to upgrade arbitrary ACPI tables
-- 
2.8.3


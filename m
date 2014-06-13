From: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Subject: [PATCH v3 2/5] acpi, apei, ghes: Introduce ARCH_HAS_ACPI_APEI_NMI to make NMI error notification a GHES feature.
Date: Fri, 13 Jun 2014 13:02:57 +0200
Message-ID: <1402657380-18539-3-git-send-email-tomasz.nowicki@linaro.org>
References: <1402657380-18539-1-git-send-email-tomasz.nowicki@linaro.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:65349 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752936AbaFMLDZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 13 Jun 2014 07:03:25 -0400
Received: by mail-wg0-f42.google.com with SMTP id z12so2487027wgg.1
        for <linux-acpi@vger.kernel.org>; Fri, 13 Jun 2014 04:03:24 -0700 (PDT)
In-Reply-To: <1402657380-18539-1-git-send-email-tomasz.nowicki@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, tony.luck@intel.com, bp@alien8.de, m.chehab@samsung.com, bp@suse.de
Cc: linux-edac@vger.kernel.org, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-acpi@lists.linaro.org, rric@kernel.org, Tomasz Nowicki <tomasz.nowicki@linaro.org>

Currently APEI depends on x86 architecture. It is because of NMI hardware
error notification of GHES which is currently supported by x86 only.
However, many other APEI features can be still used perfectly by other
architectures.

This commit adds ARCH_HAS_ACPI_APEI_NMI which will be used in next patches
for NMI related code isolation in ghes.c file. Only NMI error notification
feature depends on x86 so let it be hard selected for x86 arch.

Signed-off-by: Tomasz Nowicki <tomasz.nowicki@linaro.org>
---
 arch/x86/Kconfig          |    1 +
 drivers/acpi/apei/Kconfig |    8 +++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3fc9b12..e1dc819 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -24,6 +24,7 @@ config X86
 	select ARCH_HAS_DEBUG_STRICT_USER_COPY_CHECKS
 	select ARCH_MIGHT_HAVE_PC_PARPORT
 	select ARCH_MIGHT_HAVE_PC_SERIO
+	select ARCH_HAS_ACPI_APEI_NMI
 	select HAVE_AOUT if X86_32
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select ARCH_SUPPORTS_NUMA_BALANCING if X86_64
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index c4dac71..9f6c3ec 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -3,7 +3,6 @@ config ACPI_APEI
 	select MISC_FILESYSTEMS
 	select PSTORE
 	select UEFI_CPER
-	depends on X86
 	help
 	  APEI allows to report errors (for example from the chipset)
 	  to the operating system. This improves NMI handling
@@ -26,6 +25,13 @@ config ACPI_APEI_GHES
 	  by firmware to produce more valuable hardware error
 	  information for Linux.
 
+config ARCH_HAS_ACPI_APEI_NMI
+	bool
+	help
+	  Firmware first mode can use NMI notification mechanism to report errors
+	  to operating system. This feature is currently supported by X86
+	  architecture only.
+
 config ACPI_APEI_PCIEAER
 	bool "APEI PCIe AER logging/recovering support"
 	depends on ACPI_APEI && PCIEAER
-- 
1.7.9.5


From: Tyler Baicar <tbaicar@codeaurora.org>
Subject: [PATCH V2] arm64: kconfig: allow support for memory failure handling
Date: Tue, 21 Feb 2017 16:45:23 -0700
Message-ID: <1487720723-14871-1-git-send-email-tbaicar@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:37862 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752000AbdBUXp2 (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 21 Feb 2017 18:45:28 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: catalin.marinas@arm.com, will.deacon@arm.com, rjw@rjwysocki.net, lenb@kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, punit.agrawal@arm.com
Cc: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>

From: "Jonathan (Zhixiong) Zhang" <zjzhang@codeaurora.org>

If ACPI_APEI and MEMORY_FAILURE is configured, select
ACPI_APEI_MEMORY_FAILURE. This enables memory failure recovery
when such memory failure is reported through ACPI APEI. APEI
(ACPI Platform Error Interfaces) provides a means for the
platform to convey error information to the kernel.

Declare ARCH_SUPPORTS_MEMORY_FAILURE, as arm64 does support
memory failure recovery attempt.

Signed-off-by: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Signed-off-by: Tyler Baicar <tbaicar@codeaurora.org>
---
 arch/arm64/Kconfig        | 1 +
 drivers/acpi/apei/Kconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1117421..61e0bb0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -15,6 +15,7 @@ config ARM64
 	select ARCH_HAS_SG_CHAIN
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_USE_CMPXCHG_LOCKREF
+	select ARCH_SUPPORTS_MEMORY_FAILURE
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
diff --git a/drivers/acpi/apei/Kconfig b/drivers/acpi/apei/Kconfig
index b0140c8..6d9a812 100644
--- a/drivers/acpi/apei/Kconfig
+++ b/drivers/acpi/apei/Kconfig
@@ -9,6 +9,7 @@ config ACPI_APEI
 	select MISC_FILESYSTEMS
 	select PSTORE
 	select UEFI_CPER
+	select ACPI_APEI_MEMORY_FAILURE if MEMORY_FAILURE
 	depends on HAVE_ACPI_APEI
 	help
 	  APEI allows to report errors (for example from the chipset)
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.


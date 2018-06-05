From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 3/3] arm64: disable ACPI PPTT support temporarily
Date: Tue,  5 Jun 2018 14:55:38 +0100
Message-ID: <1528206938-2702-3-git-send-email-sudeep.holla@arm.com>
References: <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <1528206938-2702-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1528206938-2702-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Catalin Marinas <catalin.marinas@arm.com>, Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Hanjun Guo <hanjun.guo@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Will Deacon <will.deacon@arm.com>
List-Id: linux-acpi@vger.kernel.org

Currently, ARM64 doesn't support updating the CPU topology masks on
CPU hotplug operations. ACPI PPTT support rely on that missing feature
which is technically not incorrect. Instead of reverting all the PPTT
support, let's keep it simple and disable ACPI PPTT support on ARM64
for time-being until the topology updates are added for CPU hotplug
operations.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9fd4a8ccce07..98a5c78a80f9 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -7,7 +7,6 @@ config ARM64
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
 	select ACPI_MCFG if ACPI
 	select ACPI_SPCR_TABLE if ACPI
-	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
-- 
2.7.4

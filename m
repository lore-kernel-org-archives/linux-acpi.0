From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v12 5/7] arm64: select ACPI PCI code only when both features are enabled
Date: Wed, 19 Dec 2018 22:46:57 +0000
Message-ID: <20181219224659.4802-6-okaya@kernel.org>
References: <20181219224659.4802-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219224659.4802-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Sinan Kaya <okaya@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "moderated list:ARM64 PORT
        AARCH64 ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

ACPI and PCI are no longer coupled to each other. Specify requirements
for both when pulling in code.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
---
 arch/arm64/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index ea2ab0330e3a..bcb6262044d8 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -5,7 +5,7 @@ config ARM64
 	select ACPI_GTDT if ACPI
 	select ACPI_IORT if ACPI
 	select ACPI_REDUCED_HARDWARE_ONLY if ACPI
-	select ACPI_MCFG if ACPI
+	select ACPI_MCFG if (ACPI && PCI)
 	select ACPI_SPCR_TABLE if ACPI
 	select ACPI_PPTT if ACPI
 	select ARCH_CLOCKSOURCE_DATA
@@ -163,7 +163,7 @@ config ARM64
 	select OF
 	select OF_EARLY_FLATTREE
 	select OF_RESERVED_MEM
-	select PCI_ECAM if ACPI
+	select PCI_ECAM if (ACPI && PCI)
 	select POWER_RESET
 	select POWER_SUPPLY
 	select REFCOUNT_FULL
-- 
2.19.0

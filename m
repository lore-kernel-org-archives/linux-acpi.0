From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] arm64: fix ACPI dependencies
Date: Tue, 24 Jul 2018 11:33:17 +0200
Message-ID: <20180724093345.1575921-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Marc Zyngier <marc.zyngier@arm.com>, linux-kernel@vger.kernel.org, AKASHI Takahiro <takahiro.akashi@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

Kconfig reports a warning on x86 builds after the ARM64 dependency
was added.

drivers/acpi/Kconfig:6:error: recursive dependency detected!
drivers/acpi/Kconfig:6:       symbol ACPI depends on EFI

This rephrases the dependency to keep the ARM64 details out of the
shared Kconfig file, so Kconfig no longer gets confused by it.

Fixes: 5bcd44083a08 ("drivers: acpi: add dependency of EFI for arm64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/Kconfig   | 1 +
 drivers/acpi/Kconfig | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index cdcaa6a798b2..2f987a938405 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1267,6 +1267,7 @@ config EFI
 	bool "UEFI runtime support"
 	depends on OF && !CPU_BIG_ENDIAN
 	depends on KERNEL_MODE_NEON
+	select ARCH_SUPPORTS_ACPI
 	select LIBFDT
 	select UCS2_STRING
 	select EFI_PARAMS_FROM_FDT
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a8da730fabc6..0cda51c5d433 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,7 +6,7 @@
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
-	depends on IA64 || X86 || (ARM64 && EFI)
+	depends on IA64 || X86 || ARCH_SUPPORTS_ACPI
 	depends on PCI
 	select PNP
 	default y if (IA64 || X86)
@@ -41,6 +41,9 @@ menuconfig ACPI
 	  <http://www.acpi.info>
 	  <http://www.uefi.org/acpi/specs>
 
+config ARCH_SUPPORTS_ACPI
+	bool
+
 if ACPI
 
 config ACPI_LEGACY_TABLES_LOOKUP
-- 
2.18.0

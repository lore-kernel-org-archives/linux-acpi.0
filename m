From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ACPI: fix menuconfig presentation of ACPI submenu
Date: Tue, 21 Aug 2018 22:37:33 +0200
Message-ID: <20180821203750.2394352-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

My fix for a recursive Kconfig dependency caused another issue where the
ACPI specific options end up in the top-level menu in 'menuconfig'. This
was an unintended side-effect of having a silent option between
'menuconfig ACPI' and 'if ACPI'.

Moving the ARCH_SUPPORTS_ACPI symbol ahead of the ACPI menu solves that
problem and restores the previous presentation.

Reported-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Fixes: 2c870e61132c ("arm64: fix ACPI dependencies")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 1edca05ee0ae..e92eab1e960c 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -3,6 +3,9 @@
 # ACPI Configuration
 #
 
+config ARCH_SUPPORTS_ACPI
+	bool
+
 menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on ARCH_SUPPORTS_ACPI
@@ -40,9 +43,6 @@ menuconfig ACPI
 	  <http://www.acpi.info>
 	  <http://www.uefi.org/acpi/specs>
 
-config ARCH_SUPPORTS_ACPI
-	bool
-
 if ACPI
 
 config ACPI_LEGACY_TABLES_LOOKUP
-- 
2.18.0

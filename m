From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] ACPI: remove "config ACPI_DEBUG_FUNC_TRACE"
Date: Tue, 19 Mar 2013 11:41:01 +0100
Message-ID: <1363689661.1390.9.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Kconfig symbol ACPI_DEBUG_FUNC_TRACE was only used (through its
corresponding macro) in drivers/acpi/acpica/acmacros.h. That macro was
removed from that header in v3.8, with commit
86ff0e508f88eda6e479a897476026055831d2d8 ("ACPICA: Fix unmerged
acmacros.h divergences."). That commit did not explain why that macro
was removed. But it seems that ACPI_DEBUG_FUNC_TRACE can now be removed
too, as it is unused.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Eyeball tested.

 drivers/acpi/Kconfig | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 92ed969..006b714 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -298,14 +298,6 @@ config ACPI_DEBUG
 	  Documentation/kernel-parameters.txt to control the type and
 	  amount of debug output.
 
-config ACPI_DEBUG_FUNC_TRACE
-	bool "Additionally enable ACPI function tracing"
-	default n
-	depends on ACPI_DEBUG
-	help
-	  ACPI Debug Statements slow down ACPI processing. Function trace
-	  is about half of the penalty and is rarely useful.
-
 config ACPI_PCI_SLOT
 	bool "PCI slot detection driver"
 	depends on SYSFS
-- 
1.7.11.7

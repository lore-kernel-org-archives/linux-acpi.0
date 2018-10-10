From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] ACPI: remove redundant 'default n' from Kconfig
Date: Wed, 10 Oct 2018 16:41:30 +0200
Message-ID: <20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da~cRlJN49vs2486624866eucas1p1i@eucas1p1.samsung.com>
References: <CGME20181010144131eucas1p1974d23e4f09a49ed772575b9cc3770da@eucas1p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

'default n' is the default value for any bool or tristate Kconfig
setting so there is no need to write it explicitly.

Also since commit f467c5640c29 ("kconfig: only write '# CONFIG_FOO
is not set' for visible symbols") the Kconfig behavior is the same
regardless of 'default n' being present or not:

    ...
    One side effect of (and the main motivation for) this change is making
    the following two definitions behave exactly the same:
    
        config FOO
                bool
    
        config FOO
                bool
                default n
    
    With this change, neither of these will generate a
    '# CONFIG_FOO is not set' line (assuming FOO isn't selected/implied).
    That might make it clearer to people that a bare 'default n' is
    redundant.
    ...

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/acpi/Kconfig |    6 ------
 1 file changed, 6 deletions(-)

Index: b/drivers/acpi/Kconfig
===================================================================
--- a/drivers/acpi/Kconfig	2018-09-26 15:54:31.942819766 +0200
+++ b/drivers/acpi/Kconfig	2018-10-10 16:38:09.691897907 +0200
@@ -138,7 +138,6 @@ config ACPI_REV_OVERRIDE_POSSIBLE
 
 config ACPI_EC_DEBUGFS
 	tristate "EC read/write access through /sys/kernel/debug/ec"
-	default n
 	help
 	  Say N to disable Embedded Controller /sys/kernel/debug interface
 
@@ -283,7 +282,6 @@ config ACPI_PROCESSOR
 config ACPI_IPMI
 	tristate "IPMI"
 	depends on IPMI_HANDLER
-	default n
 	help
 	  This driver enables the ACPI to access the BMC controller. And it
 	  uses the IPMI request/response message to communicate with BMC
@@ -361,7 +359,6 @@ config ACPI_TABLE_UPGRADE
 
 config ACPI_DEBUG
 	bool "Debug Statements"
-	default n
 	help
 	  The ACPI subsystem can produce debug output.  Saying Y enables this
 	  output and increases the kernel size by around 50K.
@@ -374,7 +371,6 @@ config ACPI_DEBUG
 config ACPI_PCI_SLOT
 	bool "PCI slot detection driver"
 	depends on SYSFS
-	default n
 	help
 	  This driver creates entries in /sys/bus/pci/slots/ for all PCI
 	  slots in the system.  This can help correlate PCI bus addresses,
@@ -436,7 +432,6 @@ config ACPI_HED
 config ACPI_CUSTOM_METHOD
 	tristate "Allow ACPI methods to be inserted/replaced at run time"
 	depends on DEBUG_FS
-	default n
 	help
 	  This debug facility allows ACPI AML methods to be inserted and/or
 	  replaced without rebooting the system. For details refer to:
@@ -481,7 +476,6 @@ config ACPI_EXTLOG
 	tristate "Extended Error Log support"
 	depends on X86_MCE && X86_LOCAL_APIC && EDAC
 	select UEFI_CPER
-	default n
 	help
 	  Certain usages such as Predictive Failure Analysis (PFA) require
 	  more information about the error than what can be described in

From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH] ACPI: Remove the use of CONFIG_ACPI_HOTPLUG_MEMORY_MODULE
Date: Tue, 18 Jun 2013 15:06:45 -0600
Message-ID: <1371589605-15638-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>
List-Id: linux-acpi@vger.kernel.org

config ACPI_HOTPLUG_MEMORY has been changed to bool (y/n), and
its module option is no longer valid.  So, remove the use of
CONFIG_ACPI_HOTPLUG_MEMORY_MODULE.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 include/linux/acpi.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 17b5b59..353ba25 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -352,8 +352,7 @@ extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
 
 /* Enable _OST when all relevant hotplug operations are enabled */
 #if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
-	(defined(CONFIG_ACPI_HOTPLUG_MEMORY) ||		\
-	 defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)) &&	\
+	defined(CONFIG_ACPI_HOTPLUG_MEMORY) &&		\
 	defined(CONFIG_ACPI_CONTAINER)
 #define ACPI_HOTPLUG_OST
 #endif

From: Adrian Bunk <bunk@stusta.de>
Subject: [RFC: 2.6 patch] enable ACPI_HOTPLUG_CPU automatically if HOTPLUG_CPU=y
Date: Tue, 12 Jul 2005 21:51:20 +0200
Message-ID: <20050712195120.GH4034@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S262314AbVGLTvZ@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: len.brown@intel.com
Cc: acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Does the combination
- HOTPLUG_CPU=y
- ACPI_PROCESSOR=y
- ACPI_HOTPLUG_CPU=n
make any sense?


If not, please apply this patch.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.13-rc2-mm2-full/drivers/acpi/Kconfig.old	2005-07-12 21:45:41.000000000 +0200
+++ linux-2.6.13-rc2-mm2-full/drivers/acpi/Kconfig	2005-07-12 21:46:04.000000000 +0200
@@ -153,12 +153,10 @@
 	  support it.
 
 config ACPI_HOTPLUG_CPU
-	bool "Processor Hotplug (EXPERIMENTAL)"
-	depends on ACPI_PROCESSOR && HOTPLUG_CPU && EXPERIMENTAL
+	bool
+	depends on ACPI_PROCESSOR && HOTPLUG_CPU
 	select ACPI_CONTAINER
-	default n
-	 ---help---
-	 Select this option if your platform support physical CPU hotplug.
+	default y
 
 config ACPI_THERMAL
 	tristate "Thermal Zone"

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Date: Tue, 25 Jul 2006 16:18:54 -0700
Message-ID: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:30510 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030247AbWGYXTB (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 25 Jul 2006 19:19:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: len.brown@intel.com, akpm@osdl.org, zippel@linux-m68k.org, rdunlap@xenotime.net, linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net

---
the build options submitted for 2.6.18-rcX for acpiphp and the dock
module are not quite right.  Can you please review this patch and 
make sure this makes sense?  I'd like this pushed to Linus as 
soon as possible.  

Change the build options for acpiphp so that it may build without
being dependent on the ACPI_DOCK option, but yet does not allow
the option of acpiphp being built-in when dock is built as a 
module.

Signed-off-by: Randy Dunlap <rdunlap@xenotime.net>
Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/pci/hotplug/Kconfig |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

--- 2.6-git.orig/drivers/pci/hotplug/Kconfig
+++ 2.6-git/drivers/pci/hotplug/Kconfig
@@ -74,9 +74,10 @@ config HOTPLUG_PCI_IBM
 
 	  When in doubt, say N.
 
+if ACPI_DOCK=n
 config HOTPLUG_PCI_ACPI
 	tristate "ACPI PCI Hotplug driver"
-	depends on ACPI_DOCK && HOTPLUG_PCI
+	depends on ACPI && HOTPLUG_PCI
 	help
 	  Say Y here if you have a system that supports PCI Hotplug using
 	  ACPI.
@@ -85,6 +86,20 @@ config HOTPLUG_PCI_ACPI
 	  module will be called acpiphp.
 
 	  When in doubt, say N.
+endif
+if ACPI_DOCK!=n
+config HOTPLUG_PCI_ACPI
+	tristate "ACPI PCI Hotplug driver"
+	depends on HOTPLUG_PCI && ACPI_DOCK
+	help
+	  Say Y here if you have a system that supports PCI Hotplug using
+	  ACPI.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called acpiphp.
+
+	  When in doubt, say N.
+endif
 
 config HOTPLUG_PCI_ACPI_IBM
 	tristate "ACPI PCI Hotplug driver IBM extensions"

From: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
Subject: Re: [patch] pci/hotplug acpiphp: fix Kconfig for Dock dependencies
Date: Wed, 26 Jul 2006 10:32:26 -0700
Message-ID: <20060726103226.69aa79c1.kristen.c.accardi@intel.com>
References: <20060725161854.79f9cc1b.kristen.c.accardi@intel.com>
	<20060725164125.A15861@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45743 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751723AbWGZRcp (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 26 Jul 2006 13:32:45 -0400
In-Reply-To: <20060725164125.A15861@unix-os.sc.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>
Cc: linux-acpi@vger.kernel.org, len.brown@intel.com, akpm@osdl.org, zippel@linux-m68k.org, rdunlap@xenotime.net, linux-kernel@vger.kernel.org, greg@kroah.com, pcihpd-discuss@lists.sourceforge.net

---
I confirmed that Anil's patch will work, here is a proper patch with
Anil's changes.

Change the build options for acpiphp so that it may build without being
dependent on the ACPI_DOCK option, but yet does not allow the option of
acpiphp being built-in when dock is built as a module.

Signed-off-by: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Signed-off-by: Kristen Carlson Accardi <kristen.c.accardi@intel.com>
---
 drivers/pci/hotplug/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- 2.6-git.orig/drivers/pci/hotplug/Kconfig
+++ 2.6-git/drivers/pci/hotplug/Kconfig
@@ -76,7 +76,7 @@ config HOTPLUG_PCI_IBM
 
 config HOTPLUG_PCI_ACPI
 	tristate "ACPI PCI Hotplug driver"
-	depends on ACPI_DOCK && HOTPLUG_PCI
+	depends on (!ACPI_DOCK && ACPI && HOTPLUG_PCI) || (ACPI_DOCK && HOTPLUG_PCI)
 	help
 	  Say Y here if you have a system that supports PCI Hotplug using
 	  ACPI.

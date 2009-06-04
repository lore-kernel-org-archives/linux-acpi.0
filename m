From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] eeepc: fix pci & hotplug selects
Date: Thu, 04 Jun 2009 09:47:45 -0700
Message-ID: <4A27FAB1.2000602@oracle.com>
References: <20090604175657.1565ecba.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet11.oracle.com ([148.87.113.123]:38889 "EHLO
	rgminet11.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753356AbZFDQon (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Jun 2009 12:44:43 -0400
In-Reply-To: <20090604175657.1565ecba.sfr@canb.auug.org.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Corentin Chary <corentincj@iksaif.net>, acpi4asus-user@lists.sourceforge.net

I hit another manifestation of this problem today.  Patch below.
Only the patch description (error log) has changed.

---
From: Randy Dunlap <randy.dunlap@oracle.com>

EEEPC_LAPTOP selects HOTPLUG_PCI.  This causes failures (build error below)
when CONFIG_HOTPLUG is not enabled, so additionally select HOTPLUG since
kconfig 'select' doesn't follow its dependency chain.
Also, only select HOTPLUG_PCI if PCI is already enabled.

drivers/pci/hotplug/fakephp.c:55: error: implicit declaration of function 'pci_rescan_bus'
ERROR: "pci_scan_slot" [drivers/pci/hotplug/pciehp.ko] undefined!
ERROR: "pci_scan_bridge" [drivers/pci/hotplug/pciehp.ko] undefined!
ERROR: "pci_scan_slot" [drivers/pci/hotplug/pci_hotplug.ko] undefined!
ERROR: "pci_add_new_bus" [drivers/pci/hotplug/pci_hotplug.ko] undefined!

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20090604.orig/drivers/platform/x86/Kconfig
+++ linux-next-20090604/drivers/platform/x86/Kconfig
@@ -340,7 +340,8 @@ config EEEPC_LAPTOP
 	depends on RFKILL || RFKILL = n
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
-	select HOTPLUG_PCI
+	select HOTPLUG
+	select HOTPLUG_PCI if PCI
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
 	  It also adds the ability to switch camera/wlan on/off.

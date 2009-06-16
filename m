From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: [PATCH -next] eeepc: fix selects (third time)
Date: Tue, 16 Jun 2009 10:44:58 -0700
Message-ID: <4A37DA1A.8020800@oracle.com>
References: <20090616165923.8ca4ddcb.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20090616165923.8ca4ddcb.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Corentin Chary <corentincj@iksaif.net>, Len Brown <len.brown@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

linux-next still fails with various pci_*() undefined references, like:


ERROR: "pci_scan_slot" [drivers/pci/hotplug/cpqphp.ko] undefined!
ERROR: "pci_add_new_bus" [drivers/pci/hotplug/cpqphp.ko] undefined!
and
drivers/pci/hotplug/fakephp.c:55: error:implicit declaration of function 'pci_rescan_bus'

These are due to the eeepc driver's Kconfig selects.  Patch below
fixes them.

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

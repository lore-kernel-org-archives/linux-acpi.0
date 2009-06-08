From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 1/4] eeepc: fix kconfig selects
Date: Mon,  8 Jun 2009 10:16:47 +0200
Message-ID: <1244449010-7995-2-git-send-email-corentincj@iksaif.net>
References: <1244449010-7995-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iksaif.net ([88.191.73.63]:52386 "EHLO iksaif.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752493AbZFHIYV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 8 Jun 2009 04:24:21 -0400
In-Reply-To: <1244449010-7995-1-git-send-email-corentincj@iksaif.net>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, Randy Dunlap <randy.dunlap@oracle.com>

From: Randy Dunlap <randy.dunlap@oracle.com>

EEEPC_LAPTOP selects HOTPLUG_PCI.  This causes failures (build error below)
when CONFIG_HOTPLUG is not enabled, so additionally select HOTPLUG since
kconfig 'select' doesn't follow its dependency chain.
Also, only select HOTPLUG_PCI if PCI is already enabled.

drivers/pci/hotplug/fakephp.c:55: error: implicit declaration of function 'pci_rescan_bus'

Signed-off-by: Randy Dunlap <randy.dunlap@oracle.com>
Acked-by: Corentin Chary <corentincj@iksaif.net>
---
 drivers/platform/x86/Kconfig |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index afbe441..db299e1 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -341,7 +341,8 @@ config EEEPC_LAPTOP
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
 	select RFKILL
-	select HOTPLUG_PCI
+	select HOTPLUG
+	select HOTPLUG_PCI if PCI
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.
 	  It also adds the ability to switch camera/wlan on/off.
-- 
1.6.3.1


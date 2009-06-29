From: Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] eeepc-laptop: Fix build failure with HOTPLUG_PCI && !SYSFS
	(was: [git pull request] ACPI & driver patches for 2.6.31-rc1)
Date: Mon, 29 Jun 2009 10:07:54 +0200
Message-ID: <20090629080754.GA28336@elte.hu>
References: <alpine.LFD.2.00.0906260025380.20608@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:60269 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753245AbZF2II2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Jun 2009 04:08:28 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0906260025380.20608@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Corentin Chary <corentincj@iksaif.net>, Randy Dunlap <randy.dunlap@oracle.com>, Matthew Garrett <mjg@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org


FYI, there's a post-rc1 build regression with certain configs:

 drivers/built-in.o: In function `pci_hp_deregister':
 (.text+0xb166): undefined reference to `pci_hp_remove_module_link'
 drivers/built-in.o: In function `pci_hp_deregister':
 (.text+0xb19f): undefined reference to `pci_destroy_slot'
 drivers/built-in.o: In function `__pci_hp_register':
 (.text+0xb583): undefined reference to `pci_create_slot'
 drivers/built-in.o: In function `__pci_hp_register':
 (.text+0xb5b1): undefined reference to `pci_hp_create_module_link'
 make: *** [.tmp_vmlinux1] Error 1

Caused by:

| 2b121bc262fa03c94e653b2d44356c2f86c1bcdc is first bad commit
| commit 2b121bc262fa03c94e653b2d44356c2f86c1bcdc
| Date:   Thu Jun 25 13:25:36 2009 +0200
|
|     eeepc-laptop: Register as a pci-hotplug device

The problem is caused by this portion of the commit:

--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -357,6 +357,8 @@ config EEEPC_LAPTOP
        depends on RFKILL || RFKILL = n
        select BACKLIGHT_CLASS_DEVICE
        select HWMON
+       select HOTPLUG
+       select HOTPLUG_PCI if PCI
        ---help---
          This driver supports the Fn-Fx keys on Eee PC laptops.

We never select CONFIG_HOTPLUG_PCI, as it is a non-trivial, 
interactive, many-child-dependencies configuration option.

The select caused partial dependencies to be instantiated by the 
Kconfig language, and allowed the PCI hotplug core code to be built 
without SYSFS - so drivers/pci/slot.c wasnt built but was being 
relied on.

The complexity of select statements is already a warning sign that 
something unusual is done here. They should be avoided generally, 
except for clear-cut 'leaf' modules.

The patch below fixes the build failure by turning the select lines 
into a single 'depends on' line. There's no significant reduction in 
utility of the driver: it already has a list of dependencies, and 
basically all distros enable hotplug-pci anyway.

	Ingo

Signed-off-by: Ingo Molnar <mingo@elte.hu>

diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index fee6a40..46dad12 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -355,10 +355,9 @@ config EEEPC_LAPTOP
 	depends on INPUT
 	depends on EXPERIMENTAL
 	depends on RFKILL || RFKILL = n
+	depends on HOTPLUG_PCI
 	select BACKLIGHT_CLASS_DEVICE
 	select HWMON
-	select HOTPLUG
-	select HOTPLUG_PCI if PCI
 	---help---
 	  This driver supports the Fn-Fx keys on Eee PC laptops.

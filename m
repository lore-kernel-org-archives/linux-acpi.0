From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 09/11] ACPI: remove ACPI dependency on PM
Date: Wed, 05 Nov 2008 16:18:18 -0700
Message-ID: <20081105231818.26131.54384.stgit@bob.kio>
References: <20081105231710.26131.3110.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0009.atlanta.hp.com ([15.192.0.46]:46921 "EHLO
	g5t0009.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752932AbYKEXST (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 5 Nov 2008 18:18:19 -0500
In-Reply-To: <20081105231710.26131.3110.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Zhao Yakui <yakui.zhao@intel.com>, Alexey Starikovskiy <astarikovskiy@suse.de>

Allow ACPI to build without CONFIG_PM.

CONFIG_PM (power management) gives us things like suspend/resume
support.  The device discovery and configuration functionality of
ACPI is still useful even without power management.

CC: Robert P. J. Day <rpjday@mindspring.com>
Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/Kconfig |    1 -
 drivers/acpi/bus.c   |    2 ++
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 2e6f757..9530192 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -6,7 +6,6 @@ menuconfig ACPI
 	bool "ACPI (Advanced Configuration and Power Interface) Support"
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86
-	depends on PM
 	select PNP
 	default y
 	---help---
diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 765fd1c..b9cb6eb 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -857,6 +857,7 @@ static int __init acpi_init(void)
 
 	if (!result) {
 		pci_mmcfg_late_init();
+#ifdef CONFIG_PM
 		if (!(pm_flags & PM_APM))
 			pm_flags |= PM_ACPI;
 		else {
@@ -865,6 +866,7 @@ static int __init acpi_init(void)
 			disable_acpi();
 			result = -ENODEV;
 		}
+#endif
 	} else
 		disable_acpi();
 	/*


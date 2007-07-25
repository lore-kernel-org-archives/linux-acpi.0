From: Len Brown <len.brown@intel.com>
Subject: [PATCH 13/16] ACPI: Kconfig: always enable CONFIG_ACPI_SLEEP on X86
Date: Wed, 25 Jul 2007 01:51:22 -0400
Message-ID: <1185342699713-git-send-email-len.brown@intel.com>
References: <11853426852588-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:18276 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbXGYFvm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 25 Jul 2007 01:51:42 -0400
In-Reply-To: <11853426852588-git-send-email-len.brown@intel.com>
Message-Id: <7c5aa6642fa26641ebf286966a165aec71c91991.1185342489.git.len.brown@intel.com>
In-Reply-To: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
References: <e9b3aba887f47f9cd64de20fec9c333a932b70dc.1185342489.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

The SMP dependency on HOTPLUG_CPU and SUSPEND_SMP
caused more harm than good -- making ACPI sleep
support vanish for configs missing those options.
So simply select them on the (ACPI && SMP && X86) systems
that need them.

Also, remove the prompt for ACPI_SLEEP,
virtually nobody (intentionally) enables ACPI without it.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/Kconfig |   21 ++++-----------------
 1 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index efd47ee..524cbf1 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -43,24 +43,11 @@ menuconfig ACPI
 if ACPI
 
 config ACPI_SLEEP
-	bool "Sleep States"
-	depends on X86 && (!SMP || SUSPEND_SMP)
+	bool
+	depends on X86
+	select HOTPLUG_CPU if SMP
+	select SUSPEND_SMP if SMP
 	default y
-	---help---
-	  This option adds support for ACPI suspend states. 
-
-	  With this option, you will be able to put the system "to sleep". 
-	  Sleep states are low power states for the system and devices. All
-	  of the system operating state is saved to either memory or disk
-	  (depending on the state), to allow the system to resume operation
-	  quickly at your request.
-
-	  Although this option sounds really nifty, barely any of the device
-	  drivers have been converted to the new driver model and hence few
-	  have proper power management support. 
-
-	  This option is not recommended for anyone except those doing driver
-	  power management development.
 
 config ACPI_PROCFS
 	bool "Deprecated /proc/acpi files"
-- 
1.5.3.rc2.22.g69a9b

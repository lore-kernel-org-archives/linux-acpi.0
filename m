From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 2/5] ACPI: fix conflicting component definitions
Date: Fri, 07 Nov 2008 16:57:50 -0700
Message-ID: <20081107235750.32050.85099.stgit@bob.kio>
References: <20081107235644.32050.74757.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:5596 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629AbYKGX5v (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 18:57:51 -0500
In-Reply-To: <20081107235644.32050.74757.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Randy Dunlap <rdunlap@xenotime.net>

Some of the component definitions that were previous scattered around
the drivers conflict with each other.  That doesn't hurt anything
except that setting one bit in the debug_layer mask would turn on
debugging in two different modules.  This patch fixes the conflicts.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 include/acpi/acpi_drivers.h |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index ebf5420..d644a57 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -35,16 +35,16 @@
 #define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_BATTERY_COMPONENT		0x00040000
 #define ACPI_BUTTON_COMPONENT		0x00080000
-#define ACPI_SBS_COMPONENT		0x00080000
+#define ACPI_SBS_COMPONENT		0x00100000
 #define ACPI_FAN_COMPONENT		0x00200000
 #define ACPI_PCI_COMPONENT		0x00400000
 #define ACPI_POWER_COMPONENT		0x00800000
 #define ACPI_CONTAINER_COMPONENT	0x01000000
-#define ACPI_PROCESSOR_COMPONENT	0x01000000
 #define ACPI_SYSTEM_COMPONENT		0x02000000
 #define ACPI_THERMAL_COMPONENT		0x04000000
 #define ACPI_MEMORY_DEVICE_COMPONENT	0x08000000
-#define ACPI_VIDEO_COMPONENT		0x08000000
+#define ACPI_VIDEO_COMPONENT		0x10000000
+#define ACPI_PROCESSOR_COMPONENT	0x20000000
 
 /*
  * _HID definitions


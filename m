From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 3/5] ACPI: add driver component definitions to sysfs
	debug_layers
Date: Fri, 07 Nov 2008 16:57:55 -0700
Message-ID: <20081107235755.32050.94453.stgit@bob.kio>
References: <20081107235644.32050.74757.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:16391 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752674AbYKGX54 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 7 Nov 2008 18:57:56 -0500
In-Reply-To: <20081107235644.32050.74757.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Randy Dunlap <rdunlap@xenotime.net>

/sys/module/acpi/parameters/debug_layers used to contain only the
debug layers defined by the ACPI CA.  This patch adds the additional
layer definitions for ACPI drivers.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/debug.c        |   15 +++++++++++++++
 include/acpi/acpi_drivers.h |    4 ++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/debug.c b/drivers/acpi/debug.c
index abf36b4..c483968 100644
--- a/drivers/acpi/debug.c
+++ b/drivers/acpi/debug.c
@@ -44,6 +44,21 @@ static const struct acpi_dlayer acpi_debug_layers[] = {
 	ACPI_DEBUG_INIT(ACPI_CA_DISASSEMBLER),
 	ACPI_DEBUG_INIT(ACPI_COMPILER),
 	ACPI_DEBUG_INIT(ACPI_TOOLS),
+
+	ACPI_DEBUG_INIT(ACPI_BUS_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_AC_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_BATTERY_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_BUTTON_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_SBS_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_FAN_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_PCI_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_POWER_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_CONTAINER_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_SYSTEM_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_THERMAL_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_MEMORY_DEVICE_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_VIDEO_COMPONENT),
+	ACPI_DEBUG_INIT(ACPI_PROCESSOR_COMPONENT),
 };
 
 static const struct acpi_dlevel acpi_debug_levels[] = {
diff --git a/include/acpi/acpi_drivers.h b/include/acpi/acpi_drivers.h
index d644a57..3200ee8 100644
--- a/include/acpi/acpi_drivers.h
+++ b/include/acpi/acpi_drivers.h
@@ -31,6 +31,10 @@
 
 #define ACPI_MAX_STRING			80
 
+/*
+ * Please update drivers/acpi/debug.c and Documentation/acpi/debug.txt
+ * if you add to this list.
+ */
 #define ACPI_BUS_COMPONENT		0x00010000
 #define ACPI_AC_COMPONENT		0x00020000
 #define ACPI_BATTERY_COMPONENT		0x00040000


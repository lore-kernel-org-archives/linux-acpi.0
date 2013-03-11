From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] acpi: remove reference to ACPI_HOTPLUG_IO
Date: Mon, 11 Mar 2013 11:53:48 +0100
Message-ID: <1362999228.3137.55.camel@x61.thuisdomein>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The Kconfig entry for ACPI Container and Module Devices got
added in v2.6.11. Its default value has always been set to
    (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)

But the Kconfig symbol ACPI_HOTPLUG_IO has never existed. So it's
pointless to use it to set this default value.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested, actually.

 drivers/acpi/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index 92ed969..b46f5e3 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -334,7 +334,7 @@ config X86_PM_TIMER
 
 config ACPI_CONTAINER
 	bool "Container and Module Devices"
-	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU || ACPI_HOTPLUG_IO)
+	default (ACPI_HOTPLUG_MEMORY || ACPI_HOTPLUG_CPU)
 	help
 	  This driver supports ACPI Container and Module devices (IDs
 	  ACPI0004, PNP0A05, and PNP0A06).
-- 
1.7.11.7

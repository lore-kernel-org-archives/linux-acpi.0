From: Toshi Kani <toshi.kani@hp.com>
Subject: [PATCH] ACPI: Remove the use of CONFIG_ACPI_CONTAINER_MODULE
Date: Mon, 11 Feb 2013 15:33:20 -0700
Message-ID: <1360622000-22140-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0026.austin.hp.com ([15.216.28.33]:38493 "EHLO
	g1t0026.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932779Ab3BKWoM (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 11 Feb 2013 17:44:12 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@sisk.pl, linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Toshi Kani <toshi.kani@hp.com>

config ACPI_CONTAINER has been changed to bool (y/n), and its
module option is no longer valid.  So, remove the use of
CONFIG_ACPI_CONTAINER_MODULE.

Signed-off-by: Toshi Kani <toshi.kani@hp.com>
---
 include/linux/acpi.h |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index c6ccd9f..bcbdd74 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -363,8 +363,7 @@ extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
 #if defined(CONFIG_ACPI_HOTPLUG_CPU) &&			\
 	(defined(CONFIG_ACPI_HOTPLUG_MEMORY) ||		\
 	 defined(CONFIG_ACPI_HOTPLUG_MEMORY_MODULE)) &&	\
-	(defined(CONFIG_ACPI_CONTAINER) ||		\
-	 defined(CONFIG_ACPI_CONTAINER_MODULE))
+	defined(CONFIG_ACPI_CONTAINER)
 #define ACPI_HOTPLUG_OST
 #endif
 

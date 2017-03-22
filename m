From: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 1/3] ACPI, ioapic: Clear on-stack resource before using it
Date: Wed, 22 Mar 2017 18:33:23 +0100
Message-ID: <1490204005-2733-2-git-send-email-joro@8bytes.org>
References: <1490204005-2733-1-git-send-email-joro@8bytes.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from 8bytes.org ([81.169.241.247]:40663 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965106AbdCVRdm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 22 Mar 2017 13:33:42 -0400
In-Reply-To: <1490204005-2733-1-git-send-email-joro@8bytes.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>

From: Joerg Roedel <jroedel@suse.de>

The on-stack resource-window 'win' in setup_res() is not
properly initialized. This causes the pointers in the
embedded 'struct resource' to contain stale pointers.

These pointers (in my case the ->child pointer) gets later
propagated to the global iomem_resources list, causing a #GP
exception when the list is traversed in
iomem_map_sanity_check().

Fixes: c183619b63ec ('x86/irq, ACPI: Implement ACPI driver to support IOAPIC hotplug')
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 drivers/acpi/ioapic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/ioapic.c b/drivers/acpi/ioapic.c
index 1120dfd6..7e4fbf9 100644
--- a/drivers/acpi/ioapic.c
+++ b/drivers/acpi/ioapic.c
@@ -45,6 +45,12 @@ static acpi_status setup_res(struct acpi_resource *acpi_res, void *data)
 	struct resource *res = data;
 	struct resource_win win;
 
+	/*
+	 * We might assign this to 'res' later, make sure all pointers are
+	 * cleared before the resource is added to the global list
+	 */
+	memset(&win, 0, sizeof(win));
+
 	res->flags = 0;
 	if (acpi_dev_filter_resource_type(acpi_res, IORESOURCE_MEM))
 		return AE_OK;
-- 
1.9.1


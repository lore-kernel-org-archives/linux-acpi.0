From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2 1/5] ACPI: export acpi_bus_get_status_handle()
Date: Mon, 22 Jan 2018 09:51:31 +0100
Message-ID: <20180122085135.16732-2-hdegoede@redhat.com>
References: <20180122085135.16732-1-hdegoede@redhat.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44746 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752598AbeAVIvm (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Mon, 22 Jan 2018 03:51:42 -0500
In-Reply-To: <20180122085135.16732-1-hdegoede@redhat.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, devel@acpica.org

Some modular drivers need this, export it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-This is a new patch in v2 of this patch-set
---
 drivers/acpi/bus.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 4d0979e02a28..db0c05997cc2 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -108,6 +108,7 @@ acpi_status acpi_bus_get_status_handle(acpi_handle handle,
 	}
 	return status;
 }
+EXPORT_SYMBOL(acpi_bus_get_status_handle);
 
 int acpi_bus_get_status(struct acpi_device *device)
 {
-- 
2.14.3


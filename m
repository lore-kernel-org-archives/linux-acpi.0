From: Yinghai Lu <yinghai@kernel.org>
Subject: [PATCH 11/29] PCI, ACPI: remove find_bridge in acpi_bus_type
Date: Tue, 25 Sep 2012 01:26:12 -0700
Message-ID: <1348561590-28067-12-git-send-email-yinghai@kernel.org>
References: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <1348561590-28067-1-git-send-email-yinghai@kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bhelgaas@google.com>, Len Brown <lenb@kernel.org>
Cc: linux-pci@vger.kernel.org, Yinghai Lu <yinghai@kernel.org>, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

The struct member is not used anymore, remove it.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
---
 include/acpi/acpi_bus.h |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index bde976e..0e41e5f 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -389,8 +389,6 @@ struct acpi_bus_type {
 	struct bus_type *bus;
 	/* For general devices under the bus */
 	int (*find_device) (struct device *, acpi_handle *);
-	/* For bridges, such as PCI root bridge, IDE controller */
-	int (*find_bridge) (struct device *, acpi_handle *);
 };
 int register_acpi_bus_type(struct acpi_bus_type *);
 int unregister_acpi_bus_type(struct acpi_bus_type *);
-- 
1.7.7

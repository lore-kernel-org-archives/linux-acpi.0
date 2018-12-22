From: Sinan Kaya <okaya@kernel.org>
Subject: [PATCH v2 01/11] ACPI / LPSS: Add guards against CONFIG_PCI
Date: Sat, 22 Dec 2018 09:07:10 +0000
Message-ID: <20181222090720.19234-2-okaya@kernel.org>
References: <20181222090720.19234-1-okaya@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181222090720.19234-1-okaya@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-next@vger.kernel.org
Cc: linux-acpi@vger.kernel.org, Sinan Kaya <okaya@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, open list <linux-kernel@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

We can now compile ACPI without PCI support. If code depends on CONFIG_PCI,
it needs to explicitly guard that piece.

Signed-off-by: Sinan Kaya <okaya@kernel.org>
---
 drivers/acpi/acpi_lpss.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 5f94c35d165f..4148abcdf9ef 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -534,8 +534,11 @@ static struct device *acpi_lpss_find_device(const char *hid, const char *uid)
 	dev = bus_find_device(&platform_bus_type, NULL, &data, match_hid_uid);
 	if (dev)
 		return dev;
-
+#ifdef CONFIG_PCI
 	return bus_find_device(&pci_bus_type, NULL, &data, match_hid_uid);
+#else
+	return NULL;
+#endif
 }
 
 static bool acpi_lpss_dep(struct acpi_device *adev, acpi_handle handle)
-- 
2.19.0

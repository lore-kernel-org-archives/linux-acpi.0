From: helgaas@kernel.org
Subject: [PATCH 4/4] ACPI / scan: Add labels for PNP button devices
Date: Mon, 25 Mar 2019 13:34:03 -0500
Message-ID: <20190325183403.251473-5-helgaas@kernel.org>
References: <20190325183403.251473-1-helgaas@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190325183403.251473-1-helgaas@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Subsequent code treats button_device_ids[] entries differently, and it's
hard to follow without a hint as to which is which.  Add comments to
identify the power button, lid, and sleep button devices.

The "PNP" prefix is owned by Microsoft, so they distribute the canonical
list of "PNP" IDs.

Link: https://uefi.org/PNP_ACPI_Registry
Link: https://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/devids.txt
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/acpi/scan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index f3b40299a641..814a02568d68 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -846,9 +846,9 @@ static int acpi_bus_extract_wakeup_device_power_package(struct acpi_device *dev)
 static bool acpi_wakeup_gpe_init(struct acpi_device *device)
 {
 	static const struct acpi_device_id button_device_ids[] = {
-		{"PNP0C0C", 0},
-		{"PNP0C0D", 0},
-		{"PNP0C0E", 0},
+		{"PNP0C0C", 0},		/* Power button */
+		{"PNP0C0D", 0},		/* Lid */
+		{"PNP0C0E", 0},		/* Sleep button */
 		{"", 0},
 	};
 	struct acpi_device_wakeup *wakeup = &device->wakeup;
-- 
2.21.0.392.gf8f6787159e-goog

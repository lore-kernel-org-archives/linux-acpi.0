From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] pci: remove error message when device not present
Date: Thu, 29 Sep 2016 12:28:43 +0100
Message-ID: <20160929112843.13552-1-grant.likely@secretlab.ca>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Grant Likely <grant.likely@secretlab.ca>, Grant Likely <grant.likely@hpe.com>, Linn Crosetto <linn@hpe.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: linux-acpi@vger.kernel.org

It's not an error if the IBM ACPI pseudo-device isn't present, it merely
means the kernel isn't running on that IBM hardware. Get rid of the
error report so as not to pollute the kernel log with an message
irrelevant to the vast majority of users.

If someone wants to debug it, they can turn on the pr_debug() message
which will show progress through the .init function.

Reported-by: Jim Hull <jim.hull@hpe.com>
Signed-off-by: Grant Likely <grant.likely@hpe.com>
Cc: Linn Crosetto <linn@hpe.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/acpiphp_ibm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/acpiphp_ibm.c b/drivers/pci/hotplug/acpiphp_ibm.c
index f6221d7..ec43510 100644
--- a/drivers/pci/hotplug/acpiphp_ibm.c
+++ b/drivers/pci/hotplug/acpiphp_ibm.c
@@ -439,7 +439,6 @@ static int __init ibm_acpiphp_init(void)
 	if (acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
 			ACPI_UINT32_MAX, ibm_find_acpi_device, NULL,
 			&ibm_acpi_handle, NULL) != FOUND_APCI) {
-		pr_err("%s: acpi_walk_namespace failed\n", __func__);
 		retval = -ENODEV;
 		goto init_return;
 	}
-- 
2.9.3

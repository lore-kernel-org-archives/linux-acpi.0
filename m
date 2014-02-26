From: Zhang Rui <rui.zhang@intel.com>
Subject: [RFC PATCH 7/8] Revert "ACPI / PNP: skip ACPI device nodes associated with physical nodes already"
Date: Wed, 26 Feb 2014 17:11:13 +0800
Message-ID: <1393405874-3266-8-git-send-email-rui.zhang@intel.com>
References: <1393405874-3266-1-git-send-email-rui.zhang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1393405874-3266-1-git-send-email-rui.zhang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: bhelgaas@google.com, matthew.garrett@nebula.com, rafael.j.wysocki@intel.com, dmitry.torokhov@gmail.com, Zhang Rui <rui.zhang@intel.com>
List-Id: linux-acpi@vger.kernel.org

This reverts commit 2905875344f977acd188a2b0f1d163491e91459b.

commit 2905875344f977acd188a2b0f1d163491e91459b was introduced to prevent
PNP device objects from being created for ACPI device nodes already associated
with platform devices.

This is not needed any more because the platform device node won't be created
if a device has already been attached to the PNPACPI scan handler.

Plus, in some cases, we may need both PNP node and platform node for the
same ACPI device object, on purpose, like what I will do in next patch.

Thus reverting this commit.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
---
 drivers/pnp/pnpacpi/core.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
index 1ee7eb7..739fa24 100644
--- a/drivers/pnp/pnpacpi/core.c
+++ b/drivers/pnp/pnpacpi/core.c
@@ -524,10 +524,6 @@ static int __init pnpacpi_add_device(struct acpi_device *device)
 	struct acpi_hardware_id *id;
 	int error;
 
-	/* Skip devices that are already bound */
-	if (device->physical_node_count)
-		return 0;
-
 	/*
 	 * If a PnPacpi device is not present , the device
 	 * driver should not be loaded.
-- 
1.7.9.5

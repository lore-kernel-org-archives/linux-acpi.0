From: Len Brown <len.brown@intel.com>
Subject: [PATCH 19/28] ACPI: fix potential OOPS in power driver with CONFIG_ACPI_DEBUG
Date: Sat, 14 Oct 2006 04:06:00 -0400
Message-ID: <11608131942375-git-send-email-len.brown@intel.com>
References: <11608131691346-git-send-email-len.brown@intel.com>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:35212 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S1752138AbWJNIDN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Sat, 14 Oct 2006 04:03:13 -0400
In-Reply-To: <11608131691346-git-send-email-len.brown@intel.com>
Message-Id: <786f18c666d7202a86a8aa42a98783b115fe8739.1160812999.git.len.brown@intel.com>
In-Reply-To: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
References: <288f3ad406460f03642a41bb945826891a7b866f.1160812999.git.len.brown@intel.com>
Date: Wed, 23 Aug 2006 23:18:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Dmitry Torokhov <dtor@insightbb.com>, Dmitry Torokhov <dtor@mail.ru>, Len Brown <len.brown@intel.com>

From: Dmitry Torokhov <dtor@insightbb.com>

device was set to null and used before set in a debug printk

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index fec225d..fe67a8a 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -216,10 +216,8 @@ static int acpi_power_off_device(acpi_ha
 {
 	int result = 0;
 	acpi_status status = AE_OK;
-	struct acpi_device *device = NULL;
 	struct acpi_power_resource *resource = NULL;
 
-
 	result = acpi_power_get_context(handle, &resource);
 	if (result)
 		return result;
@@ -230,13 +228,13 @@ static int acpi_power_off_device(acpi_ha
 	if (resource->references) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO,
 				  "Resource [%s] is still in use, dereferencing\n",
-				  device->pnp.bus_id));
+				  resource->device->pnp.bus_id));
 		return 0;
 	}
 
 	if (resource->state == ACPI_POWER_RESOURCE_STATE_OFF) {
 		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] already off\n",
-				  device->pnp.bus_id));
+				  resource->device->pnp.bus_id));
 		return 0;
 	}
 
@@ -251,8 +249,7 @@ static int acpi_power_off_device(acpi_ha
 		return -ENOEXEC;
 
 	/* Update the power resource's _device_ power state */
-	device = resource->device;
-	device->power.state = ACPI_STATE_D3;
+	resource->device->power.state = ACPI_STATE_D3;
 
 	ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Resource [%s] turned off\n",
 			  resource->name));
-- 
1.4.3.rc2.g23bed-dirty

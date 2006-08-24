From: Dmitry Torokhov <dtor@insightbb.com>
Subject: [PATCH] ACPI: fix potential OOPS in power driver
Date: Wed, 23 Aug 2006 23:18:06 -0400
Message-ID: <200608232318.06863.dtor@insightbb.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway.insightbb.com ([74.128.0.19]:30495 "EHLO
	asav10.insightbb.com") by vger.kernel.org with ESMTP
	id S1030233AbWHXDSI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Aug 2006 23:18:08 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>

Hi,

I am wondering what is the reason to have every local variable
initialized, whether it is needed or not? Aside of increasing
code size it also hides errors compiler would warn about otherwise.

The patch below fixes potential OOPS, I have more patches that
remove unnecessary initializations, checks. Would you be interested
in these?

-- 
Dmitry

ACPI: fix potential OOPS in power driver

ACPI is littered with useless itialization of _every_ variable
on the stack. Besides increasing code it also sometimes covers
real bugs.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/acpi/power.c |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

Index: work/drivers/acpi/power.c
===================================================================
--- work.orig/drivers/acpi/power.c
+++ work/drivers/acpi/power.c
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

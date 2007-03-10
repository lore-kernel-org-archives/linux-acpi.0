From: Len Brown <len.brown@intel.com>
Subject: [PATCH 09/20] ACPI: ThinkPad Z60m: usb mouse stops working after suspend to RAM
Date: Fri,  9 Mar 2007 22:49:27 -0500
Message-ID: <11734985862291-git-send-email-len.brown@intel.com>
References: <11734985781377-git-send-email-len.brown@intel.com> <11734985791126-git-send-email-len.brown@intel.com> <1173498580364-git-send-email-len.brown@intel.com> <11734985813852-git-send-email-len.brown@intel.com> <11734985822692-git-send-email-len.brown@intel.com> <11734985822425-git-send-email-len.brown@intel.com> <11734985831806-git-send-email-len.brown@intel.com> <11734985842575-git-send-email-len.brown@intel.com> <1173498585454-git-send-email-len.brown@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:16223 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965823AbXCJDtr (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 9 Mar 2007 22:49:47 -0500
In-Reply-To: <1173498585454-git-send-email-len.brown@intel.com>
Message-Id: <ff24ba74b6d3befbfbafa142582211b5a6095d45.1173498420.git.len.brown@intel.com>
In-Reply-To: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
References: <7292576043666ff39946dee14641fe719ba8c7e8.1173498420.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Konstantin Karasyov <konstantin.a.karasyov@intel.com>, Len Brown <len.brown@intel.com>

From: Konstantin Karasyov <konstantin.a.karasyov@intel.com>

(http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg05270.html):

References : http://lkml.org/lkml/2007/2/21/413
             http://lkml.org/lkml/2007/2/28/172
Submitter  : Arkadiusz Miskiewicz <arekm@maven.pl>
Caused-By  : Konstantin Karasyov <konstantin.a.karasyov@intel.com>
             commit 0a6139027f3986162233adc17285151e78b39cac

Do not disable power resources on resume even if there are no devices referencing it.

Signed-off-by: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/acpi/power.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 1ef3385..ccecfe0 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -687,13 +687,6 @@ static int acpi_power_resume(struct acpi_device *device)
 		return result;
 
 	mutex_lock(&resource->resource_lock);
-	if ((resource->state == ACPI_POWER_RESOURCE_STATE_ON) &&
-	    list_empty(&resource->reference)) {
-		mutex_unlock(&resource->resource_lock);
-		result = acpi_power_off_device(device->handle, NULL);
-		return result;
-	}
-
 	if ((resource->state == ACPI_POWER_RESOURCE_STATE_OFF) &&
 	    !list_empty(&resource->reference)) {
 		ref = container_of(resource->reference.next, struct acpi_power_reference, node);
-- 
1.5.0.3.310.g05ef5

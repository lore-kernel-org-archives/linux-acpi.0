From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH] ACPI: Do not disable power resources w/o referencies on resume
Date: Wed, 7 Mar 2007 03:52:59 -0500
Message-ID: <200703070353.07182.lenb@kernel.org>
References: <E3C0BCA40296C347AF7142161DB9FC82B6FC0D@mssmsx411>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:36569 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161338AbXCGIyb (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Mar 2007 03:54:31 -0500
In-Reply-To: <E3C0BCA40296C347AF7142161DB9FC82B6FC0D@mssmsx411>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Karasyov, Konstantin A" <konstantin.a.karasyov@intel.com>, linux-acpi@vger.kernel.org

Applied

thanks,
-Len

Subject: ACPI: ThinkPad Z60m: usb mouse stops working after suspend to RAM
From: Konstantin Karasyov <konstantin.a.karasyov@intel.com>

(http://www.mail-archive.com/linux-acpi@vger.kernel.org/msg05270.html):

References : http://lkml.org/lkml/2007/2/21/413
             http://lkml.org/lkml/2007/2/28/172
Submitter  : Arkadiusz Miskiewicz <arekm@maven.pl>
Caused-By  : Konstantin Karasyov <konstantin.a.karasyov@intel.com>
             commit 0a6139027f3986162233adc17285151e78b39cac

Do not disable power resources on resume even if there are no devices referencing it.

Signed-off-by: Konstantin Karasyov <konstantin.a.karasyov@intel.com>
---

 drivers/acpi/power.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/drivers/acpi/power.c b/drivers/acpi/power.c
index 8df03b0..cb5ddb9 100644
--- a/drivers/acpi/power.c
+++ b/drivers/acpi/power.c
@@ -688,13 +688,6 @@ static int acpi_power_resume(struct acpi_device *device)
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 1/5] ACPI / bus: Return error code from __acpi_match_device() in one case
Date: Wed,  7 Feb 2018 16:56:06 +0200
Message-ID: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25917 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754401AbeBGO4Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Feb 2018 09:56:16 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

Instead of playing tricks with last invalid entry,
return simple -ENODATA error code cast to pointer.

It would be good for future in case caller passes NULL pointer for
ID table. Moreover, caller can check the code to be sure what happened
inside callee.

Fixes: 2b9c698efa58 ("ACPI / scan: Take the PRP0001 position in the list of IDs into account")
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 58239abb0a72..761286e50067 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -769,7 +769,7 @@ static const struct acpi_device_id *__acpi_match_device(
 		 */
 		if (!strcmp(ACPI_DT_NAMESPACE_HID, hwid->id)
 		    && acpi_of_match_device(device, of_ids))
-			return id;
+			return ERR_PTR(-ENODATA);
 	}
 	return NULL;
 }
-- 
2.15.1


From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 2/2] ACPI / LPSS: make code less confusing for reader
Date: Wed, 20 Mar 2013 14:14:30 +0200
Message-ID: <1363781670-28775-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1363781670-28775-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:54576 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756115Ab3CTMOy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 20 Mar 2013 08:14:54 -0400
In-Reply-To: <1363781670-28775-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The excerpt like this:

	if (err) {
		err = 0;
		goto error_out;
	}

makes a reader confused even if it's commented. Let's do necessary actions and
return no error explicitly.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/acpi_lpss.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index c695841..5d7ded2 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -152,8 +152,8 @@ static int acpi_lpss_create_device(struct acpi_device *adev,
 			 * Skip the device, but don't terminate the namespace
 			 * scan.
 			 */
-			ret = 0;
-			goto err_out;
+			kfree(pdata);
+			return 0;
 		}
 	}
 
-- 
1.8.2.rc0.22.gb3600c3


From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 2/5] ACPI / bus: Do not traverse through non-existed device table
Date: Wed,  7 Feb 2018 16:56:07 +0200
Message-ID: <20180207145610.88434-2-andriy.shevchenko@linux.intel.com>
References: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga05.intel.com ([192.55.52.43]:12723 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754416AbeBGO4Q (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 7 Feb 2018 09:56:16 -0500
In-Reply-To: <20180207145610.88434-1-andriy.shevchenko@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: dmaengine <dmaengine@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Sinan Kaya <okaya@codeaurora.org>, Sakari Ailus <sakari.ailus@linux.intel.com>, Vinod Koul <vinod.koul@intel.com>

When __acpi_match_device() is called it would be possible to have
ACPI ID table a MULL pointer. To avoid potential dereference,
check for this before traverse.

While here, remove redundant 'else'.

Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/acpi/bus.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 761286e50067..da7e9cf770a6 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -752,11 +752,13 @@ static const struct acpi_device_id *__acpi_match_device(
 
 	list_for_each_entry(hwid, &device->pnp.ids, list) {
 		/* First, check the ACPI/PNP IDs provided by the caller. */
-		for (id = ids; id->id[0] || id->cls; id++) {
-			if (id->id[0] && !strcmp((char *) id->id, hwid->id))
-				return id;
-			else if (id->cls && __acpi_match_device_cls(id, hwid))
-				return id;
+		if (ids) {
+			for (id = ids; id->id[0] || id->cls; id++) {
+				if (id->id[0] && !strcmp((char *)id->id, hwid->id))
+					return id;
+				if (id->cls && __acpi_match_device_cls(id, hwid))
+					return id;
+			}
 		}
 
 		/*
-- 
2.15.1


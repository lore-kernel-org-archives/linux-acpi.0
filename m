From: jeff.mcgee@intel.com
Subject: [PATCH 10/15] acpi: Export acpi_bus_type
Date: Tue, 30 Aug 2016 09:49:05 -0700
Message-ID: <20160830164910.1248-11-jeff.mcgee@intel.com>
References: <20160830164910.1248-1-jeff.mcgee@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga07.intel.com ([134.134.136.100]:37389 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756735AbcH3Qmu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Tue, 30 Aug 2016 12:42:50 -0400
In-Reply-To: <20160830164910.1248-1-jeff.mcgee@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: isg-gms@eclists.intel.com
Cc: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, Jeff McGee <jeff.mcgee@intel.com>

From: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>

Some modules, like i915.ko, needs to detect when certain ACPI features are
active inorder to prevent corruption on contended resources.
In particular, use of BIOS RapidStart Technology may corrupt the contents of
the reserved graphics memory, due to unalarmed hibernation. In which case
i915.ko cannot assume that it (reserved gfx memory) remains unmodified and
must recreate the contents and importantly not use it to store unrecoverable
user data.

Signed-off-by: Ankitprasad Sharma <ankitprasad.r.sharma@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Jeff McGee <jeff.mcgee@intel.com>
---
 drivers/acpi/scan.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 4b22ea8..7461bab 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1269,6 +1269,7 @@ struct bus_type acpi_bus_type = {
 	.remove		= acpi_device_remove,
 	.uevent		= acpi_device_uevent,
 };
+EXPORT_SYMBOL_GPL(acpi_bus_type);
 
 static void acpi_device_del(struct acpi_device *device)
 {
-- 
2.9.3


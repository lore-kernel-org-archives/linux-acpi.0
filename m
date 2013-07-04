From: Haicheng Li <haicheng.li@linux.intel.com>
Subject: [PATCH] acpi: remove unused LIST_HEAD(acpi_device_list)
Date: Thu,  4 Jul 2013 12:07:11 +0800
Message-ID: <1372910831-19721-1-git-send-email-haicheng.li@linux.intel.com>
References: <20130704022730.GB3244@hli22-desktop>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:7517 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750705Ab3GDEHx (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 4 Jul 2013 00:07:53 -0400
In-Reply-To: <20130704022730.GB3244@hli22-desktop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Haicheng Li <haicheng.lee@gmail.com>, Haicheng Li <haicheng.li@linux.intel.com>

acpi_device_list is not used by acpi code anymore, could be removed.

Signed-off-by: Haicheng Li <haicheng.li@linux.intel.com>
---
 drivers/acpi/scan.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 27da630..fcc0cdc 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -29,7 +29,6 @@ extern struct acpi_device *acpi_root;
 
 static const char *dummy_hid = "device";
 
-static LIST_HEAD(acpi_device_list);
 static LIST_HEAD(acpi_bus_id_list);
 static DEFINE_MUTEX(acpi_scan_lock);
 static LIST_HEAD(acpi_scan_handlers_list);
-- 
1.7.9.5


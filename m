From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ACPI / LPSS: constify attribute_group structures.
Date: Fri, 30 Jun 2017 18:23:50 +0530
Message-ID: <6f913e6b3193d223832f5757f57b7c17f36687fb.1498827187.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34500 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751840AbdF3MyB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Fri, 30 Jun 2017 08:54:01 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, rafael.j.wysocki@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_groups are not supposed to change at runtime. All functions
working with attribute_groups provided by <linux/sysfs.h> work with const
attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/acpi_lpss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_lpss.c b/drivers/acpi/acpi_lpss.c
index 10347e3..e51a1e9 100644
--- a/drivers/acpi/acpi_lpss.c
+++ b/drivers/acpi/acpi_lpss.c
@@ -576,7 +576,7 @@ static ssize_t lpss_ltr_mode_show(struct device *dev,
 	NULL,
 };
 
-static struct attribute_group lpss_attr_group = {
+static const struct attribute_group lpss_attr_group = {
 	.attrs = lpss_attrs,
 	.name = "lpss_ltr",
 };
-- 
1.9.1


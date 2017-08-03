From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] ACPI / dock: constify attribute_group structures.
Date: Thu,  3 Aug 2017 18:48:15 +0530
Message-ID: <f0871f6dc12ea0d90a6acf9d5156f9daaa3ee87a.1501764361.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pg0-f67.google.com ([74.125.83.67]:38319 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdHCNSg (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 3 Aug 2017 09:18:36 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

attribute_group are not supposed to change at runtime. All functions
working with attribute_group provided by <linux/sysfs.h> work with
const attribute_group. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/acpi/dock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 0c00208..2305e1a 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -585,7 +585,7 @@ static ssize_t show_dock_type(struct device *dev,
 	NULL
 };
 
-static struct attribute_group dock_attribute_group = {
+static const struct attribute_group dock_attribute_group = {
 	.attrs = dock_attributes
 };
 
-- 
1.9.1


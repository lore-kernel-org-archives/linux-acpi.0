From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ACPI: configfs: make config_item_type const
Date: Thu, 12 Oct 2017 12:02:51 +0200
Message-ID: <1507802571-4157-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52622 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752903AbdJLKDa (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 12 Oct 2017 06:03:30 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: julia.lawall@lip6.fr, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>

This is a followup patch for: https://lkml.org/lkml/2017/10/11/375 and
https://patchwork.kernel.org/patch/9999649/

Make these structures const as they are either passed to the functions
having the argument as const or stored as a reference in the "ci_type"
const field of a config_item structure.

Done using Coccienlle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 drivers/acpi/acpi_configfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/acpi_configfs.c b/drivers/acpi/acpi_configfs.c
index 853bc7f..b588503 100644
--- a/drivers/acpi/acpi_configfs.c
+++ b/drivers/acpi/acpi_configfs.c
@@ -204,7 +204,7 @@ struct configfs_attribute *acpi_table_attrs[] = {
 	NULL,
 };
 
-static struct config_item_type acpi_table_type = {
+static const struct config_item_type acpi_table_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_bin_attrs = acpi_table_bin_attrs,
 	.ct_attrs = acpi_table_attrs,
@@ -237,12 +237,12 @@ struct configfs_group_operations acpi_table_group_ops = {
 	.drop_item = acpi_table_drop_item,
 };
 
-static struct config_item_type acpi_tables_type = {
+static const struct config_item_type acpi_tables_type = {
 	.ct_owner = THIS_MODULE,
 	.ct_group_ops = &acpi_table_group_ops,
 };
 
-static struct config_item_type acpi_root_group_type = {
+static const struct config_item_type acpi_root_group_type = {
 	.ct_owner = THIS_MODULE,
 };
 
-- 
1.9.1


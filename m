From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] ACPI / dock: constify attribute_group structure
Date: Tue, 1 Aug 2017 20:28:46 -0400
Message-ID: <20170802002846.GA14666@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qt0-f193.google.com ([209.85.216.193]:37860 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751064AbdHBA1s (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Tue, 1 Aug 2017 20:27:48 -0400
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Functions working with attribute_groups provided by <linux/sysfs.h>
work with const attribute_group. These attribute_group structures do not
change at runtime so mark them as const.

File size before:
 text      data     bss     dec     hex filename
 7902      3528      64   11494    2ce6 drivers/acpi/dock.o

File size after:
 text      data     bss     dec     hex filename
 7998      3432      64   11494    2ce6 drivers/acpi/dock.o

This change was made with the help of Coccinelle.

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 drivers/acpi/dock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/dock.c b/drivers/acpi/dock.c
index 0c00208..2305e1a 100644
--- a/drivers/acpi/dock.c
+++ b/drivers/acpi/dock.c
@@ -585,7 +585,7 @@ static struct attribute *dock_attributes[] = {
 	NULL
 };
 
-static struct attribute_group dock_attribute_group = {
+static const struct attribute_group dock_attribute_group = {
 	.attrs = dock_attributes
 };
 
-- 
2.7.4


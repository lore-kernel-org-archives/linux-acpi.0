From: Insu Yun <wuninsu@gmail.com>
Subject: [PATCH] acpi:correctly check failed allocation
Date: Thu, 15 Oct 2015 12:19:30 -0400
Message-ID: <1444925970-28676-1-git-send-email-wuninsu@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-yk0-f172.google.com ([209.85.160.172]:35798 "EHLO
	mail-yk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753479AbbJOQTP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 15 Oct 2015 12:19:15 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, yeongjin.jang@gatech.edu, insu@gatech.edu, Insu Yun <wuninsu@gmail.com>

Since kobject_create_and_add can be failed in memory pressure,
return value need to be checked and return ENOMEM.

Signed-off-by: Insu Yun <wuninsu@gmail.com>
---
 drivers/acpi/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/acpi/sysfs.c b/drivers/acpi/sysfs.c
index 40a4265..e712a7b 100644
--- a/drivers/acpi/sysfs.c
+++ b/drivers/acpi/sysfs.c
@@ -878,6 +878,8 @@ int __init acpi_sysfs_init(void)
 		return result;
 
 	hotplug_kobj = kobject_create_and_add("hotplug", acpi_kobj);
+  if (!hotplug_kobj)
+    return -ENOMEM;
 	result = sysfs_create_file(hotplug_kobj, &force_remove_attr.attr);
 	if (result)
 		return result;
-- 
1.9.1


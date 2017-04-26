From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 07/15] ACPICA: debugger: fix memory leak on Pathname
Date: Wed, 26 Apr 2017 16:18:25 +0800
Message-ID: <432cc89ffcd396910ba024e97c40b075dd7cb2d3.1493194142.git.lv.zheng@intel.com>
References: <cover.1493194142.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:39305 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1952788AbdDZISg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 26 Apr 2017 04:18:36 -0400
In-Reply-To: <cover.1493194142.git.lv.zheng@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Robert Moore <robert.moore@intel.com>, Len Brown <len.brown@intel.com>, Lv Zheng <lv.zheng@intel.com>, "David E . Box" <david.e.box@intel.com>
Cc: Lv Zheng <zetalog@gmail.com>, linux-acpi@vger.kernel.org, Colin Ian King <colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

ACPICA commit 1db14dc88f308119634d77ab9dcb6586b9fe4777

On the error return path when acpi_get_object_info fails the allocated
pathname is not free'd leading to a memory leak.  Free pathname
to fix this.

Link: https://github.com/acpica/acpica/commit/1db14dc8
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Lv Zheng <lv.zheng@intel.com>
---
 drivers/acpi/acpica/dbmethod.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/dbmethod.c b/drivers/acpi/acpica/dbmethod.c
index 15c8237..df62c92 100644
--- a/drivers/acpi/acpica/dbmethod.c
+++ b/drivers/acpi/acpica/dbmethod.c
@@ -422,6 +422,7 @@ acpi_db_walk_for_execute(acpi_handle obj_handle,
 
 	status = acpi_get_object_info(obj_handle, &obj_info);
 	if (ACPI_FAILURE(status)) {
+		ACPI_FREE(pathname);
 		return (status);
 	}
 
-- 
2.7.4


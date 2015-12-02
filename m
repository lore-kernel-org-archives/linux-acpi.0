From: Hanjun Guo <guohanjun@huawei.com>
Subject: [PATCH] ACPI / property: fix compile error for acpi_node_get_property_reference() when CONFIG_ACPI=n
Date: Wed, 2 Dec 2015 15:44:22 +0800
Message-ID: <1449042262-11052-1-git-send-email-guohanjun@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga01-in.huawei.com ([58.251.152.64]:57400 "EHLO
	szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756717AbbLBHpF (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 2 Dec 2015 02:45:05 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, Kejian Yan <yankejian@huawei.com>, Hanjun Guo <hanjun.guo@linaro.org>

From: Hanjun Guo <hanjun.guo@linaro.org>

In commit 60ba032ed76e ("ACPI / property: Drop size_prop from
acpi_dev_get_property_reference()"), the argument "const char *cells_name"
was dropped, but forgot to update the stub function in no-ACPI case,
it will lead to compile error when CONFIG_ACPI=n, easliy remove
"const char *cells_name" to fix it.

Reported-by: Kejian Yan <yankejian@huawei.com>
Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
---
 include/linux/acpi.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 93811dc..7c603e4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -872,8 +872,8 @@ static inline int acpi_dev_get_property(struct acpi_device *adev,
 }
 
 static inline int acpi_node_get_property_reference(struct fwnode_handle *fwnode,
-				const char *name, const char *cells_name,
-				size_t index, struct acpi_reference_args *args)
+				const char *name, size_t index,
+				struct acpi_reference_args *args)
 {
 	return -ENXIO;
 }
-- 
1.7.12.4



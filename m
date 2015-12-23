From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] device property: add spaces to PROPERTY_ENTRY_STRING macro
Date: Wed, 23 Dec 2015 12:46:45 +0200
Message-ID: <1450867605-1984-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:11090 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643AbbLWKqu (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Dec 2015 05:46:50 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Just a style fix, no functional changes.

To be folded to Andrew's patch.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 include/linux/property.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index b8c4e42..b51fcd3 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -230,7 +230,7 @@ struct property_entry {
 	.name = _name_,					\
 	.length = sizeof(_val_),			\
 	.is_string = true,				\
-	{ .value = {.str = _val_} },			\
+	{ .value = { .str = _val_ } },			\
 }
 
 #define PROPERTY_ENTRY_BOOL(_name_)		\
-- 
2.6.4


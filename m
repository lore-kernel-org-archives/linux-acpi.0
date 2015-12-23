From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/3] device property: add spaces to PROPERTY_ENTRY_STRING macro
Date: Wed, 23 Dec 2015 15:34:42 +0200
Message-ID: <1450877684-76316-2-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

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

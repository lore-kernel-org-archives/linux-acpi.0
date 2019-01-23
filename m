From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH] device property: Fix the length used in PROPERTY_ENTRY_STRING
Date: Wed, 23 Jan 2019 17:44:16 +0300
Message-ID: <20190123144416.51859-1-heikki.krogerus@linux.intel.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

With string type property entries we need to use
sizeof(const char *) instead of the number of characters as
the length of the entry.

If the string was shorter then sizeof(const char *),
attempts to read it would have failed with -EOVERFLOW. The
problem has been hidden because all build-in string
properties have had a string longer then 8 characters until
now.

Fixes: a85f42047533 ("device property: helper macros for property entry creation")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 include/linux/property.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/property.h b/include/linux/property.h
index 3789ec755fb6..65d3420dd5d1 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -258,7 +258,7 @@ struct property_entry {
 #define PROPERTY_ENTRY_STRING(_name_, _val_)		\
 (struct property_entry) {				\
 	.name = _name_,					\
-	.length = sizeof(_val_),			\
+	.length = sizeof(const char *),			\
 	.type = DEV_PROP_STRING,			\
 	{ .value = { .str = _val_ } },			\
 }
-- 
2.20.1

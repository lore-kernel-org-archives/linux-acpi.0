From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v3 3/3] device property: avoid allocations of 0 length
Date: Tue, 29 Dec 2015 13:07:50 +0200
Message-ID: <1451387271-56535-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1451387271-56535-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1451387271-56535-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

Arrays can not have zero elements by definition of the unified device
properties. If such property comes from outside we should not allow it to pass.
Otherwise memory allocation on 0 length will return non-NULL value, which we
currently don't check.

Prevent memory allocations of 0 length.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index b3429cc..c359351 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -653,6 +653,9 @@ int fwnode_property_match_string(struct fwnode_handle *fwnode,
 	if (nval < 0)
 		return nval;
 
+	if (nval == 0)
+		return -ENODATA;
+
 	values = kcalloc(nval, sizeof(*values), GFP_KERNEL);
 	if (!values)
 		return -ENOMEM;
@@ -718,6 +721,9 @@ static int pset_copy_entry(struct property_entry *dst,
 		return -ENOMEM;
 
 	if (src->is_array) {
+		if (!src->length)
+			return -ENODATA;
+
 		if (src->is_string) {
 			nval = src->length / sizeof(const char *);
 			dst->pointer.str = kcalloc(nval, sizeof(const char *),
-- 
2.6.4

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 2/3] device property: the secondary fwnode needs to depend on the primary
Date: Wed, 23 Dec 2015 15:34:43 +0200
Message-ID: <1450877684-76316-3-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450877684-76316-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, heikki.krogerus@linux.intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

This fixes NULL pointer dereference when the primary fwnode handle
does not exist, for example with PCI devices that do not have ACPI
companion.

Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/base/property.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 0b22c8a..6c04d18 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -218,7 +218,7 @@ bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
 	bool ret;
 
 	ret = __fwnode_property_present(fwnode, propname);
-	if (ret == false && fwnode->secondary)
+	if (ret == false && fwnode && fwnode->secondary)
 		ret = __fwnode_property_present(fwnode->secondary, propname);
 	return ret;
 }
@@ -423,7 +423,7 @@ EXPORT_SYMBOL_GPL(device_property_match_string);
 	int _ret_;									\
 	_ret_ = FWNODE_PROP_READ(_fwnode_, _propname_, _type_, _proptype_,		\
 				 _val_, _nval_);					\
-	if (_ret_ == -EINVAL && _fwnode_->secondary)					\
+	if (_ret_ == -EINVAL && fwnode && _fwnode_->secondary)				\
 		_ret_ = FWNODE_PROP_READ(_fwnode_->secondary, _propname_, _type_,	\
 				_proptype_, _val_, _nval_);				\
 	_ret_;										\
@@ -593,7 +593,7 @@ int fwnode_property_read_string_array(struct fwnode_handle *fwnode,
 	int ret;
 
 	ret = __fwnode_property_read_string_array(fwnode, propname, val, nval);
-	if (ret == -EINVAL && fwnode->secondary)
+	if (ret == -EINVAL && fwnode && fwnode->secondary)
 		ret = __fwnode_property_read_string_array(fwnode->secondary,
 							  propname, val, nval);
 	return ret;
@@ -621,7 +621,7 @@ int fwnode_property_read_string(struct fwnode_handle *fwnode,
 	int ret;
 
 	ret = __fwnode_property_read_string(fwnode, propname, val);
-	if (ret == -EINVAL && fwnode->secondary)
+	if (ret == -EINVAL && fwnode && fwnode->secondary)
 		ret = __fwnode_property_read_string(fwnode->secondary,
 						    propname, val);
 	return ret;
-- 
2.6.4

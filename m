From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] driver core: Implement device property accessors through fwnode ones
Date: Mon, 23 Mar 2015 00:10:30 +0100
Message-ID: <9998673.jvqRF9ZONz@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <CACxGe6tiDszPDpP_u1yxNgMA8HjagDKtGuu35hfkyJtZdGE0Aw@mail.gmail.com> <10066684.kPKm7OTnxF@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:56269 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751920AbbCVWqa (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sun, 22 Mar 2015 18:46:30 -0400
In-Reply-To: <10066684.kPKm7OTnxF@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@linaro.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Now that the ACPI companions of devices are pointed to by the fwnode
field in struct device, the device_property_*() accessor functions
can be modified to use their fwnode_property_*() counterparts
internally with minimum extra overhead in the IS_ENABLED(CONFIG_OF)
case, so make those changes.

This allows us to get rid of the rather ugly DEV_PROP_READ_ARRAY()
macro among other things.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of

http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=ce793486e23e0162a732c605189c8028e0910e86

---
 drivers/base/property.c |   44 +++++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 27 deletions(-)

Index: linux-pm/drivers/base/property.c
===================================================================
--- linux-pm.orig/drivers/base/property.c
+++ linux-pm/drivers/base/property.c
@@ -15,6 +15,12 @@
 #include <linux/acpi.h>
 #include <linux/of.h>
 
+static inline struct fwnode_handle *dev_fwnode(struct device *dev)
+{
+	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
+		&dev->of_node->fwnode : dev->fwnode;
+}
+
 /**
  * device_property_present - check if a property of a device is present
  * @dev: Device whose property is being checked
@@ -24,10 +30,7 @@
  */
 bool device_property_present(struct device *dev, const char *propname)
 {
-	if (IS_ENABLED(CONFIG_OF) && dev->of_node)
-		return of_property_read_bool(dev->of_node, propname);
-
-	return !acpi_dev_prop_get(ACPI_COMPANION(dev), propname, NULL);
+	return fwnode_property_present(dev_fwnode(dev), propname);
 }
 EXPORT_SYMBOL_GPL(device_property_present);
 
@@ -47,17 +50,6 @@ bool fwnode_property_present(struct fwno
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
-#define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval) \
-	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval)) \
-	      : of_property_count_elems_of_size((node), (propname), sizeof(type))
-
-#define DEV_PROP_READ_ARRAY(_dev_, _propname_, _type_, _proptype_, _val_, _nval_) \
-	IS_ENABLED(CONFIG_OF) && _dev_->of_node ? \
-		(OF_DEV_PROP_READ_ARRAY(_dev_->of_node, _propname_, _type_, \
-					_val_, _nval_)) : \
-		acpi_dev_prop_read(ACPI_COMPANION(_dev_), _propname_, \
-				   _proptype_, _val_, _nval_)
-
 /**
  * device_property_read_u8_array - return a u8 array property of a device
  * @dev: Device to get the property of
@@ -77,7 +69,7 @@ EXPORT_SYMBOL_GPL(fwnode_property_presen
 int device_property_read_u8_array(struct device *dev, const char *propname,
 				  u8 *val, size_t nval)
 {
-	return DEV_PROP_READ_ARRAY(dev, propname, u8, DEV_PROP_U8, val, nval);
+	return fwnode_property_read_u8_array(dev_fwnode(dev), propname, val, nval);
 }
 EXPORT_SYMBOL_GPL(device_property_read_u8_array);
 
@@ -100,7 +92,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u
 int device_property_read_u16_array(struct device *dev, const char *propname,
 				   u16 *val, size_t nval)
 {
-	return DEV_PROP_READ_ARRAY(dev, propname, u16, DEV_PROP_U16, val, nval);
+	return fwnode_property_read_u16_array(dev_fwnode(dev), propname, val, nval);
 }
 EXPORT_SYMBOL_GPL(device_property_read_u16_array);
 
@@ -123,7 +115,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u
 int device_property_read_u32_array(struct device *dev, const char *propname,
 				   u32 *val, size_t nval)
 {
-	return DEV_PROP_READ_ARRAY(dev, propname, u32, DEV_PROP_U32, val, nval);
+	return fwnode_property_read_u32_array(dev_fwnode(dev), propname, val, nval);
 }
 EXPORT_SYMBOL_GPL(device_property_read_u32_array);
 
@@ -146,7 +138,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u
 int device_property_read_u64_array(struct device *dev, const char *propname,
 				   u64 *val, size_t nval)
 {
-	return DEV_PROP_READ_ARRAY(dev, propname, u64, DEV_PROP_U64, val, nval);
+	return fwnode_property_read_u64_array(dev_fwnode(dev), propname, val, nval);
 }
 EXPORT_SYMBOL_GPL(device_property_read_u64_array);
 
@@ -169,10 +161,7 @@ EXPORT_SYMBOL_GPL(device_property_read_u
 int device_property_read_string_array(struct device *dev, const char *propname,
 				      const char **val, size_t nval)
 {
-	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
-		of_property_read_string_array(dev->of_node, propname, val, nval) :
-		acpi_dev_prop_read(ACPI_COMPANION(dev), propname,
-				   DEV_PROP_STRING, val, nval);
+	return fwnode_property_read_string_array(dev_fwnode(dev), propname, val, nval);
 }
 EXPORT_SYMBOL_GPL(device_property_read_string_array);
 
@@ -193,13 +182,14 @@ EXPORT_SYMBOL_GPL(device_property_read_s
 int device_property_read_string(struct device *dev, const char *propname,
 				const char **val)
 {
-	return IS_ENABLED(CONFIG_OF) && dev->of_node ?
-		of_property_read_string(dev->of_node, propname, val) :
-		acpi_dev_prop_read(ACPI_COMPANION(dev), propname,
-				   DEV_PROP_STRING, val, 1);
+	return fwnode_property_read_string(dev_fwnode(dev), propname, val);
 }
 EXPORT_SYMBOL_GPL(device_property_read_string);
 
+#define OF_DEV_PROP_READ_ARRAY(node, propname, type, val, nval) \
+	(val) ? of_property_read_##type##_array((node), (propname), (val), (nval)) \
+	      : of_property_count_elems_of_size((node), (propname), sizeof(type))
+
 #define FWNODE_PROP_READ_ARRAY(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_) \
 ({ \
 	int _ret_; \


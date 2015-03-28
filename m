From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 3/3][RFD] device property: Implement fallback to built-in properties
Date: Sat, 28 Mar 2015 02:26:35 +0100
Message-ID: <5634167.lftqZnjhIC@vostro.rjw.lan>
References: <1422278260-108175-1-git-send-email-heikki.krogerus@linux.intel.com> <10066684.kPKm7OTnxF@vostro.rjw.lan> <1594911.7FXIhSfjIv@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51912 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752397AbbC1BDH (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 27 Mar 2015 21:03:07 -0400
In-Reply-To: <1594911.7FXIhSfjIv@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, ACPI Devel Mailing List <linux-acpi@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Modify the fwnode_property_* accessors so as to make them fall back
to using "built-in" device properties from a property_set structure
associated with the given device (as the secondary firmware node)
if the property in question cannot be retrieved from the primary
firmware node (DT or ACPI).  That will make the device_properties_*
functions do the same thing as they use fwnode_property_* internally.

That should make it easier to provide default values for device
properties used by device drivers to be used in case the properties
in question are not provided by the platform firmare at all or
they cannot be retireved from the platform firmware due to errors.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

First of all, this should show why I thought it would be better to use
the primary/secondary scheme for firmware nodes instead of just having a
list of them with the head pointed to by the struct device's fwnode field.
Namely, within the primary/secondary scheme the ordering of property lookup
is always well defined and there's no overhead when, for example, somebody
specifically wants to access the ACPI companion firmware node etc.

Second, as I said in the intro message, this is not for immediate application
(apart from any review comments on [1-2/3]), because it would introduce an
artificial difference between DT and ACPI that I'd prefer to avoid.

Namely, dev_fwnode() (introduced by one of the patches in linux-next) returns
the address of the dev->of_node's fwnode field if dev->of_node is present and
that would not have the secondary pointer set.  On the other hand, since ACPI
is now using set_primary_fwnode() to add its firmware node companions to
devices, the secondary pointer in its firmware node handle will be set if the
"built-in" properties are present.  So, effectively, with this patch applied
ACPI would always fall back to the "built-in" properties (if present), while
DT would not do that (unless the DT node is missing entirely).

That difference could be worked around, though, if dev->fwnode is always set
whenever dev->of_node is set in essentially this way:

	dev->of_node = dn;
	set_primary_fwnode(dev, &dn->fwnode);

(that, of course, can be defined as a macro or static inline).  Now, I'm not
sure about that, but my somewhat educated guess is that while dev->of_node is
read in many many places, the number of places in which it is set is actually
much smaller and making this change in one go should be a workable thing.

Please let me know what you think.

---
 drivers/base/property.c |   61 ++++++++++++++++++++++++------------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

Index: linux-pm/drivers/base/property.c
===================================================================
--- linux-pm.orig/drivers/base/property.c
+++ linux-pm/drivers/base/property.c
@@ -127,12 +119,16 @@ EXPORT_SYMBOL_GPL(device_property_presen
  */
 bool fwnode_property_present(struct fwnode_handle *fwnode, const char *propname)
 {
-	if (is_of_node(fwnode))
-		return of_property_read_bool(of_node(fwnode), propname);
-	else if (is_acpi_node(fwnode))
-		return !acpi_dev_prop_get(acpi_node(fwnode), propname, NULL);
+	bool ret = false;
 
-	return !!pset_prop_get(to_pset(fwnode), propname);
+	if (is_of_node(fwnode)) {
+		ret = of_property_read_bool(of_node(fwnode), propname);
+		fwnode = fwnode->secondary;
+	} else if (is_acpi_node(fwnode)) {
+		ret = !acpi_dev_prop_get(acpi_node(fwnode), propname, NULL);
+		fwnode = fwnode->secondary;
+	}
+	return ret ? true : !!pset_prop_get(to_pset(fwnode), propname);
 }
 EXPORT_SYMBOL_GPL(fwnode_property_present);
 
@@ -283,17 +279,18 @@ EXPORT_SYMBOL_GPL(device_property_read_s
 
 #define FWNODE_PROP_READ_ARRAY(_fwnode_, _propname_, _type_, _proptype_, _val_, _nval_) \
 ({ \
-	int _ret_; \
-	if (is_of_node(_fwnode_)) \
+	int _ret_ = -ENXIO; \
+	if (is_of_node(_fwnode_)) { \
 		_ret_ = OF_DEV_PROP_READ_ARRAY(of_node(_fwnode_), _propname_, \
 					       _type_, _val_, _nval_); \
-	else if (is_acpi_node(_fwnode_)) \
+		_fwnode_ = _fwnode_->secondary; \
+	} else if (is_acpi_node(_fwnode_)) { \
 		_ret_ = acpi_dev_prop_read(acpi_node(_fwnode_), _propname_, \
 					   _proptype_, _val_, _nval_); \
-	else \
-		_ret_ = pset_prop_read_array(to_pset(_fwnode_), _propname_, \
-					     _proptype_, _val_, _nval_); \
-	_ret_; \
+		_fwnode_ = _fwnode_->secondary; \
+	} \
+	_ret_ ? pset_prop_read_array(to_pset(_fwnode_), _propname_, \
+				     _proptype_, _val_, _nval_) : 0; \
 })
 
 /**
@@ -422,17 +419,21 @@ int fwnode_property_read_string_array(st
 				      const char *propname, const char **val,
 				      size_t nval)
 {
-	if (is_of_node(fwnode))
-		return val ?
+	int ret = -ENXIO;
+
+	if (is_of_node(fwnode)) {
+		ret = val ?
 			of_property_read_string_array(of_node(fwnode), propname,
 						      val, nval) :
 			of_property_count_strings(of_node(fwnode), propname);
-	else if (is_acpi_node(fwnode))
-		return acpi_dev_prop_read(acpi_node(fwnode), propname,
-					  DEV_PROP_STRING, val, nval);
-
-	return pset_prop_read_array(to_pset(fwnode), propname,
-				    DEV_PROP_STRING, val, nval);
+		fwnode = fwnode->secondary;
+	} else if (is_acpi_node(fwnode)) {
+		ret = acpi_dev_prop_read(acpi_node(fwnode), propname,
+					 DEV_PROP_STRING, val, nval);
+		fwnode = fwnode->secondary;
+	}
+	return ret ? pset_prop_read_array(to_pset(fwnode), propname,
+					  DEV_PROP_STRING, val, nval) : 0;
 }
 EXPORT_SYMBOL_GPL(fwnode_property_read_string_array);
 


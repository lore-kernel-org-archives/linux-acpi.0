From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] driver core: property: Update fwnode_property_read_string_array()
Date: Tue, 24 Mar 2015 01:40:13 +0100
Message-ID: <1670743.YY8G2nYXVm@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63404 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751935AbbCXAQL (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 23 Mar 2015 20:16:11 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Commit 5c0acf3b4f96 (driver core: Add comments about returning array
counts) forgot to update fwnode_property_read_string_array() along
the lines of device_property_read_string_array(), although it did
change the kerneldoc comment of it.  Fix that.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/property.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: linux-pm/drivers/base/property.c
===================================================================
--- linux-pm.orig/drivers/base/property.c
+++ linux-pm/drivers/base/property.c
@@ -347,8 +347,10 @@ int fwnode_property_read_string_array(st
 				      size_t nval)
 {
 	if (is_of_node(fwnode))
-		return of_property_read_string_array(of_node(fwnode), propname,
-						     val, nval);
+		return val ?
+			of_property_read_string_array(of_node(fwnode), propname,
+						      val, nval) :
+			of_property_count_strings(of_node(fwnode), propname);
 	else if (is_acpi_node(fwnode))
 		return acpi_dev_prop_read(acpi_node(fwnode), propname,
 					  DEV_PROP_STRING, val, nval);


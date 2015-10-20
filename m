From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] ACPI / property: Fix subnode lookup scope for data-only subnodes
Date: Wed, 21 Oct 2015 01:51:24 +0200
Message-ID: <3607867.RKSpENdj9h@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, Darren Hart <darren.hart@intel.com>
List-Id: linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The correct scope for looking up the objects to generate data packages for
data-only subnodes pointed to by another data-only subnode is the scope
of the parent of that subnode and not the scope containing the _DSD object
at the top of the hierarchy (the latter works only if all of the objects
returning data-only subnode packages in a given hierarchy are in the same
scope).

Fix the code to work as expected.

Fixes: 445b0eb058f5 (ACPI / property: Add support for data-only subnodes)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

On top of linux-next.

Thanks,
Rafael

---
 drivers/acpi/property.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

Index: linux-pm/drivers/acpi/property.c
===================================================================
--- linux-pm.orig/drivers/acpi/property.c
+++ linux-pm/drivers/acpi/property.c
@@ -71,7 +71,14 @@ static bool acpi_nondev_subnode_ok(acpi_
 	if (acpi_extract_properties(buf.pointer, &dn->data))
 		dn->handle = handle;
 
-	if (acpi_enumerate_nondev_subnodes(scope, buf.pointer, &dn->data))
+	/*
+	 * The scope for the subnode object lookup is the one of the namespace
+	 * node (device) containing the object that has returned the package.
+	 * That is, it's the scope of that object's parent.
+	 */
+	status = acpi_get_parent(handle, &scope);
+	if (ACPI_SUCCESS(status)
+	    && acpi_enumerate_nondev_subnodes(scope, buf.pointer, &dn->data))
 		dn->handle = handle;
 
 	if (dn->handle) {

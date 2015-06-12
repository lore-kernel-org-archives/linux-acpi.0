From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] ACPI / enumeration: Document the rules regarding the PRP0001 device ID
Date: Fri, 12 Jun 2015 02:28:45 +0200
Message-ID: <2448906.OPRrQsay8x@vostro.rjw.lan>
References: <2849248.1anC4YaKJn@vostro.rjw.lan> <20150611094129.GT1478@lahna.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:52794 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752191AbbFLACz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Jun 2015 20:02:55 -0400
In-Reply-To: <20150611094129.GT1478@lahna.fi.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

On Thursday, June 11, 2015 12:41:29 PM Mika Westerberg wrote:
> On Thu, Jun 11, 2015 at 03:24:02AM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Document how the ACPI device enumeration code uses the special
> > PRP0001 device ID.
> > 
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> At last the long needed documentation regarding PRP0001 :-) Thank you
> for doing this,
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> 
> One typo found, see below.

Thanks!

I've fixed this one and added a clarification about enumerating I2C and SPI
clients with PRP0001 and "compatible".

Updated patch is below.

---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / enumeration: Document the rules regarding the PRP0001 device ID

Document how the ACPI device enumeration code uses the special
PRP0001 device ID.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 Documentation/acpi/enumeration.txt |   51 +++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

Index: linux-pm/Documentation/acpi/enumeration.txt
===================================================================
--- linux-pm.orig/Documentation/acpi/enumeration.txt
+++ linux-pm/Documentation/acpi/enumeration.txt
@@ -359,3 +359,54 @@ the id should be set like:
 The ACPI id "XYZ0001" is then used to lookup an ACPI device directly under
 the MFD device and if found, that ACPI companion device is bound to the
 resulting child platform device.
+
+Device Tree namespace link device ID
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+The Device Tree protocol uses device indentification based on the "compatible"
+property whose value is a string or an array of strings recognized as device
+identifiers by drivers and the driver core.  The set of all those strings may be
+regarded as a device indentification namespace analogous to the ACPI/PNP device
+ID namespace.  Consequently, in principle it should not be necessary to allocate
+a new (and arguably redundant) ACPI/PNP device ID for a devices with an existing
+identification string in the Device Tree (DT) namespace, especially if that ID
+is only needed to indicate that a given device is compatible with another one,
+presumably having a matching driver in the kernel already.
+
+In ACPI, the device identification object called _CID (Compatible ID) is used to
+list the IDs of devices the given one is compatible with, but those IDs must
+belong to one of the namespaces prescribed by the ACPI specification (see
+Section 6.1.2 of ACPI 6.0 for details) and the DT namespace is not one of them.
+Moreover, the specification mandates that either a _HID or an _ADR identificaion
+object be present for all ACPI objects representing devices (Section 6.1 of ACPI
+6.0).  For non-enumerable bus types that object must be _HID and its value must
+be a device ID from one of the namespaces prescribed by the specification too.
+
+The special DT namespace link device ID, PRP0001, provides a means to use the
+existing DT-compatible device identification in ACPI and to satisfy the above
+requirements following from the ACPI specification at the same time.  Namely,
+if PRP0001 is returned by _HID, the ACPI subsystem will look for the
+"compatible" property in the device object's _DSD and will use the value of that
+property to identify the corresponding device in analogy with the original DT
+device identification algorithm.  If the "compatible" property is not present
+or its value is not valid, the device will not be enumerated by the ACPI
+subsystem.  Otherwise, it will be enumerated automatically as a platform device
+(except when an I2C or SPI link from the device to its parent is present, in
+which case the ACPI core will leave the device enumeration to the parent's
+driver) and the identification strings from the "compatible" property value will
+be used to find a driver for the device along with the device IDs listed by _CID
+(if present).
+
+Analogously, if PRP0001 is present in the list of device IDs returned by _CID,
+the identification strings listed by the "compatible" property value (if present
+and valid) will be used to look for a driver matching the device, but in that
+case their relative priority with respect to the other device IDs listed by
+_HID and _CID depends on the position of PRP0001 in the _CID return package.
+Specifically, the device IDs returned by _HID and preceding PRP0001 in the _CID
+return package will be checked first.  Also in that case the bus type the device
+will be enumerated to depends on the device ID returned by _HID.
+
+It is valid to define device objects with a _HID returning PRP0001 and without
+the "compatible" property in the _DSD or a _CID as long as one of their
+ancestors provides a _DSD with a valid "compatible" property.  Such device
+objects are then simply regarded as additional "blocks" providing hierarchical
+configuration information to the driver of the composite ancestor device.


From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] ACPI / enumeration: Document the rules regarding the
 PRP0001 device ID
Date: Thu, 11 Jun 2015 12:41:29 +0300
Message-ID: <20150611094129.GT1478@lahna.fi.intel.com>
References: <2849248.1anC4YaKJn@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:13495 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbbFKJls (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 11 Jun 2015 05:41:48 -0400
Content-Disposition: inline
In-Reply-To: <2849248.1anC4YaKJn@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Darren Hart <darren.hart@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Darren Hart <dvhart@infradead.org>

On Thu, Jun 11, 2015 at 03:24:02AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Document how the ACPI device enumeration code uses the special
> PRP0001 device ID.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

At last the long needed documentation regarding PRP0001 :-) Thank you
for doing this,

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

One typo found, see below.

> ---
>  Documentation/acpi/enumeration.txt |   49 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
> 
> Index: linux-pm/Documentation/acpi/enumeration.txt
> ===================================================================
> --- linux-pm.orig/Documentation/acpi/enumeration.txt
> +++ linux-pm/Documentation/acpi/enumeration.txt
> @@ -359,3 +359,52 @@ the id should be set like:
>  The ACPI id "XYZ0001" is then used to lookup an ACPI device directly under
>  the MFD device and if found, that ACPI companion device is bound to the
>  resulting child platform device.
> +
> +Device Tree namespace link device ID
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +The Device Tree protocol uses device indentification based on the "compatible"
> +property whose value is a string or an array of strings recognized as device
> +identifiers by drivers and the driver core.  The set of all those strings may be
> +regarded as a device indentification namespace analogous to the ACPI/PNP device
> +ID namespace.  Consequently, in principle it should not be necessary to allocate
> +a new (and arguably redundant) ACPI/PNP device ID for a devices with an existing
> +identification string in the Device Tree (DT) namespace, especially if that ID
> +is only needed to indicate that a given device is compatible with another one,
> +presumably having a matching driver in the kernel already.
> +
> +In ACPI, the device identification object called _CID (Compatible ID) is used to
> +list the IDs of devices the given one is compatible with, but those IDs must
> +belong to one of the namespaces prescribed by the ACPI specification (see
> +Section 6.1.2 of ACPI 6.0 for details) and the DT namespace is not one of them.
> +Moreover, the specification mandates that either a _HID or an _ADR identificaion
> +object be present for all ACPI objects representing devices (Section 6.1 of ACPI
> +6.0).  For non-enumerable bus types that object must be _HID and its value must
> +be a device ID from one of the namespaces prescribed by the specification too.
> +
> +The special DT namespace link device ID, PRP0001, provides a means to use the
> +existing DT-compatible device identification in ACPI and to satisfy the above
> +requirements following from the ACPI specification at the same time.  Namely,
> +if PRP0001 is returned by _HID, the ACPI subsystem will look for the
> +"compatible" property in the device object's _DSD and will use the value of that
> +property to identify the corresponding device in analogy with the original DT
> +device identification algorithm.  If the "compatible" propoerty is not present
                                                         ^^^^^^^^^
Should say 'property'.

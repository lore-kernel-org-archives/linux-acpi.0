From: Len Brown <len.brown@intel.com>
Subject: latest ACPI patch is acpi-test-20060127-2.6.16-rc1.diff.gz
Date: Tue, 31 Jan 2006 03:36:20 -0500
Message-ID: <200601310336.20837.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from sccrmhc14.comcast.net ([63.240.77.84]:2496 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S965055AbWAaIgY (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 31 Jan 2006 03:36:24 -0500
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Added an ACPICA update that fixes some long-standing bugs...

latest patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git acpica
git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test

ftp://ftp.kernel.org/pub/linux/kernel/people/lenb/acpi/patches/test/2.6.16/

cheers,
-Len

[ACPI] ACPICA 20060127

Implemented support in the Resource Manager to allow
unresolved namestring references within resource package
objects for the _PRT method. This support is in addition
to the previously implemented unresolved reference
support within the AML parser. If the interpreter slack
mode is enabled (true on Linux unless acpi=strict),
these unresolved references will be passed through
to the caller as a NULL package entry.
http://bugzilla.kernel.org/show_bug.cgi?id=5741

Implemented and deployed new macros and functions for
error and warning messages across the subsystem. These
macros are simpler and generate less code than their
predecessors. The new macros ACPI_ERROR, ACPI_EXCEPTION,
ACPI_WARNING, and ACPI_INFO replace the ACPI_REPORT_*
macros.

Implemented the acpi_cpu_flags type to simplify host OS
integration of the Acquire/Release Lock OSL interfaces.
Suggested by Steven Rostedt and Andrew Morton.

Fixed a problem where Alias ASL operators are sometimes
not correctly resolved. causing AE_AML_INTERNAL
http://bugzilla.kernel.org/show_bug.cgi?id=5189
http://bugzilla.kernel.org/show_bug.cgi?id=5674

Fixed several problems with the implementation of the
ConcatenateResTemplate ASL operator. As per the ACPI
specification, zero length buffers are now treated as a
single EndTag. One-length buffers always cause a fatal
exception. Non-zero length buffers that do not end with
a full 2-byte EndTag cause a fatal exception.

Fixed a possible structure overwrite in the
AcpiGetObjectInfo external interface. (With assistance
from Thomas Renninger)

Signed-off-by: Bob Moore <robert.moore@intel.com>
Signed-off-by: Len Brown <len.brown@intel.com>

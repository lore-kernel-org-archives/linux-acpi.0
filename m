From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 4/4] ACPI: WMI: Add documentation
Date: Wed, 28 Nov 2007 02:33:19 +0000
Message-ID: <200711280233.19987.carlos@strangeworlds.co.uk>
References: <200711280230.24318.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from slackadelic.com ([65.196.224.53]:43577 "EHLO
	mail.slackadelic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759868AbXK1Cem (ORCPT
	<rfc822;Linux-acpi@vger.kernel.org>); Tue, 27 Nov 2007 21:34:42 -0500
In-Reply-To: <200711280230.24318.carlos@strangeworlds.co.uk>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, "Nashif, Anas" <anas.nashif@intel.com>

Add documentation for WMI-ACPI, giving basic information for WMI driver
and userspace writers.

===
ChangeLog

v1 (2007-11-28)

Initial version

Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
---
 Documentation/acpi/wmi.txt |   82 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 82 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/acpi/wmi.txt

diff --git a/Documentation/acpi/wmi.txt b/Documentation/acpi/wmi.txt
new file mode 100644
index 0000000..1eff576
--- /dev/null
+++ b/Documentation/acpi/wmi.txt
@@ -0,0 +1,82 @@
+WMI-ACPI mapping driver
+
+Copyright (C) 2007 Carlos Corbacho <carlos@strangeworlds.co.uk>
+
+Updated: 28th November 2007
+
+1) About this guide
+
+This guide is a basic introduction on how to interact with the WMI-ACPI mapper
+driver in the kernel - it presumes you already have a basic knowledge of
+WMI-ACPI, ACPI and the hardware you are writing the driver for.
+
+2) What is WMI-ACPI
+
+At its simplest, WMI-ACPI is a proprietary extension to the ACPI specification
+from Microsoft to allow WMI (their implementation of WBEM) to access
+instrumentation data and methods in ACPI from userspace, via the ACPI _HID
+device PNP0C14.
+
+3) What is the WMI-ACPI mapper
+
+The Linux WMI to ACPI mapper is the implementation of the kernel part of the
+WMI-ACPI specification.
+
+NOTE: The mapper does not do anything itself with the WMIACPI devices - it
+simply makes their methods and data available to other drivers and userspace.
+
+Userspace:
+
+WMI-ACPI is exposed to userspace via sysfs and netlink. Data and methods are
+exposed through sysfs, events are sent via netlink.
+
+Accessing WMI-ACPI directly through sysfs is generally not recommended -
+ideally, this should be done by a userspace library, which could also deal
+with the netlink events.
+
+The sysfs interface is in /sys/firmware/acpi/wmi for WMI methods and data, as
+follows:
+
+/sys/firmware/acpi/wmi/
+|
+|-> <GUID>/
+ |-> type (method, data, event)
+
+Method & data blocks
+ |-> <instance>/
+ |-> data (binary data file - write input data to file, read file
+           to execute method or retrieve data).
+
+Method only
+ |-> method_id (write value of method id to execute)
+
+Events - passed to userspace via netlink. However, the extra WMI data
+associated with an event is exposed through sysfs.
+
+ |-> notification (ACPI event value)
+ |-> data (binary data file - WMI data associated with the event)
+
+Kernel interface:
+
+For drivers that want to bypass userspace (either because WBEM is overkill,
+or a userspace application is not really appropriate for want you want to do),
+and talk directly to WMI-ACPI, then the mapper also exports functions
+to do this - these are essentially thin wrappers around ACPI, so if you are
+familiar with writing an ACPI driver, then writing a WMI driver is not much more
+of a stretch.
+
+The exported WMIACPI functions can be found in <linux/acpi.h>
+
+The most important differences between WMI-ACPI and WMI are:
+
+A) WMI based drivers should be platform drivers, not ACPI drivers.
+
+B) ACPI details such as handles and/ or path names are hidden; you use GUIDs as
+   the unique identifier to call methods instead (you don't need to care either
+   about multiple PNP0C14 devices exiting - the GUIDs are always unique, and
+   these are what you will work with).
+
+C) In your probe() function, you should use wmi_has_guid() to look for the
+   GUID(s) you need for your driver.
+
+[1] http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx
\ No newline at end of file
-- 
1.5.3.4


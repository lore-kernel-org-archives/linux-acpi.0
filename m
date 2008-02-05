From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 5/5] ACPI: WMI: Add documentation
Date: Tue, 05 Feb 2008 02:17:27 +0000
Message-ID: <20080205021727.4422.67605.stgit@pacifica>
References: <20080205021658.4422.83165.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:60849 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755864AbYBECR3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2008 21:17:29 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by pacifica (8.14.1/8.14.1) with ESMTP id m152HRYX004521
	for <linux-acpi@vger.kernel.org>; Tue, 5 Feb 2008 02:17:27 GMT
In-Reply-To: <20080205021658.4422.83165.stgit@pacifica>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org

Add documentation for WMI-ACPI, giving basic information for WMI driver
and userspace writers.

===
ChangeLog

v1 (2007-11-28)

Initial version

v2 (2007-12-08)

Update with latest changes to sysfs interface

v3 (2008-02-05)

Update
---

 Documentation/acpi/wmi.txt |  131 ++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 131 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/acpi/wmi.txt


diff --git a/Documentation/acpi/wmi.txt b/Documentation/acpi/wmi.txt
new file mode 100644
index 0000000..4d243aa
--- /dev/null
+++ b/Documentation/acpi/wmi.txt
@@ -0,0 +1,131 @@
+ACPI-WMI mapping driver
+
+Copyright (C) 2007-2008 Carlos Corbacho <carlos@strangeworlds.co.uk>
+
+Updated: 5th February 2008
+
+1) About this guide
+
+This guide is a basic introduction on how to interact with the ACPI-WMI mapper
+driver in the kernel - it presumes you already have a basic knowledge of
+ACPI-WMI, ACPI and the hardware you are writing the driver for.
+
+2) What is ACPI-WMI
+
+At its simplest, ACPI-WMI is a proprietary extension to the ACPI specification
+from Microsoft to allow WMI (their implementation of WBEM) to access
+instrumentation data and methods in ACPI from userspace, via the ACPI _HID
+device PNP0C14.
+
+3) What is the ACPI-WMI mapper
+
+The Linux ACPI-WMI driver is the implementation of this mapper for Linux.
+
+NOTE: The mapper does not do anything itself with the ACPI-WMI devices - it
+simply makes their functionality available to other drivers and userspace.
+
+4) Implementation
+
+A general note:
+
+ACPI-WMI has no knowledge of the size of the data blocks passed to/ from
+ACPI-WMI - this is not encoded in the DSDT, and is usually only available in
+the form of a MOF file. If this is not available, you will need to analyze
+the DSDT to get this information.
+
+You will therefore need to know in advance the size of any data structures
+to handle them.
+
+Userspace:
+
+ACPI-WMI is exposed to userspace via sysfs and netlink. Data and methods are
+exposed through sysfs, events are sent via netlink.
+
+Accessing ACPI-WMI directly through sysfs is generally not recommended -
+ideally, this should be done by a userspace library, which could also deal
+with the netlink events.
+
+The sysfs interface is in /sys/devices/virtual/wmi for WMI methods and data, as
+follows:
+
+/sys/devices/virtual/wmi/
+|
+|-> <GUID>/
+ |-> type (method, data, event)
+
+Method & data blocks
+ |-> instance (instance to execute)
+ |-> instance_count (read only - maximum number of instances available)
+ |-> data (binary data file - write input data to file, read file
+           to execute method and/ or retrieve data).
+
+To read/ write a data block, instance must be set first.
+
+Method only
+ |-> method_id (write value of method id to execute)
+
+To execute a method, instance and method_id must be set first.
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
+and talk directly to ACPI-WMI, then the mapper also exports functions
+to do this - these are essentially thin wrappers around ACPI, so if you are
+familiar with writing an ACPI driver, then writing a WMI driver is not much more
+of a stretch.
+
+The exported ACPI-WMI functions can be found in <linux/acpi.h>
+
+The most important differences between ACPI and WMI drivers are:
+
+A) WMI based drivers should be platform drivers, not ACPI drivers.
+
+B) ACPI details such as handles and/ or path names are hidden; you use GUIDs as
+   the unique identifier to call methods instead (you don't need to care either
+   about multiple PNP0C14 devices existing - the GUIDs are always unique, and
+   these are what you will work with).
+
+C) In your probe() function, you should use wmi_has_guid() to look for the
+   GUID(s) you need for your driver.
+
+For the in kernel interface, the following functions are available:
+
+wmi_evaluate_method():
+
+Evaluate a WMI method.
+
+wmi_query_block():
+
+Return the contents of a WMI data block.
+
+wmi_set_block()
+
+Set the contents of a WMI data block.
+
+wmi_install_notify_handler():
+wmi_remove_notify_handler():
+
+Install and/ or remove a handler for a WMI event - one handler per GUID.
+
+wmi_get_event_data():
+
+Return the data associated with a given WMI event.
+
+wmi_has_guid():
+
+Returns true if a given GUID is available on the system.
+
+wmi_get_device():
+
+Return a pointer to the virtual device associated with a GUID. If you need to
+set a parent device (e.g. for an input device), use this.
+
+
+[1] http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx


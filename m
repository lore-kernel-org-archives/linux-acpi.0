From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 5/5] ACPI: WMI: Add initial documentation
Date: Tue, 5 Feb 2008 19:12:26 -0800
Message-ID: <20080205191226.9248e1e8.randy.dunlap@oracle.com>
References: <20080205021658.4422.83165.stgit@pacifica>
	<20080205021727.4422.67605.stgit@pacifica>
	<200802050225.58727.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rgminet01.oracle.com ([148.87.113.118]:50855 "EHLO
	rgminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754697AbYBFDQK (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Feb 2008 22:16:10 -0500
In-Reply-To: <200802050225.58727.carlos@strangeworlds.co.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>

On Tue, 5 Feb 2008 02:25:58 +0000 Carlos Corbacho wrote:

> ACPI: WMI: Add initial documentation
> 
> Add initial documentation for WMI-ACPI, giving basic information for WMI
> kernel and userspace driver writers.
> 
> ===
> ChangeLog
> 
> v1 (2007-11-28)
> 
> Initial version
> 
> v2 (2007-12-08)
> 
> Update with latest changes to sysfs interface
> 
> v3 (2008-02-05)
> 
> Update
> 
> Signed-off-by: Carlos Corbacho <carlos@strangeworlds.co.uk>
> CC: Len Brown <lenb@kernel.org>
> ---
> Added SOB this time... (and a few trivial fixes)
> 
> This replaces: [PATCH 5/5] ACPI: WMI: Add documentation
> 
> (AKA - I shouldn't send a patch series out at 2am...)
> 
>  Documentation/acpi/wmi.txt |  131 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 131 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/acpi/wmi.txt
> 
> 
> diff --git a/Documentation/acpi/wmi.txt b/Documentation/acpi/wmi.txt
> new file mode 100644
> index 0000000..4d243aa
> --- /dev/null
> +++ b/Documentation/acpi/wmi.txt
> @@ -0,0 +1,131 @@
> +ACPI-WMI mapping driver
> +
> +Copyright (C) 2007-2008 Carlos Corbacho <carlos@strangeworlds.co.uk>
> +
> +Updated: 5th February 2008
> +
> +1) About this guide
> +
> +This guide is a basic introduction on how to interact with the ACPI-WMI mapper
> +driver in the kernel - it presumes you already have a basic knowledge of
> +ACPI-WMI, ACPI and the hardware you are writing the driver for.
> +
> +2) What is ACPI-WMI
> +

Please tell what WMI stands for.

> +At its simplest, ACPI-WMI is a proprietary extension to the ACPI specification
> +from Microsoft to allow WMI (their implementation of WBEM) to access
> +instrumentation data and methods in ACPI from userspace, via the ACPI _HID
> +device PNP0C14.
> +
> +3) What is the ACPI-WMI mapper
> +
> +The Linux ACPI-WMI driver is the implementation of this mapper for Linux.
> +
> +NOTE: The mapper does not do anything itself with the ACPI-WMI devices - it
> +simply makes their functionality available to other drivers and userspace.
> +
> +4) Implementation
> +
> +A general note:
> +
> +ACPI-WMI has no knowledge of the size of the data blocks passed to/ from

                                                                   to/from

> +ACPI-WMI - this is not encoded in the DSDT, and is usually only available in
> +the form of a MOF file. If this is not available, you will need to analyze
> +the DSDT to get this information.
> +
> +You will therefore need to know in advance the size of any data structures
> +to handle them.
> +
> +Userspace:
> +
> +ACPI-WMI is exposed to userspace via sysfs and netlink. Data and methods are
> +exposed through sysfs, events are sent via netlink.
> +
> +Accessing ACPI-WMI directly through sysfs is generally not recommended -
> +ideally, this should be done by a userspace library, which could also deal
> +with the netlink events.
> +
> +The sysfs interface is in /sys/devices/virtual/wmi for WMI methods and data, as
> +follows:
> +
> +/sys/devices/virtual/wmi/
> +|
> +|-> <GUID>/
> + |-> type (method, data, event)
> +
> +Method & data blocks
> + |-> instance (instance to execute)
> + |-> instance_count (read only - maximum number of instances available)
> + |-> data (binary data file - write input data to file, read file
> +           to execute method and/ or retrieve data).
> +
> +To read/ write a data block, instance must be set first.

      read/write

> +
> +Method only
> + |-> method_id (write value of method id to execute)
> +
> +To execute a method, instance and method_id must be set first.
> +
> +Events - passed to userspace via netlink. However, the extra WMI data
> +associated with an event is exposed through sysfs.
> +
> + |-> notification (ACPI event value)
> + |-> data (binary data file - WMI data associated with the event)
> +
> +Kernel interface:
> +
> +For drivers that want to bypass userspace (either because WBEM is overkill,
> +or a userspace application is not really appropriate for want you want to do),

                                                        for what

> +and talk directly to ACPI-WMI, then the mapper also exports functions
> +to do this - these are essentially thin wrappers around ACPI, so if you are
> +familiar with writing an ACPI driver, then writing a WMI driver is not much more
> +of a stretch.
> +
> +The exported ACPI-WMI functions can be found in <linux/acpi.h>

                                                in <linux/acpi.h>.

> +
> +The most important differences between ACPI and WMI drivers are:
> +
> +A) WMI based drivers should be platform drivers, not ACPI drivers.

      WMI-based

> +
> +B) ACPI details such as handles and/ or path names are hidden; you use GUIDs as

                                   and/or

> +   the unique identifier to call methods instead (you don't need to care either
> +   about multiple PNP0C14 devices existing - the GUIDs are always unique, and
> +   these are what you will work with).
> +
> +C) In your probe() function, you should use wmi_has_guid() to look for the
> +   GUID(s) you need for your driver.
> +
> +For the in kernel interface, the following functions are available:

           in-kernel

> +
> +wmi_evaluate_method():
> +
> +Evaluate a WMI method.
> +
> +wmi_query_block():
> +
> +Return the contents of a WMI data block.
> +
> +wmi_set_block()

   wmi_set_block():

> +
> +Set the contents of a WMI data block.
> +
> +wmi_install_notify_handler():
> +wmi_remove_notify_handler():
> +
> +Install and/ or remove a handler for a WMI event - one handler per GUID.

           and/or

> +
> +wmi_get_event_data():
> +
> +Return the data associated with a given WMI event.
> +
> +wmi_has_guid():
> +
> +Returns true if a given GUID is available on the system.
> +
> +wmi_get_device():
> +
> +Return a pointer to the virtual device associated with a GUID. If you need to

   Returns

> +set a parent device (e.g. for an input device), use this.
> +
> +
> +[1] http://www.microsoft.com/whdc/system/pnppwr/wmi/wmi-acpi.mspx
> -

Are there netlink-aware apps that already know how to use this
interface?  If so, where?

Thanks.
---
~Randy

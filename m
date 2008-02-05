From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/5] WMI patches for acpi-test (v2)
Date: Tue, 05 Feb 2008 02:16:58 +0000
Message-ID: <20080205021658.4422.83165.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:60850 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755281AbYBECR3 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 4 Feb 2008 21:17:29 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

Len,

These patches replace the previous five you have in acpi-test - due to the
changes to patch #2 (the sysfs support), and some other problems that turned
up in some extra testing with it, I'd prefer if you replace the original patch
series with this one.

Any further patches can then safely come as incremental ones on top of this
series.

Also, two other things:

1) Would you be able to send me a copy of the DSDT for your Lenovo T61? I'd be
interested to have a look at what Lenovo are doing with WMI.

2) Do you know of any IA64 systems using ACPI-WMI? At the moment, WMI will work
on x86 and hopefully IA64, but if it turns out that no vendor has or ever will
implement ACPI-WMI on IA64, then we could safely drop it there.

-Carlos

===

Patch #1: (WMI - driver and in kernel interface) - Minor clean up

* Delete 'default m' from Kconfig (as per your changes)
* Minor fix to MAINTAINERS (s/Supported/Maintained/ - oversight on my part)

====

Patch #2: (acer-wmi) - MAINTAINERS

* Add me to MAINTAINERS

====

Patch #3: (tc1100-wmi) - MAINTAINERS

* Add me to MAINTAINERS ('Odd Fixes' only, since I don't have the hardware)

RFC only, needs actual testing on the hardware, and probably very broken.
Waiting on Matthew Garrett to get some free time to test this.

I'd ideally like someone to test this on the hardware before I drop the 'RFC' or
am happy with this going upstream.

====

Patch #4: (WMI sysfs interface) - Various large fixups

* Merged with bus ID length patch (for future bisection purposes)

* Added new Kconfig option and ifdef's to make sysfs support optional (and try
  to make it clear that at the moment, it's a development & testing option only)

* Fixed various nasty bugs - crashes, memory leaks, etc (including one that
  prevented WMI unloading if sysfs support was enabled)

* Drop the RFC

====

Patch #5: (WMI documentation) - New

Some simple documentation of the in kernel and sysfs (userspace) WMI interface.

Len:

'data' is a binary file, since WMI provides no information on what is
returned by any given WMI method/ data block, so we don't try and do anything
with it - just return whatever the ACPI buffer contains. You also need to set
'instance' first.

To do anything useful with the sysfs interface, you'll probably need something
that can:

A) Set 'instance'
B) Read 'data' for the given GUID
C) Knows what is being returned
D) Can turn that into something useful to output back

In MS land, (C) is usually provided by a MOF file - since we tend not to have
these available, the only alternative is to look at the DSDT and work out what
size structure you need to hold the returned data.
---

Carlos Corbacho (5):
      ACPI: WMI: Add documentation
      ACPI: WMI: Add sysfs userspace interface
      [RFC] tc1100-wmi: Add driver for HP Compaq TC1100 Tablets
      acer-wmi: Add driver for newer Acer laptops
      ACPI: WMI: Add ACPI-WMI mapping driver


 Documentation/acpi/wmi.txt |  131 +++++
 MAINTAINERS                |   19 +
 drivers/acpi/Kconfig       |   20 +
 drivers/acpi/Makefile      |    1 
 drivers/acpi/wmi.c         | 1253 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/Kconfig       |   25 +
 drivers/misc/Makefile      |    2 
 drivers/misc/acer-wmi.c    | 1109 +++++++++++++++++++++++++++++++++++++++
 drivers/misc/tc1100-wmi.c  |  290 ++++++++++
 include/linux/acpi.h       |   21 +
 10 files changed, 2871 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/acpi/wmi.txt
 create mode 100644 drivers/acpi/wmi.c
 create mode 100644 drivers/misc/acer-wmi.c
 create mode 100644 drivers/misc/tc1100-wmi.c


From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/5] WMI
Date: Fri, 18 Jan 2008 23:58:18 +0000
Message-ID: <20080118235818.3123.95800.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:43950 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756738AbYARX6w (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 18 Jan 2008 18:58:52 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

ANYWR - Another New Year WMI release

Len,

Can you please review at least the first two patches in this series, as I
would still really like to try and get them into 2.6.25.

-Carlos

===

Patch #1: (WMI - driver and in kernel interface) - Fix ACPI debug issues

Fix the compile errors with ACPI debugging enabled.

Len: For you to review, and to go upstream.

====

Patch #2: (acer-wmi) - No change

Len: For you to review, and to go upstream.

====

Patch #3: (tc1100-wmi) - No Change

RFC only, needs actual testing on the hardware, and probably very broken.
Waiting on Matthew Garrett to get some free time to test this.

====

Patch #4: (WMI sysfs interface) - Added new in-kernel function

RFC only (see patch #5 for reason and discussion). Adds interface under
/sys/devices/virtual/wmi

Also adds a function to return the (virtual) device associated with a GUID for
use by other parts of the kernel that want to set a parent device.

====

Patch #5: (WMI sysfs workaround) - No change

Temporary hack, needed to get patch #4 working, due to a limitation on bus_id
length (Kay Sievers is apparently working on this, ref Greg KH[1]).

Apparently, the necessary fixes _might_ go into 2.6.25 as well, or worst case
scenario is 2.6.26[2]. So we can either:

1) Hold off on patch #4 until the necessary fixes go in (this might be 2.6.25
if we're lucky, or we end up putting off WMI sysfs support until 2.6.26)

or

2) Apply patch #4, and #5 on top as a temporary hack, and then revert #5 as
soon as the necessary changes go in. (For bisection purposes, #4 and #5 should
be merged if we go ahead with this).

I don't know what would be the best solution here.

[1] http://lkml.org/lkml/2007/12/4/30
[2] http://www.nabble.com/Re:-Fix-Firmware-class-name-collision-p14352966.html
---

Carlos Corbacho (5):
      [WIP] ACPI: WMI: Limit size of device string to 19 characters
      [RFC] ACPI: WMI: Add sysfs userspace interface
      [RFC] tc1100-wmi: Add driver for HP Compaq TC1100 Tablets
      acer-wmi: Add driver for newer Acer laptops
      ACPI: WMI: Add ACPI-WMI mapping driver


 MAINTAINERS               |    7 
 drivers/acpi/Kconfig      |   11 
 drivers/acpi/Makefile     |    1 
 drivers/acpi/wmi.c        | 1190 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/Kconfig      |   25 +
 drivers/misc/Makefile     |    2 
 drivers/misc/acer-wmi.c   | 1100 ++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/tc1100-wmi.c |  290 +++++++++++
 include/linux/acpi.h      |   21 +
 9 files changed, 2647 insertions(+), 0 deletions(-)
 create mode 100644 drivers/acpi/wmi.c
 create mode 100644 drivers/misc/acer-wmi.c
 create mode 100644 drivers/misc/tc1100-wmi.c



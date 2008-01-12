From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/5] WMI
Date: Sat, 12 Jan 2008 02:20:06 +0000
Message-ID: <20080112022006.4349.22328.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:42246 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750854AbYALCUg (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 Jan 2008 21:20:36 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

ANYWR - A New Year WMI release

Len,

Can you please review at least the first two patches in this series, as I
would really like to try and get them into 2.6.25.

-Carlos

===

Patch #1: (WMI - driver and in kernel interface) - No change

Len: For you to review, and to go upstream.

====

Patch #2: (acer-wmi)

Added more device autodetection. Also, fixed setting bluetooth and wireless
on older AMW0 V2 laptops, and improved the error handling code on driver
registration.

(I am currently working on rfkill support, but have been running into some
strange problems with rfkill-input, so I'll release that as a future patch
on top of this when it's done. Until then, though, this patch still works
as-is).

Len: For you to review, and to go upstream.

====

Patch #3: (tc1100-wmi) - No Change

RFC only, needs actual testing on the hardware, and probably very broken.
Waiting on Matthew Garrett to get some free time to test this.

====

Patch #4: (WMI sysfs interface) - No Change

RFC only (see patch #5 for reason). Adds interface under
/sys/devices/virtual/wmi

Matthew: Do you want me to fold patch #5 into this?

====

Patch #5: (WMI sysfs workaround) - No change

Temporary hack, needed to get patch #4 working, due to a limitation on bus_id
length (Kay Sievers is apparently working on this, ref Greg KH[1]).

[1] http://lkml.org/lkml/2007/12/4/30
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
 drivers/acpi/wmi.c        | 1171 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/Kconfig      |   25 +
 drivers/misc/Makefile     |    2 
 drivers/misc/acer-wmi.c   | 1100 ++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/tc1100-wmi.c |  290 +++++++++++
 include/linux/acpi.h      |   20 +
 9 files changed, 2627 insertions(+), 0 deletions(-)
 create mode 100644 drivers/acpi/wmi.c
 create mode 100644 drivers/misc/acer-wmi.c
 create mode 100644 drivers/misc/tc1100-wmi.c



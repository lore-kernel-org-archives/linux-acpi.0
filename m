From: Carlos Corbacho <carlos@strangeworlds.co.uk>
Subject: [PATCH 0/5] WMI patches for acpi-test
Date: Sat, 02 Feb 2008 12:17:18 +0000
Message-ID: <20080202121718.2286.89857.stgit@pacifica>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from bb-87-81-255-5.ukonline.co.uk ([87.81.255.5]:51309 "EHLO
	pacifica" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753597AbYBBMRv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 07:17:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>, Alexey Starikovskiy <aystarik@gmail.com>

Len,

Can you please review, and hopefully apply, at least the first two patches in
this series, as I would like to get them into acpi-test (then -mm and eventually
2.6.26-rc1).

It's a little late now to put these into 2.6.25-rc1, and I don't want to
miss another merge window - so the sooner these are looked at by you, the sooner
I can address any concerns and we can have these ready for the 2.6.26-rc1
window.

-Carlos

===

Patch #1: (WMI - driver and in kernel interface) - Minor clean up

Replace leftover occurences of 'x == NULL' with '!x'

Len: For you to review and to be applied to acpi-test.

====

Patch #2: (acer-wmi) - New DMI entry, mail LED detection fix, mismatch fix

* Don't fail if we can't detect a mail LED on AMW0 systems
* Add an EC quirk for the Acer Aspire 9110
* Fix section mismatch warnings

Len: For you to review and to be applied to acpi-test.

====

Patch #3: (tc1100-wmi) - No Change

RFC only, needs actual testing on the hardware, and probably very broken.
Waiting on Matthew Garrett to get some free time to test this.

====

Patch #4: (WMI sysfs interface) - No Change

RFC only (see patch #5 for reason and discussion). Adds interface under
/sys/devices/virtual/wmi

Also adds a function to return the (virtual) device associated with a GUID for
use by other parts of the kernel that want to set a parent device.

Len: To review (but not to apply yet, unless you want to apply patch #5 as well)

====

Patch #5: (WMI sysfs workaround) - No Change

Temporary hack, needed to get patch #4 working, due to a limitation on bus_id
length (Kay Sievers is apparently working on this, ref Greg KH[1]).

Len:

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
 drivers/misc/acer-wmi.c   | 1109 ++++++++++++++++++++++++++++++++++++++++++
 drivers/misc/tc1100-wmi.c |  290 +++++++++++
 include/linux/acpi.h      |   21 +
 9 files changed, 2656 insertions(+), 0 deletions(-)
 create mode 100644 drivers/acpi/wmi.c
 create mode 100644 drivers/misc/acer-wmi.c
 create mode 100644 drivers/misc/tc1100-wmi.c


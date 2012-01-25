From: Len Brown <lenb@kernel.org>
Subject: [GIT PULL] ACPI & Power Management patches for Linux 3.3-rc1
Date: Wed, 25 Jan 2012 01:04:20 -0500
Message-ID: <4F1F9B64.7050601@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-qy0-f174.google.com ([209.85.216.174]:64626 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752406Ab2AYGEW (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 25 Jan 2012 01:04:22 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>, linux-acpi <linux-acpi@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

Hi Linus,

Please pull these ACPI & Power Management patches.

This fixes a merge-window regression due to a conflict
between error injection and preparation to remove atomicio.c
Here we fix that regression and complete the removal
of atomicio.c.

This also re-orders some idle initialization code to
complete the merge window series that allows cpuidle
to cope with bringing processors on-line after boot.

thanks!
Len Brown, Intel Open Source Technology Center
---
The following changes since commit dcd6c92267155e70a94b3927bce681ce74b8=
0d1f:

  Linux 3.3-rc1 (2012-01-19 15:04:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux.git release

for you to fetch changes up to eb7004e623637a6c2b32317c000d4b617b5cb053=
:

  Merge branches 'atomicio-apei', 'hotplug', 'sony-nvs-nosave' and 'the=
rmal-netlink' into release (2012-01-23 19:47:06 -0500)

----------------------------------------------------------------

Dan Carpenter (1):
      ACPI, APEI, EINJ, cleanup 0 vs NULL confusion

Jean Delvare (1):
      thermal: Rename generate_netlink_event

Lan Tianyu (1):
      ACPI / PM: Add Sony Vaio VPCCW29FX to nonvs blacklist.

Len Brown (1):
      Merge branches 'atomicio-apei', 'hotplug', 'sony-nvs-nosave' and =
'thermal-netlink' into release

Myron Stowe (3):
      ACPI, APEI: Add 64-bit read/write support for APEI on i386
      ACPI, APEI: Add RAM mapping support to ACPI
      ACPI: Remove ./drivers/acpi/atomicio.[ch]

Niklas S=F6derlund (1):
      ACPI, APEI, EINJ Allow empty Trigger Error Action Table

Thomas Renninger (2):
      ACPI processor hotplug: Split up acpi_processor_add
      ACPI processor hotplug: Delay acpi_processor_start() call for hot=
plugged cores

Tony Luck (1):
      Use acpi_os_map_memory() instead of ioremap() in einj driver

 Documentation/thermal/sysfs-api.txt |    2 +-
 drivers/acpi/Makefile               |    1 -
 drivers/acpi/apei/apei-base.c       |   35 +---
 drivers/acpi/apei/einj.c            |   95 ++++----
 drivers/acpi/atomicio.c             |  422 ---------------------------=
--------
 drivers/acpi/osl.c                  |  152 +++++++++++++-
 drivers/acpi/processor_driver.c     |  154 ++++++++++----
 drivers/acpi/sleep.c                |    8 +
 drivers/idle/intel_idle.c           |    2 +-
 drivers/thermal/thermal_sys.c       |    4 +-
 include/acpi/acpiosxf.h             |    4 +
 include/acpi/atomicio.h             |   10 -
 include/acpi/processor.h            |    1 +
 include/linux/thermal.h             |    4 +-
 14 files changed, 334 insertions(+), 560 deletions(-)
 delete mode 100644 drivers/acpi/atomicio.c
 delete mode 100644 include/acpi/atomicio.h
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

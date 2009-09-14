From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: [PATCH 0/4] ACPI: Remove unnecessary code in acpi drivers
Date: Mon, 14 Sep 2009 17:09:25 +0100
Message-ID: <1252944569-29799-1-git-send-email-alan-jenkins@tuffmail.co.uk>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mxout-08.mxes.net ([216.86.168.183]:63735 "EHLO
	mxout-08.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751697AbZINQJd (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Sep 2009 12:09:33 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: bjorn.helgaas@hp.com, linux-acpi@vger.kernel.org

Bjorn critiqued some code in a new acpi driver as unnecesary. However,
the same code patterns are present in most acpi drivers.  Let's remove
them all.

The first patch ammends acpi/scan.c so that the following NULL
assignment pattern can be removed with complete confidence:

    acpi_driver_remove(acpi_device *device, int removal_type) 
    {
	...
	device->driverdata = NULL;
    }

Some failure paths in scan.c were omitting to clear device->driverdata,
and more seriously device->driver, so I fixed that before removing the
NULL assignments from drivers.

In total this removes ~150 lines.

 drivers/acpi/ac.c                       |   23 +++------------
 drivers/acpi/acpi_memhotplug.c          |   13 ++-------
 drivers/acpi/battery.c                  |   18 +++---------
 drivers/acpi/container.c                |   12 ++------
 drivers/acpi/ec.c                       |    9 +-----
 drivers/acpi/fan.c                      |   14 +---------
 drivers/acpi/pci_link.c                 |   11 ++++---
 drivers/acpi/power.c                    |   19 ++-----------
 drivers/acpi/processor_core.c           |    7 +----
 drivers/acpi/sbs.c                      |   11 +------
 drivers/acpi/sbshc.c                    |   17 +----------
 drivers/acpi/scan.c                     |   45 ++++++++++++++++++------------
 drivers/acpi/thermal.c                  |   21 +++-----------
 drivers/acpi/video.c                    |   17 ++---------
 drivers/hwmon/asus_atk0110.c            |    2 -
 drivers/hwmon/hp_accel.c                |    9 ------
 drivers/input/misc/atlas_btns.c         |    5 +---
 drivers/platform/x86/asus-laptop.c      |    9 ------
 drivers/platform/x86/asus_acpi.c        |    9 ------
 drivers/platform/x86/eeepc-laptop.c     |    7 -----
 drivers/platform/x86/fujitsu-laptop.c   |    6 ----
 drivers/platform/x86/intel_menlow.c     |    6 ----
 drivers/platform/x86/panasonic-laptop.c |   16 +---------
 drivers/platform/x86/wmi.c              |    3 --
24 files changed, 70 insertions(+), 239 deletions(-)

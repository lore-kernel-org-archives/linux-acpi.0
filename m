From: Corentin Chary <corentin.chary@gmail.com>
Subject: [PATCH 0/7] platform-drivers-x86: backlight, samsung and asus
Date: Wed, 13 Jun 2012 09:32:00 +0200
Message-ID: <1339572727-24744-1-git-send-email-corentin.chary@gmail.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:54126 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751924Ab2FMHcN (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 13 Jun 2012 03:32:13 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Corentin Chary <corentin.chary@gmail.com>

Hi,

This series should fix a big issue when the vendor backlight is known
to work better than the ACPI backlight (and sometime it's the only
backlight that really works).

It adds a way for vendor drivers to promote themselves, still respecting
acpi_backlight=vendor|video parameters (in case the vendor driver is
wrong, and the ACPI driver works better). This way, acpi_video_register()
still works properly.

The series then add calls to this new functions in appropriates drivers,
and also blacklist a laptop where the ACPI video module is known to
break the backlight untill next reboot.

Thanks,

AceLan Kao (2):
  asus-wmi: control backlight power through WMI, not ACPI
  asus-wmi: enable resume on lid open

Corentin Chary (5):
  acpi: add a way to promote/demote vendor backlight drivers
  drivers-platform-x86: use acpi_video_dmi_promote_vendor()
  samsung-laptop: X360 ACPI backlight device is broken
  acpi/video_detect: blacklist samsung x360
  samsung-laptop: support R40/R41

 Documentation/ABI/testing/sysfs-platform-asus-wmi |    7 +++
 drivers/acpi/video_detect.c                       |   60 ++++++++++++++++++++-
 drivers/platform/x86/acer-wmi.c                   |   16 +++---
 drivers/platform/x86/apple-gmux.c                 |    6 +++
 drivers/platform/x86/asus-wmi.c                   |   16 ++++++
 drivers/platform/x86/asus-wmi.h                   |    1 +
 drivers/platform/x86/eeepc-wmi.c                  |   25 ++++++++-
 drivers/platform/x86/samsung-laptop.c             |   41 ++++++++++----
 include/linux/acpi.h                              |   10 ++++
 9 files changed, 162 insertions(+), 20 deletions(-)

-- 
1.7.9.5


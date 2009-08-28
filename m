From: Corentin Chary <corentincj@iksaif.net>
Subject: [PATCH 00/24] acpi4asus updates
Date: Fri, 28 Aug 2009 14:56:31 +0200
Message-ID: <1251464215-6540-1-git-send-email-corentincj@iksaif.net>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp22.services.sfr.fr ([93.17.128.10]:54868 "EHLO
	smtp22.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbZH1NAk (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 28 Aug 2009 09:00:40 -0400
Received: from smtp22.services.sfr.fr (msfrf2206 [10.18.26.20])
	by msfrf2205.sfr.fr (SMTP Server) with ESMTP id A537170064F8
	for <linux-acpi@vger.kernel.org>; Fri, 28 Aug 2009 15:00:41 +0200 (CEST)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org, alan-jenkins@tuffmail.co.uk, Corentin Chary <corentincj@iksaif.net>

Hi Len,
Here is acpi4asus series for 2.6.32:
 * eeepc-laptop bugfixes and updates.
 * asus-laptop updates (keyboard backlight and new hotkeys).
 * documentation on asus-laptop, eeepc-laptop, video/lcd,
   video/backlight and leds.

Alan Jenkins (9):
  eeepc-laptop: don't touch the pci slot if it was claimed by a
    different driver
  eeepc-laptop: use a mutex to serialize pci hotplug (resume vs.
    notify)
  eeepc-laptop: fix pci hotplug race on load and unload
  eeepc-laptop: fix ordering of init and exit functions
  eeepc-laptop: make input device a child of the platform device
  eeepc-laptop: remove redundant rfkill_set_sw_state in resume handler
  eeepc-laptop: check the 3G rfkill state on resume
  eeepc-laptop: correct the description of the hibernation abort bug
  eeepc-laptop: switch to dev_pm_ops

Corentin Chary (15):
  eeepc-laptop: add rfkill support for the Wimax in ASUS Eee PC 1000HG
  eeepc-laptop: document sysfs interface
  video/backlight: document sysfs interface
  video/lcd: document sysfs interface
  led: document sysfs interface
  asus-laptop: Show HRWS in infos and fix output format
  asus-laptop: Add *_led_get() functions
  asus-laptop: Map X50R hotkeys
  asus-laptop: set maximum led brightness
  asus-laptop: Add support for Keyboard backlight
  asus-laptop: handle keyboard backlight keys
  asus-laptop: Add suport for another "Media" key
  asus-laptop: Add "calculator" hotkey
  asus-laptop: document the module
  asus-laptop: document sysfs interface

 Documentation/ABI/stable/sysfs-class-backlight     |   36 +++
 Documentation/ABI/testing/sysfs-class-lcd          |   23 ++
 Documentation/ABI/testing/sysfs-class-led          |   28 ++
 .../ABI/testing/sysfs-platform-asus-laptop         |   52 ++++
 .../ABI/testing/sysfs-platform-eeepc-laptop        |   50 +++
 Documentation/laptops/asus-laptop.txt              |  258 ++++++++++++++++
 Documentation/leds-class.txt                       |    9 +-
 drivers/platform/x86/asus-laptop.c                 |  121 +++++++-
 drivers/platform/x86/eeepc-laptop.c                |  324 ++++++++++++--------
 9 files changed, 754 insertions(+), 147 deletions(-)
 create mode 100644 Documentation/ABI/stable/sysfs-class-backlight
 create mode 100644 Documentation/ABI/testing/sysfs-class-lcd
 create mode 100644 Documentation/ABI/testing/sysfs-class-led
 create mode 100644 Documentation/ABI/testing/sysfs-platform-asus-laptop
 create mode 100644 Documentation/ABI/testing/sysfs-platform-eeepc-laptop
 create mode 100644 Documentation/laptops/asus-laptop.txt



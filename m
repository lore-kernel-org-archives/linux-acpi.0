From: Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 00/14] Big WMI driver rework
Date: Mon, 30 Nov 2015 17:05:50 -0800
Message-ID: <cover.1448931782.git.luto@kernel.org>
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-acpi@vger.kernel.org, platform-driver-x86@vger.kernel.org, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Andy Lutomirski <luto@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Here's v1.  I'm sure it still needs work.  Thoughts?

Andy Lutomirski (14):
  wmi: Drop "Mapper (un)loaded" messages
  wmi: Pass the acpi_device through to parse_wdg
  wmi: Clean up acpi_wmi_add
  wmi: Track wmi devices per ACPI device
  wmi: Turn WMI into a bus driver
  wmi: Fix error handling when creating devices
  wmi: Split devices into types and add basic sysfs attributes
  wmi: Probe data objects for read and write capabilities
  wmi: Instantiate all devices before adding them
  wmi: Add a driver .notify function
  wmi: Add a new interface to read block data
  wmi: Switch from acpi_driver.notify to acpi_install_notify_handler
  wmi: Bind the platform device, not the ACPI node
  dell-wmi: Convert to the WMI bus infrastructure

 drivers/platform/x86/dell-wmi.c | 132 ++++----
 drivers/platform/x86/wmi.c      | 649 ++++++++++++++++++++++++++++++++--------
 include/linux/wmi.h             |  58 ++++
 3 files changed, 644 insertions(+), 195 deletions(-)
 create mode 100644 include/linux/wmi.h

-- 
2.5.0

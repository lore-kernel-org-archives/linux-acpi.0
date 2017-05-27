From: Darren Hart <dvhart@infradead.org>
Subject: [PATCH 00/16] Convert WMI to a proper bus
Date: Fri, 26 May 2017 22:31:14 -0700
Message-ID: <cover.1495862272.git.dvhart@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: platform-driver-x86@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, "Darren Hart (VMware)" <dvhart@infradead.org>, Andy Lutomirski <luto@kernel.org>, Mario Limonciello <mario_limonciello@dell.com>, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

From: "Darren Hart (VMware)" <dvhart@infradead.org>

This series is based on the original work of
Andy Lutomirski <luto@amacapital.net> [1]. I have made minor edits, and in
one instance, squashed two patches in which the latter undid the former.

This series converts WMI [2] into a proper bus, adds some useful information via
sysfs, and exposes the embedded MOF [3] binary. It converts dell-wmi to use the
new WMI bus architecture.

This is the first part of an ongoing effort to enhance the WMI infrastructure
within the kernel, and eventually expose WMI to userspace for the consumption of
management utilities as it was intended.

1. https://git.kernel.org/pub/scm/linux/kernel/git/luto/linux.git/log/?h=platform/wmi
2. https://msdn.microsoft.com/en-us/library/windows/hardware/dn614028(v=vs.85).aspx
3. https://msdn.microsoft.com/en-us/library/aa823192(v=vs.85).aspx

Andy Lutomirski (15):
  platform/x86: wmi: Drop "Mapper (un)loaded" messages
  platform/x86: wmi: Pass the acpi_device through to parse_wdg
  platform/x86: wmi: Clean up acpi_wmi_add
  platform/x86: wmi: Track wmi devices per ACPI device
  platform/x86: wmi: Turn WMI into a bus driver
  platform/x86: wmi: Fix error handling when creating devices
  platform/x86: wmi: Split devices into types and add basic sysfs attributes
  platform/x86: wmi: Probe data objects for read and write capabilities
  platform/x86: wmi: Instantiate all devices before adding them
  platform/x86: wmi: Incorporate acpi_install_notify_handler
  platform/x86: wmi: Add a new interface to read block data
  platform/x86: wmi: Bind the platform device, not the ACPI node
  platform/x86: wmi: Add an interface for subdrivers to access sibling devices
  platform/x86: wmi-mof: New driver to expose embedded WMI MOF metadata
  platform/x86: dell-wmi: Convert to the WMI bus infrastructure

Darren Hart (VMware) (1):
  platform/x86: wmi: Require query for data blocks, rename writable to setable

 drivers/platform/x86/Kconfig    |  12 +
 drivers/platform/x86/Makefile   |   1 +
 drivers/platform/x86/dell-wmi.c | 136 ++++----
 drivers/platform/x86/wmi-mof.c  | 125 ++++++++
 drivers/platform/x86/wmi.c      | 677 ++++++++++++++++++++++++++++++++--------
 include/linux/wmi.h             |  59 ++++
 6 files changed, 815 insertions(+), 195 deletions(-)
 create mode 100644 drivers/platform/x86/wmi-mof.c
 create mode 100644 include/linux/wmi.h

-- 
2.9.4

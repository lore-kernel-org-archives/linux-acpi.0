From: Tang Chen <tangchen@cn.fujitsu.com>
Subject: [PATCH 0/3 v2] Find pci root bridges by comparing HID from acpi_device_info, not acpi_device.
Date: Fri, 12 Oct 2012 20:34:18 +0800
Message-ID: <1350045261-7344-1-git-send-email-tangchen@cn.fujitsu.com>
Return-path: <linux-pci-owner@vger.kernel.org>
Sender: linux-pci-owner@vger.kernel.org
To: bhelgaas@google.com, lenb@kernel.org, yinghai@kernel.org, jiang.liu@huawei.com, izumi.taku@jp.fujitsu.com, isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

Hi Yinghai,

I found a little problem in your following patches. 
[PATCH 00/40] PCI, ACPI, x86: pci root bus hotplug support.

In acpi_is_root_bridge(), it gets device's HID from acpi_device struct.
If the device is not added when the system boots, there will be no
acpi_device for it. And as a result, acpi_is_root_bridge() will fail.
But it doesn't mean that the device is not a root bridge.

In this case, the not-added root bridges have no handle_hotplug_event_root()
callback registerred. And when we hot add it later, it will do nothing.

This patch set changes the acpi_is_root_bridge()'s behavior. When we fail
to get HID from acpi_device, we will get HID from acpi_device_info by
acpi_get_object_info(), which gets the HID from ACPI namespace directly.

So no matter the device is present or not, we will always find out if it
is a pci root bridge, and register a handle_hotplug_event_root() callback
for it.

These patches are based on Lu Yinghai's for-pci-root-bus-hotplug branch.

Tang Chen (3):
  Introduce a new acpi to determine HID match.
  Do not use acpi_device to find pci root bridge in _init code.
  Check exit status of acpi_install_notify_handler() in
    find_root_bridges().

 drivers/acpi/pci_root.c    |   19 +++++++++++--------
 drivers/acpi/pci_root_hp.c |   12 +++++++++---
 drivers/acpi/scan.c        |   24 ++++++++++++++++++++++++
 include/acpi/acpi_bus.h    |    2 ++
 4 files changed, 46 insertions(+), 11 deletions(-)

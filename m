From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 00/17] ACPI: cleanups for hotplug
Date: Mon, 21 Sep 2009 13:28:44 -0600
Message-ID: <20090921192656.21322.23072.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:35600 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753205AbZIUT2l (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:28:41 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

I'm working to make the Linux/ACPI code handle hotplug notification
events.  This should ultimately allow us to remove the existing
hotplug code scattered through the ACPI device drivers.

This is a long series of cleanups that should cause no functional
change, but will make it easier to call acpi_bus_scan() from the
notification path.

Comments and testing reports welcome.  Boot logs with
CONFIG_ACPI_DEBUG=y and "acpi.debug_layer=0x00010000" will be
helpful in debugging any issues.

Original posting: http://marc.info/?l=linux-acpi&m=124907619701194&w=2

Changes from v2 to v3:
    - refreshed to apply on current acpi-test (193a6dec1c0246a).
    - removed deferred execution patches (already in acpi-test)
    - added fix for acpiphp_ibm.c bug introduced by ACPICA
      acpi_get_object_info() changes (unrelated to this series, only
      here for convenience)

Changes from initial post to v2:
    - refreshed to apply on current acpi-test (0beab01e5b2c448).
    - fixed memory leak in acpi_add_single_object() debug code
    - added ACPI_IS_ROOT_DEVICE() macro (Len)

---

Bjorn Helgaas (17):
      ACPICA: fixup after acpi_get_object_info() change
      ACPI: add debug for device addition
      ACPI: remove unused acpi_bus_scan_fixed() argument
      ACPI: remove redundant "handle" and "parent" arguments
      ACPI: save device_type in acpi_device
      ACPI: use device_type rather than comparing HID
      ACPI: remove acpi_device_set_context() "type" argument
      ACPI: remove redundant "type" arguments
      ACPI: remove unnecessary argument checking
      ACPI: add acpi_bus_get_parent() and remove "parent" arguments
      ACPI: convert acpi_bus_scan() to operate on an acpi_handle
      ACPI: enumerate namespace before adding functional fixed hardware devices
      ACPI: identify device tree root by null parent pointer, not ACPI_BUS_TYPE
      ACPI: use acpi_walk_namespace() to enumerate devices
      ACPI: add acpi_bus_get_status_handle()
      ACPI: factor out device type and status checking
      ACPI: handle re-enumeration, when acpi_devices might already exist


 drivers/acpi/bus.c                |   49 ++--
 drivers/acpi/scan.c               |  427 +++++++++++++++++--------------------
 drivers/pci/hotplug/acpiphp_ibm.c |    1 
 include/acpi/acpi_bus.h           |    6 -
 4 files changed, 217 insertions(+), 266 deletions(-)

-- 
Bjorn

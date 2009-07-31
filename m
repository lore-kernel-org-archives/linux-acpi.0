From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 00/19] ACPI: cleanups for hotplug
Date: Fri, 31 Jul 2009 15:36:33 -0600
Message-ID: <20090731213501.29930.39957.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0029.austin.hp.com ([15.216.28.36]:18726 "EHLO
	g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752832AbZGaVge (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 31 Jul 2009 17:36:34 -0400
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

---

Bjorn Helgaas (19):
      ACPI: simplify deferred execution path
      ACPI: remove null pointer checks in deferred execution path
      ACPI: don't pass handle for fixed hardware notifications
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

 drivers/acpi/bus.c      |   49 ++---
 drivers/acpi/osl.c      |   32 +---
 drivers/acpi/scan.c     |  428 +++++++++++++++++++++--------------------------
 include/acpi/acpi_bus.h |    6 -
 4 files changed, 221 insertions(+), 294 deletions(-)

-- 
Bjorn

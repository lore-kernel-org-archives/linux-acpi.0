From: Toshi Kani <toshi.kani@hp.com>
Subject: [RFC PATCH 0/5] ACPI: Refactor system notify handling
Date: Thu, 30 Aug 2012 14:16:01 -0600
Message-ID: <1346357766-14030-1-git-send-email-toshi.kani@hp.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g1t0027.austin.hp.com ([15.216.28.34]:43381 "EHLO
	g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751221Ab2H3UVt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Aug 2012 16:21:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, bhelgaas@google.com, liuj97@gmail.com, isimatu.yasuaki@jp.fujitsu.com, Toshi Kani <toshi.kani@hp.com>

This patchset updates the ACPI system-level (ex. hotplug)
notify handling with a new .sys_notify interface.  It provides
the following changes:

- Allow ACPI drivers to register their system (hotplug) notify
  handlers to a new .sys_notify interface in their acpi_driver
  table.  This removes redundant ACPI namespace walks from ACPI
  drivers for faster booting.  The global notify handler
  acpi_bus_notify() is called for all system-level ACPI device
  notification, which then calls an appropriate driver's handler
  if any.  ACPI drivers no longer need to register or unregister
  driver's handlers to each device object in ACPI namespace.
 
- Support dynamic ACPI namespace with LoadTable & Unload opcode
  without any changes in ACPI drivers.  There is no need to 
  register / unregister handlers to ACPI device objects that may
  be loaded to / unloaded from ACPI namespace.

- Allow ACPI drivers to use a common hotplug handler when it is
  implemented.  It removes functional conflict between driver's
  notify handler and the global notify handler acpi_bus_notify().
  acpi_bus_notify() only calls an appropriate notify handler if
  any.

Note that the changes maintain the backward compatibility of ACPI
drivers.  Any ACPI driver registered its hotplug handler through
the existing interfaces, such as acpi_install_notify_handler() and
register_acpi_bus_notifier(), will continue to work as before.

---
Toshi Kani (5):
 ACPI: Add acpi_lookup_driver() function
 ACPI: Support system notify handler via .sys_notify
 ACPI: Update processor_driver to use .sys_notify
 ACPI: Update acpi_memhotplug to use .sys_notify
 ACPI: Update container to use .sys_notify

---
 drivers/acpi/acpi_memhotplug.c  |   93 +-------------------------------------
 drivers/acpi/bus.c              |   48 +++++++++++++++-----
 drivers/acpi/container.c        |   66 +--------------------------
 drivers/acpi/processor_driver.c |   82 +++-------------------------------
 drivers/acpi/scan.c             |   65 +++++++++++++++++++++++++++
 include/acpi/acpi_bus.h         |    4 ++
 6 files changed, 117 insertions(+), 241 deletions(-)

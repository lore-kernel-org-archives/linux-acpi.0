From: Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/2] PCI: Ignore hotplug events for dual GPU systems
Date: Thu, 11 Sep 2014 16:23:54 -0600
Message-ID: <20140911222022.16809.57079.stgit@bhelgaas-glaptop2.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f174.google.com ([209.85.192.174]:64540 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752241AbaIKWX6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 11 Sep 2014 18:23:58 -0400
Received: by mail-pd0-f174.google.com with SMTP id v10so14138545pde.5
        for <linux-acpi@vger.kernel.org>; Thu, 11 Sep 2014 15:23:57 -0700 (PDT)
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-pci@vger.kernel.org
Cc: SpacemanSpiff <a818958@trbvm.com>, Rajat Jain <rajatxjain@gmail.com>, Dave Airlie <airlied@linux.ie>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Pali =?utf-8?b?Um9ow6Fy?= <pali.rohar@gmail.com>, Alex Deucher <alexdeucher@gmail.com>, "Jose P." <lbdkmjdf@sharklasers.com>

These are intended to resolve problems on dual GPU systems where the radeon
driver becomes unusable because of problems suspending or resuming a GPU.
When the GPU is powered off, we may get hotplug remove events, and we 
would normally unbind the driver and destroy the pci_dev.  But in this
case, the radeon and nouveau drivers expect to remain bound to the device
because it isn't really removable, and they may power it back on later.

Links to the bug reports in the patch changelogs.

I would like to get these into v3.17 if they seem reasonable.

---

Bjorn Helgaas (2):
      PCI: Add pci_ignore_hotplug() to ignore hotplug events for a device
      ACPIPHP / radeon / nouveau: Remove acpi_bus_no_hotplug()


 drivers/acpi/bus.c                           |   10 ----------
 drivers/gpu/drm/nouveau/nouveau_acpi.c       |   16 ++--------------
 drivers/gpu/drm/nouveau/nouveau_drm.c        |    1 +
 drivers/gpu/drm/radeon/radeon_atpx_handler.c |   16 ++--------------
 drivers/gpu/drm/radeon/radeon_drv.c          |    1 +
 drivers/pci/hotplug/acpiphp_glue.c           |   16 ++++++----------
 drivers/pci/hotplug/pciehp_hpc.c             |   12 ++++++++++++
 include/acpi/acpi_bus.h                      |    4 +---
 include/linux/pci.h                          |    6 ++++++
 9 files changed, 31 insertions(+), 51 deletions(-)

From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH v3 0/8] ACPI: make every acpi_device have a HID
Date: Mon, 21 Sep 2009 13:34:59 -0600
Message-ID: <20090921193417.21656.32718.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g4t0015.houston.hp.com ([15.201.24.18]:47639 "EHLO
	g4t0015.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753152AbZIUTez (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 21 Sep 2009 15:34:55 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This series was prompted by an issue we saw recently in the mm tree:
http://lkml.org/lkml/2009/7/20/422

Synopsis:

    Linux/ACPI discovered a video device.  The device had no _HID or _CID
    methods, but based on acpi_is_video_device(), we added a sythetic CID
    ("LNXVIDEO"), so the device ended up with a CID but no HID.

    We bound the acpi_video_bus (drivers/acpi/video.c) driver to the device
    based on the CID.  This driver has a .notify() method, so we tried to
    install a notify handler on the device.  This uses strcmp() on the
    device HID to determine whether it's a fixed hardware device, and this
    oopsed because this device had no HID.

    This used to work because the HID was stored in an array that was
    initialized to zeroes, but a recent change replaced this with a pointer
    that is NULL until a HID is set.

This thread: http://marc.info/?l=linux-acpi&m=124959955813409&w=2
has patches that work around this by basically returning a pointer to an
empty string rather than a NULL pointer in this case.

However, the HID is a pretty central part of an acpi_device, and I think it
complicates the driver model too much to deal with HIDs that might be empty
strings.  I think it's better for Linux/ACPI to just make sure that *every*
acpi_device has at least one ID (either a HID, a CID, or a synthetic ID).

The main place this default "device" ID appears is with ACPI devices that
just have _ADR methods, e.g., PCI slots.

Original posting: http://marc.info/?l=linux-acpi&m=125113191017124&w=2

Changes from v2 to v3:
    - Refreshed to apply on current acpi-test (193a6dec1c0246a).

Changes from initial post to v2:
    - Applies on acpi-test (on top of "ACPI: cleanups for hotplug",
      http://marc.info/?l=linux-acpi&m=125175792329288&w=2).
    - Removed memory leak fix (folded into v2 of series that introduced it).
    - Fixes the synthetic HID for \_SB_.  This has been broken for a long
      time, so we've been seeing "device:00" instead of "LNXSYBUS" in
      sysfs.
    - Makes sure every acpi_device has a default "device" HID if nothing
      else.  (We already used "device" in sysfs if we didn't have a HID or
      CID.)
    - Adds a single list containing the HID and any CIDs.  No users make a
      distinction between them, so maintaining them separately just made
      things complicated.
    - Removes the _UID stuff, which nobody uses.

---

Bjorn Helgaas (8):
      ACPI: fix synthetic HID for \_SB_
      ACPI: use acpi_device_hid() when possible
      ACPI: make sure every acpi_device has an ID
      ACPI: maintain a single list of _HID and _CID IDs
      ACPI: remove acpi_device.flags.compatible_ids
      ACPI: remove acpi_device.flags.hardware_id
      ACPI: remove acpi_device_uid() and related stuff
      ACPI: simplify building device HID/CID list


 drivers/acpi/scan.c        |  283 +++++++++++++-------------------------------
 drivers/pnp/pnpacpi/core.c |   21 +--
 include/acpi/acpi_bus.h    |   16 +-
 3 files changed, 100 insertions(+), 220 deletions(-)

-- 
Bjorn

From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: [PATCH 05/10] ACPI: make sure every acpi_device has an ID
Date: Mon, 24 Aug 2009 10:38:55 -0600
Message-ID: <20090824163855.28131.76369.stgit@bob.kio>
References: <20090824163659.28131.96400.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:6925 "EHLO
	g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbZHXQiu (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 24 Aug 2009 12:38:50 -0400
In-Reply-To: <20090824163659.28131.96400.stgit@bob.kio>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org, Hugh Dickins <hugh.dickins@tiscali.co.uk>, Valdis Kletnieks <Valdis.Kletnieks@vt.edu>, Lin Ming <ming.m.lin@intel.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

This makes sure every acpi_device has at least one ID.  If we build an
acpi_device for a namespace node with no _HID or _CID, we sometimes
synthesize an ID like "LNXCPU" or "LNXVIDEO".  If we don't even have
that, give it a default "device" ID.

Note that this means things like:
    /sys/devices/LNXSYSTM:00/LNXSYBUS:00/HWP0001:00/HWP0002:04/device:00
(a PCI slot SxFy device) will have "hid" and "modprobe" entries, where
they didn't before.  These aren't very useful (a HID of "device" doesn't
tell you what *kind* of device it is, so it doesn't help find a driver),
but I don't think they're harmful.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
---
 drivers/acpi/scan.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 8a7616f..88f39e1 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1094,6 +1094,16 @@ static void acpi_device_set_id(struct acpi_device *device)
 		break;
 	}
 
+	/*
+	 * We build acpi_devices for some objects that don't have _HID or _CID,
+	 * e.g., PCI bridges and slots.  Drivers can't bind to these objects,
+	 * but we do use them indirectly by traversing the acpi_device tree.
+	 * This generic ID isn't useful for driver binding, but it provides
+	 * the useful property that "every acpi_device has an ID."
+	 */
+	if (!hid && !cid_list && !cid_add)
+		hid = "device";
+
 	if (hid) {
 		strcpy(device->pnp.hardware_id, hid);
 		device->flags.hardware_id = 1;


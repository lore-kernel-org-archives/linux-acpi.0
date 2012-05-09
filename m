From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V3 0/8]  usb/acpi: Add binding usb device with acpi
Date: Wed,  9 May 2012 23:00:27 +0800
Message-ID: <1336575635-13120-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:1053 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758467Ab2EIPI6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 May 2012 11:08:58 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com

This patchset's purppose is to bind usb device with associated
acpi node. The ACPI method "_PLD" and "_UPC" can be used to
identify usb port's connect type(hot-plug, hard-wired and
not-used). The patchset also can work on the port without device
connected.

This patchset derives from following patches.
>From Matthew Garrett
[PATCH V2 2/4] ACPI: Add _PLD support
[PATCH V2 3/4] usb: Bind devices to ACPI devices when possible
[PATCH v2 4/4] usb: Set device removable state based on ACPI USB data

>From Tianyu Lan
[PATCH V3 1/4] usb: add struct usb_hub_port to store port related members
[PATCH V3 2/4] usb: move struct usb_device->children to struct usb_hub_port->child
[PATCH V3 3/4] usb/acpi: add the support of usb hub ports' acpi binding without attached devices.
[PATCH V3 4/4] usb/acpi: add usb check for the connect type of usb port

Previously those patches was blocked by [PATCH V2 1/4] ACPI: Fix up _PLD methods.
Current the final version of this patch has been integrated into ACPICA and released as:
6a99b1c94d053b3420eaa4a4bc8b2883dd90a2f9
ACPICA: Object repair code: Support to add Package wrappers

[PATCH V3 1/8] ACPI: Add stubs for (un)register_acpi_bus_type
[PATCH V3 2/8] ACPI: Add _PLD support
[PATCH V3 3/8] usb: Bind devices to ACPI devices when possible
[PATCH V3 4/8] usb: Set device removable state based on ACPI USB
[PATCH V3 5/8] usb: add struct usb_hub_port to store port related
[PATCH V3 6/8] usb: move struct usb_device->children to struct
[PATCH V3 7/8] usb/acpi: add the support of usb hub ports' acpi
[PATCH V3 8/8] usb/acpi: add usb check for the connect type of usb

git diff --stat
 drivers/acpi/glue.c                  |    2 +
 drivers/acpi/utils.c                 |   30 +++++++
 drivers/staging/usbip/usbip_common.c |    3 +-
 drivers/usb/core/Makefile            |    1 +
 drivers/usb/core/devices.c           |    3 +-
 drivers/usb/core/hub.c               |  135 +++++++++++++++++++++---------
 drivers/usb/core/usb-acpi.c          |  155 ++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c               |    6 ++
 drivers/usb/core/usb.h               |   19 ++++-
 drivers/usb/host/r8a66597-hcd.c      |    3 +-
 include/acpi/acpi_bus.h              |   36 ++++++++
 include/linux/usb.h                  |   11 ++-
 12 files changed, 358 insertions(+), 46 deletions(-)


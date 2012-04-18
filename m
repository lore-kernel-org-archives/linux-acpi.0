From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V2 0/7] usb/acpi: Add binding usb device with acpi
Date: Wed, 18 Apr 2012 10:36:34 +0800
Message-ID: <1334716601-12266-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:28324 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708Ab2DRClV (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 17 Apr 2012 22:41:21 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, tianyu.lan@intel.com

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

[PATCH V2 1/7] ACPI: Add _PLD support
[PATCH V2 2/7] usb: Bind devices to ACPI devices when possible
[PATCH V2 3/7] usb: Set device removable state based on ACPI USB data
[PATCH V2 4/7] usb: add struct usb_hub_port to store port related
[PATCH V2 5/7] usb: move struct usb_device->children to struct
[PATCH V2 6/7] usb/acpi: add the support of usb hub ports' acpi binding
[PATCH V2 7/7] usb/acpi: add usb check for the connect type of usb port

git diff --stat 
 drivers/acpi/utils.c                 |   29 +++++++
 drivers/staging/usbip/usbip_common.c |    3 +-
 drivers/usb/core/Makefile            |    1 +
 drivers/usb/core/devices.c           |    3 +-
 drivers/usb/core/hub.c               |  133 +++++++++++++++++++++--------
 drivers/usb/core/usb-acpi.c          |  154 ++++++++++++++++++++++++++++++++++
 drivers/usb/core/usb.c               |    6 ++
 drivers/usb/core/usb.h               |   19 ++++-
 drivers/usb/host/r8a66597-hcd.c      |    3 +-
 include/acpi/acpi_bus.h              |   31 +++++++
 include/linux/usb.h                  |   10 ++-
 11 files changed, 349 insertions(+), 43 deletions(-)


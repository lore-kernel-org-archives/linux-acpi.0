From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V3 0/4] usb/acpi: To bind usb hub ports with acpi when not attached usb devices.
Date: Sat, 31 Mar 2012 11:16:58 +0800
Message-ID: <1333163822-5849-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:51221 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751497Ab2CaDUt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 30 Mar 2012 23:20:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg@redhat.com

Based on the Matthew Garrett's patch set.
[PATCH V2 1/4] ACPI: Fix up _PLD methods
[PATCH V2 2/4] ACPI: Add _PLD support
[PATCH V2 3/4] usb: Bind devices to ACPI devices when possible
[PATCH V2 4/4] usb: Set device removable state based on ACPI USB data

Add usb hub ports' platform_data to store acpi_handle. When a usb
hub is found, getting all ports' acpi handle and check port's connect
type through acpi method "_UPC" and "_PLD". When a usb device is found,
set it's removalbe depending on the port's connect type.

[PATCH V3 1/4] usb: add struct usb_hub_port to store port related
[PATCH V3 2/4] usb: move struct usb_device->children to struct
[PATCH V3 3/4] usb/acpi: add the support of usb hub ports' acpi
[PATCH V3 4/4] usb/acpi: add usb check for the connect type of usb

 drivers/staging/usbip/usbip_common.c |    3 +-
 drivers/usb/core/devices.c           |    3 +-
 drivers/usb/core/hub.c               |  137 ++++++++++++++++++++++++---------
 drivers/usb/core/usb-acpi.c          |  104 +++++++++++++++++--------
 drivers/usb/core/usb.h               |   10 +++
 drivers/usb/host/r8a66597-hcd.c      |    3 +-
 include/linux/usb.h                  |   11 ++-
 7 files changed, 194 insertions(+), 77 deletions(-)


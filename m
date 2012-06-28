From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH V4 0/8] usb: make usb port a real device and provide control of port's power to usr space
Date: Thu, 28 Jun 2012 15:31:34 +0800
Message-ID: <1340868702-1894-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:19305 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751985Ab2F1Hjj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Jun 2012 03:39:39 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

This patchset merged two following patchsets and make usb port a real device.
[PATCH V3 1/4] usb: add struct usb_hub_port to store
[PATCH V3 2/4] usb: move struct usb_device->children
[PATCH V3 3/4] usb/acpi: add the support of usb hub
[PATCH V3 4/4] usb/acpi: add usb check for the connection
[PATCH 1/3] xhci: Add clear PORT_POWER feature process in the
[PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the xhci
[PATCH 3/3] usb : Add sysfs files to control usb port's power

This patchset is to provide usb port power off mechanism. Add two
attributes "portX/control" and "portX/state" for each ports
under the usb hub interface sysfs directory.

"portX/control" has two options
"on" - port power must be on.
"off" - port power must be off.

"portX/state" reports usb port's power state
"on" - power on
"off" - power off
"error" - can't get power state

[PATCH V4 1/8] usb: convert port_owners type from void * to struct
[PATCH V4 2/8] usb: make usb port a real device
[PATCH V4 3/8] usb: move children to struct usb_port
[PATCH V4 4/8] usb/acpi : rebinding usb with acpi since usb port
[PATCH V4 5/8] usb/acpi: add check for the connect type of usb port
[PATCH V4 6/8] xhci: Add clear PORT_POWER feature process in the
[PATCH V4 7/8] USB/ACPI: Add usb port's acpi power control in the
[PATCH V4 8/8] usb : Add usb port's power control attributes


 git diff --stat HEAD~8
 Documentation/ABI/testing/sysfs-bus-usb |   25 ++++++++++++
 drivers/staging/usbip/usbip_common.c    |    3 +-
 drivers/usb/core/devices.c              |    7 ++--
 drivers/usb/core/hub.c                  |  349 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------
 drivers/usb/core/usb-acpi.c             |  202 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------------
 drivers/usb/core/usb.h                  |   25 ++++++++++--
 drivers/usb/host/r8a66597-hcd.c         |    9 +++--
 drivers/usb/host/xhci-hub.c             |   16 ++++++++
 include/linux/usb.h                     |   33 +++++++++++++++-
 9 files changed, 562 insertions(+), 107 deletions(-)



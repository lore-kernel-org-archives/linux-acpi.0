From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 0/3] USB/ACPI: Add usb port power off mechanism
Date: Mon, 11 Jun 2012 10:24:31 +0800
Message-ID: <1339381474-17413-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:25381 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751422Ab2FKCcC (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sun, 10 Jun 2012 22:32:02 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org, sarah.a.sharp@linux.intel.com
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu

"portX/control" has two options
"on" - port power must be on.
"off" - port power must be off.

"portX/state" reports usb port's power state
"on" - power on
"off" - power off
"error" - can't get power state

[PATCH 1/3] xhci: Add clear PORT_POWER feature process in the
[PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the xhci
[PATCH 3/3] usb : Add sysfs files to control usb port's power

This patchset is based on my previous patchset.
[PATCH V3 1/4] usb: add struct usb_hub_port to store
[PATCH V3 2/4] usb: move struct usb_device->children
[PATCH V3 3/4] usb/acpi: add the support of usb hub
[PATCH V3 4/4] usb/acpi: add usb check for the connection

git diff --stat
Documentation/ABI/testing/sysfs-bus-usb |   33 ++++++++++++++++++++++++++++++++
drivers/usb/core/hub.c                  |  168 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
drivers/usb/core/usb-acpi.c             |   28 ++++++++++++++++++++++++++++
drivers/usb/host/xhci-hub.c             |   14 ++++++++++++++
include/linux/usb.h                     |   10 ++++++++++
5 files changed, 252 insertions(+), 1 deletion(-)

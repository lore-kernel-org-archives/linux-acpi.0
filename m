From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [PATCH 0/5] usb/acpi: To bind usb hub ports with acpi when not attached usb devices.
Date: Wed, 28 Mar 2012 14:49:08 +0800
Message-ID: <1332917353-28123-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51719 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209Ab2C1GwZ (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 28 Mar 2012 02:52:25 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org, gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@intel.com, mjg@redhat.com

Based on the Matthew Garrett's patch set.
[PATCH V2 1/4] ACPI: Fix up _PLD methods
[PATCH V2 2/4] ACPI: Add _PLD support
[PATCH V2 3/4] usb: Bind devices to ACPI devices when possible
[PATCH V2 4/4] usb: Set device removable state based on ACPI USB data

Add usb hub ports' platform_data to store acpi_handle. When a usb
hub is found, getting all ports' acpi handle and check port's connect
type through acpi method "_UPC" and "_PLD". When a usb device is found,
set it's removalbe depending on the port's connect type.


git diff --stat
 drivers/usb/core/devices.c      |    4 +-
 drivers/usb/core/hub.c          |  141 ++++++++++++++++++++++++++++-----------
 drivers/usb/core/usb-acpi.c     |  102 +++++++++++++++++++---------
 drivers/usb/core/usb.h          |   10 +++
 drivers/usb/host/r8a66597-hcd.c |    4 +-
 include/linux/usb.h             |   10 +++-
 6 files changed, 196 insertions(+), 75 deletions(-)


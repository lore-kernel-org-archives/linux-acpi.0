From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [RFC PATCH 0/3] USB/ACPI: Add usb port power off mechanism
Date: Fri, 25 May 2012 13:47:59 +0800
Message-ID: <1337924882-17332-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:5433 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751281Ab2EYFyR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 25 May 2012 01:54:17 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: gregkh@linuxfoundation.org, lenb@kernel.org
Cc: linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com

portx_power_control has three options. "auto", "on" and "off"
"auto" - if port without device, power off the port.
"on" - port must be power on.
"off" - port must be power off

portx_power_state can be used to determine ports's power state.

[RFC PATCH 1/3] xhci: Add clear PORT_POWER feature process in the
[RFC PATCH 2/3] USB/ACPI: Add usb port's acpi power control in the
[RFC PATCH 3/3] usb : Add sysfs files to control usb port's power

 git diff --stat 
 drivers/usb/core/hub.c      |   38 ++++++++++
 drivers/usb/core/sysfs.c    |  167 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/usb/core/usb-acpi.c |   28 +++++++
 drivers/usb/core/usb.c      |    2 +
 drivers/usb/core/usb.h      |    6 ++
 drivers/usb/host/xhci-hub.c |   15 ++++
 include/linux/usb.h         |   22 ++++++
 7 files changed, 275 insertions(+), 3 deletions(-)




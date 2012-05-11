From: Lan Tianyu <tianyu.lan@intel.com>
Subject: [Resend PATCH V3 0/8]  usb/acpi: Add binding usb device with acpi
Date: Fri, 11 May 2012 16:08:24 +0800
Message-ID: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:35020 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755917Ab2EKIOt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 04:14:49 -0400
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

[Resend PATCH V3 1/8] ACPI: Add stubs for (un)register_acpi_bus_type
[Resend PATCH V3 2/8] ACPI: Add _PLD support
[Resend PATCH V3 3/8] usb: Bind devices to ACPI devices when
[Resend PATCH V3 4/8] usb: Set device removable state based on ACPI
[Resend PATCH V3 5/8] usb: add struct usb_hub_port to store port
[Resend PATCH V3 6/8] usb: move struct usb_device->children to
[Resend PATCH V3 7/8] usb/acpi: add the support of usb hub ports'
[Resend PATCH V3 8/8] usb/acpi: add usb check for the connect type

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

Based on the usb-next tree
Lastest commit
commit d530296f63c039a5683db665acc5ecdb3b593eb2
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Thu May 10 14:35:21 2012 -0700

    USB: serial: opticon: hook up suspend/resume callbacks
    
    With a previous patch, the usb_driver suspend/resume callbacks got
    overridden and were never called if a usb_serial driver defined them.
    This patch fixes the opticon driver to move the suspend/resume callbacks
    into the usb_serial_driver structure where they will be properly called.
    
    It then removes the unused usb_driver structure.
    
    Cc: Johan Hovold <jhovold@gmail.com>
    Cc: Rusty Russell <rusty@rustcorp.com.au>
    Cc: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
    Cc: Julia Lawall <julia@diku.dk>
    Cc: Alan Stern <stern@rowland.harvard.edu>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>


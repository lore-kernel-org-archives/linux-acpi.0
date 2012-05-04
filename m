From: Lan Tianyu <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [Resend PATCH V2 0/7] usb/acpi: Add binding usb device with acpi
Date: Fri,  4 May 2012 11:06:36 +0800
Message-ID: <1336100803-28353-1-git-send-email-tianyu.lan@intel.com>
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org, sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, mjg59-1xO5oi07KQx4cg9Nei1l7Q@public.gmane.org, mfm-Oo0r1OC9pj9iLUuM0BA3LQ@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

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

[Resend PATCH V2 1/7] ACPI: Add _PLD support (Acked by Len brown)
[Resend PATCH V2 2/7] usb: Bind devices to ACPI devices when possible
[Resend PATCH V2 3/7] usb: Set device removable state based on ACPI USB data
[Resend PATCH V2 4/7] usb: add struct usb_hub_port to store port related
[Resend PATCH V2 5/7] usb: move struct usb_device->children to struct
[Resend PATCH V2 6/7] usb/acpi: add the support of usb hub ports' acpi binding
[Resend PATCH V2 7/7] usb/acpi: add usb check for the connect type of usb port

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




--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

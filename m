From: "Lan, Tianyu" <tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [RFC PATCH 0/4 ] usb/acpi: To bind usb hub ports with acpi when not
 attached usb devices.
Date: Mon, 19 Mar 2012 14:35:19 +0000
Message-ID: <4CFBC02C07DA244CA19D6815A05BE6EE054716@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Language: en-US
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Len Brown <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org" <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: "linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Matthew Garrett <mjg-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org" <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, "Sharp, Sarah A" <sarah.a.sharp-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

Based on the Matthew Garrett's patch set.
[PATCH V2 1/4] ACPI: Fix up _PLD methods
[PATCH V2 2/4] ACPI: Add _PLD support
[PATCH V2 3/4] usb: Bind devices to ACPI devices when possible
[PATCH V2 4/4] usb: Set device removable state based on ACPI USB data

Add usb hub ports' platform_data to store acpi_handle. When a usb
hub is found, getting all ports' acpi handle and check port's connect
type through acpi method "_UPC" and "_PLD". When a usb device is found,
set it's removalbe depending on the port's connect type.

[RFC PATCH 1/4] usb: add struct usb_hub_port to store port related
[RFC PATCH 2/4] usb: add platform_data in the struct usb_hub_port
[RFC PATCH 3/4] usb/acpi: add the support of usb hub ports' acpi
[RFC PATCH 4/4] usb/acpi: add usb check for the connect type of usb

Best Regards 
Tianyu Lan 


--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

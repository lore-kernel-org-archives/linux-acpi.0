From: Sarah Sharp <sarah.a.sharp-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: PCI D3 wakeup failure on Lynx Point xHCI
Date: Thu, 21 Feb 2013 13:41:45 -0800
Message-ID: <20130221214145.GA25639@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: "Rafael J. Wysocki" <rjw-KKrjLPT3xs0@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hi Rafael,

I'm running into some issues with PCI D3 wakeup on the latest version of
the Lynx Point chipset.  I can give you the stepping and BIOS version
privately if you need it.

Basically, I think PMEs are being lost somewhere in the ACPI or PCI
stack.  I'm not sure how to further debug this issue, so I'm hoping you have
some pointers.

This is reproduced on the 3.7.1, 3.7.7, and 3.8.0 kernels.

First, I go into powertop and basically change all the 'Bad' entries to
'Good', which turns on runtime PM for all PCI devices, bridges, and
rootports.  I have no USB devices plugged into the xHCI host, and I wait
until the host is suspended, and the PCI device is in D3.

Then I run:

watch -n 1 'sudo lspci -vvv -s 00:14.0'

When I plug in a USB 2.0 device to a USB 2.0 port, the hotplug event is
lost.  I can see from the lspci output that the Status line under the PM
capabilities changes when I plug in the device.  The PME- changes to
PME+, which I assume means a PME happened.  But the USB core's PCI
resume functions are never called.

Wakeup from D3 works fine on the previous generation chipset (Panther
Point) on my Lenovo x230 laptop, so this makes me suspicious that it's a
hardware or BIOS issue.  I'll try updating my BIOS and seeing if that
helps.

Sarah Sharp
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

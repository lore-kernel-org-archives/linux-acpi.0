From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH] Allow others to use ACPI EC interface
Date: Thu, 21 Nov 2002 18:03:27 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A536@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Stelian Pop' <stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, acpi-devel-pyega4qmqnRoyOMFzWx49A@public.gmane.org, Patrick Mochel <mochel-3NddpPZAyC0@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Stelian Pop [mailto:stelian.pop-A5NNTvo2L0pl57MIdRCFDg@public.gmane.org] 
> Well, not directly related to the EC thing but rather to the 
> ACPI/sonypi
> integration, but maybe you noticed that the sonypi driver also
> re-implements some code which is originally defined in the ACPI bios
> (SRS, DIS methods on "SPIC" ACPI object). 
> 
> One day I should really call some ACPI exported function to do this,
> but last time I looked at this (3 months ago ?), the ACPI API (the one
> exported to external users) was still changing each day. 

Yeah I think the interface is settling down. You should be able to look at
the code in drivers/acpi or drivers/hotplug/acpiphp* for examples.

>From looking at other Sony ACPI BIOSes I've collected, it appears that SPIC
has a hardware ID (HID) in the ACPI namespace. It seems analogous to the
Toshiba Laptop Extras device in drivers/acpi.

Indeed, I think a sonypi driver that assumes ACPI will be much shorter and
look quite different from the current one. But since we have resolved the EC
contention issues, this need not be addressed immediately.

Regards -- Andy

PS IIRC there is the idea of a "platform enumerator" that will suitably
generalize the mobo enumeration function ACPI performs on x86 for other
platforms, but I don't think that has been implemented yet.

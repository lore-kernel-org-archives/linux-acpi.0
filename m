From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] Metolious hardware-sensors-using-ACPI specs
Date: Mon, 16 Dec 2002 10:21:22 -0800
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <EDC461A30AC4D511ADE10002A5072CAD04C7A5A4@orsmsx119.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
To: 'Pavel Machek' <pavel-AlSwsSmVLrQ@public.gmane.org>, ACPI mailing list <acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, kernel list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-acpi@vger.kernel.org

> From: Pavel Machek [mailto:pavel-AlSwsSmVLrQ@public.gmane.org] 
> Is it goign to be implemented in linux-acpi?
> 
> I took a look at specs at intel, and it has rather funny legaleese:

Wow, is that still on a website somewhere?

So as you may know from looking at the spec, Metolious was a spec that
defined a way for platforms to enumerate various motherboard sensors to the
OS, for manageability purposes.

It never took off, except for a couple companies that used the Windows
driver for other things because they didn't want to write a driver that
received ACPI device Notify()s.

The licensing may be weird, but given that there really is no point in
implementing it on Linux, does that really matter?

Regards -- Andy

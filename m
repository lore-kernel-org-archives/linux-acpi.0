From: "Grover, Andrew" <andrew.grover-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [ACPI] MS-6368L ACPI IRQ problem still in 2.4.21
Date: Mon, 23 Jun 2003 15:23:48 -0700
Sender: linux-kernel-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Message-ID: <F760B14C9561B941B89469F59BA3A847E96FBE@orsmsx401.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
content-class: urn:content-classes:message
To: Marek Michalkiewicz <marekm-HuSaFJn/uQtscumT1wHf3A@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

> From: Marek Michalkiewicz [mailto:marekm-HuSaFJn/uQtscumT1wHf3A@public.gmane.org] 
> long time ago I noticed a problem with the ACPI IRQ not working
> if it is _not_ shared with some other PCI IRQ.  The problem still
> exists in the 2.4.21 kernel, confirmed on two machines with the
> MSI MS-6368L motherboard (VIA PLE133 chipset).
> 
> I need ACPI for just one thing: to run "shutdown -h now" after the
> power button is pressed.  (The box is a server which usually has
> no keyboard connected.)
> 
> As I can see in /proc/interrupts, the BIOS usually allocates IRQ9
> for ACPI (not shared with anything else), and the IRQ9 counter is
> always zero.  Pressing the power button has no effect at all.
> 
> There is an easy workaround: in BIOS setup, set IRQ9 to "Legacy ISA"
> instead of "PCI/ISA PnP" so that ACPI gets some other IRQ, shared
> with some other PCI devices (in my case, IRQ11 is shared by: acpi,
> usb-uhci, usb-uhci, eth0).  Then the power button works fine.
> 
> Is this a known problem?  Should I complain to MSI (BIOS fix),
> or is this a Linux bug?  Any patches I should try?  This looks
> a bit unusual to me - one would expect problems if an IRQ _is_
> shared, and some broken hardware/driver doesn't like sharing...
> 
> If there is no known fix, perhaps the "Legacy ISA" workaround
> (which I discovered by accident) should be documented somewhere?

Is this an SMP machine?
What do the INT_SRC_OVR lines in the dmesg say?

Thanks -- Andy

From: Reuben Farrelly <reuben-lkml-MwA23MxOyI4@public.gmane.org>
Subject: Re: [linux-usb-devel] Re: 2.6.15-mm3 [USB lost interrupt bug]
Date: Mon, 16 Jan 2006 11:50:35 +1300
Message-ID: <43CAD1BB.60301@reub.net>
References: <Pine.LNX.4.44L0.0601121052190.5383-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <Pine.LNX.4.44L0.0601121052190.5383-100000-IYeN2dnnYyZXsRXLowluHWD2FQJk+8+b@public.gmane.org>
Sender: linux-acpi-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
Cc: Andrew Morton <akpm-3NddpPZAyC0@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jgarzik-e+AXbWqSrlAAvxtiuMwx3w@public.gmane.org, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org, Neil Brown <neilb-YbfuJp6tym7X/JP9YwkgDA@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

On 13/01/2006 4:53 a.m., Alan Stern wrote:
> On Thu, 12 Jan 2006, Reuben Farrelly wrote:
> 
>>>> Initializing USB Mass Storage driver...
>>>> irq 193: nobody cared (try booting with the "irqpoll" option)
> 
>>>> handlers:
>>>> [<c027017e>] (usb_hcd_irq+0x0/0x56)
>>>> Disabling IRQ #193
>>> USB lost its interrupt.  Could be USB, more likely ACPI.
>> I've seen this one happen nearly every boot since then including bootups that 
>> are otherwise OK (no oopses), so it's probably worth more looking into rather 
>> than being written off as a 'once off':
>>
>> uhci_hcd 0000:00:1d.3: Unlink after no-IRQ?  Controller is probably using the 
>> wrong IRQ.
> 
>> It's a new regression to -mm3.
> 
> Did the same IRQ get assigned to that controller in earlier kernel 
> versions?
> 
> Alan Stern

Hi Alan,

If it's any use, here's some simply and easy-to-get information which may even 
be what you are looking for:

[root@tornado dovecot]# uname -a
Linux tornado.reub.net 2.6.15-mm1 #1 SMP Sun Jan 8 03:42:25 NZDT 2006 i686 i686 
i386 GNU/Linux
[root@tornado ~]# cat /proc/interrupts
            CPU0       CPU1
   0:   21638510          0    IO-APIC-edge  timer
   4:        356          0    IO-APIC-edge  serial
   8:          1          0    IO-APIC-edge  rtc
   9:          0          0   IO-APIC-level  acpi
  14:          1          0    IO-APIC-edge  ide0
  50:          3          0   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2
169:        120          0   IO-APIC-level  uhci_hcd:usb5
177:    2837992          0   IO-APIC-level  sky2
185:      61450          0   IO-APIC-level  uhci_hcd:usb4, serial
193:    4722447          0   IO-APIC-level  libata, uhci_hcd:usb3
NMI:          0          0
LOC:   21638418   21638338
ERR:          0
MIS:          0
[root@tornado ~]#
[root@tornado ~]# lspci
00:00.0 Host bridge: Intel Corporation 925X/XE Memory Controller Hub (rev 04)
00:01.0 PCI bridge: Intel Corporation 925X/XE PCI Express Root Port (rev 04)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 2 (rev 03)
00:1c.2 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 3 (rev 03)
00:1c.3 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 4 (rev 03)
00:1d.0 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface 
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE 
Controller (rev 03)
00:1f.2 SATA controller: Intel Corporation 82801FR/FRW (ICH6R/ICH6RW) SATA 
Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus 
Controller (rev 03)
04:00.0 Ethernet controller: Marvell Technology Group Ltd. 88E8050 PCI-E ASF 
Gigabit Ethernet Controller (rev 17)
06:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA 2064W [Millennium] 
(rev 01)
06:02.0 Serial controller: Timedia Technology Co Ltd PCI2S550 (Dual 16550 UART) 
(rev 01)
[root@tornado ~]#

I guess this looks like it was assigned the same IRQ ?

Currently booted into -mm1 which is OK and hasn't shown any nasty symptoms yet.

Reuben




-
To unsubscribe from this list: send the line "unsubscribe linux-acpi" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

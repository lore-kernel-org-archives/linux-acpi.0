From: Nicole Faerber <nicole.faerber@dpin.de>
Subject: Re: kernel <=4.15rc9, acpi_irq - Disabling IRQ #9 after resume from
 sleep
Date: Sun, 28 Jan 2018 22:22:14 +0100
Message-ID: <6c14e2a6-2f06-fa1a-6bda-d88e4541920b@dpin.de>
References: <4b983a91-d5af-dd92-ea5a-4bed05e281c6@dpin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from dpin.de ([178.77.96.241]:34268 "EHLO dpin.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752886AbeA1VWR (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Sun, 28 Jan 2018 16:22:17 -0500
Received: from x4e30a55a.dyn.telefonica.de ([78.48.165.90] helo=[192.168.178.58])
        by lvps178-77-96-241.dedicated.hosteurope.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.84_2)
        (envelope-from <nicole.faerber@dpin.de>)
        id 1efuP1-0002Ft-Da
        for linux-acpi@vger.kernel.org; Sun, 28 Jan 2018 22:22:16 +0100
In-Reply-To: <4b983a91-d5af-dd92-ea5a-4bed05e281c6@dpin.de>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Am 23.01.2018 um 16:59 schrieb Nicole Færber:
> Hi,
> 
> pretty much since I am working on the device I have this issues and it
> still persist up until latest 4.15rc9 kernels. What happens is something
> like this, excerpt from dmesg:
> ...
> [52208.493346] input: Lenovo ThinkPad 10 Ultrabook Keyboard as
> /devices/pci0000:00/0000:00:14.0/usb1/1-1/1-1:1.1/0003:17EF:6062.0007/input/input16
> [52208.553407] hid-generic 0003:17EF:6062.0007: input,hiddev0,hidraw2:
> USB HID v1.10 Mouse [Lenovo ThinkPad 10 Ultrabook Keyboard] on
> usb-0000:00:14.0-1/input1
> [52208.553749] usbhid 1-1:1.2: couldn't find an input interrupt endpoint
> [52209.028700] irq 9: nobody cared (try booting with the "irqpoll" option)
> [52209.028710] CPU: 1 PID: 6011 Comm: thunar-volman Tainted: G     U A
>       4.15.0-rc9tpt10 #1
> [52209.028712] Hardware name: LENOVO 20C10024GE/20C10024GE, BIOS
> GWET44WW (1.44) 02/13/2017
> [52209.028713] Call Trace:
> [52209.028719]  <IRQ>
> [52209.028728]  dump_stack+0x46/0x68
> [52209.028733]  __report_bad_irq+0x29/0xc0
> [52209.028737]  note_interrupt+0x237/0x280
> [52209.028741]  handle_irq_event_percpu+0x52/0x80
> [52209.028743]  handle_irq_event+0x27/0x50
> [52209.028746]  handle_fasteoi_irq+0x73/0x120
> [52209.028750]  handle_irq+0x16/0x30
> [52209.028753]  do_IRQ+0x42/0xc0
> [52209.028756]  common_interrupt+0x95/0x95
> [52209.028758]  </IRQ>
> [52209.028761] RIP: 0033:0x7f144ba796e0
> [52209.028763] RSP: 002b:00007ffc45d64df0 EFLAGS: 00000246 ORIG_RAX:
> ffffffffffffffde
> [52209.028766] RAX: 0000000000000061 RBX: 00007f144bdc3c20 RCX:
> 0000000000000061
> [52209.028767] RDX: 0000000000000061 RSI: 0000000000000000 RDI:
> 0000564df1cc2810
> [52209.028769] RBP: 0000564df1cc27c0 R08: 0000000000000000 R09:
> 0000564df1cc27c0
> [52209.028770] R10: ffffffffffffffb0 R11: 00007f144c31b720 R12:
> 0000000000000050
> [52209.028771] R13: 0000000000009850 R14: 0000564df1cc27b0 R15:
> 0000564df1cb3c40
> [52209.028773] handlers:
> [52209.028779] [<00000000a8ae6ecd>] acpi_irq
> [52209.028782] Disabling IRQ #9
> [52217.086686] usb 1-1: USB disconnect, device number 5
> ...
> 
> This does not happen on a freshly booted system. After boot I can do
> anything with the device and it will not happen.
> 
> But after I suspended the device a single time it becomes vulnerable to
> the above issue. The issue can easiest be reproduced when I e.g. remove
> the keyboard dock from the device, which seems to carry additional
> signals to the USB for keyboard and mouse.
> 
> The device in question is a Thinkpad Tablet 10 Gen2, Intel Baytrail
> Z3795 CPU.
> 
> Another interesting detail is that the acpi IRQ#9 is usually never used,
> neither before nor after suspend:
> 
> # cat /proc/interrupts |grep acpi
>  9:        0        0        0        0   IO-APIC    9-fasteoi   acpi
> 
> Until the issue happens, when 100000 irqs rush in, nobody cares and the
> kernel disables it.
> 
> Also interesting, since kernel 4.15rc kernels finally (yeah!) the Intel
> idle modes S0i<n> started to work! Which is great, saves a lot of power
> during suspend. But after the above issue the device goes to sleep, yes,
> but it does not enter S0i<n> states anymore.
> 
> Before S0i<n> started to work I did not care that much since it did not
> have any drawback but now it has and I would very much like to find a fix.
> 
> If anyone has an idea what to try I will gladly do so - I can pretty
> nicely reproduce the so it is also pretty easy to try possible fixes.
> 
> Thank you so much!
> 
> Cheers
>   nicole

I tried to debug this a little further and found that this has something
to do with the xhci_hcd USB driver. If I set its power control to "auto"
the IRQ#9 storm happens when disconnecting the keyboard dock right away,
without a prior suspend:

echo 'auto' > '/sys/bus/pci/devices/0000:00:14.0/power/control'

The problem also occurs if power control is _not_ set to auto but if I
press some keys on the keyboard while the device is in sleep state.

The keyboard dock is a USB device with three interfaces, port 1 dev 6:

# lsusb -t
/:  Bus 02.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/1p, 5000M
/:  Bus 01.Port 1: Dev 1, Class=root_hub, Driver=xhci_hcd/6p, 480M
    |__ Port 1: Dev 6, If 1, Class=Human Interface Device,
Driver=usbhid, 12M
    |__ Port 1: Dev 6, If 2, Class=Human Interface Device, Driver=, 12M
    |__ Port 1: Dev 6, If 0, Class=Human Interface Device,
Driver=usbhid, 12M
    |__ Port 3: Dev 3, If 0, Class=Communications, Driver=cdc_mbim, 480M
    |__ Port 3: Dev 3, If 1, Class=CDC Data, Driver=cdc_mbim, 480M
    |__ Port 3: Dev 3, If 2, Class=Communications, Driver=cdc_acm, 480M
    |__ Port 3: Dev 3, If 3, Class=CDC Data, Driver=cdc_acm, 480M
    |__ Port 3: Dev 3, If 4, Class=Communications, Driver=cdc_acm, 480M
    |__ Port 3: Dev 3, If 5, Class=CDC Data, Driver=cdc_acm, 480M
    |__ Port 3: Dev 3, If 6, Class=Communications, Driver=cdc_acm, 480M
    |__ Port 3: Dev 3, If 7, Class=CDC Data, Driver=cdc_acm, 480M


Pretty weird - what is the connection between the acpi_irq and the xhci
USB host?

I also tried to remove the xhci driver before going to sleep but this
does not work well since then the CPU will not enter S0i<n> states anymore.

Any help to debug this further and eventually fixing it is very much
appreciated.

Cheers
  nicole

From: Lee Howard <faxguy-SyaKlFUygf5PT3Bn4HtJTg@public.gmane.org>
Subject: Fwd: Re: [linux-usb-devel] joystick - can't read configurations, error -22 [stern-nwvwT67g6+6dFdvTe/nMLgBM1jkYDipv@public.gmane.org
Date: Mon, 31 May 2004 12:07:06 -0700
Sender: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: <20040531190706.GI4146@bilbo.x101.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
Content-Disposition: inline
Errors-To: acpi-devel-admin-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5ji9XKYC2TYK4Io4DoRGLOrNAH6kLmebB@public.gmane.org>
List-Post: <mailto:acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5lLLH9aP38KF1pqr+6INuaA@public.gmane.org>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/acpi-devel>,
	<mailto:acpi-devel-request-5NWGOfrQmneRv+LV9MX5utDmRdBvX5/5R9m/fhtKvoLKtGCp0j7rLg@public.gmane.org>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=acpi-devel>
To: acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Hello.

I have used kernel 2.6.6 just fine for a while now.  I did have not 
ACPI built.  I recently wanted to use a USB joystick that required me 
to upgrade to kernel 2.6.7-rc1.  After doing so I had problems with my 
ethernet driver (forcedeth, which didn't change at all between 2.6.6 
and 2.6.7) and I got lots of noise from the kernel regarding USB (see 
below, forwarded message).

Following some advice that I got on the Linux Kernel mailing list that 
the problem may be ACPI-related I built-in ACPI support into my kernel 
and all of the problems went away.

Seems to me that some recent changes have made ACPI a requirement, 
which, I'm sure is unintended and thus a bug.

Thanks.

Lee.


----- Begin Forwarded Message -----
Date: 2004.05.31 11:50
Subject: Re: [linux-usb-devel] joystick - can't read configurations, 
error -22
From: Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>
To: Lee Howard <faxguy-SyaKlFUygf5PT3Bn4HtJTg@public.gmane.org>
CC: linux-usb-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Message-ID: 
<Pine.LNX.4.44L0.0405311448480.3036-100000-pYrvlCTfrz9XsRXLowluHWD2FQJk+8+b@public.gmane.org>

On Sun, 30 May 2004, Lee Howard wrote:

> On 2004.05.30 08:34 Lee Howard wrote:
> >
> > Thanks, that seems to have helped.  Now I get this (note that the
> > motherboard has two USB controllers and that I don't use the
ehci_hcd
> > controller yet):
> >
> > ehci_hcd 0000:00:02.2: nVidia Corporation nForce2 USB Controller
> > PCI: Setting latency timer of device 0000:00:02.2 to 64
> > ehci_hcd 0000:00:02.2: irq 5, pci mem d087b000
> > ehci_hcd 0000:00:02.2: new USB bus registered, assigned bus number 1
> > irq 5: nobody cared!
> >  [<c0107daa>] __report_bad_irq+0x2a/0x90
> >  [<c0107e9c>] note_interrupt+0x6c/0xb0
> >  [<c01080d2>] do_IRQ+0xe2/0xf0
> >  [<c01063f8>] common_interrupt+0x18/0x20
> >  [<c011c730>] __do_softirq+0x30/0x90
> >  [<c011c7b6>] do_softirq+0x26/0x30
> >  [<c01080b9>] do_IRQ+0xc9/0xf0
> >  [<c01063f8>] common_interrupt+0x18/0x20
> >  [<c0190d0b>] pci_bus_read_config_byte+0x4b/0x60
> >  [<d08d92bc>] ehci_start+0x2cc/0x360 [ehci_hcd]
> >  [<c01196c1>] printk+0x111/0x150
> >  [<d08883ef>] usb_register_bus+0x14f/0x160 [usbcore]
> >  [<d088d278>] usb_hcd_pci_probe+0x398/0x4e0 [usbcore]
> >  [<c0194682>] pci_device_probe_static+0x52/0x70
> >  [<c01946db>] __pci_device_probe+0x3b/0x50
> >  [<c019471c>] pci_device_probe+0x2c/0x50
> >  [<c01c1d4f>] bus_match+0x3f/0x70
> >  [<c01c1e79>] driver_attach+0x59/0x90
> >  [<c01c2121>] bus_add_driver+0x91/0xb0
> >  [<c01c25df>] driver_register+0x2f/0x40
> >  [<c019490c>] pci_register_driver+0x5c/0x90
> >  [<d083802b>] init+0x2b/0x32 [ehci_hcd]
> >  [<c012d7b8>] sys_init_module+0x108/0x1e0
> >  [<c0105a8b>] syscall_call+0x7/0xb
> >
> > handlers:
> > [<d08890a0>] (usb_hcd_irq+0x0/0x70 [usbcore])
> > Disabling IRQ #5
> > PCI: cache line size of 64 is not supported by device 0000:00:02.2
> 
> This noise went away when I built-in ACPI support into the kernel, by
> the way.

This confirms my suspicions that a lot of the problems people have been
reporting recently are caused by the ACPI driver.  You should send this
information to the ACPI development mailing list:
<acpi-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>.

Alan Stern

----- End Forwarded Message -----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

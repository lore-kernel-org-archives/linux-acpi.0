From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Bugme-new] [Bug 12056] New: the serial device(ttyS0) is
 unuseable after booting the kernel
Date: Mon, 17 Nov 2008 18:53:09 -0800
Message-ID: <20081117185309.68d19017.akpm@linux-foundation.org>
References: <bug-12056-10286@http.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:52348 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751552AbYKRCxp (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Mon, 17 Nov 2008 21:53:45 -0500
In-Reply-To: <bug-12056-10286@http.bugzilla.kernel.org/>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, Zhao Yakui <yakui.zhao@intel.com>, Li Shaohua <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>
Cc: bugme-daemon@bugzilla.kernel.org, shanwei@cn.fujitsu.com


(switched to email.  Please respond via emailed reply-to-all, not via the
bugzilla web interface).

On Mon, 17 Nov 2008 18:44:44 -0800 (PST) bugme-daemon@bugzilla.kernel.org wrote:

> http://bugzilla.kernel.org/show_bug.cgi?id=12056
> 
>            Summary: the serial device(ttyS0) is unuseable after booting the
>                     kernel
>            Product: ACPI
>            Version: 2.5
>      KernelVersion: 2.6.28-rc3
>           Platform: All
>         OS/Version: Linux
>               Tree: Mainline
>             Status: NEW
>           Severity: blocking
>           Priority: P1
>          Component: ACPICA-Core
>         AssignedTo: acpi_acpica-core@kernel-bugs.osdl.org
>         ReportedBy: shanwei@cn.fujitsu.com
> 
> 
> Latest working kernel version:2.6.28-rc3
> Earliest failing kernel version:2.6.28-rc1
> Distribution:
> Hardware Environment:fujitsu's PG
> Software Environment:
> Problem Description:
> 
>   When i switch to the kernel of 2.6.28-rc3, the serial device 
> (ttyS0) is unused. But on 2.6.27, it's ok. 
> 
> On 2.6.28-rc3:
> [root@DaVid compiler]# setserial /dev/ttyS0
> /dev/ttyS0, UART: unknown, Port: 0x03f8, IRQ: 4
> 
> On 2.6.27:
> [root@DaVid compiler]# setserial /dev/ttyS0
> /dev/ttyS0, UART: 16550A, Port: 0x03f8, IRQ: 4
> 
>   The problem comes from this patch 39a0ad871000d2a016a4fa113a6e53d22aabf25d___
> For the device that is not present but functional, it unload the driver for the
> device. 
>   In the following patch, I try to fix it whthout check the present bit when
> adding device. After applied the patch, the serial device is useable again.
> 
> diff --git a/drivers/pnp/pnpacpi/core.c b/drivers/pnp/pnpacpi/core.c
> index 383e47c..bcc731b 100644
> --- a/drivers/pnp/pnpacpi/core.c
> +++ b/drivers/pnp/pnpacpi/core.c
> @@ -154,7 +154,7 @@ static int __init pnpacpi_add_device(struct acpi_device
> *device)
>          */
>         status = acpi_get_handle(device->handle, "_CRS", &temp);
>         if (ACPI_FAILURE(status) || !ispnpidacpi(acpi_device_hid(device)) ||
> -           is_exclusive_device(device) || (!device->status.present))
> +           is_exclusive_device(device))
>                 return 0;
> 
>         dev = pnp_alloc_dev(&pnpacpi_protocol, num, acpi_device_hid(device));
> 
> Steps to reproduce:
> 1)build the kernel of 2.6.28-rc3;
> 2)check the device with ___setserial /dev/ttyS0___
> 
> 


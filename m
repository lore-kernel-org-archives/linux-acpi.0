From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem
 after ACPI S3 suspend.
Date: Thu, 6 Jan 2005 10:48:29 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0501061044410.1024-100000@ida.rowland.org>
References: <20050105230902.4085.qmail@web50204.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050105230902.4085.qmail@web50204.mail.yahoo.com>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Paul Ionescu <i_p_a_u_l@yahoo.com>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Wed, 5 Jan 2005, Paul Ionescu wrote:

> The dmesg from a kernel 2.6.10 with CONFIG_USB_DEBUG
> is bellow:
> suspended without any device plugged, resumed, plugged
> a device in.
> 
> uhci_hcd 0000:00:1d.1: suspend_hc
> PM: Preparing system for suspend
> ehci_hcd 0000:00:1d.7: --> PCI D3hot
> uhci_hcd 0000:00:1d.2: suspend_hc
> uhci_hcd 0000:00:1d.2: --> PCI D0/legacy
> uhci_hcd 0000:00:1d.1: suspend_hc
> uhci_hcd 0000:00:1d.1: --> PCI D0/legacy
> uhci_hcd 0000:00:1d.0: suspend_hc
> uhci_hcd 0000:00:1d.0: --> PCI D0/legacy
> PM: Entering state.
>  hwsleep-0307 [23] acpi_enter_sleep_state: Entering
> sleep state [S3]
> Back to C!
> Warning: CPU frequency is 1700000, cpufreq assumed
> 1000000 kHz.
> Debug: sleeping function called from invalid context
> at mm/slab.c:2062
> in_atomic():0, irqs_disabled():1
>  [<c01188f5>] __might_sleep+0x95/0xb0
>  [<c0216247>] acpi_ut_trace+0x28/0x2e
>  [<c0140690>] kmem_cache_alloc+0x50/0x60
>  [<c021d362>] acpi_pci_link_set+0x89/0x26b
>  [<c021da11>] acpi_pci_link_resume+0x45/0x79
>  [<c021da88>] irqrouter_resume+0x43/0x5e
>  [<c025a0c6>] sysdev_resume+0x66/0xc4
>  [<c025dbb5>] device_power_up+0x5/0xa
>  [<c0131bd0>] suspend_enter+0x30/0x50
>  [<c0131c93>] enter_state+0x63/0x90
>  [<c021a513>] acpi_suspend+0x28/0x35
>  [<c01d9a44>] copy_from_user+0x54/0x90
>  [<c021a618>] acpi_system_write_sleep+0x66/0x77
>  [<c01548e1>] vfs_write+0xd1/0x130
>  [<c01549f1>] sys_write+0x41/0x70
>  [<c0102e0d>] sysenter_past_esp+0x52/0x75
> hub 4-0:1.0: resubmit --> -108
> hub 2-0:1.0: resubmit --> -108
> hub 3-0:1.0: resubmit --> -108
> PM: Finishing up.
> uhci_hcd 0000:00:1d.0: resume from PCI D0 (legacy)
> PCI: Setting latency timer of device 0000:00:1d.0 to
> 64
> uhci_hcd 0000:00:1d.1: resume from PCI D0 (legacy)
> PCI: Setting latency timer of device 0000:00:1d.1 to
> 64
> uhci_hcd 0000:00:1d.2: resume from PCI D0 (legacy)
> PCI: Setting latency timer of device 0000:00:1d.2 to
> 64
> ehci_hcd 0000:00:1d.7: resume from PCI D3hot

I think you've run across another indication that the suspend/resume 
support in the USB drivers is not yet ready for prime time.  Does the 
patch below help?  (Note: this is meant for use with CONFIG_USB_SUSPEND 
not set.)

Alan Stern



--- 2.6.10-orig/drivers/usb/core/hcd.c	Mon Jan  3 09:39:35 2005
+++ 2.6.10/drivers/usb/core/hcd.c	Thu Jan  6 10:43:16 2005
@@ -534,7 +534,8 @@
 
 	/* complete the status urb, or retrigger the timer */
 	spin_lock (&hcd_data_lock);
-	if (urb->dev->state == USB_STATE_CONFIGURED) {
+	if (urb->dev->state == USB_STATE_CONFIGURED &&
+			hcd->state == USB_STATE_RUNNING) {
 		length = hcd->driver->hub_status_data (
 					hcd, urb->transfer_buffer);
 		if (length > 0) {



-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

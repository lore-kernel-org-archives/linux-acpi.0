From: Paul Ionescu <i_p_a_u_l@yahoo.com>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Thu, 6 Jan 2005 10:07:40 -0800 (PST)
Message-ID: <20050106180740.40359.qmail@web50203.mail.yahoo.com>
References: <Pine.LNX.4.44L0.0501061044410.1024-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0501061044410.1024-100000@ida.rowland.org>
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: USB development list <linux-usb-devel@lists.sourceforge.net>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

Hi Alan,

Now after a suspend/resume cycle, I see the devices
with lsusb, but they are not working (I tried a
mouse), and I get in logs a lot of:
Jan  6 20:04:14 r50p kernel:
drivers/usb/input/hid-core.c: input irq status -84
received
Jan  6 20:04:14 r50p kernel:
drivers/usb/input/hid-core.c: input irq status -84
received
Jan  6 20:04:14 r50p kernel: uhci_hcd 0000:00:1d.1:
suspend_hc
Jan  6 20:04:14 r50p kernel: uhci_hcd 0000:00:1d.1:
wakeup_hc
Jan  6 20:04:14 r50p kernel:
drivers/usb/input/hid-core.c: input irq status -84
received
Jan  6 20:04:16 r50p last message repeated 87 times
Jan  6 20:04:16 r50p kernel: uhci_hcd 0000:00:1d.1:
suspend_hc
Jan  6 20:04:16 r50p kernel: uhci_hcd 0000:00:1d.1:
wakeup_hc
Jan  6 20:04:17 r50p kernel:
drivers/usb/input/hid-core.c: input irq status -84
received
Jan  6 20:04:19 r50p last message repeated 86 times
Jan  6 20:04:19 r50p kernel: uhci_hcd 0000:00:1d.1:
suspend_hc
Jan  6 20:04:19 r50p kernel: uhci_hcd 0000:00:1d.1:
wakeup_hc
Jan  6 20:04:19 r50p kernel:
drivers/usb/input/hid-core.c: input irq status -84
received
Jan  6 20:04:21 r50p last message repeated 87 times

Now, even a rmmod/insmod after resume does not help
any more.
Tested with both ehci and uhci loaded when suspending.

Thanks,
Paul

--- Alan Stern <stern@rowland.harvard.edu> wrote:
> I think you've run across another indication that
> the suspend/resume 
> support in the USB drivers is not yet ready for
> prime time.  Does the 
> patch below help?  (Note: this is meant for use with
> CONFIG_USB_SUSPEND 
> not set.)
> 
> Alan Stern
> 
> 
> 
> --- 2.6.10-orig/drivers/usb/core/hcd.c	Mon Jan  3
> 09:39:35 2005
> +++ 2.6.10/drivers/usb/core/hcd.c	Thu Jan  6
> 10:43:16 2005
> @@ -534,7 +534,8 @@
>  
>  	/* complete the status urb, or retrigger the timer
> */
>  	spin_lock (&hcd_data_lock);
> -	if (urb->dev->state == USB_STATE_CONFIGURED) {
> +	if (urb->dev->state == USB_STATE_CONFIGURED &&
> +			hcd->state == USB_STATE_RUNNING) {
>  		length = hcd->driver->hub_status_data (
>  					hcd, urb->transfer_buffer);
>  		if (length > 0) {
> 
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

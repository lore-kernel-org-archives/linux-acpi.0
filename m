From: David Brownell <david-b@pacbell.net>
Subject: Re: [ACPI] Re: kernel 2.6.10 , uhci-hcd problem after ACPI S3 suspend.
Date: Thu, 6 Jan 2005 09:31:58 -0800
Message-ID: <200501060931.58821.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0501061044410.1024-100000@ida.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-usb-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44L0.0501061044410.1024-100000@ida.rowland.org>
Content-Disposition: inline
Sender: linux-usb-devel-admin@lists.sourceforge.net
Errors-To: linux-usb-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:linux-usb-devel@lists.sourceforge.net>
List-Help: <mailto:linux-usb-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-usb-devel>,
	<mailto:linux-usb-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-usb-devel>
To: linux-usb-devel@lists.sourceforge.net
Cc: Alan Stern <stern@rowland.harvard.edu>, Paul Ionescu <i_p_a_u_l@yahoo.com>, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Thursday 06 January 2005 7:48 am, Alan Stern wrote:

> I think you've run across another indication that the suspend/resume 
> support in the USB drivers is not yet ready for prime time.  Does the 
> patch below help?  (Note: this is meant for use with CONFIG_USB_SUSPEND 
> not set.)

This would be a case where the root hub timer isn't
getting shut down "properly" during suspend ... right
now the OHCI and EHCI code test for HCD_IS_RUNNING()
in their hub_status_data() entries.  I remember not
liking that fix, but also not thinking usbcore was
a safe place for the fix -- I forget why.

- Dave


> --- 2.6.10-orig/drivers/usb/core/hcd.c	Mon Jan  3 09:39:35 2005
> +++ 2.6.10/drivers/usb/core/hcd.c	Thu Jan  6 10:43:16 2005
> @@ -534,7 +534,8 @@
>  
>  	/* complete the status urb, or retrigger the timer */
>  	spin_lock (&hcd_data_lock);
> -	if (urb->dev->state == USB_STATE_CONFIGURED) {
> +	if (urb->dev->state == USB_STATE_CONFIGURED &&
> +			hcd->state == USB_STATE_RUNNING) {
>  		length = hcd->driver->hub_status_data (
>  					hcd, urb->transfer_buffer);
>  		if (length > 0) {
> 
> 
> 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
linux-usb-devel@lists.sourceforge.net
To unsubscribe, use the last form field at:
https://lists.sourceforge.net/lists/listinfo/linux-usb-devel

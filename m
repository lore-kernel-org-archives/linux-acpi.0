From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [Resend PATCH V3 6/8] usb: move struct usb_device->children to
 struct usb_hub_port->child
Date: Fri, 11 May 2012 17:10:27 -0700
Message-ID: <20120512001027.GA25600@kroah.com>
References: <1336723712-7686-1-git-send-email-tianyu.lan@intel.com>
 <1336723712-7686-7-git-send-email-tianyu.lan@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54066 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754512Ab2ELAKc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 20:10:32 -0400
Received: by dady13 with SMTP id y13so3684552dad.19
        for <linux-acpi@vger.kernel.org>; Fri, 11 May 2012 17:10:32 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1336723712-7686-7-git-send-email-tianyu.lan@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, mjg59@srcf.ucam.org, mfm@muteddisk.com

On Fri, May 11, 2012 at 04:08:30PM +0800, Lan Tianyu wrote:

> +struct usb_device *usb_get_hub_child_device(struct usb_device *hdev,
> +	int port1)
> +{
> +	struct usb_hub *hub = hdev_to_hub(hdev);
> +
> +	if (!hub || port1 > hdev->maxchild || port1 < 1)
> +		return NULL;
> +	return hub->port_data[port1 - 1].child;
> +}
> +EXPORT_SYMBOL_GPL(usb_get_hub_child_device);

We need kerneldoc documentation for this new public function.  Please
send a follow-on patch that adds this.

thanks,

greg k-h

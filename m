From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's
 power
Date: Thu, 7 Jun 2012 10:24:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206071022200.1311-100000@iolanthe.rowland.org>
References: <4FD04DF5.5060007@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:38916 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1760447Ab2FGOYD (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 7 Jun 2012 10:24:03 -0400
In-Reply-To: <4FD04DF5.5060007@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Thu, 7 Jun 2012, Lan Tianyu wrote:

> > One more problem -- your implementation of "off" isn't quite right.
> > You need to update hub_power_on() too.
> >
> How about this?
> 
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -861,7 +861,9 @@ static unsigned hub_power_on(struct usb_hub *hub, bool do_delay)
>                  dev_dbg(hub->intfdev, "trying to enable port power on "
>                                  "non-switchable hub\n");
>          for (port1 = 1; port1 <= hub->descriptor->bNbrPorts; port1++)
> -               set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);
> +               if (hub->port_data[port1 - 1].port_power_policy
> +                               == USB_PORT_POWER_ON)
> +                       set_port_feature(hub->hdev, port1, USB_PORT_FEAT_POWER);

Yes, that's the idea.

Alan Stern


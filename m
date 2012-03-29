From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 2/5] usb: move struct usb_device->children to struct
 usb_hub_port->child
Date: Thu, 29 Mar 2012 10:50:46 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1203291047560.1417-100000@iolanthe.rowland.org>
References: <4F741ED7.8010105@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:34121 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753764Ab2C2Our (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 29 Mar 2012 10:50:47 -0400
In-Reply-To: <4F741ED7.8010105@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: lenb@kernel.org, gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com, mjg@redhat.com

On Thu, 29 Mar 2012, Lan Tianyu wrote:

> >> @@ -1475,11 +1477,12 @@ bool usb_device_is_owned(struct usb_device *udev)
> >>
> >>   static void recursively_mark_NOTATTACHED(struct usb_device *udev)
> >>   {
> >> +	struct usb_hub	*hub = hdev_to_hub(udev);
> >
> > I'm not sure this is good.  You are calling hdev_to_hub without knowing
> > beforehand that udev really is a hub -- in fact, most of the time udev
> > won't be a hub.  The routine wasn't meant to be used that way.  Have
> > you checked that hdev_to_hub won't crash when the argument isn't a hub?
> > What happens if the active configuration has no interfaces?
> About this, I have an idea to add a check of hdev->maxchild. I have
> verified that hdev->maxchild only is set in the hub_configure() and
> hub_disconnect(). So we can identify whether the udev is a usb hub or
> not through hdev->maxchild. Does this make sense?

Yes, okay.  If you add such a check to hdev_to_hub() then it will work 
properly.  Unless somebody markets a hub with no ports -- but we don't 
need to worry about that!  :-)

Alan Stern


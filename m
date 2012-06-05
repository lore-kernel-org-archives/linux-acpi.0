From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH V3 3/3] usb : Add sysfs files to control usb port's
 power
Date: Tue, 5 Jun 2012 10:18:50 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1206051017040.1542-100000@iolanthe.rowland.org>
References: <4FCDC3BB.50809@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:51961 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757210Ab2FEOSv (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jun 2012 10:18:51 -0400
In-Reply-To: <4FCDC3BB.50809@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>
Cc: gregkh@linuxfoundation.org, lenb@kernel.org, linux-usb@vger.kernel.org, linux-acpi@vger.kernel.org, sarah.a.sharp@linux.intel.com

On Tue, 5 Jun 2012, Lan Tianyu wrote:

> > The patch does not implement anything at all for "auto".  It should do
> > _something_.
> >
> Yeah, if we don't power off port without device when echo "auto" > portX/control,
> this patch does nothing about "auto". Original plan is to deal with port without
> devices firstly. Do you mean I should add the process of port with device in this
> patch?

At least make a start.  For example, have "auto" turn off the power if
no device is attached to the port.

If "auto" does nothing, there's no reason to put it in this patch at 
all.  It could be added in a later patch, along with its 
implementation.

Alan Stern


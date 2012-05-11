From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 10:20:31 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205111019000.1865-100000@iolanthe.rowland.org>
References: <20120511041309.22096.qmail@stuge.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47405 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755382Ab2EKOUc (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 10:20:32 -0400
In-Reply-To: <20120511041309.22096.qmail@stuge.se>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Peter Stuge <peter@stuge.se>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Dan Williams <dcbw@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 11 May 2012, Peter Stuge wrote:

> Sarah Sharp wrote:
> > Maybe we need an "off" setting that forces the port off?
> 
> FWIW this would be very welcome in libusb, to do a hard reset of
> bus-powered devices.
> 
> It can be attempted via SET_FEATURE(PORT_POWER) to the hub, but a
> "real" API would be nice.

But remember that such an API would be very unreliable.  Many hubs and
root hubs cannot shut off port power at all, and some of the remaining
ones use ganged power switches (you have to turn off all the ports in a
gang before power is removed from any of them).

Alan Stern


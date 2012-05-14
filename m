From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Mon, 14 May 2012 16:21:23 -0700
Message-ID: <20120514232123.GK18754@xanatos>
References: <20120511202113.GH18754@xanatos>
 <Pine.LNX.4.44L0.1205111629150.1865-100000@iolanthe.rowland.org>
 <20120511235922.GJ18754@xanatos>
 <20120512001722.GA28011@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:24276 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758254Ab2ENXVe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 14 May 2012 19:21:34 -0400
Content-Disposition: inline
In-Reply-To: <20120512001722.GA28011@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dan Williams <dcbw@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, May 11, 2012 at 05:17:22PM -0700, Greg KH wrote:
> On Fri, May 11, 2012 at 04:59:22PM -0700, Sarah Sharp wrote:
> > > > Only the xHCI host controller will have the port power off mechanism.
> > > 
> > > You're only talking about the upcoming Intel implementation, right?
> > 
> > Yes.  The port power off mechanism is an Intel specific ACPI call.
> > AFAIK, there isn't anyone else who is going to have this mechanism.
> 
> That's not fair, you don't know what other vendors are going to do in
> their controllers, or their system firmware, to be able to accurately say
> this.

Yes, you are correct, I don't know if other vendors will do this in the
future, or if they'll use the same ACPI API.

AFAIK, the port power off mechanism has only been discussed internally
within Intel until this thread.  So it's unlikely that anyone will have
this mechanism in the near future.  But as you said, never say never. :)

We'll strive to make the mechanism as generic as possible, so that other
vendors can add their own ACPI hooks into the xHCI driver if they choose
to do a similar port power off mechanism.

Sarah Sharp

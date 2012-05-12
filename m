From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Sat, 12 May 2012 09:54:42 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205120951480.6778-100000@netrider.rowland.org>
References: <20120512001722.GA28011@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from netrider.rowland.org ([192.131.102.5]:47267 "HELO
	netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752137Ab2ELNyo (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 May 2012 09:54:44 -0400
In-Reply-To: <20120512001722.GA28011@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Dan Williams <dcbw@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 11 May 2012, Greg KH wrote:

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

Right.  Even if other vendors don't use this ACPI mechanism, some of
them may very well implement the native USB port power control
mechanism.  If we add port power support to our drivers, we should 
certainly include native support.

Alan Stern


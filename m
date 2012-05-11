From: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 11:12:56 -0700
Message-ID: <20120511181256.GD18754@xanatos>
References: <4FAD3A51.4010803@intel.com>
 <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:63291 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932215Ab2EKSM6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 11 May 2012 14:12:58 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, gregkh@linuxfoundation.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, May 11, 2012 at 01:44:26PM -0400, Alan Stern wrote:
> On Sat, 12 May 2012, Lan Tianyu wrote:
> 
> >     The power saving depends on devices. I test a usb3.0 ssd. The power saving of
> > power off is about 2.2w more than just selective suspend. In theory, power
> > off can help to save remaining power after selective suspend.
> 
> That's a lot of power!  Suspended USB devices aren't supposed to
> consume more than 2.5 mA of bus current, which at 5 V amounts to <=
> 0.0125 W.  Does the port really use that much?  Or does the SSD have a
> separate power supply that it disables when port power is removed?

I actually suspect that the host controller is powering off several PLLs
if all the ports are powered off.  After all, if it doesn't have to pay
attention to connects, disconnects, or remote wakeup, it can power off a
lot more circuitry, and possibly even enter D3cold instead of D3hot when
the PCI device is suspended (depending on what board Tianyu is testing
on).  But I agree that it would be interesting to see if the SSD has a
separate power supply that it's turning off.

> > > The patch did not address the case of powering down ports that have no
> > > devices attached.  That might be a better place to start, because it's
> > > simpler, even though it might not yield as much power savings.
> > 
> > Do you mean internal ports?
> 
> Internal or external.
> 
> >  From my opinion, ACPI will tell us whether the port is connectable or not.
> 
> ACPI will tell you about some ports, not others (for example, ACPI
> knows nothing about the ports on hubs that the user plugs in).  On
> other systems, a Device Tree database might provide the same
> information.
> 
> > When the internal port is not connectable, this means the port is not used
> > and this patch will power down the port.
> 
> ...
> 
> > For external ports, this should be associated with sys file control. The users
> > need to determine when they should be power off.
> 
> You don't mean "external", you mean "not described as unconnectable by 
> ACPI".
> 
> > So I should work on the external ports without devices firstly and
> > add the sys file for user to control?
> 
> Yes, I think so.  It will be less controversial and probably simpler.  
> When that mechanism is ready, you should be able to use it
> automatically for unconnectable ports.
> 
> One tricky thing: In theory, there should be a separate sysfs file for 
> each port.  That seems like a lot of overhead though; is there any way 
> to present the information in a single file that won't offend sysfs 
> purists?

Tianyu proposed having one file per hub, with a bit field that
controlled each port power.  However, I was concerned about different
userspace applications racing with each other to turn or off ports.  For
example, one app could read the bit field, attempt to power off just
port 1, but before it can write to the sysfs file, a second app powers
on port2, and the first app then writes to the sysfs file, leaving port
1 powered off, and port 2 powered off, which is not what the second app
wanted.

But if you can think of a better way to coalesce the port power off
mechanisms into one file, we're all ears. :)

Sarah Sharp

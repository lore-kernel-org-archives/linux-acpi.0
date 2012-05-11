From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 15:32:56 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1205111515070.1865-100000@iolanthe.rowland.org>
References: <20120511183543.GF7920@kroah.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:47594 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933151Ab2EKTc6 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 15:32:58 -0400
In-Reply-To: <20120511183543.GF7920@kroah.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Lan Tianyu <tianyu.lan@intel.com>, Sarah Sharp <sarah.a.sharp@linux.intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, 11 May 2012, Greg KH wrote:

> > One tricky thing: In theory, there should be a separate sysfs file for 
> > each port.  That seems like a lot of overhead though; is there any way 
> > to present the information in a single file that won't offend sysfs 
> > purists?
> 
> Why is that a lot of "overhead"?  It's what, 7-9 files max?  As Sarah
> points out, one file for all ports is racy and can get to be a mess.
> 
> But then again, I'm a "sysfs purist" :)

Having multiple files makes it impossible to change several ports at
once, or see the values for all the ports at once.  Not a big deal, 
mostly a matter of convenience.

On Fri, 11 May 2012, Sarah Sharp wrote:

> Tianyu proposed having one file per hub, with a bit field that
> controlled each port power.  However, I was concerned about different
> userspace applications racing with each other to turn or off ports.  For
> example, one app could read the bit field, attempt to power off just
> port 1, but before it can write to the sysfs file, a second app powers
> on port2, and the first app then writes to the sysfs file, leaving port
> 1 powered off, and port 2 powered off, which is not what the second app
> wanted.

Writes should indicate only the items to be changed; they shouldn't 
specify the values for things that are to be left alone.  Then there's 
no race unless two tasks try to modify the same port at the same time, 
which is hopeless anyway.

> But if you can think of a better way to coalesce the port power off
> mechanisms into one file, we're all ears. :)

I'm sure this has become up before for other sysfs files.  We're
talking about an array, and having one file per array value is just
clunky.

Actually we're probably talking about two arrays: one for
power-control and one for power-status.

So for example, reading the power-control file could return a list of 
ports, one per line, something like this:

1:auto
2:on
3:auto
4:off

(I find such lists easier to interpret than a sequence of flags, like
"A+A-"; other people may disagree.)  Writes could be parsed as a list
of elements to be changed, separated by whitespace, such as:

	echo '2:auto 4:on' >/sys/.../power_control

The power-status file would be similar, except that it wouldn't be
writable and the value would be the current power status: either on or
off (not auto).  Or if you wanted to be fancy, each line could contain 
all the information from a Get-Port-Status request.

That's one possibility; no doubt others would work just as well.

Alan Stern


From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Sat, 12 May 2012 07:04:38 -0700
Message-ID: <20120512140438.GA30539@kroah.com>
References: <4FAD3A51.4010803@intel.com>
 <Pine.LNX.4.44L0.1205111302080.1865-100000@iolanthe.rowland.org>
 <20120511181256.GD18754@xanatos>
 <4FAE5BFE.4000904@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:43641 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755489Ab2ELOEl (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 12 May 2012 10:04:41 -0400
Received: by dady13 with SMTP id y13so4188841dad.19
        for <linux-acpi@vger.kernel.org>; Sat, 12 May 2012 07:04:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4FAE5BFE.4000904@mvista.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, Alan Stern <stern@rowland.harvard.edu>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Sat, May 12, 2012 at 04:47:58PM +0400, Sergei Shtylyov wrote:
> Hello.
> 
> On 11-05-2012 22:12, Sarah Sharp wrote:
> 
> >>>For external ports, this should be associated with sys file control. The users
> >>>need to determine when they should be power off.
> 
> >>You don't mean "external", you mean "not described as unconnectable by
> >>ACPI".
> 
> >>>So I should work on the external ports without devices firstly and
> >>>add the sys file for user to control?
> 
> >>Yes, I think so.  It will be less controversial and probably simpler.
> >>When that mechanism is ready, you should be able to use it
> >>automatically for unconnectable ports.
> 
> >>One tricky thing: In theory, there should be a separate sysfs file for
> >>each port.  That seems like a lot of overhead though; is there any way
> >>to present the information in a single file that won't offend sysfs
> >>purists?
> 
> >Tianyu proposed having one file per hub, with a bit field that
> >controlled each port power.  However, I was concerned about different
> >userspace applications racing with each other to turn or off ports.  For
> >example, one app could read the bit field, attempt to power off just
> >port 1, but before it can write to the sysfs file, a second app powers
> >on port2, and the first app then writes to the sysfs file, leaving port
> >1 powered off, and port 2 powered off, which is not what the second app
> >wanted.
> 
> >But if you can think of a better way to coalesce the port power off
> >mechanisms into one file, we're all ears. :)
> 
>    How about two files? You write 1 to the bit that matcheas port
> you want powered on in the 'poweron' file, and vice versa, you write
> 1 to the bit that matches port you want powered off in the
> 'poweroff' file.

Ick, no, bit manipulation in sysfs files isn't the nicest thing at all
(especially as Sarah implied that we could have more than 64 ports for a
host, and then what, we have what, 128bit variables here?)

One file per port please, in a generic way.

greg k-h

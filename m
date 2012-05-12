From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH] usb/acpi: Add support usb port power off mechanism
 for device fixed on the motherboard
Date: Fri, 11 May 2012 17:17:22 -0700
Message-ID: <20120512001722.GA28011@kroah.com>
References: <20120511202113.GH18754@xanatos>
 <Pine.LNX.4.44L0.1205111629150.1865-100000@iolanthe.rowland.org>
 <20120511235922.GJ18754@xanatos>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:54619 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761357Ab2ELAR0 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 11 May 2012 20:17:26 -0400
Received: by dady13 with SMTP id y13so3688902dad.19
        for <linux-acpi@vger.kernel.org>; Fri, 11 May 2012 17:17:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120511235922.GJ18754@xanatos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sarah Sharp <sarah.a.sharp@linux.intel.com>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dan Williams <dcbw@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-usb@vger.kernel.org

On Fri, May 11, 2012 at 04:59:22PM -0700, Sarah Sharp wrote:
> > > Only the xHCI host controller will have the port power off mechanism.
> > 
> > You're only talking about the upcoming Intel implementation, right?
> 
> Yes.  The port power off mechanism is an Intel specific ACPI call.
> AFAIK, there isn't anyone else who is going to have this mechanism.

That's not fair, you don't know what other vendors are going to do in
their controllers, or their system firmware, to be able to accurately say
this.

> > > > And what about ports on the USB-2 "rate-matching" hubs that Intel now
> > > > builds into its chipsets?
> > > 
> > > For the Intel platform that has the port power off mechanism, there are
> > > EHCI host controllers, but the port switch over changes *all* the USB
> > > ports under xHCI.
> > 
> > Leaving aside the matter of people who don't use the port switch-over, 
> > what about other platforms?
> 
> I'm not sure about other future Intel chipsets, like server chipsets.
> As I said, I don't think the port power off mechanism will save servers
> a large percentage of their power budget.  I don't think there's any
> plans to add the port power off mechanism to EHCI.

Power savings mean more in real dollars to server systems than to mobile
systems.  So don't be supprised to see this show up on some server
systems, especially with the wide range of "custom" motherboards that
people are creating for large "cloud" data centers.

Never say never :)

greg k-h

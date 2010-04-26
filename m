From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] acpi: silence kmemcheck false positive
Date: Tue, 27 Apr 2010 00:19:22 +0200
Message-ID: <20100426221922.GW29093@bicker>
References: <20100422194346.GB29093@bicker> <20100422200220.GC29093@bicker> <201004221632.21129.bjorn.helgaas@hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:51666 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753417Ab0DZWTx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 26 Apr 2010 18:19:53 -0400
Received: by wwb22 with SMTP id 22so836221wwb.19
        for <linux-acpi@vger.kernel.org>; Mon, 26 Apr 2010 15:19:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <201004221632.21129.bjorn.helgaas@hp.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, Shaohua Li <shaohua.li@intel.com>, Zhang Rui <rui.zhang@intel.com>, Zhao Yakui <yakui.zhao@intel.com>, linux-acpi@vger.kernel.org, vegardno@ifi.uio.no, casteyde.christian@free.fr

On Thu, Apr 22, 2010 at 04:32:20PM -0600, Bjorn Helgaas wrote:
> > > -	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC);
> > > +	event = kmalloc(sizeof(struct acpi_bus_event), GFP_ATOMIC | __GFP_NOTRACK_FALSE_POSITIVE);
> 
> Just in terms of reading the code, this solution is fairly ugly.
> I think __GFP_NOTRACK should be sort of the last resort, after we've
> ruled out all the more conventional strategies.
> 
> Has anybody tried any of the alternatives Vegard suggested here:
> https://bugzilla.kernel.org/show_bug.cgi?id=14998#c35 ?
> 

First of all I really want to thank Vegard for taking the time to look
at this.  There are three options in the bugzilla entry:

> 1. Copy the struct "by hand" and use strncpy() for the strings to avoid
> the uninitialized areas.

The downside is that copying by hand is a maintainance hassle.

> 2. Allocate the event with kmalloc() instead of on the stack and free it
> after the call to acpi_bus_receive_event().

The problem with this is that if a future function uses stack data instead
of allocated data we're back at square one.  Perhaps if we put a huge 
warning sign it would be OK.  There isn't a sparse anotation for this, 
but it would be nice to have.  One other place where we could use it 
would be passing stack space as a DMA transfer buffer.

> 3. Allocate the event with kmalloc() and pass ownership of the structure
> to acpi_bus_receive_event() to avoid the copying altogether.
                                                                                                                             
I don't think the kmalloc() is meant here because it says we avoid the 
copying.  This is a simple api change but in the end I didn't think it
was as nice as the current api.  I did write a patch to do it though so
if anyone prefers that I can send it.

In the end, I decided it was easiest to just to change the kmalloc() to a
kzalloc().

regards,
dan carpenter


From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to generic suspend
 functionality
Date: Thu, 10 Jun 2010 11:11:59 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1006101110190.4129@localhost.localdomain>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
 <1275230238.14907.8.camel@maxim-laptop>
 <alpine.LFD.2.00.1006041508190.4073@localhost.localdomain>
 <1275751718.10792.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173011pub.verizon.net ([206.46.173.11]:46460 "EHLO
	vms173011pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932286Ab0FJPMS (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2010 11:12:18 -0400
In-reply-to: <1275751718.10792.0.camel@maxim-laptop>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Sat, 5 Jun 2010, Maxim Levitsky wrote:

> On Fri, 2010-06-04 at 15:11 -0400, Len Brown wrote: 
> > > Since the other patch 'ACPI / EC / PM: Fix race between EC transactions
> > > and system suspend' is now merged, this should be rebased on top of it
> > > (I did the opposite....)
> > 
> > Maxim,
> > Since your system needs both these fixes, and they are merged together
> > in the acpi git tree, it would be great if you could test that tree
> > and let me know if we got it right.
> > 
> > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test


> Which kernel do you expect these patches to land on?

the test tree above is in linux-next now.
there are some patches that will be 2.6.36 in there,
but I was considereing this one for 2.6.35-rc3 --
though your e-mail with a stack trace has caused me to pause --
did I mis-merge it?

thanks,
-Len Brown, Intel Open Source Technology Center

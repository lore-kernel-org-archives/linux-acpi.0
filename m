From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [PATCH 1/2] suspend: Move NVS save/restore code to generic
 suspend functionality
Date: Thu, 10 Jun 2010 18:21:08 +0300
Message-ID: <1276183268.3137.5.camel@maxim-laptop>
References: <1275078735-1866-1-git-send-email-mjg@redhat.com>
	 <1275230238.14907.8.camel@maxim-laptop>
	 <alpine.LFD.2.00.1006041508190.4073@localhost.localdomain>
	 <1275751718.10792.0.camel@maxim-laptop>
	 <alpine.LFD.2.00.1006101110190.4129@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34814 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759342Ab0FJPVO (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 10 Jun 2010 11:21:14 -0400
In-Reply-To: <alpine.LFD.2.00.1006101110190.4129@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Matthew Garrett <mjg@redhat.com>, linux-acpi@vger.kernel.org, linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>, Alan Stern <stern@rowland.harvard.edu>

On Thu, 2010-06-10 at 11:11 -0400, Len Brown wrote: 
> On Sat, 5 Jun 2010, Maxim Levitsky wrote:
> 
> > On Fri, 2010-06-04 at 15:11 -0400, Len Brown wrote: 
> > > > Since the other patch 'ACPI / EC / PM: Fix race between EC transactions
> > > > and system suspend' is now merged, this should be rebased on top of it
> > > > (I did the opposite....)
> > > 
> > > Maxim,
> > > Since your system needs both these fixes, and they are merged together
> > > in the acpi git tree, it would be great if you could test that tree
> > > and let me know if we got it right.
> > > 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6.git test
> 
> 
> > Which kernel do you expect these patches to land on?
> 
> the test tree above is in linux-next now.
> there are some patches that will be 2.6.36 in there,
> but I was considereing this one for 2.6.35-rc3 --
> though your e-mail with a stack trace has caused me to pause --
> did I mis-merge it?

I can't reproduce that anymore.
I had a userspace script that would mmap /dev/mem and 'fix' the issue.
I used it to help some ubuntu users and to test some unrelated work on
ubuntu kernel.

Yet, the script should exit before write to /sys/power/state.

However when this happened I also closed the system's lid, which might
make the same script to run in parallel, and therefore an attempt to
ioremap the NVS area failed.
can't think for any other explanation why ioremap could fail.
Anyway, I think it would be safe to add a check to and abort suspend if
ioremap fails.


I don't use this script anymore.

Best regards,
Maxim Levitsky


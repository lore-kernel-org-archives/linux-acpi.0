From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Kernel Version specific vendor override possibilities needed - Revert and provide osi=linux or provide a replacement
Date: Thu, 21 Feb 2008 15:58:13 +0000
Message-ID: <20080221155813.GA9601@srcf.ucam.org>
References: <1203471860.3358.177.camel@linux-2bdv.site> <200802210341.13809.lenb@kernel.org> <200802211641.22920.trenn@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cavan.codon.org.uk ([78.32.9.130]:54617 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933571AbYBUP6e (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 21 Feb 2008 10:58:34 -0500
Content-Disposition: inline
In-Reply-To: <200802211641.22920.trenn@suse.de>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Renninger <trenn@suse.de>
Cc: Len Brown <lenb@kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Theodore Tso <tytso@mit.edu>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Starikovskiy, Alexey Y" <aystarik@gmail.com>

On Thu, Feb 21, 2008 at 04:41:21PM +0100, Thomas Renninger wrote:

> The bug is rather complicated to fix/workaround through the OS (E.g. suspend 
> reordering, AML bug, you simply misread the ACPI spec and it did work for 
> Windows (the ACPI kernel maintainer likes to add the "compatibility" hack, 
> but it's just too intrusive to backport into your stable kernel release you 
> support), ...). But a modification in the DSDT is a one-liner and an obvious 
> fix.
> You desperately search for a flag to be able to make sure you do not risk to 
> break Windows...
> Now they have to ignore the bug. Bad for the vendor, bad for the customer, bad 
> for us (yet another complex "Windows compatibility" hack).

And then later we fix the bug and the Linux workaround starts breaking 
things. The vendor is unhappy. You can't even just key it off kernel 
versions, since distributions will backport arbitrarily large chunks of 
code (and if you doubt this, take a look at the sata tree in the RHEL 
kernel some time). 

> A general Linux flag is the way to start, everything more specific will/can 
> get embedded into this flag later if it makes sense (without any risk for the 
> vendors to break Windows). There are (I expect most) cases where embedding 
> stuff into if(linux) makes a lot sense. But Henrique and others are probably 
> right that we need something more fine grained later (in rare cases, e.g. the 
> in-kernel graphics driver issues).

There's no flag we can provide to indicate a desire for graphics 
POSTing. If vendors want to offer that, then they should provide an 
entry point that triggers it and a kernel driver that calls it. The 
policy for deciding whether or not to do this is far more complex than 
can be provided in-kernel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

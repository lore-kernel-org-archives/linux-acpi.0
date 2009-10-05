From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [git pull request] ACPI Processor Aggregator Driver for
 2.6.32-rc1
Date: Mon, 5 Oct 2009 15:40:21 -0700
Message-ID: <20091005154021.129a8f9f.akpm@linux-foundation.org>
References: <alpine.LFD.2.00.0910030145140.25240@localhost.localdomain>
	<20091005033256.GA26592@balbir.in.ibm.com>
	<200910052159.24920.rjw@sisk.pl>
	<20091005140415.57f1db5e.akpm@linux-foundation.org>
	<alpine.LFD.2.00.0910051818130.32307@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:50078 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753963AbZJEWmT (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 18:42:19 -0400
In-Reply-To: <alpine.LFD.2.00.0910051818130.32307@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: rjw@sisk.pl, balbir@linux.vnet.ibm.com, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, a.p.zijlstra@chello.nl, shaohua.li@intel.com, svaidy@linux.vnet.ibm.com

On Mon, 05 Oct 2009 18:20:44 -0400 (EDT)
Len Brown <lenb@kernel.org> wrote:

> > Technical question: the overall feature, which I'd describe as
> > "shutting down CPUs when an external agent tells us the
> > thermal/electrical/other load is too high" is not at all specific to
> > the x86 CPU.  Should the code have been designed in such a way as to
> > permit other architectures to play?  
> 
> I agree with Peter and Vaidy that a generic capability in the Linux 
> scheduler would be wonderful.  But we don't have that today.
> 
> Re: this driver in particular...
> acpi_pad accepts an ACPI event from the platform and then
> does something with it.
> 
> Today, ACPI runs on just x86 and ia64, and I'm not aware
> of any plans to implement this particularly feature on ia64 platforms.

The sysfs handling looks generic and the driver can clearly be split
into upper and lower layers, with all the ACPI specificity in the lower
one.

One would need to poll the arch maintainers to find out whether that's
a desirable thing to attempt at the intial stage.

If it _is_ desirable then there's now a risk that the interfaces and
possibly behaviour will change in non-back-compatible ways.  Or they
will be stuck with ugly back-compatibility things

But it's all too late now, isn't it.  This is the first time that
non-linux-acpi readers knew of the existence of this driver.

From: Len Brown <lenb@kernel.org>
Subject: Re: [git pull request] ACPI Processor Aggregator Driver for 2.6.32-rc1
Date: Mon, 05 Oct 2009 21:28:18 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0910052054540.309@localhost.localdomain>
References: <alpine.LFD.2.00.0910030145140.25240@localhost.localdomain>
 <20091005033256.GA26592@balbir.in.ibm.com> <200910052159.24920.rjw@sisk.pl>
 <20091005140415.57f1db5e.akpm@linux-foundation.org>
 <alpine.LFD.2.00.0910051818130.32307@localhost.localdomain>
 <20091005154021.129a8f9f.akpm@linux-foundation.org>
 <alpine.LFD.2.01.0910051614510.3432@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from vms173007pub.verizon.net ([206.46.173.7]:25139 "EHLO
	vms173007pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755657AbZJFB3T (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 5 Oct 2009 21:29:19 -0400
In-reply-to: <alpine.LFD.2.01.0910051614510.3432@localhost.localdomain>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, rjw@sisk.pl, balbir@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, a.p.zijlstra@chello.nl, shaohua.li@intel.com, svaidy@linux.vnet.ibm.com

> ...  we probably never want to even try 
> to solve it in the scheduler, because why the hell should we care and add 
> complex logic for something like that?

Today we take cores down to 100% idle, one at a time.
This is useful, but isn't the best we can do.

For we get zero "uncore" power savings.
As long as at least one core is active anywhere in the system,
all the uncores in all the packages in the system must remain active.

What a scheduler-based solution could do is
instead of taking, say, 1 of 64 cores down for 100%
of the period, it could take all 64 cores down
for 64th of the same period.  This could get the hardware
into the deeper "package C-states", for a measurable
net power savings.

At the same time, this system-wide throttling may mitigate
some of the fairness/availability issues raised regarding
taking cores 100% off-line.

But doing this optimally will not be trivial.
The hardware must stay in the deep-sleep-states long enough
to make it worth the energy to enter and exit those states.
The hardware will flush the caches, having a performance
impact on all the cores.  Device interrupts would prevent
the cores from sleeping, so they'd need to be somehow delayed
if we are to sleep long enough to make sleeping worth it etc.

cheers,
-Len Brown, Intel Open Source Technology Center


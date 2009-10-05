From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [git pull request] ACPI Processor Aggregator Driver for 2.6.32-rc1
Date: Mon, 5 Oct 2009 21:59:24 +0200
Message-ID: <200910052159.24920.rjw@sisk.pl>
References: <alpine.LFD.2.00.0910030145140.25240@localhost.localdomain> <20091005033256.GA26592@balbir.in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([217.79.144.158]:48659 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752213AbZJET6y (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 5 Oct 2009 15:58:54 -0400
In-Reply-To: <20091005033256.GA26592@balbir.in.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: balbir@linux.vnet.ibm.com
Cc: Len Brown <lenb@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Peter Zijlstra <a.p.zijlstra@chello.nl>, Shaohua Li <shaohua.li@intel.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>

On Monday 05 October 2009, Balbir Singh wrote:
> * Len Brown <lenb@kernel.org> [2009-10-03 01:56:32]:
> 
> >     This driver does not use the kernel's CPU hot-plug mechanism
> >     because after the transient emergency is over, the system must
> >     be returned to its normal state, and hotplug would permanently
> >     break both cpusets and binding.
> >     
> 
> Why does hotplug break cpusets and binding?
> 
> 
> >     So to force idle, the driver creates a power saving thread.
> >     The scheduler will migrate the thread to the preferred CPU.
> >     The thread has max priority and has SCHED_RR policy,
> >     so it can occupy one CPU.  To save power, the thread will
> >     invoke the deep C-state entry instructions.
> >     
> >     To avoid starvation, the thread will sleep 5% of the time
> >     time for every second (current RT scheduler has threshold
> >     to avoid starvation, but if other CPUs are idle,
> >     the CPU can borrow CPU timer from other,
> >     which makes the mechanism not work here)
> >     
> >     Vaidyanathan Srinivasan has proposed scheduler enhancements
> >     to allow injecting idle time into the system.  This driver doesn't
> >     depend on those enhancements, but could cut over to them
> >     when they are available.
> >     
> >     Peter Z. does not favor upstreaming this driver until
> >     the those scheduler enhancements are in place.  However,
> >     we favor upstreaming this driver now because it is useful
> >     now, and can be enhanced over time.
> >     
> >     Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> >     NACKed-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
> >     Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
> >     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> This is a first a patch with a NACKed-by, could we please have more
> discussion on the proposed design.

This thing has already been merged, it appears:

commit 8e0af5141ab950b78b3ebbfaded5439dcf8b3a8d
Author: Shaohua Li <shaohua.li@intel.com>
Date:   Mon Jul 27 18:11:02 2009 -0400

    ACPI: create Processor Aggregator Device driver

and it looks like a total breakage of rules to me.

Thanks,
Rafael

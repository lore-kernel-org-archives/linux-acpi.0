From: Mike Galbraith <efault@gmx.de>
Subject: Re: [Bug #15192] netperf ~50% regression with 2.6.33-rc1, bisect
 to 1b9508f
Date: Mon, 22 Feb 2010 05:59:22 +0100
Message-ID: <1266814762.6072.3.camel@marge.simson.net>
References: <vZZJKzCUn4G.A.CPB.F7hZLB@chimera>
	 <d3IDKWHT5gE.A.Z-B.V7hZLB@chimera>
	 <1265011447.6220.15.camel@marge.simson.net>
	 <1266652377.3464.6.camel@minggr.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1266652377.3464.6.camel@minggr.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Ming <ming.m.lin@intel.com>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Peter Zijlstra <peterz@infradead.org>, venkatesh.pallipadi@intel.com, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Sat, 2010-02-20 at 15:52 +0800, Lin Ming wrote:
> On Mon, 2010-02-01 at 16:04 +0800, Mike Galbraith wrote:
> > On Mon, 2010-02-01 at 01:22 +0100, Rafael J. Wysocki wrote:
> > > This message has been generated automatically as a part of a report
> > > of recent regressions.
> > > 
> > > The following bug entry is on the current list of known regressions
> > > from 2.6.32.  Please verify if it still should be listed and let me know
> > > (either way).
> > 
> > Yes, it should remain open.  We're currently waiting for some data from
> > Lin Ming.  The regression itself isn't making much sense.. a kernel with
> > NEWIDLE disabled should show the same performance, but does not.  
> 
> (sorry for late response, I'm just back from vacation)
> 
> We finally located this to a bug in mwait based C-state entry.
> Venki's patch has fixed it.
> http://patchwork.kernel.org/patch/78544/
> 
> Venki, this is the original report,
> http://marc.info/?l=linux-kernel&m=126441481427331&w=4

Excellent, mystery solved.  (adds acpi)

	-Mike

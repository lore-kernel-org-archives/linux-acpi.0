From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: acpi_ex_system_memory_space_handler oops
Date: Tue, 18 Aug 2009 15:18:35 +0800
Message-ID: <1250579915.13743.8.camel@minggr.sh.intel.com>
References: <20090812201034.GA2983@localdomain.by>
	 <1250498613.28336.68.camel@minggr.sh.intel.com>
	 <20090817113059.GA3245@localdomain.by>
	 <d3f22a0908170622x7dd9ce73m5c3ea86406cc9935@mail.gmail.com>
	 <20090818071359.GA3713@localdomain.by>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:48764 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752052AbZHRHXe (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 18 Aug 2009 03:23:34 -0400
In-Reply-To: <20090818071359.GA3713@localdomain.by>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Tue, 2009-08-18 at 15:13 +0800, Sergey Senozhatsky wrote:
> On (08/17/09 21:22), Lin Ming wrote:
> > > rc6-git2
> > > 25 successful reboots.
> > >
> > > I'll need some more time to test against rc5.
> > >
> > > /*should I also test DSDT in case region-debug.patch fixed the problem?*/
> > 
> > Yes, please also help to test the custome DSDT.
> > region-debug.patch is just a debug patch.
> > We need to root cause the problem clearly and then work out a clean solution.
> > 
> 
> Hi, Lin
> Looks like DSDT didn't solve the problem (oops on 4th reboot).
> 
> So:
> region-debug.patch	+
> DSDT			-
> 
> /* Is that possible? */

Yes, that is possible. 
The same aml method is re-entered when interpreter lock is released.
So you still see AE_ALREADY_EXISTS error with the custom DSDT, right?

Thanks for the info, I'll continue to look at this issue.
And would you please test the region-debug.patch multiple times to
verify if it really fixes the bug?

Thanks,
Lin Ming


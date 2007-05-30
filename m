From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: (Intel Core 2 Duo 2.4gig 4meg cache + Intel S3000AH + Linux) -
	ACPI kernel option = 1 core?
Date: Wed, 30 May 2007 09:10:28 +0800
Message-ID: <1180487428.3311.1.camel@sli10-conroe.sh.intel.com>
References: <FC1D1B23302A22499C60C967336B2AE0014B6159@pdsmsx411.ccr.corp.intel.com>
	 <465BFEA4.1010307@netwaynetworks.com.au>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:5774 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbXE3BOd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 29 May 2007 21:14:33 -0400
In-Reply-To: <465BFEA4.1010307@netwaynetworks.com.au>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Steven Evans <steve@netwaynetworks.com.au>
Cc: linux-acpi@vger.kernel.org

On Tue, 2007-05-29 at 20:21 +1000, Steven Evans wrote:
> Li, Shaohua wrote: 
> >   
> > > -----Original Message-----
> > > From: linux-acpi-owner@vger.kernel.org [mailto:linux-acpi-
> > > owner@vger.kernel.org] On Behalf Of Steve Evans
> > > Sent: Tuesday, May 29, 2007 9:16 AM
> > > To: linux-acpi@vger.kernel.org
> > > Subject: (Intel Core 2 Duo 2.4gig 4meg cache + Intel S3000AH + Linux) -
> > > ACPI kernel option = 1 core?
> > > 
> > > Hey guys
> > > 
> > > I've been configuring up a Linux 2.6.21.1 kernel from Linus' trusty
> > > kernel.org.
> > > 
> > > I configured it up and built it and noticed that the dual core CPU I
> > >     
> > was
> >   
> > > using is now a single core chip.
> > > 
> > > I've spent alittle time on this problem and think I found out how to
> > > enable or disable the single core.  My base config is:
> > > - Processor - SMP On
> > > - Processor - SMT/Hyperthreading scheduler On
> > > - Processor - Multicore scheduler On
> > > - Processor - Optimize for any CPU type (ie P4, Core2, i586) or base
> > > system (ie BigSMB/summit or PC-compatible)
> > > - Power management support On
> > > - All other power management pieces turned off
> > > - All other options are set standard by 'make mrproper'
> > > 
> > > I compile the kernel with ACPI off and I get 1 cpu/cpu-core.
> > > 
> > > I then recompile with just the ACPI turned on (ie havn't turned on
> > > Processor, Fan or any other modules there) and I get to see my second
> > >     
> > core.
> >   
> > > This server will be well ventilated and will be running multiple VM's.
> > > To guarantee performance I'd like to have ACPI turned off.
> > > 
> > > I can also say that this bug seems to be present in 2.6.18 as well.
> > > 
> > > So I guess my question is, has this issue been fixed?  Or how can I
> > >     
> > help
> >   
> > > to fix it?
> > > 
> > >     
> > Boot option 'acpi=ht'
> > 
> >   
> Hi,
> 
> Thanks for that.  I found that I needed the "irqpoll" option there as
> well to get the SATA working.
> 
> Is there anything else I need to know to ensure it will remain fast
> and stable?
Looks no option just use ACPI as MP detect and irq routing. But why do
you want to disable ACPI? Just cpufreq governor 'performance', which
should not harm performance.

Thanks,
Shaohua

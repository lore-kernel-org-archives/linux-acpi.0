From: Zhao Yakui <yakui.zhao@intel.com>
Subject: Re: [PATCH 5/5] ACPI: Update the t-state for every affected cpu
	when t-state is changed
Date: Sat, 02 Feb 2008 18:10:14 +0800
Message-ID: <1201947014.22650.44.camel@yakui_zhao.sh.intel.com>
References: <1201499756.17068.27.camel@yakui_zhao.sh.intel.com>
	 <200802020239.42963.lenb@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:41031 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760934AbYBBK11 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 05:27:27 -0500
In-Reply-To: <200802020239.42963.lenb@kernel.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi@vger.kernel.org

On Sat, 2008-02-02 at 02:39 -0500, Len Brown wrote:
> On Monday 28 January 2008 00:55, Zhao Yakui wrote:
> > Subject: ACPI : Update the t-state for every affected cpu when t-state is changed
> > >From : Zhao Yakui <yakui.zhao@intel.com>
> > 
> > According to ACPI spec, the _TSD object provides T-state control cross
> > logical processor dependency information to OSPM. So the t-state
> > coordination should be considered when T-state for one cpu is changed.
> > 
> > According to ACPI spec, three types of coordination are defined.
> > SW_ALL, SW_ANY and HW_ALL.
> 
> > SW_ALL: it means that OSPM needs to initiate T-state transition on 
> > all processors in the domain. It is necessary to call throttling set function
> > for all affected cpus.
> 
> > SW_ANY: it means that OSPM may initiate T-state transition on any processor in 
> > the domain. 
> 
> > HW_ALL: Apec only says that hardware will perform the coordination and doesn't 
> > recommend how OSPM coordinate T-state among the affected cpus. So it is treated
> > as the type of SW_ALL. It means that OSPM needs to initiate t-state transition
> > on all the processors in the domain.
> 
> Not really. HW_ALL means that the OS can assume that the CPUs are independent,
> and hardware will take care of any coordination needed. 
 Hardware will be responsible for coordinating the state transition
between multiple processors. But hardware should provide OSPM with a
means to determine the actual state residency so that the correct state
is entered. 
> 
> ie. the OS should implement throttling changes on each CPU depending
> only on that CPU's needs and not need to consider any effects on other CPUs.
> 
> This is not the same as SW_ALL, which tells us that all the CPUS in a domain
> are _dependent_, and the OS must enforce that by writing the _same_ value
> to each CPU. 
> 
> say you have a domain with 2 CPUS.
> If it is HW_ALL and you throttle one cpu, then you are done. 
   In this case , how to update the state of another cpu? Can it be
treated as SW_ANY?  
> if it is SW_ALL then if you want to throttle one cpu, then you must
> also throttle the other. 
   I agree. It is necessary to initiate the state transition for every
affected cpu. 
> 
> -Len


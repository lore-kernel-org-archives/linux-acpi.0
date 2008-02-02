From: Len Brown <lenb@kernel.org>
Subject: Re: [PATCH 5/5] ACPI: Update the t-state for every affected cpu when t-state is changed
Date: Sat, 2 Feb 2008 02:39:42 -0500
Message-ID: <200802020239.42963.lenb@kernel.org>
References: <1201499756.17068.27.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:35006 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755675AbYBBHj4 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 2 Feb 2008 02:39:56 -0500
In-Reply-To: <1201499756.17068.27.camel@yakui_zhao.sh.intel.com>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Zhao Yakui <yakui.zhao@intel.com>
Cc: linux-acpi@vger.kernel.org

On Monday 28 January 2008 00:55, Zhao Yakui wrote:
> Subject: ACPI : Update the t-state for every affected cpu when t-state is changed
> >From : Zhao Yakui <yakui.zhao@intel.com>
> 
> According to ACPI spec, the _TSD object provides T-state control cross
> logical processor dependency information to OSPM. So the t-state
> coordination should be considered when T-state for one cpu is changed.
> 
> According to ACPI spec, three types of coordination are defined.
> SW_ALL, SW_ANY and HW_ALL.

> SW_ALL: it means that OSPM needs to initiate T-state transition on 
> all processors in the domain. It is necessary to call throttling set function
> for all affected cpus.

> SW_ANY: it means that OSPM may initiate T-state transition on any processor in 
> the domain. 

> HW_ALL: Apec only says that hardware will perform the coordination and doesn't 
> recommend how OSPM coordinate T-state among the affected cpus. So it is treated
> as the type of SW_ALL. It means that OSPM needs to initiate t-state transition
> on all the processors in the domain.

Not really. HW_ALL means that the OS can assume that the CPUs are independent,
and hardware will take care of any coordination needed.

ie. the OS should implement throttling changes on each CPU depending
only on that CPU's needs and not need to consider any effects on other CPUs.

This is not the same as SW_ALL, which tells us that all the CPUS in a domain
are _dependent_, and the OS must enforce that by writing the _same_ value
to each CPU.

say you have a domain with 2 CPUS.
If it is HW_ALL and you throttle one cpu, then you are done.
if it is SW_ALL then if you want to throttle one cpu, then you must
also throttle the other.

-Len

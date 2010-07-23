From: ykzhao <yakui.zhao@intel.com>
Subject: Re: [RFC] - Mapping ACPI tables as CACHED
Date: Fri, 23 Jul 2010 22:26:05 +0800
Message-ID: <1279895165.13929.61.camel@localhost.localdomain>
References: <20100722152220.GA18290@sgi.com>
	 <1279849573.13929.28.camel@localhost.localdomain>
	 <20100723072301.GC23461@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:37686 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760146Ab0GWO3v (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 23 Jul 2010 10:29:51 -0400
In-Reply-To: <20100723072301.GC23461@elte.hu>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
Cc: Jack Steiner <steiner@sgi.com>, "tglx@linutronix.de" <tglx@linutronix.de>, "lenb@kernel.org" <lenb@kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Linus Torvalds <torvalds@linux-foundation.org>

On Fri, 2010-07-23 at 15:23 +0800, Ingo Molnar wrote:
> * ykzhao <yakui.zhao@intel.com> wrote:
> 
> > From the above description maybe the E820_ACPI region can be mapped as 
> > cached. But this still depends on the BIOS. If the some shared data resides 
> > in the E820_ACPI region on some BIOS, maybe we can't map the E820_ACPI 
> > region as cached again.
> 
> I dont think we can do this safely unless some other OS (Windows) does it as 
> well. (the reason is that if some BIOS messes this up then it will cause nasty 
> bugs/problems only on Linux.)
> 

Yes. We can't map the corresponding ACPI region as cached under the
following case:
    >No E820_ACPI region is reported by BIOS. In such case the ACPI
table resides in the NVS region     

But if the BIOS can follow the spec and report the separated
E820_ACPI/E820_NVS region, maybe we can give a try to map the E820_ACPI
region as cached type. For example: the server machine.(The spec
describes the E820_ACPI region as reclaimed memory, which means that it
can be managed by OS after ACPI table is loaded).

Can we add a boot option to control whether the E820_ACPI region can be
mapped as cached type?

> But the benefits of caching are very clear and well measured by Jack, so we 
> want the feature. What we can do is to add an exception for 'known good' hw 
> vendors - i.e. something quite close to Jack's RFC patch, but implemented a 
> bit more cleanly:
> 
> Exposing x86_platform and e820 details to generic ACPI code isnt particularly 
> clean - there should be an ACPI accessor function for that or so: a new 
> acpi_table_can_be_cached(table) function or so.

Agree. The function of acpi_os_map_memory will also be used on IA64
platform. It seems more reasonable to use a wrapper function to check
whether the corresponding region can be mapped as cached type. 
> 
> In fact since __acpi_map_table(addr,size) is defined by architectures already, 
> this could be done purely within x86 code.
> 
> Thanks,
> 
> 	Ingo


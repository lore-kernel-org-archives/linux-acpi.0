From: "Liu, Jinsong" <jinsong.liu@intel.com>
Subject: RE: [Xen-devel] [PATCH 1/2] RFC: Prepare PAD for native and	xen
 platform
Date: Thu, 5 Apr 2012 13:01:45 +0000
Message-ID: <DE8DF0795D48FD4CA783C40EC82923351241B0@SHSMSX101.ccr.corp.intel.com>
References: <DE8DF0795D48FD4CA783C40EC82923350AD088@SHSMSX101.ccr.corp.intel.com>
 <4F46530B020000780007F751@nat28.tlf.novell.com>
 <DE8DF0795D48FD4CA783C40EC82923350AD9BB@SHSMSX101.ccr.corp.intel.com>
 <DE8DF0795D48FD4CA783C40EC82923350B2013@SHSMSX101.ccr.corp.intel.com>
 <20120226173458.GB18098@phenom.dumpdata.com>
 <DE8DF0795D48FD4CA783C40EC82923350B9496@SHSMSX101.ccr.corp.intel.com>
 <DE8DF0795D48FD4CA783C40EC82923350BAC09@SHSMSX101.ccr.corp.intel.com>
 <DE8DF0795D48FD4CA783C40EC8292335105EFA@SHSMSX101.ccr.corp.intel.com>
 <20120326164835.GE10236@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:7646 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751840Ab2DENBt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 5 Apr 2012 09:01:49 -0400
In-Reply-To: <20120326164835.GE10236@phenom.dumpdata.com>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Brown, Len" <len.brown@intel.com>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "keir.xen@gmail.com" <keir.xen@gmail.com>, Jan Beulich <jbeulich@suse.com>, "Li, Shaohua" <shaohua.li@intel.com>, "lenb@kernel.org" <lenb@kernel.org>

Konrad Rzeszutek Wilk wrote:
>>> Compare approaches:
>>> 
>>> 1. xen overwritten approach (patches V2, x86_init, osl approach)   
>>>         Pros: a little simpler code
>>>     Cons:
>>>         1). specific to xen, cannot extend to other virt platform;
>>>         2). need to change natvie acpi_pad as modular;
>>> 
>>> 2. paravirt interface approach (original patches V1)     Pros:
>>>         1). standard hypervisor-agnostic interface (USENIX
>>>         conference 2006), can easily hook to Xen/lguest/... on
>>>         demand; 2). arch independent; 3). no need to change native
>>>         acpi_pad as     non-modular; Cons: a little complicated
>>> code, and code patching is some 
>>> overkilled for this case (but no harm);
>>> 
>>> (BTW, in the future we need add more and more pv ops, like
>>> pv_pm_ops, pv_cpu_hotplug_ops, pv_mem_hotplug_ops, etc. So how
>>> about add a pv_misc_ops template to handle them all? seems it's a
>>> common issue). 
>>> 
> 
> I think (and you probabaly have a better idea) is that the maintainer
> of drivers/acpi/* is not very open to adding in code that only
> benefits Xen. 
> 
> If it benefits other architectures (say ARM) then adding in hooks
> there (in osl for example) makes sense - but I am not sure if ARM has
> a form 
> of _PUR code/calls it needs to do.
> 
> So with that in mind, neither of those options seems proper - as all
> of them depend on changing something in drivers/acpi/*.
> 
> I've one or two suggestions of what could be done to still make this
> work, but I need you to first see what happens if the native acpi_pad
> runs under Xen with the latest upstream code (along with three patches
> that are in a BZ I pointed you too).

Konrad, any new idea? seems we hardly totally walk around acpi staff. Thanks, Jinsong
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: Regression in 3.1 causes Xen to use wrong idle
 routine
Date: Mon, 14 Nov 2011 13:26:56 -0500
Message-ID: <20111114182656.GB14966@phenom.dumpdata.com>
References: <4EA7DFD1.9060608@canonical.com>
 <CAJvTdK=yAek4sJFXUp=kQSmnuE=HpgefN5Q-GLWhMXo=LhJ-2A@mail.gmail.com>
 <20111114143123.GA8317@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:34129 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751010Ab1KNS1L (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 14 Nov 2011 13:27:11 -0500
Content-Disposition: inline
In-Reply-To: <20111114143123.GA8317@phenom.dumpdata.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, pradeepv@amazon.com
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "xen-devel@lists.xensource.com" <xen-devel@lists.xensource.com>, Stefan Bader <stefan.bader@canonical.com>

On Mon, Nov 14, 2011 at 09:31:24AM -0500, Konrad Rzeszutek Wilk wrote:
> Hey Len,
> 
> > > The problem I see is that select_idle_routine() is called from
> > > arch/x86/kernel/cpu/common.c and since Xen setup does not set pm_idle
> > > anymore, it can cause mwait_idle or amd_e400_idle functions to be selected.
> > > In testing it seem amd_e400_idle in PVM domU at least does not immediately cause
> > > problems, but mwait_idle just causes crashes. From the reports I have
> > > this may be related to older hypervisors (3.1 and older) not clearing the mwait
> > > capability. But overall there seems something wrong in the interaction.
> > 
> > Why is Xen advertising X86_FEATURE_MWAIT and then crashing
> > when the dom0 (or other guests) use what it advertises?
> 
> The only case where I've seen this is with Amazon EC2. The other
> newer hypervisors (4.1.1 and such) do not trigger this.
> 
> > 
> > What versions of Xen have this bug?
> 
> Whatever Amazon is using. I think they are RHEL5 based hypervisor.

Vincent,

Would you have ideas of what might be happening? It looks as if some Amazon
instances are advertisting the MWAIT flag but not really supporting it. Any ideas
of what might be going on?

> 
> > 
> > > I am not really sure whether the logic of calling pm_idle() on all errors from
> > > cpuidle_call_idle() is already flawed or the assumption in the Xen patch about
> > > being able to prevent the wrong idle function by turning cpuidle off is incorrect.
> > 
> > The patches above appear to be operating as intended.
> > What wasn't expected, was that some version of Xen is deployed that
> > advertises the MWAIT feature, but crashes when it is used.
> 
> How does that work with AMD? On those machines it ends up calling
> amd_e400_idle instead of the default_idle. Granted it does not "BUG" out
> but it does lead to extra trap-n-emulate (the MSR operation) in to the hypervisor
> which is not good.

.. snip..
> > Working around this Xen bug for a newly compiled Dom0 is insufficient.

It looks to affect PV guests as well.

> > 
> > All guests that also look for MWAIT support w/o asking ACPI
> > (ie. all versions of Linux that use intel_idle, such as the last few
> > Fedora's, RHEL, SLES etc.)
> > will trip over the same Xen bug, even if Dom0 doesn't.

Don't think I answered this one: 

The intel_idle has not been used in those cases b/c the default_idle
had been used instead.

> > 
> > Xen must not advertises MWAIT support if it doesn't have MWAIT support.
> 
> How does work out when we figure MWAIT support from the CPUID?
> Or are you saying that it is correct - if the CPU advertises it, then yes
> advertise it to the Linux kernel?
> 
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xensource.com
> http://lists.xensource.com/xen-devel

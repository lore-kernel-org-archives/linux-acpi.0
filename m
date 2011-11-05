From: Lin Ming <ming.m.lin@intel.com>
Subject: Re: [PATCH -v1] acpi: Fix possible recursive locking in hwregs.c
Date: Sat, 05 Nov 2011 22:50:48 +0800
Message-ID: <1320504648.4941.7.camel@hp6530s>
References: <1320317323.5711.5.camel@localhost.localdomain>
	 <1320321770.2813.10.camel@hp6530s>	<4EB2D225.60808@linux.vnet.ibm.com>
	 <CADZ9YHiht68YLz5eWc0xc8R3bxLrgdf4sxgLBwODiKoLQLU7FQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:33903 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751311Ab1KEOv6 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 5 Nov 2011 10:51:58 -0400
In-Reply-To: <CADZ9YHiht68YLz5eWc0xc8R3bxLrgdf4sxgLBwODiKoLQLU7FQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Rakib Mullick <rakib.mullick@gmail.com>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Brown, Len" <len.brown@intel.com>, "Moore, Robert" <robert.moore@intel.com>

On Fri, 2011-11-04 at 13:53 +0800, Rakib Mullick wrote:
> On Thu, Nov 3, 2011 at 11:40 PM, Srivatsa S. Bhat
> <srivatsa.bhat@linux.vnet.ibm.com> wrote:
> > Hi,
> >
> > On 11/03/2011 05:32 PM, Lin Ming wrote:
> >> On Thu, 2011-11-03 at 18:48 +0800, Rakib Mullick wrote:
> >>> Calling pm-suspend might trigger a recursive lock in it's code path. In function acpi_hw_clear_acpi_status,
> >>
> >> As I replied at https://lkml.org/lkml/2011/9/22/6, I still don't think
> >> there is a recursive lock.
> >>
> >
> > At first look, it definitely doesn't look like a recursive lock, as Lin said.
> > But, quoting Documentation/lockdep-design.txt:
> >
> > "Multi-lock dependency rules:
> > ----------------------------
> >
> > The same lock-class must not be acquired twice, because this could lead
> > to lock recursion deadlocks."
> >
> > So, Rakib, do the 2 locks belong to the same lock-class? If yes, then I think
> > that is the reason for the lockdep splat. Could you show the lockdep warning?
> >
> Yes, same lock-class. And as per "Multi-lock dependency rules:", it
> leads to lock recursion deadlocks.
> Lockdep warning attached.
> 
> > By the way, another way to look at this patch is as an optimization..
> > i.e., if acpi_gbl_hardware_lock doesn't need to be held to call
> > acpi_ev_walk_gpe_list(), then we can move from the coarse-grained locking
> > to finer-grained locking by releasing it earlier, as you did in your patch.
> > [Note that you will have to update the goto label also, i.e., rename it as
> > 'exit' or something like that]
> >
> I can do it, thanks for suggestions. But, what does Lin thinks? Lin
> are you okay?

I'm OK.

We need to figure out why the dead lock happens.
Could you also paste the patch which trigger this dead lock?

Thanks,
Lin Ming

> 
> Thanks,
> Rakib



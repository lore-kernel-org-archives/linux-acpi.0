From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH -v3 3/4] lib, Make gen_pool memory allocator lockless
Date: Fri, 15 Apr 2011 12:46:29 -0400
Message-ID: <20110415164629.GA13983@Krystal>
References: <1302684835-14133-1-git-send-email-ying.huang@intel.com> <1302684835-14133-4-git-send-email-ying.huang@intel.com> <20110413210757.GA11683@Krystal> <4DA7903B.5030508@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:50726 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753341Ab1DOQqi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Fri, 15 Apr 2011 12:46:38 -0400
Content-Disposition: inline
In-Reply-To: <4DA7903B.5030508@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>, "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

* Huang Ying (ying.huang@intel.com) wrote:
> On 04/14/2011 05:07 AM, Mathieu Desnoyers wrote:
> > * Huang Ying (ying.huang@intel.com) wrote:
> > [...]
> >> + * rcu_read_lock and rcu_read_unlock is not used int gen_pool_alloc,
> >> + * gen_pool_free, gen_pool_avail and gen_pool_size etc, because chunks
> >> + * are only added into pool, not deleted from pool unless the pool
> >> + * itself is destroyed.  If chunk will be deleted from pool,
> >> + * rcu_read_lock and rcu_read_unlock should be uses in these
> >> + * functions.
> > 
> > So how do you protect between pool destruction and adding chunks into
> > the pool ?
> 
> Because the pool itself will be freed when destruction, we need some
> mechanism outside of pool.  For example, if gen_pool_add() is called via
> device file IOCTL, we must un-register the device file first, and
> destroy the pool after the last reference to device has gone.

I am concerned about the list_for_each_entry_rcu() (and thus
rcu_dereference_raw()) used outside of rcu_read_lock/unlock pairs.
Validation infrastructure as recently been added to RCU: it triggers
warnings when these situations are encountered in some RCU debugging
configurations. The case of RCU list iteration is not covered by the
checks, but it would make sense to be aware of it.

So although it seems like your code does not require rcu read lock
critical sections, I'd prefer to let Paul McKenney have a look.

Thanks,

Mathieu

> 
> Best Regards,
> Huang Ying

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com

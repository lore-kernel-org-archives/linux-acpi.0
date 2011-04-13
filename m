From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: [PATCH -v3 3/4] lib, Make gen_pool memory allocator lockless
Date: Wed, 13 Apr 2011 17:07:57 -0400
Message-ID: <20110413210757.GA11683@Krystal>
References: <1302684835-14133-1-git-send-email-ying.huang@intel.com> <1302684835-14133-4-git-send-email-ying.huang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.openrapids.net ([64.15.138.104]:47508 "EHLO
	blackscsi.openrapids.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757779Ab1DMVH7 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Wed, 13 Apr 2011 17:07:59 -0400
Content-Disposition: inline
In-Reply-To: <1302684835-14133-4-git-send-email-ying.huang@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>

* Huang Ying (ying.huang@intel.com) wrote:
[...]
> + * rcu_read_lock and rcu_read_unlock is not used int gen_pool_alloc,
> + * gen_pool_free, gen_pool_avail and gen_pool_size etc, because chunks
> + * are only added into pool, not deleted from pool unless the pool
> + * itself is destroyed.  If chunk will be deleted from pool,
> + * rcu_read_lock and rcu_read_unlock should be uses in these
> + * functions.

So how do you protect between pool destruction and adding chunks into
the pool ?

Thanks,

Mathieu

-- 
Mathieu Desnoyers
Operating System Efficiency R&D Consultant
EfficiOS Inc.
http://www.efficios.com

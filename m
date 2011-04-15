From: Huang Ying <ying.huang@intel.com>
Subject: Re: [PATCH -v3 3/4] lib, Make gen_pool memory allocator lockless
Date: Fri, 15 Apr 2011 08:24:27 +0800
Message-ID: <4DA7903B.5030508@intel.com>
References: <1302684835-14133-1-git-send-email-ying.huang@intel.com> <1302684835-14133-4-git-send-email-ying.huang@intel.com> <20110413210757.GA11683@Krystal>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:42037 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754749Ab1DOAYa (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 14 Apr 2011 20:24:30 -0400
In-Reply-To: <20110413210757.GA11683@Krystal>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "Luck, Tony" <tony.luck@intel.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>

On 04/14/2011 05:07 AM, Mathieu Desnoyers wrote:
> * Huang Ying (ying.huang@intel.com) wrote:
> [...]
>> + * rcu_read_lock and rcu_read_unlock is not used int gen_pool_alloc,
>> + * gen_pool_free, gen_pool_avail and gen_pool_size etc, because chunks
>> + * are only added into pool, not deleted from pool unless the pool
>> + * itself is destroyed.  If chunk will be deleted from pool,
>> + * rcu_read_lock and rcu_read_unlock should be uses in these
>> + * functions.
> 
> So how do you protect between pool destruction and adding chunks into
> the pool ?

Because the pool itself will be freed when destruction, we need some
mechanism outside of pool.  For example, if gen_pool_add() is called via
device file IOCTL, we must un-register the device file first, and
destroy the pool after the last reference to device has gone.

Best Regards,
Huang Ying

From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v5 0/3] Lockless memory allocator and list
Date: Fri, 19 Nov 2010 10:02:11 +0800
Message-ID: <1290132134-21217-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:63005 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754860Ab0KSCDO (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 18 Nov 2010 21:03:14 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

This patchset adds a lockless memory allocator and a lock-less
list.

v5:

- Add ARCH_HAVE_NMI_SAFE_CMPXCHG
- Add spin_trylock_irqsave based fallback in lockless memory allocator
  if ARCH_HAVE_NMI_SAFE_CMPXCHG=n
- Make lockless list depends on ARCH_HAVE_NMI_SAFE_CMPXCHG

v4:

- Split from APEI patchset
- Update patch description and comments according to ML comments

v3:

- Rework lockless memory allocator and list according to ML comments

[PATCH -v5 1/3] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
[PATCH -v5 2/3] lib, Make gen_pool memory allocator lockless
[PATCH -v5 3/3] lib, Add lock-less NULL terminated single list

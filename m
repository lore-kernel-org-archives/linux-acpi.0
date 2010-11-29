From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v6 0/3] Lockless memory allocator and list
Date: Mon, 29 Nov 2010 15:03:18 +0800
Message-ID: <1291014201-15513-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52747 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751275Ab0K2HD1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Nov 2010 02:03:27 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

This patchset adds a lockless memory allocator and a lock-less
list.

v6:

- Revise ARCH_HAVE_NMI_SAFE_CMPXCHG definition for some architectures
  according to architecture maitainers' comments.

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

[PATCH -v6 1/3] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
[PATCH -v6 2/3] lib, Make gen_pool memory allocator lockless
[PATCH -v6 3/3] lib, Add lock-less NULL terminated single list

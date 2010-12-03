From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v7 0/3] Lockless memory allocator and list
Date: Fri,  3 Dec 2010 10:46:55 +0800
Message-ID: <1291344418-25206-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-acpi@vger.kernel.org

This patchset adds a lockless memory allocator and a lock-less
list.

v7:

- Revise ARCH_HAVE_NMI_SAFE_CMPXCHG definition for some architectures
  according to architecture maitainers' comments.
- Remove spin_trylock_irqsave based fallback for lockless memory allocator,
  because it does not work for !CONFIG_SMP and is not likely to be used.
- Make lockless memory allocator and list does not depend on
  ARCH_HAVE_NMI_SAFE_CMPXCHG.  Instead, require the user to depend on it
  when needed. And BUG_ON(in_nmi()) is added in necessary place to prevent
  silent race.

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

[PATCH -v7 1/3] Add Kconfig option ARCH_HAVE_NMI_SAFE_CMPXCHG
[PATCH -v7 2/3] lib, Make gen_pool memory allocator lockless
[PATCH -v7 3/3] lib, Add lock-less NULL terminated single list

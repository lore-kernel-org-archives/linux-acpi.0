From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v4 0/2] Lockless memory allocator and list
Date: Tue, 16 Nov 2010 08:53:09 +0800
Message-ID: <1289868791-16658-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:40415 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752826Ab0KPAxv (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 15 Nov 2010 19:53:51 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Peter Zijlstra <peterz@infradead.org>

Hi, Len,

This patchset is needed by APEI support. Which involves some lockless
operations. And I think they can be used by some other part of kernel
too.

v4:

- Split from APEI patchset
- Update patch description and comments according to ML comments

v3:

- Rework lockless memory allocator and list according to ML comments

[PATCH -v4 1/2] lib, Make gen_pool memory allocator lockless
[PATCH -v4 2/2] lib, Add lock-less NULL terminated single list

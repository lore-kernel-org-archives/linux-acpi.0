From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v4 1/2] lib, Make gen_pool memory allocator lockless
Date: Wed, 17 Nov 2010 11:49:43 +0100
Message-ID: <1289990983.2109.678.camel@laptop>
References: <1289868791-16658-1-git-send-email-ying.huang@intel.com>
	 <1289868791-16658-2-git-send-email-ying.huang@intel.com>
	 <20101116135038.fcaa90ca.akpm@linux-foundation.org>
	 <1289960281.8719.1218.camel@yhuang-dev>
	 <20101116183506.41e77e1a.akpm@linux-foundation.org>
	 <1289963005.8719.1238.camel@yhuang-dev>
	 <20101116195720.23287038.akpm@linux-foundation.org>
	 <1289973914.8719.1261.camel@yhuang-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canuck.infradead.org ([134.117.69.58]:55280 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756319Ab0KQKtq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Nov 2010 05:49:46 -0500
In-Reply-To: <1289973914.8719.1261.camel@yhuang-dev>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Huang Ying <ying.huang@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Steven Rostedt <rostedt@goodmis.org>

On Wed, 2010-11-17 at 14:05 +0800, Huang Ying wrote:
> Hi, Peter,
> 
> Do you think think irq_work should depend on that?  Or we just
> reimplement irq_work based on lockless list and make irq_work depends on
> lockless list? 

If you can make it use a lockless list thing that's fine.

I'm not sure Andrew's CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG makes much sense
for CONFIG_ARCH_HAVE_NMI=n though..

Anyway, make sure to consolidate net/rds/xlist.h and its users, having
two lockless lists is one too many.

> At least as the first step, I prefer to just make lockless list depend
> on CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG.

But only if the platform has NMIs, otherwise its moot.

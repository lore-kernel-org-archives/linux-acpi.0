From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v4 1/2] lib, Make gen_pool memory allocator lockless
Date: Wed, 17 Nov 2010 12:53:16 +0100
Message-ID: <1289994796.2109.722.camel@laptop>
References: <1289868791-16658-1-git-send-email-ying.huang@intel.com>
	 <1289868791-16658-2-git-send-email-ying.huang@intel.com>
	 <20101116135038.fcaa90ca.akpm@linux-foundation.org>
	 <1289960281.8719.1218.camel@yhuang-dev> <1289990458.2109.675.camel@laptop>
	 <AANLkTi=X2noJJwJwWh30-ac76f-pN5W0cD2c9w0F1EeK@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canuck.infradead.org ([134.117.69.58]:59292 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934581Ab0KQLx2 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Nov 2010 06:53:28 -0500
In-Reply-To: <AANLkTi=X2noJJwJwWh30-ac76f-pN5W0cD2c9w0F1EeK@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: huang ying <huang.ying.caritas@gmail.com>
Cc: Huang Ying <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <lenb@kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>

On Wed, 2010-11-17 at 19:47 +0800, huang ying wrote:
> On Wed, Nov 17, 2010 at 6:40 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Wed, 2010-11-17 at 10:18 +0800, Huang Ying wrote:
> >>
> >> cmpxchg has been used in that way by ftrace and perf for a long time. So
> >> I agree to make it a requirement on future architecture ports.
> >
> > Neither mandate an architecture do this though, only that when an
> > architecture wants to support either feature and has NMIs (not all archs
> > have NMI equivalents) it has to be safe.
> 
> So we can make sure cmpxchg can be used in lock-less code on
> architectures with perf, irq_work or ftrace enabled?

It had better, otherwise stuff is broken.

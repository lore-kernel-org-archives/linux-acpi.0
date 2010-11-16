From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH -v4 0/2] Lockless memory allocator and list
Date: Tue, 16 Nov 2010 19:04:09 +0100
Message-ID: <1289930649.2109.640.camel@laptop>
References: <1289868791-16658-1-git-send-email-ying.huang@intel.com>
	 <1289908158.2109.568.camel@laptop>
	 <AANLkTime3Sh2TbgCGKir=t_TBNsd5fHipEqQwa4bVJuY@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from canuck.infradead.org ([134.117.69.58]:55594 "EHLO
	canuck.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755585Ab0KPSEM convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Nov 2010 13:04:12 -0500
In-Reply-To: <AANLkTime3Sh2TbgCGKir=t_TBNsd5fHipEqQwa4bVJuY@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Huang Ying <ying.huang@intel.com>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Chris Mason <chris.mason@oracle.com>, Jens Axboe <jaxboe@fusionio.com>

On Tue, 2010-11-16 at 08:38 -0800, Linus Torvalds wrote:
> 
> I kind of like the lock-less list implementation (it could easily be
> useful for random things, and it's very simple).

Yes, there's various implementations floating around, and we already
have one in-kernel ( net/rds/xlist.h ), mason and axboe and me have been
kicking around various patches using that thing in other circumstances
as well.

[ At some point we had perf -- what now is kernel/irq_work.c --  using
  it as well, but the new code grew too complex due to requirements
  from Huang ]

>  And I don't think the
> notion of a lockless memory allocator is wrong either, although it
> looks a lot more specialized than the list thing (the solution to
> lockless allocations is generally simply to do them ahead of time).
> 
Right, I don't generally object to lockless things, but they either need
to be 1) faster than the existing code, and/or 2) have a very convincing
use-case (other than performance) for their added complexity.

Afaict the proposed patch adds lots more LOCK'ed instructions into that
allocator path than it removes, ie its a slow down for existing users.



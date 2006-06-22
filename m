From: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.17-mm1 - possible recursive locking detected
Date: Wed, 21 Jun 2006 21:59:46 -0700
Message-ID: <20060621215946.5d27e1f1.akpm@osdl.org>
References: <CFF307C98FEABE47A452B27C06B85BB6CF0CF1@hdsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.4]:24785 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932796AbWFVFAA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 22 Jun 2006 01:00:00 -0400
In-Reply-To: <CFF307C98FEABE47A452B27C06B85BB6CF0CF1@hdsmsx411.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Brown, Len" <len.brown@intel.com>
Cc: michal.k.k.piotrowski@gmail.com, mingo@elte.hu, arjan@linux.intel.com, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, robert.moore@intel.com

On Thu, 22 Jun 2006 00:28:56 -0400
"Brown, Len" <len.brown@intel.com> wrote:

> >It looks like an ACPI problem.
> 
> Thanks for the note, and the .config, I reproduced it here.
> 
> CONFIG_LOCKDEP complains about this sequence:
> 
> ...
> 	<presumed previous acquire/release acpi_gbl_hardware_lock>
> ...
> acpi_ev_gpe_detect()
> 	spin_lock_irqsave(acpi_gbl_gpe_lock,)
> 
> 	spin_lock_irqsave(acpi_gbl_hardware_lock,) <stack trace is on
> this acquire>
> 	spin_lock_irqrestore(acpi_gbl_hardware_lock,)
> 
> 	...
> 
> 	spin_lock_irqrestore(acpi_gbl_gpe_lock)
> 
> It complains about this only the 1st time, even though
> this same code sequence runs for every (subsequent) ACPI interrupt.
> 
> The intent of the arrangement is that acpi_gbl_hardware_lock is for very
> small critical sections around RMW hardware register access.
> It can be acquired with or without other locks held, but
> nothing else is acquired when it is held.
> 
> Nothing jumps out at me as incorrect above, so 
> at this point it looks like a CONFIG_LOCKDEP artifact --
> but lets ask the experts:-)

Yes, lockdep uses the callsite of spin_lock_init() to detect the "type" of
a lock.

But the ACPI obfuscation layers use the same spin_lock_init() site to
initialise two not-the-same locks, so lockdep decides those two locks are
of the same "type" and gets confused.

We had earlier decided to remove that ACPI code which kmallocs a single
spinlock.  When that's done, lockdep will become unconfused.

AFACIT it's all used for just two statically allocated locks anwyay.

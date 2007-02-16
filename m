From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: [PATCH] i386 irq: Kill NR_IRQ_VECTORS and increase NR_IRQS
Date: Fri, 16 Feb 2007 03:33:32 -0700
Message-ID: <m1y7mye6ir.fsf@ebiederm.dsl.xmission.com>
References: <200702160015.04453.lenb@kernel.org>
	<m1mz3efn0q.fsf@ebiederm.dsl.xmission.com>
	<200702161115.59017.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751907AbXBPKgD@vger.kernel.org>
In-Reply-To: <200702161115.59017.ak@suse.de> (Andi Kleen's message of "Fri, 16
	Feb 2007 11:15:58 +0100")
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Andrew Morton <akpm@osdl.org>, Natalie Protasevich <Natalie.Protasevich@unisys.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

Andi Kleen <ak@suse.de> writes:

>> Allowing the kernel to work on big machines without complicated
>> and error prone irq remapping logic.
>
> How much memory does this use by default? If it's much there should
> be at least a CONFIG_* to make it smaller.

If you don't build a generic kernel and are not a big way smp you only
get 200 IRQs so it is less.  

Otherwise it is either 1024 or NR_CPUS*32 depending on the subarch
we compile.  The limits are actually unchanged from what we are doing
today.

I'm in the final stages of figuring out how to kill the stupid
irq_desc array which should make all the memory consumption worries
go away but that is a little ways off, and I'm putting real bug
fixes ahead of that work.

Basically this is just a back port from x86_64 without the
complication of the per cpu vector logic.  So if we run into any
issues I missed before this reaches a stable kernel we can just copy
the fix from x86_64 where we have been doing this for a while.  

So in short the existing CONFIG_ options should give us the control
we need, and before it becomes any kind of an issue I intend to
completely remove the compile time limit and make it dynamic.

Eric

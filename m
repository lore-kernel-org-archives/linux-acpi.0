From: Andi Kleen <ak@suse.de>
Subject: Re: 2.6.14-rc3-rt2
Date: Thu, 6 Oct 2005 12:04:32 +0200
Message-ID: <200510061204.33045.ak@suse.de>
References: <5bdc1c8b0510041111n188b8e14lf5a1398406d30ec4@mail.gmail.com> <20051006084920.GB22397@elte.hu> <Pine.LNX.4.58.0510060544390.28535@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750780AbVJFKET@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0510060544390.28535@localhost.localdomain>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, Mark Knecht <markknecht@gmail.com>, linux-kernel@vger.kernel.org, tony.luck@intel.com, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Thursday 06 October 2005 11:48, Steven Rostedt wrote:
> On Thu, 6 Oct 2005, Ingo Molnar wrote:
> > * Steven Rostedt <rostedt@goodmis.org> wrote:
> > > > ahh ... I would not be surprised if this caused actual problems on
> > > > x64 in the upstream kernel too: using save_flags() over u32 will
> > > > corrupt a word on the stack ...
> > >
> > > Actually, it's still safe upstream.  The locks are taken via a function
> > > defined as:
> > >
> > > unsigned long acpi_os_acquire_lock(acpi_handle handle)
> > > {
> > > 	unsigned long flags;
> > > 	spin_lock_irqsave((spinlock_t *) handle, flags);
> > > 	return flags;
> > > }
> > >
> > > So a u32 flags with
> > >
> > >   flags = acpi_os_acquire_lock(lock);
> > >
> > > would be safe, unless a 64 bit machine stored the value of IR in the
> > > upper word, which I don't know of any archs that do that.
> >
> > ok. But this still looks very volatile. Nowhere do we guarantee (or can
> > we guarantee) that silently zeroing out the upper 32 bits of flags is
> > safe!
>
> Andi,
>
> So, should I send my patch upstream?

It's a theoretical only issue for mainline right now. The only architectures 
using the ACPI code are i386,x86-64,ia64. The first two are ok with 
truncating. The IA64 PSR is longer than 32bit, but unless I'm misreading the 
code they only care about the "i" bit which is also in the lower 32bit (Tony 
can probably confirm/deny) 

Still might be good to clean up, but certainly not a urgent issue.

-Andi

From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Wed, 18 Jun 2008 15:14:09 +0200
Message-ID: <20080618131409.GC11501@elte.hu>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <alpine.LFD.1.10.0806170905221.3395@apollo.tec.linutronix.de> <200806172244.24026.rjw@sisk.pl> <200806180019.49628.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200806180019.49628.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > Thanks, it eliminates the WARNING, but still the box doesn't work 
> > with the "x86: add C1E aware idle function" patch applied, even with 
> > 'highres=off'.
> > 
> > The main symptom is that CPU loads are computed incorrectly (I got X 
> > using 126% of CPU time from 'top', for example).  Apart from this, 
> > some processes (like gkrellm) seem to be 'frozen' and only change 
> > their state in 'jumps', as though they only got CPU from time to 
> > time at random.
> > 
> > Reverting the above-mentioned patch fixes those problems.
> 
> Ah.  If your fix is replaced with the appended one, the system happily 
> works with C1E and highres.

very nice! I have applied your fix to tip/x86/cpu.

does this resolve all problems on your box, or is the IO-APIC problem 
still open?

	Ingo

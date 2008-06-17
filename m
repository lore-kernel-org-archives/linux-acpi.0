From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Tue, 17 Jun 2008 22:44:23 +0200
Message-ID: <200806172244.24026.rjw@sisk.pl>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806170105.45647.rjw@sisk.pl> <alpine.LFD.1.10.0806170905221.3395@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0806170905221.3395@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tuesday, 17 of June 2008, Thomas Gleixner wrote:
> On Tue, 17 Jun 2008, Rafael J. Wysocki wrote:
> > 
> > BTW, with the C1E patches reverted I don't get the
> > WARNING: at /home/rafael/src/linux-next/kernel/smp.c:215 smp_call_function_single+0x3d/0xa2
> > in the log.  Thomas?
> 
> Yeah, my bad. Fix below.

Thanks, it eliminates the WARNING, but still the box doesn't work with
the "x86: add C1E aware idle function" patch applied, even with 'highres=off'.

The main symptom is that CPU loads are computed incorrectly (I got X using 126%
of CPU time from 'top', for example).  Apart from this, some processes (like
gkrellm) seem to be 'frozen' and only change their state in 'jumps', as though
they only got CPU from time to time at random.

Reverting the above-mentioned patch fixes those problems.

Thanks,
Rafael

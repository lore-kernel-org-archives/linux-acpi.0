From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Sun, 22 Jun 2008 00:47:00 +0200
Message-ID: <200806220047.01497.rjw@sisk.pl>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806181640.45595.rjw@sisk.pl> <alpine.LFD.1.10.0806181726400.3395@apollo.tec.linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <alpine.LFD.1.10.0806181726400.3395@apollo.tec.linutronix.de>
Content-Disposition: inline
Sender: linux-next-owner@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wednesday, 18 of June 2008, Thomas Gleixner wrote:
> On Wed, 18 Jun 2008, Rafael J. Wysocki wrote:
> > > I just checked that the original c1e series and the affected code in
> > > tip are not different. IIRC you confirmed that the C1E patches would
> > > work on your box. So I wonder what else got changed which causes these
> > > problems.
> > 
> > Well, to eliminate any possible correlations, do you have a version of the
> > series or a single patch against the current mainline?
> 
> http://userweb.kernel.org/~tglx/952f4a-c1e-apic.patch
> http://userweb.kernel.org/~tglx/952f4a-c1e.patch
> 
> c1e-apic is the forward port of the apic changes and c1e is the pure
> c1e stuff. On my box it does not work w/o the c1e-apic one, but ....

Unfortunately, with the c1e.patch on top of the apic.patch on top of the
current mainline I get the same symptoms as with -next:
- processes freeze
- CPU loads are unreasonably high
- things generally get stucked if I don't move the mouse or press keys

Removing the the c1e.patch makes things work again.

Thanks,
Rafael

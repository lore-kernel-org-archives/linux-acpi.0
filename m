From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Wed, 18 Jun 2008 17:29:50 +0200 (CEST)
Message-ID: <alpine.LFD.1.10.0806181726400.3395@apollo.tec.linutronix.de>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <alpine.LFD.1.10.0806181000440.3395@apollo.tec.linutronix.de> <alpine.LFD.1.10.0806181421320.3395@apollo.tec.linutronix.de> <200806181640.45595.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200806181640.45595.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Wed, 18 Jun 2008, Rafael J. Wysocki wrote:
> > I just checked that the original c1e series and the affected code in
> > tip are not different. IIRC you confirmed that the C1E patches would
> > work on your box. So I wonder what else got changed which causes these
> > problems.
> 
> Well, to eliminate any possible correlations, do you have a version of the
> series or a single patch against the current mainline?

http://userweb.kernel.org/~tglx/952f4a-c1e-apic.patch
http://userweb.kernel.org/~tglx/952f4a-c1e.patch

c1e-apic is the forward port of the apic changes and c1e is the pure
c1e stuff. On my box it does not work w/o the c1e-apic one, but ....

Thanks,
	tglx

From: Ingo Molnar <mingo@elte.hu>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Wed, 18 Jun 2008 15:15:45 +0200
Message-ID: <20080618131545.GD11501@elte.hu>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <200806172244.24026.rjw@sisk.pl> <200806180019.49628.rjw@sisk.pl> <200806180025.20504.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200806180025.20504.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Rafael J. Wysocki <rjw@sisk.pl> wrote:

> > Ah.  If your fix is replaced with the appended one, the system 
> > happily works with C1E and highres.
> 
> Scratch that.  The symptoms appeared later this time, that's all.  
> I've just got b43 consuming 90+ % of the CPU time. :-(

ah, ok. Discarded the patch :-/

	Ingo

From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: linux-next: Tree for June 13: IO APIC breakage on HP nx6325
Date: Tue, 17 Jun 2008 22:19:14 +0100 (BST)
Message-ID: <Pine.LNX.4.55.0806172206580.28110@cliff.in.clinika.pl>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au>
 <Pine.LNX.4.55.0806161636510.20218@cliff.in.clinika.pl> <200806170038.37224.rjw@sisk.pl>
 <200806172259.47861.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <200806172259.47861.rjw@sisk.pl>
Sender: linux-next-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Ingo Molnar <mingo@elte.hu>, Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Len Brown <lenb@kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Tue, 17 Jun 2008, Rafael J. Wysocki wrote:

> May I gently ask that the patch ("x86: I/O APIC: timer through 8259A second-chance")
> be reverted?

 We're trying to find a solution for a long-standing problem and this
patch is a step in that direction.  We need to find out exactly what is
going wrong with the HP nx6325 system and removing the patch would make us
lose the opportunity to get things right in this area.  At the time I
submitted that patch I warned a lot of testing would be required before it
goes upstream and hopefully my request will get honored.  If you do not
want to participate in testing for whatever reason, you have the right to
do so, but I insist on the patch to stay at least until we know the source
of the problem and conclude there is no other way to get it fixed.  Len
reported he's got the same system and it behaves the same, so I hope he'll
be able to do the testing if you decide to opt out.

 Unfortunately the 64-bit variation has a lot of necessary logging
disabled by default (as you have now discovered with the need to rename
apic_printk() to printk()), so my plan is to cook up a patch to enable all
the available logging facilities around that code first.  I was very tired
yesterday and could not afford having a look at the logs -- sorry about
that.  I'll try to do it tonight and see if there is anything else I can
do.

  Maciej

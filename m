From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [BKPATCH] LAPIC fix for 2.6
Date: Sun, 10 Oct 2004 17:47:05 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58.0410101744110.3897@ppc970.osdl.org>
References: <1097429707.30734.21.camel@d845pe> <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
 <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268588AbUJKArP@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org



On Sun, 10 Oct 2004, Maciej W. Rozycki wrote:
> 
>  Hmm, any particular reason to keep the local APIC disabled by default?  

Yes. It changes interrupt handling, so any SMM stuff tends to break on
BIOSes that don't know about APICs. Things like the magic keys etc. It
apparently also breaks some ACPI stuff (likely AML code that "knows" that
interrupts are done with the legacy controller).

Mostly a laptop issue, I suspect - simply because desktops don't do 
anything strange these days.

So the default is the "safe" settings. And if you care, and your machine
works with the APIC, the command line thing is available.

		Linus

From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [BKPATCH] LAPIC fix for 2.6
Date: Sun, 10 Oct 2004 20:04:09 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <Pine.LNX.4.58L.0410102000160.4217@blysk.ds.pg.gda.pl>
References: <1097429707.30734.21.camel@d845pe> <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S268439AbUJJTEX@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0410101044200.3897@ppc970.osdl.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Len Brown <len.brown@intel.com>, Andrew Morton <akpm@osdl.org>, Kernel Mailing List <linux-kernel@vger.kernel.org>, ACPI Developers <acpi-devel@lists.sourceforge.net>
List-Id: linux-acpi@vger.kernel.org

On Sun, 10 Oct 2004, Linus Torvalds wrote:

> > Hi Linus, please do a 
> > 
> > 	bk pull bk://linux-acpi.bkbits.net/26-latest-release
> 
> Ok, this version of the patch suddenly looks like a real bug-fix in that
> it now makes the command line options "lapic"/"nolapic" a lot more
> logical.

 Hmm, any particular reason to keep the local APIC disabled by default?  
Most BIOS vendors keep it disabled just because it's easier to get stuff
set up this way -- with the APIC enabled you need to do the same steps to
program the 8259As as with the APIC disabled, plus program the APIC 
itself, which provides no gain to BIOS itself or to DOS, so why bother?

  Maciej

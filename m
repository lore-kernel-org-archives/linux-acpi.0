From: Ingo Molnar <mingo@elte.hu>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Mon, 26 Nov 2007 21:45:40 +0100
Message-ID: <20071126204540.GA19874@elte.hu>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org> <4743CC0B.9000508@linux.vnet.ibm.com> <20071120221839.faab108e.akpm@linux-foundation.org> <20071126143943.0a01665b@cuia.boston.redhat.com> <20071126123319.7483e57f.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx3.mail.elte.hu ([157.181.1.138]:36828 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754594AbXKZUqj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 26 Nov 2007 15:46:39 -0500
Content-Disposition: inline
In-Reply-To: <20071126123319.7483e57f.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Rik van Riel <riel@redhat.com>, kamalesh@linux.vnet.ibm.com, linux-kernel@vger.kernel.org, apw@shadowen.org, balbir@linux.vnet.ibm.com, linux-acpi@vger.kernel.org, tglx@linutronix.de, Christoph Lameter <clameter@sgi.com>


* Andrew Morton <akpm@linux-foundation.org> wrote:

> On Mon, 26 Nov 2007 14:39:43 -0500
> Rik van Riel <riel@redhat.com> wrote:
> 
> > On Tue, 20 Nov 2007 22:18:39 -0800
> > Andrew Morton <akpm@linux-foundation.org> wrote:
> > 
> > > > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > > > Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter
> > > 
> > > ACPI or x86 breakage, I guess.
> > > 
> > > Did 'noapic' work?
> > 
> > I got the same bug as above, 'noapic' gets past that point 
> 
> We still don't know what caused this, afaik.

yes. Is it a regression? If yes, could someone try to bisect it so that 
we can fix it? If it's caused by x86.git then the 'mm' branch of the x86 
git tree can be used for bisection:

   git://git.kernel.org/pub/scm/linux/kernel/git/x86/linux-2.6-x86.git

it's supposed to build and boot fine at every bisection point. The 
bisection run can be cut significantly by narrowing the bisection to the 
arch/x86 changes only:

  git-bisect start arch/x86 include/asm-x86/

(and if it finds a nonsensical commit, i.e. the breakage is not caused 
by the x86 commits, save the "git-bisect log" output into a file, 
restart the git bisection and use "git-bisect replay" to insert all the 
test points into a fuller bisection run - this saves quite some time.)

	Ingo

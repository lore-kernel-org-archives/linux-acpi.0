From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Date: Fri, 28 Jan 2005 16:49:53 +0100
Message-ID: <20050128154953.GJ6703@wotan.suse.de>
References: <20050128133927.GC6703@wotan.suse.de> <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com> <20050128143010.GE6703@wotan.suse.de> <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com> <20050128151839.GI6703@wotan.suse.de> <Pine.LNX.4.61.0501281534420.7304@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261465AbVA1Pt4@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281534420.7304@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 28, 2005 at 03:46:05PM +0000, Hugh Dickins wrote:
> On Fri, 28 Jan 2005, Andi Kleen wrote:
> 
> > > Forgive me for not wading through the code, but it really needs to
> > > be spelt out in the comments: what's wrong with the existing kernel,
> > > with "noapic nolapic" in the distro's bootstring by default?
> > 
> > It's harder to explain and traditionally in LILO you couldn't remove
> > any options (in grub you can now).
> 
> And it's just that initial installation boot, via grub, which really
> matters.  Thereafter can be edited, before perhaps switching to LILO.

I now remember another reason for it: upgrades. SUSE always did it this
way (It goes back many moons to 2.2 based kernels when the UP APIC code
was added). It would be probably rather fragile to change this
automatically during an update.

I realize this isn't a big concern for mainline, but given that
people are always complaining about distributions having too many
patches it may be still good to add it to mainline because 
the SUSE kernel has it. Unless people think it is totally unsuitable (?),
but I don't think it is that bad.

Also I must add in addition to the CONFIG there are valuable bugfixes
in there too.

-Andi

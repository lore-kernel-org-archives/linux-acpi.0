From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Date: Fri, 28 Jan 2005 18:46:13 +0100
Message-ID: <20050128174613.GP6703@wotan.suse.de>
References: <20050128133927.GC6703@wotan.suse.de> <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com> <20050128143010.GE6703@wotan.suse.de> <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com> <20050128151839.GI6703@wotan.suse.de> <Pine.LNX.4.61.0501281038480.22906@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261491AbVA1SEN@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281038480.22906@montezuma.fsmlabs.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Cc: Andi Kleen <ak@suse.de>, Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 28, 2005 at 10:43:42AM -0700, Zwane Mwaikambo wrote:
> On Fri, 28 Jan 2005, Andi Kleen wrote:
> 
> > > Forgive me for not wading through the code, but it really needs to
> > > be spelt out in the comments: what's wrong with the existing kernel,
> > > with "noapic nolapic" in the distro's bootstring by default?
> > 
> > It's harder to explain and traditionally in LILO you couldn't remove
> > any options (in grub you can now). I think it makes much more sense
> > to have an positive option for this too, not a negative one. 
> 
> Well new distributions with 2.6 most probably aren't using LILO and if 
> you're running 2.6 with some ancient distro you can add commandline 
> options yourself.

Ok, thanks for the constructive feedback. I withdraw the patch then
and will continue to maintain it in private.

-Andi

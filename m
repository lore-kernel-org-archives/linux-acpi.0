From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Date: Fri, 28 Jan 2005 10:43:42 -0700 (MST)
Message-ID: <Pine.LNX.4.61.0501281038480.22906@montezuma.fsmlabs.com>
References: <20050128133927.GC6703@wotan.suse.de>
 <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com>
 <20050128143010.GE6703@wotan.suse.de> <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com>
 <20050128151839.GI6703@wotan.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261495AbVA1Rx3@vger.kernel.org>
In-Reply-To: <20050128151839.GI6703@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: Hugh Dickins <hugh@veritas.com>, akpm@osdl.org, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fri, 28 Jan 2005, Andi Kleen wrote:

> > Forgive me for not wading through the code, but it really needs to
> > be spelt out in the comments: what's wrong with the existing kernel,
> > with "noapic nolapic" in the distro's bootstring by default?
> 
> It's harder to explain and traditionally in LILO you couldn't remove
> any options (in grub you can now). I think it makes much more sense
> to have an positive option for this too, not a negative one. 

Well new distributions with 2.6 most probably aren't using LILO and if 
you're running 2.6 with some ancient distro you can add commandline 
options yourself.

> Also I must add my patch fixes real bugs in the code, not just
> adding the new option.

Please seperate them then.

> > I'm not going to be the only one confused by this!
> 
> I think there is much more confusion in the current way.

I'm going to claim confusion over this one too.

Thanks,
	Zwane

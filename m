From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Date: Fri, 28 Jan 2005 16:18:39 +0100
Message-ID: <20050128151839.GI6703@wotan.suse.de>
References: <20050128133927.GC6703@wotan.suse.de> <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com> <20050128143010.GE6703@wotan.suse.de> <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261446AbVA1PSt@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0501281506100.7207@goblin.wat.veritas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Hugh Dickins <hugh@veritas.com>
Cc: Andi Kleen <ak@suse.de>, akpm@osdl.org, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

> Forgive me for not wading through the code, but it really needs to
> be spelt out in the comments: what's wrong with the existing kernel,
> with "noapic nolapic" in the distro's bootstring by default?

It's harder to explain and traditionally in LILO you couldn't remove
any options (in grub you can now). I think it makes much more sense
to have an positive option for this too, not a negative one. 

Also I must add my patch fixes real bugs in the code, not just
adding the new option.

> I'm not going to be the only one confused by this!

I think there is much more confusion in the current way.

-Andi

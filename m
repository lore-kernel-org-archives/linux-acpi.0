From: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH] Add CONFIG_X86_APIC_OFF for i386/UP
Date: Fri, 28 Jan 2005 14:27:51 +0000 (GMT)
Message-ID: <Pine.LNX.4.61.0501281421410.7109@goblin.wat.veritas.com>
References: <20050128133927.GC6703@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261413AbVA1O3S@vger.kernel.org>
In-Reply-To: <20050128133927.GC6703@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Andi Kleen <ak@suse.de>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
List-Id: linux-acpi@vger.kernel.org

On Fri, 28 Jan 2005, Andi Kleen wrote:
> 
> This patch adds a new CONFIG_X86_APIC_OFF option. This is useful
> for distribution UP kernels who should run with local APIC off by
> default (because older machines often have broken mptables etc.).
> 
> But there are a few machines who don't boot with apic off so there
> needs to be an command line option to enable it.
> 
> When X86_APIC_OFF is set the APIC code is compiled in, but is 
> only enabled when "apic" or "lapic" is specified on the command line
> (or a DMI scanner force enables it).

I'm confused!  Why do we need X86_APIC_OFF config option (but code
compiled in), with boot options "apic" or "lapic" to enable it,
when we already have the code compiled in, with boot options
"noapic" or "nolapic" to disable it?

Hugh

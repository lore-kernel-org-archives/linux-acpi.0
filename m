From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [Xen-devel] [PATCH v2 1/3] x86/boot: add acpi rsdp address to
 setup_header
Date: Fri, 8 Dec 2017 09:35:16 +0100
Message-ID: <20171208083516.gc7buju6zucxnlnf@gmail.com>
References: <20171207122821.30158-1-jgross@suse.com>
 <20171207122821.30158-2-jgross@suse.com>
 <20171208071653.mzyf3ct6n6h2x37r@gmail.com>
 <5A2A5B4C0200007800195CDC@prv-mh.provo.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5A2A5B4C0200007800195CDC@prv-mh.provo.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jan Beulich <JBeulich@suse.com>
Cc: lenb@kernel.org, x86@kernel.org, tglx@linutronix.de, xen-devel@lists.xenproject.org, corbet@lwn.net, boris.ostrovsky@oracle.com, mingo@redhat.com, rjw@rjwysocki.net, Juergen Gross <jgross@suse.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, hpa@zytor.com, Borislav Petkov <bp@alien8.de>, Matt Fleming <matt@codeblueprint.co.uk>, Ard Biesheuvel <ard.biesheuvel@linaro.org>
List-Id: linux-acpi@vger.kernel.org


* Jan Beulich <JBeulich@suse.com> wrote:

> >>> On 08.12.17 at 08:16, <mingo@kernel.org> wrote:
> > Also, a more fundamental question: why doesn't Xen use EFI to hand over 
> > hardware configuration details?
> 
> Iirc the main purpose of the change here is to allow booting PVH
> (guest or Dom0) with Grub2 in the middle. PVH, at least for the
> time being, is something that gets away without any firmware
> (and I'm pretty certain this is going to remain that way for Dom0).
> ACPI tables are being built by the tool stack (guest) or hypervisor
> (Dom0). Hence there simply isn't any EFI which could be used to
> propagate such information.

Ok, that's fair enough. If hpa (or someone else) doesn't object to the boot 
protocol extension this approach looks good to me in principle.

Thanks,

	Ingo

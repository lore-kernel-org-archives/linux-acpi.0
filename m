From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 1/3] x86/boot: add acpi rsdp address to setup_header
Date: Fri, 8 Dec 2017 09:48:27 +0100
Message-ID: <20171208084827.yv3vrtfnn6otjdg4@gmail.com>
References: <20171207122821.30158-1-jgross@suse.com>
 <20171207122821.30158-2-jgross@suse.com>
 <20171208071653.mzyf3ct6n6h2x37r@gmail.com>
 <81777128-a277-c47b-2570-a330b2f6c50d@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <81777128-a277-c47b-2570-a330b2f6c50d@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Juergen Gross <jgross@suse.com>
Cc: linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org, x86@kernel.org, boris.ostrovsky@oracle.com, hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, corbet@lwn.net, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org


* Juergen Gross <jgross@suse.com> wrote:

> >> +Offset/size:	0x268/8
> >> +Protocol:	2.14+
> >> +
> >> +  This field can be set by the boot loader to tell the kernel the
> >> +  physical address of the ACPI RSDP table.
> >> +
> >> +  A value of 0 indicates the kernel should fall back to the standard
> >> +  methods to locate the RSDP (search in EBDA/low memory).
> > 
> > That's not the only method used: the ACPI RSDP address can also be discovered via 
> > efi.rsdp20 and efi.rsdp, both of which appear to be 32-bit values.
> 
> Sure, but this is valid for booting via EFI only.

Yeah, so what I tried to say is that the description as written is not fully 
correct and triggered my pedantry:

 +  A value of 0 indicates the kernel should fall back to the standard
 +  methods to locate the RSDP (search in EBDA/low memory).

To make it correct we need to either write less:

 +  A value of 0 indicates the kernel should fall back to the standard
 +  methods to locate the RSDP.

or write more and make it open ended so it doesn't have to be extended with every 
method of getting the RSDP that might be added in the future:

 +  A value of 0 indicates the kernel should fall back to the standard
 +  methods to locate the RSDP (search in EBDA/low memory, get it from
 +  EFI if present, etc.).

... or so?

Thanks,

	Ingo

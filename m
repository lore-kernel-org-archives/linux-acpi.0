From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Early kernel messages are overflowing the static log buffer
Date: Wed, 22 Dec 2010 14:09:46 +0100
Message-ID: <20101222130946.GC13412@elte.hu>
References: <4D06B317.2090608@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4D06B317.2090608@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mike Travis <travis@sgi.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, David Rientjes <rientjes@google.com>, Len Brown <lenb@kernel.org>, Jack Steiner <steiner@sgi.com>, Lori Gilbertson <loriann@sgi.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-acpi@vger.kernel.org


* Mike Travis <travis@sgi.com> wrote:

> So it seems we need to reduce the number of messages.

Absolutely!

> The voluminous message sources before buffer reallocation are:
> 
> [    0.000000]  BIOS-e820: 0000000000000000 - 000000000008f000
> (usable)                                              ...
> [    0.000000] EFI: mem00: type=3, attr=0xf,
> range=[0x0000000000000000-0x0000000000001000) (0MB)
> [    ...
> [    0.000000] modified physical RAM map:
> [    0.000000]  modified: 0000000000000000 - 0000000000001000
> (usable)                         ...
> [    0.000000] SRAT: PXM 0 -> APIC 0 -> Node 0
> ...
> [    0.000000] Bootmem setup node 0 0000000000000000-0000000800000000
> [    0.000000]   NODE_DATA [000000000000e100 - 00000000000420ff]
> [    0.000000]   bootmap [0000000000100000 -  00000000001fffff] pages 100
> ...
> [    0.000000] early_node_map[137] active PFN ranges
> [    0.000000]     0: 0x00000000 -> 0x00000001
> ...
> [    0.000000] On node 1 totalpages: 8388608
> [    0.000000]   Normal zone: 114688 pages used for memmap
> [    0.000000]   Normal zone: 8273920 pages, LIFO batch:31
> ...
> [    0.000000] ACPI: X2APIC (apic_id[0x00] uid[0x00] enabled)
> ...
> [    0.000000] PM: Registered nosave memory: 0000000000001000 - 0000000000006000
> ...
> [    0.000000] pcpu-alloc: [000] 0000 0001 0002 0003 0004 0005 0006 0007 1024 1025 1026 1027 1028 1029 1030 1031
> 
> What I'm asking is which of these would be most acceptable to
> either remove or replace with some sort of message reduction?

The pcpu alloc messages look entirely superfluous and zappable - make them 
KERN_DEBUG perhaps (and Cc: Tejun)?

> Note that a lot of the messages are completely redundant.  Like
> the Bootmem setup generally has exactly the same information
> (spread over 15 lines), for each of the 128 Nodes.

Yeah.

> One patch that I still have was David's "reduce srat verbosity in
> the kernel log" that was rejected by you as too complex.  This
> would have resulted in about a 16:1 reduction in SRAT: messages,
> without loss of an information.  Before I start another doomed patch,
> I'd like to find out the guidelines.  Remember, no one really looks
> at these messages unless the system panics, usually during startup.
> So the information here may be key to diagnosing the problem.

Mind resending that patch again? Maybe we can find a simpler solution. I almost 
never NAK patches permanently - there can always be reasons i missed, or better 
implementations.

We dont want to lose physical memory layout information - it's useful in many other 
types of post mortem analysis and we dont want to force people to reboot into some 
debug kernel just to be able to report essential bits.

Thanks,

	Ingo

From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: 2.6.24-rc3-mm1 - Kernel Panic on IO-APIC
Date: Sat, 24 Nov 2007 03:49:15 +0300
Message-ID: <20071124004915.GA1743@martell.zuzino.mipt.ru>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org> <4743CC0B.9000508@linux.vnet.ibm.com> <20071120221839.faab108e.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:2395 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752562AbXKXAtX (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 23 Nov 2007 19:49:23 -0500
Received: by ug-out-1314.google.com with SMTP id z38so599372ugc
        for <linux-acpi@vger.kernel.org>; Fri, 23 Nov 2007 16:49:21 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20071120221839.faab108e.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, Andy Whitcroft <apw@shadowen.org>, Balbir Singh <balbir@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>

On Tue, Nov 20, 2007 at 10:18:39PM -0800, Andrew Morton wrote:
> On Wed, 21 Nov 2007 11:41:23 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:
> 
> > Hi Andrew,
> > 
> > Kernel panic's across different architectures like powerpc, x86_64, 
> 
> powerpc complains about IO-APICs??
> 
> > Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
> > Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
> > Mount-cache hash table entries: 256
> > SMP alternatives: switching to UP code
> > ACPI: Core revision 20070126

Hmm. same date here. It's Asus P5B-E motheboard

> > ..MP-BIOS bug: 8254 timer not connected to IO-APIC
> > Kernel panic - not syncing: IO-APIC + timer doesn't work! Try using the 'noapic' kernel parameter
> 
> ACPI or x86 breakage, I guess.
> 
> Did 'noapic' work?

No! The box freezes somewhere after "Freeing unused kernel memory"...

Bisection points to git-x86.patch, though.

git-bisect start
# good: [f05092637dc0d9a3f2249c9b283b973e6e96b7d2] Linux 2.6.24-rc3
git-bisect good f05092637dc0d9a3f2249c9b283b973e6e96b7d2
# bad: [46c8c396d2c87b786a7fac615c289f85a18e53ce] w1-build-fix
git-bisect bad 46c8c396d2c87b786a7fac615c289f85a18e53ce
# bad: [4e22f4852c48e1eddfe04299e78c0456164abe86] frv-move-dma-macros-to-scatterlisth-for-consistency
git-bisect bad 4e22f4852c48e1eddfe04299e78c0456164abe86
# bad: [4e22f4852c48e1eddfe04299e78c0456164abe86] frv-move-dma-macros-to-scatterlisth-for-consistency
git-bisect bad 4e22f4852c48e1eddfe04299e78c0456164abe86
# good: [d5135f31313af2be37d8ccb71e2a42f8e221d8c4] ide-mm-ide-disk-extend-timeout-for-pio-out-commands
git-bisect good d5135f31313af2be37d8ccb71e2a42f8e221d8c4
# good: [6be815e83f506f4c39a46cf59014e29a95c5e6c4] iommu-sg-merging-call-blk_queue_segment_boundary-in-__scsi_alloc_queue
git-bisect good 6be815e83f506f4c39a46cf59014e29a95c5e6c4
# good: [6be815e83f506f4c39a46cf59014e29a95c5e6c4] iommu-sg-merging-call-blk_queue_segment_boundary-in-__scsi_alloc_queue
git-bisect good 6be815e83f506f4c39a46cf59014e29a95c5e6c4
# bad: [c792db6d06114a85e33a27c89e9e979f11b951c4] slub-fix-coding-style-violations
git-bisect bad c792db6d06114a85e33a27c89e9e979f11b951c4
# bad: [c792db6d06114a85e33a27c89e9e979f11b951c4] slub-fix-coding-style-violations
git-bisect bad c792db6d06114a85e33a27c89e9e979f11b951c4
# bad: [76f3939b76ff557f73720b57a16716196f04e407] x86_64-make-sparsemem-vmemmap-the-default-memory-model-v2
git-bisect bad 76f3939b76ff557f73720b57a16716196f04e407
# good: [b8ba611566d8799a979b190d4bb14305ca64ee0e] sis-fb-driver-_ioctl32_conversion-functions-do-not-exist-in-recent-kernels
git-bisect good b8ba611566d8799a979b190d4bb14305ca64ee0e
# good: [e34995928859308d2abef1709332e2b12d36db2f] git-ipwireless_cs
git-bisect good e34995928859308d2abef1709332e2b12d36db2f
# bad: [f520abbbe11bc8253714bcd34aaaf19bdf82189e] git-x86-identify_cpu-fix
git-bisect bad f520abbbe11bc8253714bcd34aaaf19bdf82189e


I honestly tried fresh #mm from x86 tree -- the one which ends at commit
70be766db1105c0fc9aed8e954d0c343c1eda067 "x86: Add the RDC machine
specific reboot fixup". FWIW, commit "x86: validate against ACPI motherboard
resources" is innocent. After "x86: make stack size configurable" damn thing
wouldn't build and applying fixets from -mm doesn't help at 3AM.

Again, it's late here, I'll recheck today.

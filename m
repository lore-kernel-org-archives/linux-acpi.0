From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/5] resources: add arch hook for preventing allocation
 in reserved areas
Date: Fri, 10 Dec 2010 12:30:08 -0800
Message-ID: <20101210123008.7fed582d@jbarnes-desktop>
References: <20101208213606.13026.47657.stgit@bob.kio>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <20101208213606.13026.47657.stgit@bob.kio>
Sender: linux-pci-owner@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

On Wed, 08 Dec 2010 14:36:06 -0700
Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:

> 
> This adds arch_remove_reservations(), which an arch can implement if it
> needs to protect part of the address space from allocation.
> 
> Sometimes that can be done by just requesting a resource.  This hook is to
> cover cases where protected area doesn't fit well in the hierarchical
> resource tree.  For example, x86 BIOS E820 reservations are not related
> to devices, so they may overlap part of, all of, or more than a device
> resource.
> 
> Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
> ---

Hm, this is bigger than the simple change of just avoiding the high 2M;
Linus have you checked it out yet?  It's nicer than simply adjusting
PCIBIOS_MAX_MEM since it will affect all resource callers rather than
just PCI, but it's definitely bigger.

If you want just the simple change for 2.6.37 I can push that, but
we'll need to get a tested-by from Matthew:

  diff --git a/arch/x86/include/asm/pci.h b/arch/x86/include/asm/pci.h
  index ca0437c..aef9f77 100644
  --- a/arch/x86/include/asm/pci.h
  +++ b/arch/x86/include/asm/pci.h
  @@ -141,7 +141,7 @@ void dma32_reserve_bootmem(void);

   /* generic pci stuff */
   #include <asm-generic/pci.h>
  -#define PCIBIOS_MAX_MEM_32 0xffffffff
  +#define PCIBIOS_MAX_MEM_32 0xfff00000

   #ifdef CONFIG_NUMA
   /* Returns the node based on pci bus */

and I'll queue up this set for 2.6.38.

Thanks,
-- 
Jesse Barnes, Intel Open Source Technology Center

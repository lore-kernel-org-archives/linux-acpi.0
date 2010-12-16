From: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: [PATCH 6/9] resources: add arch hook for preventing allocation in reserved areas
Date: Thu, 16 Dec 2010 15:56:06 -0700
Message-ID: <201012161556.07868.bjorn.helgaas@hp.com>
References: <20101216173614.8185.19462.stgit@bob.kio> <20101216173846.8185.82045.stgit@bob.kio> <AANLkTindCiEeHDhDJhc9o-iZHvts2d1QnH2CxmDtgb6=@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <AANLkTindCiEeHDhDJhc9o-iZHvts2d1QnH2CxmDtgb6=@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Adam Belay <abelay@mit.edu>
List-Id: linux-acpi@vger.kernel.org

On Thursday, December 16, 2010 03:03:21 pm Linus Torvalds wrote:
> On Thu, Dec 16, 2010 at 9:38 AM, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> >
> > This adds arch_remove_reservations(), which an arch can implement if it
> > needs to protect part of the address space from allocation.
> 
> Oh, I just realized - we've had gcc (or maybe "as") bugs when the weak
> symbol is in the same compilation unit as the caller, and some part of
> the toolchain just ends up short-circuiting it (either gcc inlines it,
> or maybe it was that as resolves it early). Making the "weak" part not
> work, because it binds strongly.
> 
> It may be that we don't support those gcc versions any more, but I
> thought I'd bring the issue up. It's safer to put the weak functions
> in some other file if possible.

I'd be glad to repost and do that if necessary.  Does anybody
know for sure if it is?

I did find these cases where we have a weak symbol definition in
the same file as the caller, as well as another version elsewhere,
so maybe those toolchains are indeed no longer supported?

  arch_disable_smp_support()
    defined and called in init/main.c (used for "nosmp" arg)
    also defined in arch/x86/kernel/apic/io_apic.c

  smp_setup_processor_id()
    defined and called in init/main.c
    also defined in arch/s390/kernel/smp.c
    also defined in arch/sparc/kernel/smp_64.c

  arch_enable_nonboot_cpus_begin()
    defined and called in kernel/cpu.c
    also defined in arch/x86/kernel/smpboot.c

  arch_irq_work_raise()
    defined and called in kernel/irq_work.c
    also defined in arch/sparc/kernel/pcr.c
    also defined in arch/x86/kernel/irq_work.c

  arch_jump_label_text_poke_early()
    defined and called in kernel/jump_label.c
    also defined in arch/sparc/kernel/jump_label.c
    also defined in arch/x86/kernel/jump_label.c

  arch_deref_entry_point()
    defined and called in kernel/kprobes.c
    also defined in arch/ia64/kernel/kprobes.c
    also defined in arch/powerpc/kernel/kprobes.c

  arch_scale_smt_power()
    defined and called in kernel/sched_fair.c
    also defined in arch/x86/kernel/cpu/sched.c

  memblock_nid_range()
    defined and called in mm/memblock.c
    also defined in arch/sparc/mm/init_64.c

If this toolchain bug is still a problem, I would think all of the
above would be defects, so my guess is that we don't have to worry
about it any more.

Bjorn

From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [ghes_copy_tofrom_phys] BUG: sleeping function called from
 invalid context at mm/page_alloc.c:4150
Date: Mon, 30 Oct 2017 10:20:40 -0700
Message-ID: <CA+55aFy2c88wKndjRAds-3MZ+MsArGBySOog+Rxmd2AciGFGkA@mail.gmail.com>
References: <CA+55aFxSJGeN=2X-uX-on1Uq2Nb8+v1aiMDz5H1+tKW_N5Q+6g@mail.gmail.com>
 <20171029225155.qcum5i75awrt5tzm@wfg-t540p.sh.intel.com> <20171029231835.3725fnd5yehlmqob@wfg-t540p.sh.intel.com>
 <20171030110511.scfrdtlnf5lbdhu5@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171030110511.scfrdtlnf5lbdhu5@pd.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@suse.de>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>, Tyler Baicar <tbaicar@codeaurora.org>, Huang Ying <ying.huang@intel.com>, Chen Gong <gong.chen@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Will Deacon <will.deacon@arm.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux ACPI <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Mon, Oct 30, 2017 at 4:05 AM, Borislav Petkov <bp@suse.de> wrote:
>
> Looks like Tyler broke it:
>
> 77b246b32b2c ("acpi: apei: check for pending errors when probing GHES entries")
>
> and it went into 4.13 and -stable.

I think this whole driver is garbage.

It does ioremap_page_range() in both NMI and irq context.

The fact that it triggers at probe time is just pure luck, and is
probably because at that point we don't happen to have the page tables
for the ioremap set up yet, so it actually does an allocation, which
is what then causes the warning.

But we should have warned much eariler, and this code has apparently
never worked right.

The driver is COMPLETELY broken. It needs to do the ioremap not at
interrupt time, but when setting up the device, and outside a
spinlock.

I think somebody must have known how broken this whole thing was,
because it literally uses a RAW spinloick, and I suspect the reason
for that is because lockdep complained about the breakage without it.

Reverting just the latest addition is not going to help. The breakage
is much more fundamental than that.

Note that doing this thing in NMI context is *really* wrong, because
the whole ioremap() code is definitely not NMI-safe. I don't think
it's irq-safe either.

I will add a "might_sleep()" to ioremap_page_range() itself, so that
we get this warning more reliably and much eailer. Right now it has
been hidden by the fact that most of the time the time the page tables
may be already allocated, but even then it's broken.

The only safe way to do that kind of access is likely using the FIXMAP model.

                 Linus

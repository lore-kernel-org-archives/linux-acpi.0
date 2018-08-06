From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] arm64: clean the additional checks before calling
 ghes_notify_sea()
Date: Mon, 6 Aug 2018 15:26:24 +0100
Message-ID: <20180806142623.GA15275@arm.com>
References: <1532638907-46129-1-git-send-email-gengdongjiu@huawei.com>
 <20180727100617.GB25592@arm.com>
 <CAMj-D2Ab9Txk27GDQbOy3X=Qup7BuA3sWSovsOpffpxe6UcBFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMj-D2Ab9Txk27GDQbOy3X=Qup7BuA3sWSovsOpffpxe6UcBFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gengdongjiu <gengdj.1984@gmail.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, mark.rutland@arm.com, Len Brown <lenb@kernel.org>, rafael.j.wysocki@intel.com, erik.schmauss@intel.com, robert.moore@intel.com, arm-mail-list <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-acpi@vger.kernel.org, devel@acpica.org
List-Id: linux-acpi@vger.kernel.org

On Sun, Aug 05, 2018 at 10:35:03AM +0800, gengdongjiu wrote:
> 2018-07-27 18:06 GMT+08:00 Will Deacon <will.deacon@arm.com>:
> > On Thu, Jul 26, 2018 at 05:01:47PM -0400, Dongjiu Geng wrote:
> >> In order to remove the additional check before calling the
> >> ghes_notify_sea(), make stub definition when !CONFIG_ACPI_APEI_SEA.
> >>
> >> Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
> >> ---
> >
> > Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Will,
>      This patch will be applied, right? thanks

I haven't queued it in the arm64 tree, since it touches include/acpi/ghes.h
and you don't have an ack from the acpi folks. I acked it so that you could
route it via the acpi tree without me holding you up.

Will

> >> This cleanup is ever mentioned by Mark Rutland in [1]
> >>
> >> [1]:
> >> https://lkml.org/lkml/2018/5/31/289
> >> ---
> >>  arch/arm64/mm/fault.c | 7 +------
> >>  include/acpi/ghes.h   | 4 ++++
> >>  2 files changed, 5 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
> >> index b8eecc7..9ffe01d 100644
> >> --- a/arch/arm64/mm/fault.c
> >> +++ b/arch/arm64/mm/fault.c
> >> @@ -727,12 +727,7 @@ static int do_sea(unsigned long addr, unsigned int esr, struct pt_regs *regs)
> >>
> >>  int handle_guest_sea(phys_addr_t addr, unsigned int esr)
> >>  {
> >> -     int ret = -ENOENT;
> >> -
> >> -     if (IS_ENABLED(CONFIG_ACPI_APEI_SEA))
> >> -             ret = ghes_notify_sea();
> >> -
> >> -     return ret;
> >> +     return ghes_notify_sea();
> >>  }
> >>
> >>  asmlinkage void __exception do_mem_abort(unsigned long addr, unsigned int esr,
> >> diff --git a/include/acpi/ghes.h b/include/acpi/ghes.h
> >> index 1624e2b..82cb4eb 100644
> >> --- a/include/acpi/ghes.h
> >> +++ b/include/acpi/ghes.h
> >> @@ -118,6 +118,10 @@ static inline void *acpi_hest_get_next(struct acpi_hest_generic_data *gdata)
> >>            (void *)section - (void *)(estatus + 1) < estatus->data_length; \
> >>            section = acpi_hest_get_next(section))
> >>
> >> +#ifdef CONFIG_ACPI_APEI_SEA
> >>  int ghes_notify_sea(void);
> >> +#else
> >> +static inline int ghes_notify_sea(void) { return -ENOENT; }
> >> +#endif
> >>
> >>  #endif /* GHES_H */
> >> --
> >> 1.9.1
> >>

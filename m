From: Herbert Poetzl <herbert@13thfloor.at>
Subject: Re: [PATCH] 2.6.16-rc6 calls check_acpi_pci() on x86 with ACPI disabled
Date: Wed, 15 Mar 2006 02:53:18 +0100
Message-ID: <20060315015318.GA24945@MAIL.13thfloor.at>
References: <20060315013125.GA24402@MAIL.13thfloor.at> <20060314174540.5c138458.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from MAIL.13thfloor.at ([212.16.62.50]:51143 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S932581AbWCOBxU (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Tue, 14 Mar 2006 20:53:20 -0500
Content-Disposition: inline
In-Reply-To: <20060314174540.5c138458.akpm@osdl.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, "Brown, Len" <len.brown@intel.com>

On Tue, Mar 14, 2006 at 05:45:40PM -0800, Andrew Morton wrote:
> Herbert Poetzl <herbert@13thfloor.at> wrote:
> >
> > 
> > Hi Andrew! Folks!
> > 
> > check_acpi_pci() is called form arch/i386/kernel/setup.c
> > even if CONFIG_ACPI is not defined, but the code in
> > include/asm/acpi.h doesn't provide it in this case, 
> 
> Well that's a shame.
> 
> > so either we need to move the declaration outside the 
> > CONFIG_ACPI check, or alternatively move the call in
> > setup.c inside the CONFIG_ACPI one
> > 
> > attached two patches which would do this
> 
> Prefer the first version.  But it'll break if CONFIG_X86_IO_APIC &&
> !CONFIG_ACPI
> 
> So how's about this?

hmm, well, the comment around the check_acpi_pci() call
says: "Checks more than just ACPI actually", so I didn't
want to make it depend on ACPI in the 'first' version,
which now would change semantics, but if it is fine to
make it depend on ACPI, the second version might be the
simpler solution (which should have the same semantic as
your version ... I think

maybe the ACPI folks should clarify if this stuff has to
be run if ACPI is off, in which case renaming the thing
might be a good idea ...

best,
Herbert

> From: Herbert Poetzl <herbert@13thfloor.at>
> 
> check_acpi_pci() is called from arch/i386/kernel/setup.c even if
> CONFIG_ACPI is not defined, but the code in include/asm/acpi.h doesn't
> provide it in this case.
> 
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> ---
> 
>  include/asm/acpi.h |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff -puN include/asm/acpi.h~dont-check_acpi_pci-on-x86-with-acpi-disabled include/asm/acpi.h
> --- devel/include/asm/acpi.h~dont-check_acpi_pci-on-x86-with-acpi-disabled	2006-03-14 17:42:11.000000000 -0800
> +++ devel-akpm/include/asm/acpi.h	2006-03-14 17:44:50.000000000 -0800
> @@ -103,6 +103,12 @@ __acpi_release_global_lock (unsigned int
>          :"=r"(n_hi), "=r"(n_lo)     \
>          :"0"(n_hi), "1"(n_lo))
>  
> +#if defined(CONFIG_ACPI) && defined(CONFIG_X86_IO_APIC)
> +extern void check_acpi_pci(void);
> +#else
> +static inline void check_acpi_pci(void) { }
> +#endif
> +
>  #ifdef CONFIG_ACPI 
>  extern int acpi_lapic;
>  extern int acpi_ioapic;
> @@ -128,8 +134,6 @@ extern int acpi_gsi_to_irq(u32 gsi, unsi
>  extern int skip_ioapic_setup;
>  extern int acpi_skip_timer_override;
>  
> -extern void check_acpi_pci(void);
> -
>  static inline void disable_ioapic_setup(void)
>  {
>  	skip_ioapic_setup = 1;
> @@ -142,8 +146,6 @@ static inline int ioapic_setup_disabled(
>  
>  #else
>  static inline void disable_ioapic_setup(void) { }
> -static inline void check_acpi_pci(void) { }
> -
>  #endif
>  
>  static inline void acpi_noirq_set(void) { acpi_noirq = 1; }
> _

From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [RFC PATCH 2/4] x86/setup: parse acpi to get hotplug info before init_mem_mapping()
Date: Mon, 7 Jan 2019 20:52:34 +0800
Message-ID: <CAFgQCTtzKukUpeRy-q91gdCKOtpHY3jjNzdFChx0Fj-9PHBM4Q@mail.gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com> <1546849485-27933-3-git-send-email-kernelfans@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1546849485-27933-3-git-send-email-kernelfans@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@kernel.org, linux-acpi@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Mon, Jan 7, 2019 at 4:25 PM Pingfan Liu <kernelfans@gmail.com> wrote:
>
> At present, memblock bottom-up allocation can help us against stamping over
> movable node in very high probability. But if the hotplug info has already
> been parsed, the memblock allocator can step around the movable node by
> itself. This patch pushes the parsing step forward, just ahead of where,
> the memblock allocator can work. Later in this series, the bottom-up
> allocation style can be removed on x86_64.
>
> Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/kernel/setup.c | 15 +++++++++++++++
>  include/linux/acpi.h    |  1 +
>  2 files changed, 16 insertions(+)
>
> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> index acbcd62..df4132c 100644
> --- a/arch/x86/kernel/setup.c
> +++ b/arch/x86/kernel/setup.c
> @@ -805,6 +805,20 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
>         return 0;
>  }
>
> +/* only need the effect of acpi_numa_memory_affinity_init()
> + * ->memblock_mark_hotplug()
> + */
> +static int early_detect_acpi_memhotplug(void)
> +{
> +#ifdef CONFIG_ACPI_NUMA
> +       acpi_table_upgrade(__va(get_ramdisk_image()), get_ramdisk_size());
> +       acpi_table_init();
> +       acpi_numa_init();

As this is RFC version, I do not suppress this extra printk info yet.
Should do it next version.
> +       acpi_tb_terminate();
> +#endif
> +       return 0;
> +}
> +
>  /*
>   * Determine if we were loaded by an EFI loader.  If so, then we have also been
>   * passed the efi memmap, systab, etc., so we should use these data structures
> @@ -1131,6 +1145,7 @@ void __init setup_arch(char **cmdline_p)
>         trim_platform_memory_ranges();
>         trim_low_memory_range();
>
> +       early_detect_acpi_memhotplug();
>         init_mem_mapping();
>
>         idt_setup_early_pf();
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 44dcbba..1b69044 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -235,6 +235,7 @@ int acpi_mps_check (void);
>  int acpi_numa_init (void);
>
>  int acpi_table_init (void);
> +void acpi_tb_terminate(void);
>  int acpi_table_parse(char *id, acpi_tbl_table_handler handler);
>  int __init acpi_table_parse_entries(char *id, unsigned long table_size,
>                               int entry_id,
> --
> 2.7.4
>

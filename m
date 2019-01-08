From: Pingfan Liu <kernelfans@gmail.com>
Subject: Re: [RFC PATCH 2/4] x86/setup: parse acpi to get hotplug info before init_mem_mapping()
Date: Tue, 8 Jan 2019 14:30:36 +0800
Message-ID: <CAFgQCTs=xSdawO5G0-mEg=JN9TuchY4Me=Yc8kK-7wFgS3NR-A@mail.gmail.com>
References: <1546849485-27933-1-git-send-email-kernelfans@gmail.com>
 <1546849485-27933-3-git-send-email-kernelfans@gmail.com> <fe24007c-c726-720e-f018-6a08d1a6b66a@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <fe24007c-c726-720e-f018-6a08d1a6b66a@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Hansen <dave.hansen@intel.com>
Cc: x86@kernel.org, linux-acpi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Dave Hansen <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Tue, Jan 8, 2019 at 1:11 AM Dave Hansen <dave.hansen@intel.com> wrote:
>
>
> On 1/7/19 12:24 AM, Pingfan Liu wrote:
> > At present, memblock bottom-up allocation can help us against stamping over
> > movable node in very high probability.
>
> Is this what you are fixing?  Making a "high probability", a certainty?
>  Is this the problem?
>

Yes, as my reply on another mail in detail.
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index acbcd62..df4132c 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -805,6 +805,20 @@ dump_kernel_offset(struct notifier_block *self, unsigned long v, void *p)
> >       return 0;
> >  }
> >
> > +/* only need the effect of acpi_numa_memory_affinity_init()
> > + * ->memblock_mark_hotplug()
> > + */
>
> CodingStyle, please.
>

Will fix.
> > +static int early_detect_acpi_memhotplug(void)
> > +{
> > +#ifdef CONFIG_ACPI_NUMA
> > +     acpi_table_upgrade(__va(get_ramdisk_image()), get_ramdisk_size());
>
> This adds a new, early, call to acpi_table_upgrade(), and presumably all
> the following functions.  However, it does not remove any of the later
> calls.  How do they interact with each other now that they are
> presumably called twice?
>

ACPI is a big subsystem, I have a hurry through these functions. This
group seems not to allocate extra memory, and using static data. So if
called twice, just overwriting the effect of previous one. The only
issue is printk some info twice. I will pay more time on this for the
next version.
> > +     acpi_table_init();
> > +     acpi_numa_init();
> > +     acpi_tb_terminate();
> > +#endif
> > +     return 0;
> > +}
>
> Why does this return an 'int' that is unconsumed by its lone caller?
>

No special purpose about the return. Just a habit.
> There seems to be a lack of comments on this newly-added code.
>
> >  /*
> >   * Determine if we were loaded by an EFI loader.  If so, then we have also been
> >   * passed the efi memmap, systab, etc., so we should use these data structures
> > @@ -1131,6 +1145,7 @@ void __init setup_arch(char **cmdline_p)
> >       trim_platform_memory_ranges();
> >       trim_low_memory_range();
> >
> > +     early_detect_acpi_memhotplug();
>
> Comments, please.  Why is this call here, specifically?  What is it doing?
>
It parses the acpi srat to extract memory hotmovable info, and feed
those info to memory allocator. The exactly effect is:
acpi_numa_memory_affinity_init() ->memblock_mark_hotplug(). So later
when memblock allocator allocates range, in __next_mem_range(), there
is cond check to skip movable node:  if (movable_node_is_enabled() &&
memblock_is_hotpluggable(m)) continue;

Thanks,
Pingfan

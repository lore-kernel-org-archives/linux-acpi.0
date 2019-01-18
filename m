From: Kairui Song <kasong@redhat.com>
Subject: Re: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec usage
Date: Fri, 18 Jan 2019 19:43:20 +0800
Message-ID: <CACPcB9dTm_2UCRord01oW+mmoPYY7dFTHj7qFrMxOnhPx3Ov3w@mail.gmail.com>
References: <20190118111310.29589-1-kasong@redhat.com> <20190118111310.29589-3-kasong@redhat.com>
 <20190118112628.GC622@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190118112628.GC622@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, Dave Young <dyoung@redhat.com>, Baoquan He <bhe@redhat.com>, kexec@lists.infradead.org, Andrew Morton <akpm@linux-foundation.org>, Robert Moore <robert.moore@intel.com>, "Schmauss, Erik" <erik.schmauss@intel.com>, Rafael Wysocki <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, Chao Fan <fanc.fnst@cn.fujitsu.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 18, 2019 at 7:26 PM Borislav Petkov <bp@alien8.de> wrote:

> No, this is getting completely nuts: there's a bunch of functions which
> all end up returning boot_params's field except pvh_get_root_pointer().
>
> And now you're adding a late variant. And the cmdline paramater
> acpi_rsdp is in a CONFIG_KEXEC wrapper, and and...
>
> Wait until Chao Fan's stuff is applied, then do your changes ontop
> an drop all that ifdeffery. We will make this RDSP thing enabled
> unconditionally so that there's no need for ifdeffery and function
> wrappers.
>
> Also, after Chao's stuff, you won't need to call
> acpi_os_get_root_pointer() because the early code would've done that.
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.

Good suggestion, will wait for Chao's update then.


--
Best Regards,
Kairui Song

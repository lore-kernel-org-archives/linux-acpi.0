From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v3 2/3] acpi: store acpi_rsdp address for later kexec
 usage
Date: Fri, 18 Jan 2019 12:26:28 +0100
Message-ID: <20190118112628.GC622@zn.tnic>
References: <20190118111310.29589-1-kasong@redhat.com>
 <20190118111310.29589-3-kasong@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190118111310.29589-3-kasong@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kairui Song <kasong@redhat.com>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, dyoung@redhat.com, bhe@redhat.com, kexec@lists.infradead.org, akpm@linux-foundation.org, robert.moore@intel.com, erik.schmauss@intel.com, rafael.j.wysocki@intel.com, lenb@kernel.org, fanc.fnst@cn.fujitsu.com, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Fri, Jan 18, 2019 at 07:13:09PM +0800, Kairui Song wrote:
> Currently we have acpi_os_get_root_pointer as the universal function
> to get RSDP address. But the function itself and some functions it
> depends on are in .init section and make it not easy to retrieve the
> RSDP value once kernel is initialized.
> 
> And for kexec, it need to retrive RSDP again if EFI is disabled, because
> the second kernel will not be able get the RSDP value in such case, so
> it expects either the user specify the RSDP value using kernel cmdline,
> or kexec could retrive and pass the RSDP value using boot_params.
> 
> This patch stores the RSDP address when initialized is done, and
> introduce an acpi_os_get_root_pointer_late for later kexec usage.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  drivers/acpi/osl.c   | 10 ++++++++++
>  include/linux/acpi.h |  3 +++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index f29e427d0d1d..6340d34d0df1 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -187,6 +187,16 @@ static int __init setup_acpi_rsdp(char *arg)
>  	return kstrtoul(arg, 16, &acpi_rsdp);
>  }
>  early_param("acpi_rsdp", setup_acpi_rsdp);
> +
> +acpi_physical_address acpi_os_get_root_pointer_late(void) {
> +	return acpi_rsdp;
> +}
> +
> +static int __init acpi_store_root_pointer(void) {
> +	acpi_rsdp = acpi_os_get_root_pointer();
> +	return 0;
> +}

No, this is getting completely nuts: there's a bunch of functions which
all end up returning boot_params's field except pvh_get_root_pointer().

And now you're adding a late variant. And the cmdline paramater
acpi_rsdp is in a CONFIG_KEXEC wrapper, and and...

Wait until Chao Fan's stuff is applied, then do your changes ontop
an drop all that ifdeffery. We will make this RDSP thing enabled
unconditionally so that there's no need for ifdeffery and function
wrappers.

Also, after Chao's stuff, you won't need to call
acpi_os_get_root_pointer() because the early code would've done that.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.

From: Randy Dunlap <rdunlap@xenotime.net>
Subject: Re: [Patch] acpi: introduce "acpi_addr=" parameter for kdump
Date: Thu, 10 Mar 2011 08:26:00 -0800
Message-ID: <20110310082600.b52de7fb.rdunlap@xenotime.net>
References: <1299766243-494-1-git-send-email-amwang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-doc-owner@vger.kernel.org>
In-Reply-To: <1299766243-494-1-git-send-email-amwang@redhat.com>
Sender: linux-doc-owner@vger.kernel.org
To: Amerigo Wang <amwang@redhat.com>
Cc: linux-kernel@vger.kernel.org, Takao Indoh <tindoh@redhat.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Len Brown <lenb@kernel.org>, linux-doc@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org

On Thu, 10 Mar 2011 22:10:43 +0800 Amerigo Wang wrote:

> From: Takao Indoh <tindoh@redhat.com>
> 
> There is a problem with putting the first kernel in EFI virtual mode,
> it is that when the second kernel comes up it tries to initialize the
> EFI again and once we have put EFI in virtual mode we can not really
> do that.
> 
> Actually, EFI is not necessary for kdump, we can boot the second kernel
> with "noefi" parameter, but the boot will mostly fail because 2nd kernel
> cannot find RSDP.
> 
> In this situation, we introduced "acpi_addr=" kernel parameter,
> so that kexec-tools can pass the "noefi acpi_addr=X" to the second kernel
> to make kdump works.
> 
> Signed-off-by: Takao Indoh <tindoh@redhat.com>
> [amwang@redhat.com: Add documentation.]
> Signed-off-by: WANG Cong <amwang@redhat.com>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Vivek Goyal <vgoyal@redhat.com>
> 
> ---
> 
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index f4a04c0..0fbbdc6 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -163,6 +163,11 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  
>  			See also Documentation/power/pm.txt, pci=noacpi
>  
> +	acpi_addr=	[ACPI,EFI]
> +			Pass the RSDP address to the kernel, mostly used
> +			on machines running EFI runtime service to boot the
> +			second kernel for kdump.
> +

I think that "acpi_addr" is a bit too generic.  How about
acpi_rsdp or acpi_root instead?


>  	acpi_apic_instance=	[ACPI, IOAPIC]
>  			Format: <int>
>  			2: use 2nd APIC table, if available
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index c90c76a..06dfec0 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -238,8 +238,19 @@ void acpi_os_vprintf(const char *fmt, va_list args)
>  #endif
>  }
>  
> +static unsigned long acpi_addr;
> +static int __init setup_acpi_addr(char *arg)
> +{
> +	acpi_addr = simple_strtoul(arg, NULL, 16);
> +	return 0;
> +}
> +early_param("acpi_addr", setup_acpi_addr);
> +
>  acpi_physical_address __init acpi_os_get_root_pointer(void)
>  {
> +	if (acpi_addr)
> +		return acpi_addr;
> +
>  	if (efi_enabled) {
>  		if (efi.acpi20 != EFI_INVALID_TABLE_ADDR)
>  			return efi.acpi20;


---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***

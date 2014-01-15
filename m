From: David Rientjes <rientjes@google.com>
Subject: Re: [PATCH] acpi memory hotplug, add parameter to disable memory
 hotplug [v3]
Date: Tue, 14 Jan 2014 16:42:24 -0800 (PST)
Message-ID: <alpine.DEB.2.02.1401141642020.3375@chino.kir.corp.google.com>
References: <1389727273-27817-1-git-send-email-prarit@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1389727273-27817-1-git-send-email-prarit@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Prarit Bhargava <prarit@redhat.com>
Cc: linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, kosaki.motohiro@gmail.com, dyoung@redhat.com, toshi.kani@hp.com, isimatu.yasuaki@jp.fujitsu.com, linux-acpi@vger.kernel.org, kexec@lists.infradead.org
List-Id: linux-acpi@vger.kernel.org

On Tue, 14 Jan 2014, Prarit Bhargava wrote:

> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> index b9e9bd8..ea93f75 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -343,6 +343,9 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
>  			no: ACPI OperationRegions are not marked as reserved,
>  			no further checks are performed.
>  
> +	acpi_no_memhotplug [ACPI] Disable memory hotplug.  Useful for kexec
> +			   and kdump kernels.
> +
>  	add_efi_memmap	[EFI; X86] Include EFI memory map in
>  			kernel's map of available physical RAM.
>  
> diff --git a/drivers/acpi/acpi_memhotplug.c b/drivers/acpi/acpi_memhotplug.c
> index 551dad7..4a0fa94 100644
> --- a/drivers/acpi/acpi_memhotplug.c
> +++ b/drivers/acpi/acpi_memhotplug.c
> @@ -361,7 +361,19 @@ static void acpi_memory_device_remove(struct acpi_device *device)
>  	acpi_memory_device_free(mem_device);
>  }
>  
> +static bool acpi_no_memhotplug;
> +

I think this should be annotated with __initdata.

>  void __init acpi_memory_hotplug_init(void)
>  {
> +	if (acpi_no_memhotplug)
> +		return;
> +
>  	acpi_scan_add_handler_with_hotplug(&memory_device_handler, "memory");
>  }
> +
> +static int __init disable_acpi_memory_hotplug(char *str)
> +{
> +	acpi_no_memhotplug = true;
> +	return 1;
> +}
> +__setup("acpi_no_memhotplug", disable_acpi_memory_hotplug);

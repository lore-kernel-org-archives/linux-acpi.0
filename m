From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] acpi: try to trust cpu_index from x86_cpu_to_apicid
Date: Mon, 21 Apr 2014 22:51:31 +0200
Message-ID: <11963454.DotWb00OAa@vostro.rjw.lan>
References: <1397519754-10205-1-git-send-email-bhe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1397519754-10205-1-git-send-email-bhe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Baoquan He <bhe@redhat.com>
Cc: linux-kernel@vger.kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org, jiang.liu@linux.intel.com, vgoyal@redhat.com
List-Id: linux-acpi@vger.kernel.org

On Tuesday, April 15, 2014 07:55:54 AM Baoquan He wrote:
> In smp with multi cpus, when enter into kdump kernel with only 1 cpu,
> a warning message is printed out:
> 
> acpi LNXCPU:0a: BIOS reported wrong ACPI id 0 for the processor
> 
> In this case kdump kernel use the same ACPI tables as 1st kernel,
> means lapic information is got from MADT. The acpi_id related to
> this cpu index and lapic_id may not be 0, so the code to assign
> value to cpu_index is not correct in this case per cpu0_initialized.
> cpu index stored in x86_cpu_to_apicid need be respected.
> 
> Now fix it in this patch per boot_cpu_physical_apicid. When cpu index
> related to boot_cpu_physical_apicid is not stored in x86_cpu_to_apicid,
> then we can say this is UP system running SMP kernel with no LAPIC in MADT

Why don't you fix the warning message instead to cover this case too? 

> Signed-off-by: Baoquan He <bhe@redhat.com>
> ---
>  drivers/acpi/acpi_processor.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index c29c2c3..1ae460c 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -267,7 +267,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>  	pr->apic_id = apic_id;
>  
>  	cpu_index = acpi_map_cpuid(pr->apic_id, pr->acpi_id);
> -	if (!cpu0_initialized) {
> +	if (!cpu0_initialized && (boot_cpu_physical_apicid == pr->apic_id)) {
>  		cpu0_initialized = 1;
>  		/* Handle UP system running SMP kernel, with no LAPIC in MADT */
>  		if ((cpu_index == -1) && (num_online_cpus() == 1))
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.

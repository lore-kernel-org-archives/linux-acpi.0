From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v2 1/7] ACPI / processor: remove cpu_index in acpi_processor_get_info()
Date: Tue, 05 May 2015 12:08:34 +0100
Message-ID: <5548A4B2.5030603@arm.com>
References: <1430793998-21631-1-git-send-email-hanjun.guo@linaro.org> <1430793998-21631-2-git-send-email-hanjun.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:44454 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752913AbbEELIj (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 5 May 2015 07:08:39 -0400
In-Reply-To: <1430793998-21631-2-git-send-email-hanjun.guo@linaro.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Hanjun Guo <hanjun.guo@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Will Deacon <Will.Deacon@arm.com>, Catalin Marinas <Catalin.Marinas@arm.com>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>



On 05/05/15 03:46, Hanjun Guo wrote:
> Just use pr->id instead of cpu_index to simplify the code.
>

IIRC pr->id is u32, has it changed in any other patches that's not in
mainline ? Otherwise, comparing it with -1 makes no sense here.

Regards,
Sudeep

> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> ---
>   drivers/acpi/acpi_processor.c | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
> index 58f335c..d6ac918 100644
> --- a/drivers/acpi/acpi_processor.c
> +++ b/drivers/acpi/acpi_processor.c
> @@ -216,7 +216,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>   	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
>   	struct acpi_processor *pr = acpi_driver_data(device);
>   	phys_cpuid_t phys_id;
> -	int cpu_index, device_declaration = 0;
> +	int device_declaration = 0;
>   	acpi_status status = AE_OK;
>   	static int cpu0_initialized;
>   	unsigned long long value;
> @@ -268,17 +268,16 @@ static int acpi_processor_get_info(struct acpi_device *device)
>   		acpi_handle_debug(pr->handle, "failed to get CPU physical ID.\n");
>   	pr->phys_id = phys_id;
>
> -	cpu_index = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
> +	pr->id = acpi_map_cpuid(pr->phys_id, pr->acpi_id);
>   	if (!cpu0_initialized && !acpi_has_cpu_in_madt()) {
>   		cpu0_initialized = 1;
>   		/*
>   		 * Handle UP system running SMP kernel, with no CPU
>   		 * entry in MADT
>   		 */
> -		if ((cpu_index == -1) && (num_online_cpus() == 1))
> -			cpu_index = 0;
> +		if ((pr->id == -1) && (num_online_cpus() == 1))
> +			pr->id = 0;
>   	}
> -	pr->id = cpu_index;
>
>   	/*
>   	 *  Extra Processor objects may be enumerated on MP systems with
>

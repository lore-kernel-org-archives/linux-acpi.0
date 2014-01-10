From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [PATCH] ACPI: print error message and bail out early if failed
 to parse APIC ID for CPU
Date: Fri, 10 Jan 2014 09:35:08 +0800
Message-ID: <52CF4E4C.7080909@linux.intel.com>
References: <1389255320-1563-1-git-send-email-jiang.liu@linux.intel.com> <5603175.k76fij1bcj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5603175.k76fij1bcj@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org



On 2014/1/9 20:12, Rafael J. Wysocki wrote:
> On Thursday, January 09, 2014 04:15:19 PM Jiang Liu wrote:
>> Enhance ACPI CPU hotplug driver to print clear error message and
>> bail out early if BIOS returns wrong value in ACPI MADT table or
>> _MAT method. Otherwise it will add the CPU device even if failed
>> to get APIC ID and fails any operations against sysfs interface:
>> /sys/devices/system/cpu/cpux/online
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
> 
> Do you have any pointers to bug reports regarding this etc.?  If so,
> it would be good to add links to them to the commit log.
Hi Rafael,
	I have no bug id for this. It was found during verifying an
internal BIOS version, so no external bug id for it yet.
Cheers!
Gerry
> 
> Thanks!
> 
>> ---
>>  drivers/acpi/acpi_processor.c |   24 ++++++++++++++----------
>>  1 file changed, 14 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
>> index 3c1d6b0..6ce71b0 100644
>> --- a/drivers/acpi/acpi_processor.c
>> +++ b/drivers/acpi/acpi_processor.c
>> @@ -212,7 +212,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>  	union acpi_object object = { 0 };
>>  	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
>>  	struct acpi_processor *pr = acpi_driver_data(device);
>> -	int cpu_index, device_declaration = 0;
>> +	int apic_id, cpu_index, device_declaration = 0;
>>  	acpi_status status = AE_OK;
>>  	static int cpu0_initialized;
>>  	unsigned long long value;
>> @@ -258,18 +258,21 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>  		device_declaration = 1;
>>  		pr->acpi_id = value;
>>  	}
>> -	pr->apic_id = acpi_get_apicid(pr->handle, device_declaration,
>> -					pr->acpi_id);
>> -	cpu_index = acpi_map_cpuid(pr->apic_id, pr->acpi_id);
>>  
>> -	/* Handle UP system running SMP kernel, with no LAPIC in MADT */
>> -	if (!cpu0_initialized && (cpu_index == -1) &&
>> -	    (num_online_cpus() == 1)) {
>> -		cpu_index = 0;
>> +	apic_id = acpi_get_apicid(pr->handle, device_declaration, pr->acpi_id);
>> +	if (apic_id < 0) {
>> +		acpi_handle_err(pr->handle, "failed to get CPU APIC ID.\n");
>> +		return -ENODEV;
>>  	}
>> +	pr->apic_id = apic_id;
>>  
>> -	cpu0_initialized = 1;
>> -
>> +	cpu_index = acpi_map_cpuid(pr->apic_id, pr->acpi_id);
>> +	if (!cpu0_initialized) {
>> +		cpu0_initialized = 1;
>> +		/* Handle UP system running SMP kernel, with no LAPIC in MADT */
>> +		if ((cpu_index == -1) && (num_online_cpus() == 1))
>> +			cpu_index = 0;
>> +	}
>>  	pr->id = cpu_index;
>>  
>>  	/*
>> @@ -282,6 +285,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
>>  		if (ret)
>>  			return ret;
>>  	}
>> +
>>  	/*
>>  	 * On some boxes several processors use the same processor bus id.
>>  	 * But they are located in different scope. For example:
>>
> 

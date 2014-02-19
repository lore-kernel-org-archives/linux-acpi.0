From: Jiang Liu <jiang.liu@linux.intel.com>
Subject: Re: [RFC Patch v1 3/6] acpi_pad: use acpi_evaluate_pad() to replace
 open-coded version
Date: Wed, 19 Feb 2014 13:57:49 +0800
Message-ID: <530447DD.7080805@linux.intel.com>
References: <1392613271-10912-1-git-send-email-jiang.liu@linux.intel.com> <1392613373-11003-1-git-send-email-jiang.liu@linux.intel.com> <1392613373-11003-3-git-send-email-jiang.liu@linux.intel.com> <2178847.Vaot4mm02Q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:2954 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761AbaBSF6M (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 19 Feb 2014 00:58:12 -0500
In-Reply-To: <2178847.Vaot4mm02Q@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Lv Zheng <lv.zheng@intel.com>, Len Brown <lenb@kernel.org>, Tony Luck <tony.luck@intel.com>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi Rafael,
	Thanks for reminder, will fix it in next version.

Cheers!
Gerry

On 2014/2/18 9:07, Rafael J. Wysocki wrote:
> On Monday, February 17, 2014 01:02:50 PM Jiang Liu wrote:
>> Use public function acpi_evaluate_pad() to replace open-coded
> 
> I suppose you mean acpi_evaluate_ost()?  And in the other patches
> in this series too?
> 
>> version of evaluating ACPI _OST method.
>>
>> Signed-off-by: Jiang Liu <jiang.liu@linux.intel.com>
>> ---
>>  drivers/acpi/acpi_pad.c |   24 +++++-------------------
>>  1 file changed, 5 insertions(+), 19 deletions(-)
>>
>> diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
>> index 1e3ce76..86b4e11 100644
>> --- a/drivers/acpi/acpi_pad.c
>> +++ b/drivers/acpi/acpi_pad.c
>> @@ -408,28 +408,14 @@ static int acpi_pad_pur(acpi_handle handle)
>>  	return num;
>>  }
>>  
>> -/* Notify firmware how many CPUs are idle */
>> -static void acpi_pad_ost(acpi_handle handle, int stat,
>> -	uint32_t idle_cpus)
>> -{
>> -	union acpi_object params[3] = {
>> -		{.type = ACPI_TYPE_INTEGER,},
>> -		{.type = ACPI_TYPE_INTEGER,},
>> -		{.type = ACPI_TYPE_BUFFER,},
>> -	};
>> -	struct acpi_object_list arg_list = {3, params};
>> -
>> -	params[0].integer.value = ACPI_PROCESSOR_AGGREGATOR_NOTIFY;
>> -	params[1].integer.value =  stat;
>> -	params[2].buffer.length = 4;
>> -	params[2].buffer.pointer = (void *)&idle_cpus;
>> -	acpi_evaluate_object(handle, "_OST", &arg_list, NULL);
>> -}
>> -
>>  static void acpi_pad_handle_notify(acpi_handle handle)
>>  {
>>  	int num_cpus;
>>  	uint32_t idle_cpus;
>> +	struct acpi_buffer param = {
>> +		.length = 4,
>> +		.pointer = (void *)&idle_cpus,
>> +	};
>>  
>>  	mutex_lock(&isolated_cpus_lock);
>>  	num_cpus = acpi_pad_pur(handle);
>> @@ -439,7 +425,7 @@ static void acpi_pad_handle_notify(acpi_handle handle)
>>  	}
>>  	acpi_pad_idle_cpus(num_cpus);
>>  	idle_cpus = acpi_pad_idle_cpus_num();
>> -	acpi_pad_ost(handle, 0, idle_cpus);
>> +	acpi_evaluate_ost(handle, ACPI_PROCESSOR_AGGREGATOR_NOTIFY, 0, &param);
>>  	mutex_unlock(&isolated_cpus_lock);
>>  }
>>  
>>
> 

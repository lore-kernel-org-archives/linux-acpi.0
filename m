From: Dou Liyang <douly.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v2 3/4] acpi: Fix the check handle in case of declaring
 processors using the Device operator
Date: Thu, 2 Mar 2017 16:12:23 +0800
Message-ID: <d45eeebf-2b91-c718-6168-6ff1fdeffc9c@cn.fujitsu.com>
References: <1487580471-17665-1-git-send-email-douly.fnst@cn.fujitsu.com>
 <1487580471-17665-4-git-send-email-douly.fnst@cn.fujitsu.com>
 <alpine.DEB.2.20.1703011152310.4005@nanos>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from cn.fujitsu.com ([59.151.112.132]:7849 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754239AbdCBIMf (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Mar 2017 03:12:35 -0500
In-Reply-To: <alpine.DEB.2.20.1703011152310.4005@nanos>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: mingo@kernel.org, peterz@infradead.org, rjw@rjwysocki.net, hpa@zytor.com, rafael@kernel.org, cl@linux.com, tj@kernel.org, akpm@linux-foundation.org, rafael.j.wysocki@intel.com, len.brown@intel.com, izumi.taku@jp.fujitsu.com, xiaolong.ye@intel.com, x86@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org

Hi tglx,

At 03/01/2017 07:12 PM, Thomas Gleixner wrote:
> On Mon, 20 Feb 2017, Dou Liyang wrote:
>
>> In ACPI spec, we can declare processors using both Processor and
>> Device operator. And before we use the ACPI table, we should check
>> the correctness for all processors in ACPI namespace.
>>
>> But, Currently, the check handle is just include only the processors
>> which are declared by Processor operator. It misses the processors
>> declared by Device operator.
>>
>> The patch adds the case of Device operator.
>
> See the comments in the previous mails. They apply here as well.
>
> Though this changelog is actively confusing. The subject line says:
>
>   acpi: Fix the check handle in case of declaring processors using the Device
>   	operator
>
> Aside of being a way too long subject, it suggests that there is just a
> missing check for the case where a processor is declared via the Device
> operator. But that's not what the patch is doing.
>
> It implements the distinction between Device and Processor operator, which
> is missing in acpi_processor_ids_walk() right now.
>
> So the proper changelog (if I understand the patch correctly) would be:
>
> Subject: acpi/processor: Implement DEVICE operator for processor enumeration
>
>   ACPI allows to declare processors either with the PROCESSOR or with the
>   DEVICE operator. The current implementation handles only the PROCESSOR
>   operator.
>
>   On a system which uses the DEVICE operator for processor enumeration the
>   evaluation fails.
>
>   Check for the ACPI type of the ACPI handle and evaluate PROCESSOR and
>   DEVICE types seperately.
>
> Hmm?
>

Yes, you are right. I didn't explain clearly.
I will modify in my next version.

>>  {
>>  	acpi_status status;
>> +	acpi_object_type acpi_type;
>> +	unsigned long long uid;
>>  	union acpi_object object = { 0 };
>>  	struct acpi_buffer buffer = { sizeof(union acpi_object), &object };
>>
>> -	status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
>> -	if (ACPI_FAILURE(status))
>> -		acpi_handle_info(handle, "Not get the processor object\n");
>> -	else
>> -		processor_validated_ids_update(object.processor.proc_id);
>> +	status = acpi_get_type(handle, &acpi_type);
>
> Shouldn't the status be checked here?

oops, Yes. Need to be checked.

>
>> +	switch (acpi_type) {
>> +	case ACPI_TYPE_PROCESSOR:
>> +		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
>> +		if (ACPI_FAILURE(status))
>> +			acpi_handle_info(handle, "Not get the processor object\n");
>> +		else
>> +			processor_validated_ids_update(
>> +						object.processor.proc_id);
>> +		break;
>> +	case ACPI_TYPE_DEVICE:
>> +		status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
>> +		if (ACPI_FAILURE(status))
>> +			return false;
>> +		processor_validated_ids_update(uid);
>> +		break;
>> +	default:
>> +		return false;
>
> This is inconsistent vs. the failure handling in the PROCESSOR and DEVICE
> case and the default case does not give any information either.
>
> What about this:
>
> 	switch (acpi_type) {
> 	case ACPI_TYPE_PROCESSOR:
> 		status = acpi_evaluate_object(handle, NULL, NULL, &buffer);
> 		if (ACPI_FAILURE(status))
> 			goto err;
> 		uid = object.processor.proc_id;
> 		break;
> 		
> 	case ACPI_TYPE_DEVICE:
> 		status = acpi_evaluate_integer(handle, "_UID", NULL, &uid);
> 		if (ACPI_FAILURE(status))
> 			goto err;
> 		break;
> 	default:
> 		goto err;
> 	}
>
> 	processor_validated_ids_update(uid);
> 	return true;
>
> err:
> 	acpi_handle_info(handle, "Invalid processor object\n");
> 	return false;
> }
>

Looks good than mine.

Thanks,
	Liyang.

> Thanks,
>
> 	tglx
>
>
>



From: Al Stone <al.stone@linaro.org>
Subject: Re: [PATCH v6 6/6] ACPI: make sure ECs do not use the ACPI global
 lock
Date: Mon, 13 Jan 2014 16:46:13 -0700
Message-ID: <52D47AC5.7080508@linaro.org>
References: <1389394340-2680-1-git-send-email-al.stone@linaro.org> <1389394340-2680-7-git-send-email-al.stone@linaro.org> <1826710.CJqGCqohkh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:47562 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751921AbaAMXqP (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Mon, 13 Jan 2014 18:46:15 -0500
Received: by mail-pd0-f172.google.com with SMTP id z10so2670252pdj.17
        for <linux-acpi@vger.kernel.org>; Mon, 13 Jan 2014 15:46:14 -0800 (PST)
In-Reply-To: <1826710.CJqGCqohkh@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-acpi@lists.linaro.org, patches@linaro.org, linaro-kernel@lists.linaro.org

On 01/10/2014 04:33 PM, Rafael J. Wysocki wrote:
> On Friday, January 10, 2014 03:52:20 PM al.stone@linaro.org wrote:
>> From: Al Stone <al.stone@linaro.org>
>>
>> ACPI ECs (Embedded Controllers) are allowed to use the ACPI global
>> lock in legacy mode.  Since there is no global lock in hardware
>> reduced mode, make sure that ECs cannot inadvertently use it with
>> older ACPI tables that may have defined an _GLK method for the
>> EC device.  Since an individual lock can and should be defined for
>> each EC, access to each EC should still be properly controlled.
>>
>> Signed-off-by: Al Stone <al.stone@linaro.org>
>> ---
>>   drivers/acpi/ec.c | 12 ++++++++++--
>>   1 file changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/acpi/ec.c b/drivers/acpi/ec.c
>> index ba5b56d..3f15110 100644
>> --- a/drivers/acpi/ec.c
>> +++ b/drivers/acpi/ec.c
>> @@ -745,9 +745,17 @@ ec_parse_device(acpi_handle handle, u32 Level, void *context, void **retval)
>>   	if (ACPI_FAILURE(status))
>>   		return status;
>>   	ec->gpe = tmp;
>> -	/* Use the global lock for all EC transactions? */
>> +	/*
>> +	 * Use the global lock for all EC transactions?
>> +	 *
>> +	 * If ACPI is in hardware reduced mode, there is no global lock.
>> +	 * If a _GLK method is defined, it needs to be ignored, just
>> +	 * in case it returns "true", which could happen if the ASL is
>> +	 * written incorrectly.
>
> What is going to happen if it is defined and works correctly in turn?

If for any reason the ec->global_lock field is non-zero, then every
time an EC transaction is being run (acpi_ec_transaction()), there will
be an attempt to acquire the ACPI global lock in violation of the
definition of hardware reduced mode -- the spec says that there is
no ACPI global lock in this mode.

Since the ACPICA code acpi_acquire_global_lock() doesn't check if it
is in hardware reduced or not, it will go ahead and make the attempt.
And again, things will work, but we will not be in hardware reduced
mode by definition.

If the ACPICA code is compiled for hardware reduced only, then
acpi_acquire_global_lock() is properly stubbed out and we would
stay in compliance with the spec's definition of hardware reduced.

>> +	 */
>>   	tmp = 0;
>> -	acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
>> +	if (!acpi_gbl_reduced_hardware)
>> +		acpi_evaluate_integer(handle, "_GLK", NULL, &tmp);
>>   	ec->global_lock = tmp;
>>   	ec->handle = handle;
>>   	return AE_CTRL_TERMINATE;
>>
>


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Linaro Enterprise Group
al.stone@linaro.org
-----------------------------------

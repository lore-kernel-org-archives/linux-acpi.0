From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: Re: [PATCH] ACPI / CPPC: Use 64-bit arithmetic instead of 32-bit
Date: Thu, 8 Feb 2018 10:40:38 -0600
Message-ID: <1f5cffd5-4806-a8e6-48d7-bc2f8ec1d440@embeddedor.com>
References: <20180206233617.GA30829@embeddedgus>
 <2503109.MpnWDuSnnD@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from gateway36.websitewelcome.com ([192.185.193.12]:27906 "EHLO
        gateway36.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751544AbeBHRFB (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Thu, 8 Feb 2018 12:05:01 -0500
Received: from cm12.websitewelcome.com (cm12.websitewelcome.com [100.42.49.8])
        by gateway36.websitewelcome.com (Postfix) with ESMTP id 08B7C40173478
        for <linux-acpi@vger.kernel.org>; Thu,  8 Feb 2018 10:40:40 -0600 (CST)
In-Reply-To: <2503109.MpnWDuSnnD@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org



On 02/08/2018 03:49 AM, Rafael J. Wysocki wrote:
> On Wednesday, February 7, 2018 12:36:17 AM CET Gustavo A. R. Silva wrote:
>> Add suffix ULL to constant 500 in order to give the compiler complete
>> information about the proper arithmetic to use. Notice that this
>> constant is used in a context that expects an expression of type
>> u64 (64 bits, unsigned).
>>
>> The expression NUM_RETRIES * cppc_ss->latency at line 578, which at
>> preprocessing time translates to 500 * cppc_ss->latency is currently
>> being evaluated using 32-bit arithmetic.
>>
>> Addresses-Coverity-ID: 1382602
>> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
>> ---
>> Notice that another option is to cast NUM_RETRIES to u64 at line 578,
>> but as there is only one instace in which this macro is being used I
>> think adding the ULL is just enough.
>>
>>   drivers/acpi/cppc_acpi.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 06ea474..0afbb26 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -119,7 +119,7 @@ static DEFINE_PER_CPU(struct cpc_desc *, cpc_desc_ptr);
>>    * to PCC commands. Keeping it high enough to cover emulators where
>>    * the processors run painfully slow.
>>    */
>> -#define NUM_RETRIES 500
>> +#define NUM_RETRIES 500ULL
>>   
>>   struct cppc_attr {
>>   	struct attribute attr;
>>
> 
> Applied, thanks!
> 
> 

Thank you, Rafael.

-- 
Gustavo

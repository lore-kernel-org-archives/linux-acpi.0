From: Punit Agrawal <punit.agrawal@arm.com>
Subject: Re: [PATCH] acpi/apei: Fix in-correct return value
Date: Fri, 21 Oct 2016 15:58:15 +0100
Message-ID: <877f9121h4.fsf@e105922-lin.cambridge.arm.com>
References: <20161018160719.31252-1-punit.agrawal@arm.com>
        <a159bf94-223b-7ec5-b4a5-16ab65662e1e@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:46612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755445AbcJUO6U (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 21 Oct 2016 10:58:20 -0400
In-Reply-To: <a159bf94-223b-7ec5-b4a5-16ab65662e1e@codeaurora.org> (Tyler
        Baicar's message of "Thu, 20 Oct 2016 13:51:31 -0600")
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Baicar, Tyler" <tbaicar@codeaurora.org>
Cc: linux-acpi@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, bp@suse.de, Len Brown <lenb@kernel.org>

"Baicar, Tyler" <tbaicar@codeaurora.org> writes:

> On 10/18/2016 10:07 AM, Punit Agrawal wrote:
>> Although ghes_proc tests for error while reading the error status, it
>> always return success (0). Fix this by propagating the return value.
>>
>> Fixes: d334a49113a4a33 ("ACPI, APEI, Generic Hardware Error Source memory error support")
>> Signed-of-by: Punit Agrawal <punit.agrawa.@arm.com>
>> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
>> Cc: Len Brown <lenb@kernel.org>
> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>

Thanks for taking the patch for a spin.

Hopefully Rafael can pick the patch as a fixes for the next rc.


>
> Thanks,
> Tyler
>> ---
>>   drivers/acpi/apei/ghes.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index f0a029e..0d099a2 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -662,7 +662,7 @@ static int ghes_proc(struct ghes *ghes)
>>   	ghes_do_proc(ghes, ghes->estatus);
>>   out:
>>   	ghes_clear_estatus(ghes);
>> -	return 0;
>> +	return rc;
>>   }
>>     static void ghes_add_timer(struct ghes *ghes)

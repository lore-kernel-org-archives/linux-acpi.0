From: Zhengqiang <zhengqiang10@huawei.com>
Subject: Re: [PATCH] Bug fix: Clear ack of GHES table which contain wrong
 Error status block, let new error can fill GHES table.
Date: Tue, 31 Oct 2017 16:22:43 +0800
Message-ID: <59F832D3.5050401@huawei.com>
References: <1509326594-201050-1-git-send-email-zhengqiang10@huawei.com>
 <61027894-b8ab-b90d-05fa-c8a04acfa42d@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <61027894-b8ab-b90d-05fa-c8a04acfa42d@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Tyler Baicar <tbaicar@codeaurora.org>, will.deacon@arm.com, james.morse@arm.com, shiju.jose@huawei.com, rjw@rjwysocki.net
Cc: gengdongjiu@huawei.com, wangxiongfeng2@huawei.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linuxarm@huawei.com
List-Id: linux-acpi@vger.kernel.org

Hi, Tyler Baicar,
Sorry, i missed your patch, you already solved it. thanks.

On 2017/10/30 21:53, Tyler Baicar wrote:
> On 10/29/2017 9:23 PM, Qiang Zheng wrote:
>> Current Error status block processing flow, if wrong format is checked,
>> GHES table ack is not cleared.
>> It will cause new error can not be filled GHES table, because UEFI
>> need check ack to know if error was handled by OS.
>>
>> This patch solved issue, no matter Error status block format is wrong,
>> But GHES table format is corrected, we clear ack.
>>
>> Signed-off-by: Qiang Zheng <zhengqiang10@huawei.com>
>> ---
>>   drivers/acpi/apei/ghes.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index 077f9ba..b0e0782 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -743,6 +743,7 @@ static int ghes_proc(struct ghes *ghes)
>>       }
>>       ghes_do_proc(ghes, ghes->estatus);
>>   +out:
> The out goto is already at this location. Please sync to the tip:
> 
>         ghes_do_proc(ghes, ghes->estatus);
> 
> out:
>         ghes_clear_estatus(ghes);
> 
>         if (rc == -ENOENT)
>                 return rc;
> 
>         /*
>          * GHESv2 type HEST entries introduce support for error acknowledgment,
>          * so only acknowledge the error if this support is present.
>          */
>         if (is_hest_type_generic_v2(ghes))
>                 return ghes_ack_error(ghes->generic_v2);
> 
>         return rc;
> 
> 
>>       /*
>>        * GHESv2 type HEST entries introduce support for error acknowledgment,
>>        * so only acknowledge the error if this support is present.
>> @@ -752,7 +753,7 @@ static int ghes_proc(struct ghes *ghes)
>>           if (rc)
>>               return rc;
>>       }
>> -out:
>> +
>>       ghes_clear_estatus(ghes);
>>       return rc;
>>   }
> 

From: Xie XiuQi <xiexiuqi@huawei.com>
Subject: Re: [PATCH v5 2/3] GHES: add a notify chain for process memory
 section
Date: Thu, 8 Feb 2018 16:41:23 +0800
Message-ID: <a26d3082-ef72-9684-5f22-4d65b8adb998@huawei.com>
References: <1516969885-150532-1-git-send-email-xiexiuqi@huawei.com>
 <1516969885-150532-3-git-send-email-xiexiuqi@huawei.com>
 <20180207103145.GC8944@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from szxga06-in.huawei.com ([45.249.212.32]:33120 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750865AbeBHIq2 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 8 Feb 2018 03:46:28 -0500
In-Reply-To: <20180207103145.GC8944@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Borislav Petkov <bp@suse.de>
Cc: catalin.marinas@arm.com, will.deacon@arm.com, mingo@redhat.com, mark.rutland@arm.com, ard.biesheuvel@linaro.org, james.morse@arm.com, Dave.Martin@arm.com, takahiro.akashi@linaro.org, tbaicar@codeaurora.org, stephen.boyd@linaro.org, julien.thierry@arm.com, shiju.jose@huawei.com, zjzhang@codeaurora.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, wangxiongfeng2@huawei.com, zhengqiang10@huawei.com, gengdongjiu@huawei.com, huawei.libin@huawei.com, wangkefeng.wang@huawei.com, lijinyue@huawei.com, guohanjun@huawei.com, hanjun.guo@linaro.org, cj.chengjian@huawei.com

Hi Boris,

Thanks for your comments.

On 2018/2/7 18:31, Borislav Petkov wrote:
> On Fri, Jan 26, 2018 at 08:31:24PM +0800, Xie XiuQi wrote:
>> Add a notify chain for process memory section, with
>> which other modules might do error recovery.
>>
>> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
>> Tested-by: Wang Xiongfeng <wangxiongfeng2@huawei.com>
>> Tested-by: Tyler Baicar <tbaicar@codeaurora.org>
>> ---
>>  drivers/acpi/apei/ghes.c | 10 ++++++++++
>>  include/acpi/ghes.h      |  8 ++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
>> index cff671d..1f0ebfb 100644
>> --- a/drivers/acpi/apei/ghes.c
>> +++ b/drivers/acpi/apei/ghes.c
>> @@ -109,6 +109,9 @@ static inline bool is_hest_type_generic_v2(struct ghes *ghes)
>>  static LIST_HEAD(ghes_hed);
>>  static DEFINE_MUTEX(ghes_list_mutex);
>>  
>> +ATOMIC_NOTIFIER_HEAD(ghes_mem_err_chain);
>> +EXPORT_SYMBOL(ghes_mem_err_chain);
> 
> Definitely not EXPORT_SYMBOL.
> 
> And certainly not export the notifier head. Have register and unregister
> functions instead.
> 
> That is, *if* you can't solve it differently with James. Notifiers
> should be avoided if possible.
> 

Yes, I saw the patchset, I agree. I will work with James to solve the problem.

-- 
Thanks,
Xie XiuQi


From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: Re: [PATCH v2 0/2] Work around for Hisilicon CPPC cpufreq
Date: Thu, 14 Feb 2019 21:27:04 +0800
Message-ID: <851b2825-3324-cfc4-0806-d4aa7ef577cd@huawei.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
 <2f397788-fcb0-a781-c497-9e698494f508@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2f397788-fcb0-a781-c497-9e698494f508@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: John Garry <john.garry@huawei.com>, viresh.kumar@linaro.org, rafael@kernel.org, gcherianv@gmail.com, pprakash@codeaurora.org, george.cherian@cavium.com, robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com
List-Id: linux-acpi@vger.kernel.org



On 2019/2/14 19:39, John Garry wrote:
> On 14/02/2019 07:46, Xiongfeng Wang wrote:
>> Hisilicon chips do not support delivered performance counter register
>> and reference performance counter register. But the platform can
>> calculate the real performance using its own method. This patch provide
>> a workaround for this problem, and other platforms can also use this
>> workaround framework. We reuse the desired performance register to
>> store the real performance calculated by the platform. After the
>> platform finished the frequency adjust, it gets the real performance and
>> writes it into desired performance register. OS can use it to calculate
>> the real frequency.
>>
> 
> It would be convenient for reviewers to detail what changed between versions in future.

Thanks, I will add changelog next time.

Xiongfeng

> 
> John
> 
>> Xiongfeng Wang (2):
>>   ACPI / CPPC: Add a helper to get desired performance
>>   cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
>>
>>  drivers/acpi/cppc_acpi.c       | 38 +++++++++++++++++++++++
>>  drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>>  include/acpi/cppc_acpi.h       |  1 +
>>  3 files changed, 109 insertions(+)
>>
> 
> 
> 
> .
> 

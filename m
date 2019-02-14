From: John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v2 0/2] Work around for Hisilicon CPPC cpufreq
Date: Thu, 14 Feb 2019 11:39:22 +0000
Message-ID: <2f397788-fcb0-a781-c497-9e698494f508@huawei.com>
References: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>, viresh.kumar@linaro.org, rafael@kernel.org, gcherianv@gmail.com, pprakash@codeaurora.org, george.cherian@cavium.com, robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com
List-Id: linux-acpi@vger.kernel.org

On 14/02/2019 07:46, Xiongfeng Wang wrote:
> Hisilicon chips do not support delivered performance counter register
> and reference performance counter register. But the platform can
> calculate the real performance using its own method. This patch provide
> a workaround for this problem, and other platforms can also use this
> workaround framework. We reuse the desired performance register to
> store the real performance calculated by the platform. After the
> platform finished the frequency adjust, it gets the real performance and
> writes it into desired performance register. OS can use it to calculate
> the real frequency.
>

It would be convenient for reviewers to detail what changed between 
versions in future.

John

> Xiongfeng Wang (2):
>   ACPI / CPPC: Add a helper to get desired performance
>   cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
>
>  drivers/acpi/cppc_acpi.c       | 38 +++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  1 +
>  3 files changed, 109 insertions(+)
>

From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3 0/2] Work around for Hisilicon CPPC cpufreq
Date: Tue, 19 Feb 2019 10:59:00 +0100
Message-ID: <12311117.DSx6JT7Gj8@aspire.rjw.lan>
References: <1550375655-58007-1-git-send-email-wangxiongfeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550375655-58007-1-git-send-email-wangxiongfeng2@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: viresh.kumar@linaro.org, rafael@kernel.org, gcherianv@gmail.com, pprakash@codeaurora.org, george.cherian@cavium.com, robert.moore@intel.com, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, john.garry@huawei.com
List-Id: linux-acpi@vger.kernel.org

On Sunday, February 17, 2019 4:54:13 AM CET Xiongfeng Wang wrote:
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
> Changlog:
> 
> v2 -> v3:
> 	Recontruct 'cppc_get_desired_perf'.
> 	Rename 'cppc_workaround_info' to 'cppc_workaround_oem_info'
> 	Drop 'get_rate' member from struct cppc_workaround_oem_info
> 	Change 'cppc_wa_get_rate' pointer to a flag to indicate whether
> 	we need to aplly the workaround.
> 	Move the new functions to the beginning of cppc-cpufreq.c
> 
> 
> Xiongfeng Wang (2):
>   ACPI / CPPC: Add a helper to get desired performance
>   cpufreq / cppc: Work around for Hisilicon CPPC cpufreq
> 
>  drivers/acpi/cppc_acpi.c       | 39 +++++++++++++++++++++++++
>  drivers/cpufreq/cppc_cpufreq.c | 66 ++++++++++++++++++++++++++++++++++++++++++
>  include/acpi/cppc_acpi.h       |  1 +
>  3 files changed, 106 insertions(+)
> 
> 

Both patches applied, thanks!

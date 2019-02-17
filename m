From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [PATCH v3 0/2] Work around for Hisilicon CPPC cpufreq
Date: Sun, 17 Feb 2019 11:54:13 +0800
Message-ID: <1550375655-58007-1-git-send-email-wangxiongfeng2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, rafael@kernel.org, gcherianv@gmail.com, pprakash@codeaurora.org, george.cherian@cavium.com, robert.moore@intel.com
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, guohanjun@huawei.com, wangxiongfeng2@huawei.com, john.garry@huawei.com
List-Id: linux-acpi@vger.kernel.org

Hisilicon chips do not support delivered performance counter register
and reference performance counter register. But the platform can
calculate the real performance using its own method. This patch provide
a workaround for this problem, and other platforms can also use this
workaround framework. We reuse the desired performance register to
store the real performance calculated by the platform. After the
platform finished the frequency adjust, it gets the real performance and
writes it into desired performance register. OS can use it to calculate
the real frequency.

Changlog:

v2 -> v3:
	Recontruct 'cppc_get_desired_perf'.
	Rename 'cppc_workaround_info' to 'cppc_workaround_oem_info'
	Drop 'get_rate' member from struct cppc_workaround_oem_info
	Change 'cppc_wa_get_rate' pointer to a flag to indicate whether
	we need to aplly the workaround.
	Move the new functions to the beginning of cppc-cpufreq.c


Xiongfeng Wang (2):
  ACPI / CPPC: Add a helper to get desired performance
  cpufreq / cppc: Work around for Hisilicon CPPC cpufreq

 drivers/acpi/cppc_acpi.c       | 39 +++++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  1 +
 3 files changed, 106 insertions(+)

-- 
1.7.12.4

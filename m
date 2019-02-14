From: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Subject: [PATCH v2 0/2] Work around for Hisilicon CPPC cpufreq
Date: Thu, 14 Feb 2019 15:46:06 +0800
Message-ID: <1550130368-60513-1-git-send-email-wangxiongfeng2@huawei.com>
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

Xiongfeng Wang (2):
  ACPI / CPPC: Add a helper to get desired performance
  cpufreq / cppc: Work around for Hisilicon CPPC cpufreq

 drivers/acpi/cppc_acpi.c       | 38 +++++++++++++++++++++++
 drivers/cpufreq/cppc_cpufreq.c | 70 ++++++++++++++++++++++++++++++++++++++++++
 include/acpi/cppc_acpi.h       |  1 +
 3 files changed, 109 insertions(+)

-- 
1.7.12.4

From: Jeffrey Hugo <jhugo@codeaurora.org>
Subject: [PATCH v2 0/2] PPTT handle Handle architecturally unknown cache types
Date: Fri, 14 Sep 2018 10:28:07 -0600
Message-ID: <1536942489-4018-1-git-send-email-jhugo@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sudeep.holla@arm.com, gregkh@linuxfoundation.org, rjw@rjwysocki.net, linux-acpi@vger.kernel.org, jeremy.linton@arm.com
Cc: linux-kernel@vger.kernel.org, vkilari@codeaurora.org, Jeffrey Hugo <jhugo@codeaurora.org>
List-Id: linux-acpi@vger.kernel.org

The ARM Architecture Reference Manual allows for caches to be "invisible" and
thus not specified in the system registers under some scenarios such as if the
cache cannot be managed by set/way operations.

However, such caches may be specified in the ACPI PPTT table for workload
performance/scheduling optimizations.

Currently such caches can cause an error in lscpu -

lscpu: cannot open /sys/devices/system/cpu/cpu0/cache/index3/type: No such
file or directory

and result in no output, providing a poor user experience.  lstopo is also
affected as such caches are not included in the output.

Address these issues by attempting to be a little more discerning about when
cache information is provided to userspace, and also utilize all sources for
cache information when possible.

[v2]
-Updated cacheinfo per Sudeep's suggestion
-Integrated the PPTT fix into existing PPTT code per Sudeep's suggestion

Jeffrey Hugo (2):
  drivers: base: cacheinfo: Do not populate sysfs for unknown cache
    types
  ACPI/PPTT: Handle architecturally unknown cache types

 drivers/acpi/pptt.c      | 15 +++++++++++----
 drivers/base/cacheinfo.c |  2 ++
 2 files changed, 13 insertions(+), 4 deletions(-)

-- 
Qualcomm Datacenter Technologies as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.

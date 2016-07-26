From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V2 0/5] CPPC enhancements
Date: Tue, 26 Jul 2016 13:45:23 -0600
Message-ID: <1469562328-10201-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46200 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753947AbcGZTqA (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 26 Jul 2016 15:46:00 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, pprakash@codeaurora.org

Hi,

This series has patches related to cppc that either improves the performance
or adds some features.

v2:
  * Sysfs entry for counter wraparound time(Alexey)
  * Updated latency calculation to sum of Nominal and MRTT(Alexey)
  * Moved refernce_perf from perf_caps to fb_ctrs
  * Addressed review comments from Hoan and few minor cleanups
v1:
  * Pulled in the CPPC batching path to this series
  * Addressed POSTCHANGE issue(Alexey) and switch to RW semaphore(Hoan)

Thanks,
Prashanth

Ashwin Chaugule (2):
  ACPI/CPPC: restructure read/writes for efficient sys mapped reg ops
  ACPI/CPPC: add sysfs support to compute delivered performance

Prashanth Prakash (3):
  ACPI/CPPC: acquire pcc_lock only while accessing PCC subspace
  ACPI/CPPC: support for batching CPPC requests
  ACPI/CPPC: set a non-zero value for transition_latency

 drivers/acpi/cppc_acpi.c       | 467 +++++++++++++++++++++++++++++++++--------
 drivers/cpufreq/cppc_cpufreq.c |   1 +
 include/acpi/cppc_acpi.h       |   8 +-
 3 files changed, 387 insertions(+), 89 deletions(-)

-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


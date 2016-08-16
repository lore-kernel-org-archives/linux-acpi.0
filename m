From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V3 0/7] CPPC enhancements
Date: Tue, 16 Aug 2016 14:39:37 -0600
Message-ID: <1471379984-15712-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:54826 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420AbcHPUjx (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 16 Aug 2016 16:39:53 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, Prashanth Prakash <pprakash@codeaurora.org>

Hi,

This series has patches related to cppc that either improves the performance
or adds some features.

v3:
  * Fixed the error path in send_pcc_cmd in CPPC batching patch
  * Included a patch to consolidate all the global variables
  * Included a patch to check for PCC error bit (Alexey)
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

Prashanth Prakash (5):
  ACPI/CPPC: acquire pcc_lock only while accessing PCC subspace
  ACPI/CPPC: support for batching CPPC requests
  ACPI/CPPC: set a non-zero value for transition_latency
  ACPI/CPPC: move all PCC related information into pcc_data
  ACPI/CPPC: check for error bit in PCC status field

 drivers/acpi/cppc_acpi.c       | 600 +++++++++++++++++++++++++++++++----------
 drivers/cpufreq/cppc_cpufreq.c |   1 +
 include/acpi/cppc_acpi.h       |  14 +-
 3 files changed, 466 insertions(+), 149 deletions(-)

-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


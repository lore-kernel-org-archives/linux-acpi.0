From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 0/5] CPPC enhancements
Date: Thu, 30 Jun 2016 12:02:33 -0600
Message-ID: <1467309758-26536-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:52764 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932124AbcF3SCt (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 30 Jun 2016 14:02:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, pprakash@codeaurora.org

Hi,

This series has patches related to cppc that either improves the performance
or adds some features.

The CPPC batching patch has been pulled into this series after addressing
the comments from Alexey (POSTCHANGE issue) and Hoan(switch to mutex)

Thanks,
Prashanth

Ashwin Chaugule (2):
  ACPI/CPPC: restructure read/writes for efficient sys mapped reg ops
  ACPI/CPPC: add sysfs support to compute delivered performance

Prashanth Prakash (3):
  ACPI/CPPC: acquire pcc_lock only while accessing PCC subspace
  ACPI/CPPC: support for batching CPPC requests
  ACPI/CPPC: set a non-zero value for transition_latency

 drivers/acpi/cppc_acpi.c       | 427 +++++++++++++++++++++++++++++++++--------
 drivers/cpufreq/cppc_cpufreq.c |   1 +
 include/acpi/cppc_acpi.h       |   5 +-
 3 files changed, 353 insertions(+), 80 deletions(-)

-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.


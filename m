From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V4 0/5] acpi: cppc optimization patches
Date: Wed, 17 Feb 2016 13:20:58 -0700
Message-ID: <1455740463-19192-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:53028 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964970AbcBQUVY (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 17 Feb 2016 15:21:24 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: ashwin.chaugule@linaro.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, alexey.klimov@arm.com, Prashanth Prakash <pprakash@codeaurora.org>

Changes in V4: 
[1] Added another patch which decides if or when to send a request to the 
platform based on the Minimum Request Turnaround Time(MRTT) and Maximum 
Periodic Access Rate(MPAR) to make sure the implementation is compliant
to ACPI spec
[2] Fixed the condition for pr_debug message in cppc_chan_tx_done() 

Changes in V3: Addressed the review comments from Alexey, Ashwin and Timur

Changes in V2: Fixed compilation error on i386

This series introduces changes to reduce the time required to send a frequency
transition requests to the platform while using the cppc-cpufreq driver.

With these changes we see significant improvement in the average time to send
freq. transition request to the platform. Profiling on an ARM platform showed
that the average transaction time per request reduced from 200us to under 20us.

Ashwin Chaugule (1):
  ACPI / CPPC: Optimize PCC Read Write operations

Prashanth Prakash (4):
  acpi: cppc: optimized cpc_read and cpc_write
  mailbox: pcc: optimized pcc_send_data
  acpi: cppc: replace writeX/readX to PCC with relaxed version
  acpi/cppc: use MRTT/MPAR to decide if/when a req can be sent

 drivers/acpi/cppc_acpi.c | 237 ++++++++++++++++++++++++++++++++++++++---------
 drivers/mailbox/pcc.c    | 111 ++++++++++++++++++++--
 2 files changed, 295 insertions(+), 53 deletions(-)

-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.


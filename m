From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V2 0/4] acpi: cppc optimization patches
Date: Fri, 22 Jan 2016 18:07:16 -0700
Message-ID: <1453511240-20792-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:50637 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754540AbcAWBHi (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 22 Jan 2016 20:07:38 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net
Cc: ashwin.chaugule@linaro.org, linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Prashanth Prakash <pprakash@codeaurora.org>

Changes in V2: Fixed compilation error on i386

This series introduces changes to reduce the time required to send a frequency
transition requests to the platform while using the cppc-cpufreq driver.

With these changes we see significant improvement in the average time to send
freq. transition request to the platform. Profiling on an ARM platform showed
that the average transaction time per request reduced from 200us to under 20us.
Ashwin Chaugule (1):
  ACPI / CPPC: Optimize PCC Read Write operations

Prashanth Prakash (3):
  acpi: cppc: optimized cpc_read and cpc_write
  mailbox: pcc: optimized pcc_send_data
  acpi: cppc: replace writeX/readX to PCC with relaxed version

 drivers/acpi/cppc_acpi.c | 186 +++++++++++++++++++++++++++++++++++------------
 drivers/mailbox/pcc.c    | 111 ++++++++++++++++++++++++++--
 2 files changed, 244 insertions(+), 53 deletions(-)

-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.


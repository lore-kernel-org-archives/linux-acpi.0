From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 0/4] acpi: cppc optimization patches
Date: Fri, 15 Jan 2016 11:43:31 -0700
Message-ID: <1452883415-24452-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:34731 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753443AbcAOSnz (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Fri, 15 Jan 2016 13:43:55 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rjw@rjwysocki.net, ashwin.chaugule@linaro.org
Cc: linux-acpi@vger.kernel.org, linaro-acpi@lists.linaro.org, Prashanth Prakash <pprakash@codeaurora.org>

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

 drivers/acpi/cppc_acpi.c | 184 +++++++++++++++++++++++++++++++++++------------
 drivers/mailbox/pcc.c    | 110 ++++++++++++++++++++++++++--
 2 files changed, 241 insertions(+), 53 deletions(-)

-- 
Qualcomm Technologies, Inc. on behalf
of the Qualcomm Innovation Center, Inc.  The Qualcomm Innovation Center, Inc. 
is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.


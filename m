From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH V2 0/2] additional sysfs entries for CPPC
Date: Wed, 29 Mar 2017 13:49:58 -0600
Message-ID: <1490817000-13876-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:46652 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753049AbdC2TuU (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 29 Mar 2017 15:50:20 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, hotran@apm.com, ahs3@redhat.com, Prashanth Prakash <pprakash@codeaurora.org>

This patch-set adds few additional sysfs entries to expose the
performance capabilities of each CPU. The performance capabilities
include highest perf, lowest perf, nominal perf and lowest
non-linear perf. See 8.4.7.1 for ACPI 6.1 spec for details on
these capabilities.

cppc_cpufreq driver operates in KHz scale whereas the delivered
performance computed in userspace will be in abstract CPPC scale, so
exposing perf capabilities should allow userspace to figure out the
conversion factor from CPPC scale to KHz.

Changes in V2:
 - Removed caching of perf caps based on Rafael's inputs

Prashanth Prakash (2):
  ACPI / CPPC: Read lowest non linear perf in cppc_get_perf_caps
  ACPI / CPPC: add sysfs entries for CPPC perf capabilities

 drivers/acpi/cppc_acpi.c | 80 ++++++++++++++++++++++++++----------------------
 include/acpi/cppc_acpi.h |  3 +-
 2 files changed, 46 insertions(+), 37 deletions(-)

-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


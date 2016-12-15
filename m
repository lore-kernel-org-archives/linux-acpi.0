From: Prashanth Prakash <pprakash@codeaurora.org>
Subject: [PATCH 0/2] additional sysfs entries for CPPC
Date: Wed, 14 Dec 2016 18:06:32 -0700
Message-ID: <1481763994-28146-1-git-send-email-pprakash@codeaurora.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.29.96]:44506 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933869AbcLOBGl (ORCPT
        <rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Dec 2016 20:06:41 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: rjw@rjwysocki.net, alexey.klimov@arm.com, hotran@apm.com, cov@codeaurora.org, Prashanth Prakash <pprakash@codeaurora.org>

This patch-set adds few additional sysfs entries to expose the
performance capabilities of each CPU. The performance capabilities
include highest perf, lowest perf, nominal perf and lowest 
non-linear perf. See 8.4.7.1 for ACPI 6.1 spec for details on
these capabilities.

cppc_cpufreq driver operates in KHz scale whereas the delivered
performance computed in userspace will be in abstract CPPC scale, so
exposing perf capabilities should allow userspace to figure out the
conversion factor from CPPC scale to KHz.

Prashanth Prakash (2):
  ACPI / CPPC: read all perf caps in a single cppc read command
  ACPI / CPPC: add sysfs entries for CPPC perf capabilities

 drivers/acpi/cppc_acpi.c | 164 ++++++++++++++++++++++++++++++-----------------
 include/acpi/cppc_acpi.h |   3 +-
 2 files changed, 107 insertions(+), 60 deletions(-)

-- 
Qualcomm Datacenter Technologies on behalf of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.


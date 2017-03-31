From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH 0/2] Make cppc acpi driver aware of pcc subspace ids
Date: Fri, 31 Mar 2017 06:24:00 +0000
Message-ID: <1490941442-11954-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-sn1nam02on0049.outbound.protection.outlook.com ([104.47.36.49]:48006
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751311AbdCaGY0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 31 Mar 2017 02:24:26 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, devel@acpica.org
Cc: ashwin.chaugule@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, jassisinghbrar@gmail.com, robert.moore@intel.com, lv.zheng@intel.com, George Cherian <george.cherian@cavium.com>

The current cppc acpi driver works with only one pcc subspace id.
It maintains and registers only one pcc channel even if the acpi table has 
different pcc subspace ids. The series tries to address the same by making 
cppc acpi driver aware of multiple possible pcc subspace ids.

Patch 1 : In preparation to share the MAX_PCC_SUBSPACE definition with cppc acpi
	  driver
Patch 2 : Make the cppc acpi driver aware of multiple pcc subspace ids.

George Cherian (2):
  mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
  ACPI / CPPC: Make cppc acpi driver aware of pcc subspace ids

 drivers/acpi/cppc_acpi.c | 186 ++++++++++++++++++++++++++---------------------
 drivers/mailbox/pcc.c    |   1 -
 include/acpi/pcc.h       |   1 +
 3 files changed, 103 insertions(+), 85 deletions(-)

-- 
2.7.4


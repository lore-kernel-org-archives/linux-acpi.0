From: George Cherian <george.cherian@cavium.com>
Subject: [PATCH v4 0/2] Make cppc acpi driver aware of pcc subspace ids
Date: Wed, 20 Sep 2017 05:24:45 +0000
Message-ID: <1505885087-5112-1-git-send-email-george.cherian@cavium.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-sn1nam01on0044.outbound.protection.outlook.com ([104.47.32.44]:1085
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750924AbdITFZT (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 20 Sep 2017 01:25:19 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: devel@acpica.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: lv.zheng@intel.com, robert.moore@intel.com, jassisinghbrar@gmail.com, lenb@kernel.org, rjw@rjwysocki.net, pprakash@codeaurora.org, George Cherian <george.cherian@cavium.com>

The current cppc acpi driver works with only one pcc subspace id.
It maintains and registers only one pcc channel even if the acpi table has 
different pcc subspace ids. 

As per ACPI 6.2 spec  all PCC registers, for all processors in the same 
performance domain (as defined by _PSD), must be defined to be in the same
subspace. The series tries to address the same by making cppc acpi driver 
aware of multiple possible pcc subspace ids.

Patch 1 : In preparation to share the MAX_PCC_SUBSPACE definition with cppc acpi
          driver
Patch 2 : Make the cppc acpi driver aware of multiple pcc subspace ids.

Changes from v3:
  - Address Issue reported by kbuild-robot.

Changes from v2:
  - Addressed Prashanth's comments on
    * Not to use local variables to update mpar_count, last_mpar_reset and 
      last_cmd_cmpl_time
    * Add check for kzalloc failure in pcc_data_alloc()
    * Initialize pcc_subspace_id to -1 in acpi_cppc_processor_probe()
    * Check for pcc_subspace_id validity before registering pcc_channel

Changes from v1:
  - Add last_cmd_cmpl_time, last_mpar_reset, mpar_count to the cppc_pcc_data to
make it per subspace.
  - PCC per subspace dynamic allocation support added instead of static
allocation
  - Added a new function pcc_data_alloc, In instances where CPU's with SMT
support same PCC subspace would be used for all CPU's belonging to same 
physical core. This function adds the pcc_subspace refcounting and allocates
the cppc_pcc_data per unique subspace idx.
  - Added cleanup in acpi_cppc_processor_exit. Free the mbox channel and free
the cppc_pcc_data in case refcount is zero.

George Cherian (2):
  mailbox: PCC: Move the MAX_PCC_SUBSPACES definition to header file
  ACPI / CPPC: Make cppc acpi driver aware of pcc subspace ids

 drivers/acpi/cppc_acpi.c | 243 +++++++++++++++++++++++++++++------------------
 drivers/mailbox/pcc.c    |   1 -
 include/acpi/pcc.h       |   1 +
 3 files changed, 154 insertions(+), 91 deletions(-)

-- 
2.1.4


From: Lv Zheng <lv.zheng@intel.com>
Subject: [PATCH 0/6] ACPI/OSL: Rework of ACPICA memory OSLs to improve performance.
Date: Thu, 23 Oct 2014 10:11:57 +0800
Message-ID: <cover.1414029477.git.lv.zheng@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:2574 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750928AbaJWCMG (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 22 Oct 2014 22:12:06 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <len.brown@intel.com>
Cc: Lv Zheng <lv.zheng@intel.com>, Lv Zheng <zetalog@gmail.com>, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Fei Yang <fei.yang@intel.com>

It is reported that there is a performance issue in the ACPICA OSL
implementation around memory mappings.

On the reported platforms, there is a debugging facility implemented in the
ACPI namespace using circular logging buffer:
        Name (DPTR, 0x3AFEB000)
        Name (EPTR, 0x3AFFB000)
        Name (CPTR, 0x3AFEB010)
        Mutex (MMUT, 0x00)
        Method (MDBG, 1, Serialized)
        {
            Store (Acquire (MMUT, 0x03E8), Local0)
            If (Local0 == Zero)
            {
                OperationRegion (ABLK, SystemMemory, CPTR, 0x10)
                Field (ABLK, ByteAcc, NoLock, Preserve)
                {
                    AAAA,   128
                }
                Store (Arg0, AAAA) /* \MDBG.AAAA */
                CPTR = (CPTR + 0x10) /* \CPTR */
                If (CPTR >= EPTR)
                {
                    CPTR = (DPTR + 0x10) /* \CPTR */
                }
                Release (MMUT)
            }
            Return (Local0)
        }
This function is heavily invoked by other ACPI control methods.
The reported platforms suffer from 2-5 minutes kernel stuck in the end of
accessing the mapped circular buffer system memory region. By
instrumentation, the 2-5 minutes time consumption overhead can be seen to
happen on the synchronize_rcu() invoked in the acpi_os_unmap_memory().

This patchset removes the synchronize_rcu() from the hot path to improve
the performance.

Lv Zheng (6):
  ACPI/OSL: Split memory operation region implementations to a seperate
    file.
  ACPI/OSL: Rename system memory functions.
  ACPI/OSL: Cleanup memory access functions by merging duplicate code.
  ACPI/OSL: Add acpi_map2virt() to merge duplicate code.
  ACPI/OSL: Cleanup branch logics.
  ACPI/OSL: Fix performance issue in system memory lockings.

 drivers/acpi/Makefile |    2 +-
 drivers/acpi/mem.c    |  414 +++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/acpi/osl.c    |  381 ---------------------------------------------
 3 files changed, 415 insertions(+), 382 deletions(-)
 create mode 100644 drivers/acpi/mem.c

-- 
1.7.10


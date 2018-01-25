From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 0/2] xen: re-enable booting as Xen PVH guest
Date: Thu, 25 Jan 2018 15:36:37 +0100
Message-ID: <20180125143639.9969-1-jgross@suse.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50071 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750911AbeAYOgn (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Thu, 25 Jan 2018 09:36:43 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, xen-devel@lists.xenproject.org
Cc: lenb@kernel.org, rafael.j.wysocki@intel.com, mingo@redhat.com, boris.ostrovsky@oracle.com, Juergen Gross <jgross@suse.com>

The Xen PVH boot protocol passes vital information to the kernel via
a start_info block. One of the data transferred is the physical address
of the RSDP table.

Unfortunately PVH support in the kernel didn't use that passed address
for RSDP, but relied on the legacy mechanism searching for the RSDP in
low memory. After a recent change in Xen putting the RSDP to a higher
address booting as PVH guest is now failing.

This small series repairs that by passing the RSDP address from the
start_info block to ACPI handling.

Juergen Gross (2):
  x86/acpi: add retrieval function for rsdp address
  xen: add acpi_arch_get_root_pointer() for pvh guests

 arch/x86/xen/enlighten_pvh.c | 14 +++++++++++---
 drivers/acpi/osl.c           | 10 +++++++++-
 include/linux/acpi.h         |  2 ++
 3 files changed, 22 insertions(+), 4 deletions(-)

-- 
2.13.6


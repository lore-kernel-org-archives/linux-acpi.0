From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 00/11] ACPI, APEI, Patches for 3.3
Date: Thu,  8 Dec 2011 11:25:39 +0800
Message-ID: <1323314750-8185-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:14032 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756877Ab1LHDZy (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 7 Dec 2011 22:25:54 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org

Most patches has been sent for 3.2 before.  The changes is as follow:

- Add [01/11]: Add 64bit read/write support to atomicio on i386
- Change [07/11]: Do not use kmap on IA64

For [10/11] and [11/11], there is some other idea to fix the issue,
if some other method is preferred, please drop these two patches.

[PATCH 01/11] ACPI, Add 64bit read/write support to atomicio on i386
[PATCH 02/11] ACPI, APEI, GHES: Add PCIe AER recovery support
[PATCH 03/11] ACPI, APEI, Print resource errors in conventional
[PATCH 04/11] ACPI, APEI, Remove table not found message
[PATCH 05/11] ACPI, APEI, GHES, Distinguish interleaved error report
[PATCH 06/11] ACPI, APEI, Printk queued error record before panic
[PATCH 07/11] ACPI, Add RAM mapping support to ACPI atomic IO
[PATCH 08/11] ACPI, APEI, EINJ, Fix resource conflict on some
[PATCH 09/11] ACPI, APEI, EINJ, Refine the fix of resource conflict
[PATCH 10/11] ACPI, Record ACPI NVS regions
[PATCH 11/11] ACPI, APEI, Resolve false conflict between ACPI NVS

Best Regards,
Huang Ying

From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 0/3] Report APEI GHES error information via printk
Date: Tue, 30 Nov 2010 10:51:38 +0800
Message-ID: <1291085501-31494-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:23185 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751716Ab0K3Cvq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 29 Nov 2010 21:51:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

Hi, Len,

Although we have no consensus on whether we need a hardware error specific
reporting interface. We have the consensus that we need to report hardware
error information via printk. This patchset adds that to APEI GHES.

v2:

- Some minor adjustment of PCIe error section definition and printk format

[PATCH -v2 1/3] Add CPER PCIe error section structure and constants definition
[PATCH -v2 2/3] ACPI, APEI, Add APEI generic error status print support
[PATCH -v2 3/3] ACPI, APEI, report GHES error information via printk

Best Regards,
Huang Ying

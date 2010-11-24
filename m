From: Huang Ying <ying.huang@intel.com>
Subject: [RFC][PATCH 0/3] Report APEI GHES error information via printk
Date: Wed, 24 Nov 2010 09:16:51 +0800
Message-ID: <1290561414-13313-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:27535 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754440Ab0KXBR0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 23 Nov 2010 20:17:26 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Mauro Carvalho Chehab <mchehab@redhat.com>, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>

Although we have no consensus on whether we need a hardware error specific
reporting interface. We have the consensus that we need to report hardware
error information via printk. This patchset adds that to APEI GHES.

[RFC][PATCH 1/3] Add CPER PCIe error section structure and constants definition
[RFC][PATCH 2/3] ACPI, APEI, Add APEI generic error status print support
[RFC][PATCH 3/3] ACPI, APEI, report GHES error information via printk

From: Huang Ying <ying.huang@intel.com>
Subject: [RFC 0/2] ACPI, APEI, GHES, printk support for recoverable error via NMI
Date: Wed,  9 Feb 2011 15:27:29 +0800
Message-ID: <1297236451-11331-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:17707 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750944Ab1BIH1h (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 9 Feb 2011 02:27:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, Tony Luck <tony.luck@intel.com>, ying.huang@intel.com, linux-acpi@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>

This patchset is based on the lockless list patchset.

[RFC 1/2] lib, Make gen_pool memory allocator lockless
[RFC 2/2] ACPI, APEI, GHES, printk support for recoverable error via NMI

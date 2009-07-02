From: "Li, Shaohua" <shaohua.li@intel.com>
Subject: EC
Date: Thu, 2 Jul 2009 13:42:47 +0800
Message-ID: <76780B19A496DC4B80439008DAD7076C03453A5BFC@PDSMSX501.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:46497 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750713AbZGBFnt convert rfc822-to-8bit (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 2 Jul 2009 01:43:49 -0400
Content-Language: en-US
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Alexey Starikovskiy <astarikovskiy@suse.de>, "lenb@kernel.org" <lenb@kernel.org>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>

Hi,
Preempt isn't disabled between ec_burst_enable()/ec_burst_disable(), so it's very likely there is a preemption between them and make the timing for burst mode not comply with ACPI spec (400ms for first access and 50ms for subsequent access).

We have a system with broken EC and the BIOS engineer identified it's the timing issue.
What's the judgment why Linux doesn't comply with ACPI spec?

Thanks,
Shaohua

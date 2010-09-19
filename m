From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH 0/5] ACPI, APEI, BUG fixes for 2.6.36
Date: Sun, 19 Sep 2010 11:00:30 +0800
Message-ID: <1284865235-29920-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:29657 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753003Ab0ISDB1 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 18 Sep 2010 23:01:27 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org

Hi, Len,

This patchset is some BUG fixes about APEI for 2.6.36. Can you merge
it?

[PATCH 1/5] ACPI, APEI, Fix APEI related table size checking
[PATCH 2/5] ACPI, APEI, Fix acpi_pre_map() return value
[PATCH 3/5] ACPI, APEI, HEST Fix the unsuitable usage of platform_data
[PATCH 4/5] ACPI, APEI, Fix error path for memory allocation
[PATCH 5/5] ACPI, APEI, Fix ERST MOVE_DATA instruction implementation

Best Regards,
Huang Ying

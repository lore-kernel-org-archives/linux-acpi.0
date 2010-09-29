From: Huang Ying <ying.huang@intel.com>
Subject: [PATCH -v2 0/5] ACPI, APEI, BUG fixes for 2.6.36
Date: Wed, 29 Sep 2010 19:53:50 +0800
Message-ID: <1285761235-4751-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:51878 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751605Ab0I2LyD (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 29 Sep 2010 07:54:03 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Andi Kleen <andi@firstfloor.org>, linux-acpi@vger.kernel.org

Hi, Len,

This patchset is version 2 of some BUG fixes about APEI for 2.6.36.
Can you merge it?

[PATCH -v2 1/5] ACPI, APEI, Fix APEI related table size checking
[PATCH -v2 2/5] ACPI, APEI, Fix acpi_pre_map() return value
[PATCH -v2 3/5] ACPI, APEI, HEST Fix the unsuitable usage of platform_data
[PATCH -v2 4/5] ACPI, APEI, Fix error path for memory allocation
[PATCH -v2 5/5] ACPI, APEI, Fix ERST MOVE_DATA instruction implementation

Best Regards,
Huang Ying

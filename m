From: Zhang Rui <rui.zhang@intel.com>
Subject: [PATCH 0/8] ACPI: ACPI table management enhencement
Date: Fri, 19 Dec 2008 15:57:37 +0800
Message-ID: <1229673457.562.132.camel@rzhang-dt>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47165 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752814AbYLSH7G (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Fri, 19 Dec 2008 02:59:06 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-acpi <linux-acpi@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, "Zhang, Rui" <rui.zhang@intel.com>

Hi all,

this patch set is an ACPI table management enhancement.

Patch 01 adds the new sysfs I/F for ACPI dynamic tables.
now dynamic ACPI tables can be get at
/sys/firmware/acpi/tables/dynamic/...

Patch 02 ~ 08 introduce the ACPI inactive table management.
Here inactive table means the table that is pointed to by
the inactive root table, e.g RSDT if Linux is using XSDT.
Detailed introduction of each patch is in the change log.

Any comments are welcome.

thanks,
rui


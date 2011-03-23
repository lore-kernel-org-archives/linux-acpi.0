From: Lin Ming <ming.m.lin@intel.com>
Subject: [PATCH 0/3] ACPI/ACPICA: Resolve spinlock and global lock handling code divergence
Date: Wed, 23 Mar 2011 17:26:33 +0800
Message-ID: <1300872396-16522-1-git-send-email-ming.m.lin@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:5458 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755943Ab1CWJSt (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 23 Mar 2011 05:18:49 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Bob Moore <robert.moore@intel.com>
Cc: linux-acpi@vger.kernel.org

Currently, linux osl code does not implement the interface acpi_os_create_lock.
This series implements and uses it. So the spinlock code divergence is fixed.

Also, fix the code divergence introduced by commit
9cd0314(ACPI / ACPICA: Fix global lock acquisition).

[PATCH 1/3] ACPI: osl, add acpi_os_create_lock interface
[PATCH 2/3] ACPICA: Use acpi_os_create_lock interface
[PATCH 3/3] ACPICA: Fix code divergence of global lock handling

Thanks,
Lin Ming

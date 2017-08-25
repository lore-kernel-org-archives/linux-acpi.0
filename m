From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC] ACPI / PM: Disable MSR T-state after resumed
Date: Sat, 26 Aug 2017 00:43:18 +0800
Message-ID: <cover.1503678995.git.yu.c.chen@intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:55988 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934266AbdHYQl7 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 25 Aug 2017 12:41:59 -0400
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-acpi@vger.kernel.org
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, Chen Yu <yu.c.chen@intel.com>

There is a growing number of reports that the MSR throttling has
been enabled after resumed back from suspend to ram, which impacts
the system performance. This patchset tries to address this issue
by turning off the T-state after resumed back.

Chen Yu (2):
  ACPI / PM: Reuse the acpi_sleep_syscore_ops for future requirement
  ACPI / PM: Disable the MSR T-state during CPU online

 drivers/acpi/sleep.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 58 insertions(+), 2 deletions(-)

-- 
2.7.4


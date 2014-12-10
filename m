From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v1] ACPI / Fan: Use bus id for non PNP0C0B (Fan) device
Date: Tue,  9 Dec 2014 16:15:39 -0800
Message-ID: <1418170540-8349-1-git-send-email-srinivas.pandruvada@linux.intel.com>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:20467 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796AbaLJAQq (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Tue, 9 Dec 2014 19:16:46 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: rui.zhang@intel.com, rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

v1
Except for PNP0C0B Fan device, use ACPI bus id.

v0
Explicit comparison with INT3404 for using acpi bus id. 

Srinivas Pandruvada (1):
  ACPI / Fan: Use bus id for non PNP0C0B (Fan) device

 drivers/acpi/fan.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

-- 
1.9.1


From: Zhao Yakui <yakui.zhao@intel.com>
Subject: [PATCH 0/5] ACPI: Add the T-state coordination
Date: Mon, 28 Jan 2008 13:50:22 +0800
Message-ID: <1201499422.17068.12.camel@yakui_zhao.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:15371 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbYA1GIh (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Mon, 28 Jan 2008 01:08:37 -0500
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: lenb@kernel.org
Cc: linux-acpi@vger.kernel.org

Hi, all,

This patch series is for T-state coordination.
Patch 01 Set the bit of ACPI_PDC_SMP_T_SWCOORD.
Patch 02 Check the parameter when calling the function of
acpi_processor_get/set_throttling. 
Patch 03 Update the T-state coordination after obtaining _TSD info
Patch 04 Add the t-state event notifier function
Patch 05 Update the t-state for every affected cpu when t-state is
changed 

I've tested this patch set on t61 laptop. It can work on the three
T-state control mode(MSR, SystemIO, FADT).


Thanks,
Yakui


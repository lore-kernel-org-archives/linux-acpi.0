From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH v5 0/2] Fixes for ACPI BERT table
Date: Wed, 21 Jun 2017 10:20:40 -0700
Message-ID: <cover.1498065055.git.tony.luck@intel.com>
References: <20170619155854.gtcowx3cityb3gqt@pd.tnic>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:34723 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752937AbdFURVN (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Wed, 21 Jun 2017 13:21:13 -0400
In-Reply-To: <20170619155854.gtcowx3cityb3gqt@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

At Boris' suggestion I've split this into two parts for version 5.
First one stops the driver from clearing the block_status field as:
 1) it is unnecessary
 2) not mentioned in the spec
 3) may upset user mode tools that extract information from the BERT table.

Second is the code simplification that you've seen before in ealier
versions of this patch.

Cc: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: linux-acpi@vger.kernel.org

Tony Luck (2):
  ACPI / APEI / BERT: Don't clear "block_status" in header
  ACPI / APEI: Boot Error Record Table processing was needlessly
    complicated

 drivers/acpi/apei/bert.c | 59 ++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 47 deletions(-)

-- 
2.11.0


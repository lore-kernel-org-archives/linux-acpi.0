From: "Luck, Tony" <tony.luck@intel.com>
Subject: [PATCH v2 0/2] Clean up ACPI Boot Error Record Table code
Date: Fri, 12 May 2017 14:42:10 -0700
Message-ID: <cover.1494624795.git.tony.luck@intel.com>
References: <20170512120118.zwhgtcbf4u4zshbn@pd.tnic>
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:58545 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757950AbdELVnX (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
        Fri, 12 May 2017 17:43:23 -0400
In-Reply-To: <20170512120118.zwhgtcbf4u4zshbn@pd.tnic>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Tony Luck <tony.luck@intel.com>, Len Brown <lenb@kernel.org>, Huang Ying <ying.huang@intel.com>, Borislav Petkov <bp@suse.de>, Tomasz Nowicki <tomasz.nowicki@linaro.org>, Jonathan Zhang <zjzhang@codeaurora.org>, Tyler Baicar <tbaicar@codeaurora.org>, linux-acpi@vger.kernel.org

From: Tony Luck <tony.luck@intel.com>

ACPI 6.1 spec clarified the structure of the Boot Error Record Table.
Linux code was overly complex, and included a redundant structure
definition of "acpi_bert_region".

v2 changes:
Rafael: Split the change to <acpi/actbl1.h> into a separate patch so
	it can be fed through ACPICA process.
Boris:  Better wording for the comment about the "address" field in 
	the acpi_table_bert structure.

Tony Luck (2):
  ACPI / APEI: Boot Error Record Table processing was needlessly
    complicated
  ACPI / APEI: No remaining users of struct acpi_bert_region

 drivers/acpi/apei/bert.c | 54 +++++++-----------------------------------------
 include/acpi/actbl1.h    | 16 +++++---------
 2 files changed, 12 insertions(+), 58 deletions(-)

Cc: Len Brown <lenb@kernel.org>
Cc: Huang Ying <ying.huang@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Tomasz Nowicki <tomasz.nowicki@linaro.org>
Cc: Jonathan (Zhixiong) Zhang <zjzhang@codeaurora.org>
Cc: Tyler Baicar <tbaicar@codeaurora.org>
Cc: linux-acpi@vger.kernel.org
Reviewed-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Tony Luck <tony.luck@intel.com>

-- 
2.11.0


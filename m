From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 3/6] tools/testing/nvdimm: fix return code for
 unimplemented commands
Date: Sat, 11 Jul 2015 10:40:53 -0400
Message-ID: <20150711144053.25013.48187.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <20150711142806.25013.16924.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:56636 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751522AbbGKOqf (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Sat, 11 Jul 2015 10:46:35 -0400
In-Reply-To: <20150711142806.25013.16924.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, ross.zwisler@linux.intel.com, linux-kernel@vger.kernel.org

The implementation for the new "DIMM Flags" DSM relies on the -ENOTTY
return code to indicate that the flags are unimplimented and to fall
back to a safe default.  As is the -ENXIO error code erroneoously
indicates to fail enabling a BLK region.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 4b69b8368de0..092d4724fe16 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -155,7 +155,7 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 	int i, rc;
 
 	if (!nfit_mem || !test_bit(cmd, &nfit_mem->dsm_mask))
-		return -ENXIO;
+		return -ENOTTY;
 
 	/* lookup label space for the given dimm */
 	for (i = 0; i < ARRAY_SIZE(handle); i++)


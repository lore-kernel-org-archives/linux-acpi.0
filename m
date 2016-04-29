From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v11 4/5] tools/testing/nvdimm: ND_CMD_CALL support
Date: Thu, 28 Apr 2016 19:42:44 -0700
Message-ID: <146189776391.29835.5942531917681816412.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146189774241.29835.12947278159500915461.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:45257 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752356AbcD2Cnd (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Thu, 28 Apr 2016 22:43:33 -0400
In-Reply-To: <146189774241.29835.12947278159500915461.stgit@dwillia2-desk3.amr.corp.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, rafael.j.wysocki@intel.com

Enable nfit_test to use nd_cmd_pkg marshaling.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 tools/testing/nvdimm/test/nfit.c |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index ed899a411c22..e09a300eb8e0 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -336,6 +336,7 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 {
 	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 	struct nfit_test *t = container_of(acpi_desc, typeof(*t), acpi_desc);
+	unsigned int func = cmd;
 	int i, rc = 0, __cmd_rc;
 
 	if (!cmd_rc)
@@ -346,7 +347,21 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 		unsigned long cmd_mask = nvdimm_cmd_mask(nvdimm);
 
-		if (!nfit_mem || !test_bit(cmd, &cmd_mask))
+		if (!nfit_mem)
+			return -ENOTTY;
+
+		if (cmd == ND_CMD_CALL) {
+			struct nd_cmd_pkg *call_pkg = buf;
+
+			buf_len = call_pkg->nd_size_in + call_pkg->nd_size_out;
+			buf = (void *) call_pkg->nd_payload;
+			func = call_pkg->nd_command;
+			if (call_pkg->nd_family != nfit_mem->family)
+				return -ENOTTY;
+		}
+
+		if (!test_bit(cmd, &cmd_mask)
+				|| !test_bit(func, &nfit_mem->dsm_mask))
 			return -ENOTTY;
 
 		/* lookup label space for the given dimm */
@@ -357,7 +372,7 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		if (i >= ARRAY_SIZE(handle))
 			return -ENXIO;
 
-		switch (cmd) {
+		switch (func) {
 		case ND_CMD_GET_CONFIG_SIZE:
 			rc = nfit_test_cmd_get_config_size(buf, buf_len);
 			break;
@@ -378,7 +393,7 @@ static int nfit_test_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		if (!nd_desc || !test_bit(cmd, &nd_desc->cmd_mask))
 			return -ENOTTY;
 
-		switch (cmd) {
+		switch (func) {
 		case ND_CMD_ARS_CAP:
 			rc = nfit_test_cmd_ars_cap(buf, buf_len);
 			break;


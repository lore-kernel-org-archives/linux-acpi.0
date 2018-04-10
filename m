From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 5/5] tools/testing/nvdimm: enable labels for nfit_test.1 dimms
Date: Tue, 10 Apr 2018 15:39:35 -0700
Message-ID: <152339997498.16061.12506015439348065666.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152339994885.16061.1760220735664848631.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <152339994885.16061.1760220735664848631.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Enable test cases for the kernel's fallback to label-less mode.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 tools/testing/nvdimm/test/nfit.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 51fc41c24a77..4ea385be528f 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -2265,6 +2265,9 @@ static void nfit_test1_setup(struct nfit_test *t)
 	set_bit(ND_CMD_ARS_STATUS, &acpi_desc->bus_cmd_force_en);
 	set_bit(ND_CMD_CLEAR_ERROR, &acpi_desc->bus_cmd_force_en);
 	set_bit(ND_INTEL_ENABLE_LSS_STATUS, &acpi_desc->dimm_cmd_force_en);
+	set_bit(ND_CMD_GET_CONFIG_SIZE, &acpi_desc->dimm_cmd_force_en);
+	set_bit(ND_CMD_GET_CONFIG_DATA, &acpi_desc->dimm_cmd_force_en);
+	set_bit(ND_CMD_SET_CONFIG_DATA, &acpi_desc->dimm_cmd_force_en);
 }
 
 static int nfit_test_blk_do_io(struct nd_blk_region *ndbr, resource_size_t dpa,

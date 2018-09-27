From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 1/3] acpi, nfit: Introduce nfit_mem flags
Date: Wed, 26 Sep 2018 21:24:26 -0700
Message-ID: <153802226609.833068.13167424056547725578.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <153802226065.833068.11943510429252969385.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <153802226065.833068.11943510429252969385.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

In preparation for adding a flag to indicate whether a DIMM publishes a
dirty-shutdown count, convert the existing flags to a bit field.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c |   27 ++++++++++++++++-----------
 drivers/acpi/nfit/nfit.h |    8 ++++++--
 2 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index b7773c70ee81..f6944f9011fd 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -192,18 +192,20 @@ static int xlat_nvdimm_status(struct nvdimm *nvdimm, void *buf, unsigned int cmd
 		 * In the _LSI, _LSR, _LSW case the locked status is
 		 * communicated via the read/write commands
 		 */
-		if (nfit_mem->has_lsr)
+		if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags))
 			break;
 
 		if (status >> 16 & ND_CONFIG_LOCKED)
 			return -EACCES;
 		break;
 	case ND_CMD_GET_CONFIG_DATA:
-		if (nfit_mem->has_lsr && status == ACPI_LABELS_LOCKED)
+		if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)
+				&& status == ACPI_LABELS_LOCKED)
 			return -EACCES;
 		break;
 	case ND_CMD_SET_CONFIG_DATA:
-		if (nfit_mem->has_lsw && status == ACPI_LABELS_LOCKED)
+		if (test_bit(NFIT_MEM_LSW, &nfit_mem->flags)
+				&& status == ACPI_LABELS_LOCKED)
 			return -EACCES;
 		break;
 	default:
@@ -489,14 +491,16 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 			min_t(u32, 256, in_buf.buffer.length), true);
 
 	/* call the BIOS, prefer the named methods over _DSM if available */
-	if (nvdimm && cmd == ND_CMD_GET_CONFIG_SIZE && nfit_mem->has_lsr)
+	if (nvdimm && cmd == ND_CMD_GET_CONFIG_SIZE
+			&& test_bit(NFIT_MEM_LSR, &nfit_mem->flags))
 		out_obj = acpi_label_info(handle);
-	else if (nvdimm && cmd == ND_CMD_GET_CONFIG_DATA && nfit_mem->has_lsr) {
+	else if (nvdimm && cmd == ND_CMD_GET_CONFIG_DATA
+			&& test_bit(NFIT_MEM_LSR, &nfit_mem->flags)) {
 		struct nd_cmd_get_config_data_hdr *p = buf;
 
 		out_obj = acpi_label_read(handle, p->in_offset, p->in_length);
 	} else if (nvdimm && cmd == ND_CMD_SET_CONFIG_DATA
-			&& nfit_mem->has_lsw) {
+			&& test_bit(NFIT_MEM_LSW, &nfit_mem->flags)) {
 		struct nd_cmd_set_config_hdr *p = buf;
 
 		out_obj = acpi_label_write(handle, p->in_offset, p->in_length,
@@ -1798,12 +1802,13 @@ static int acpi_nfit_add_dimm(struct acpi_nfit_desc *acpi_desc,
 	if (acpi_nvdimm_has_method(adev_dimm, "_LSI")
 			&& acpi_nvdimm_has_method(adev_dimm, "_LSR")) {
 		dev_dbg(dev, "%s: has _LSR\n", dev_name(&adev_dimm->dev));
-		nfit_mem->has_lsr = true;
+		set_bit(NFIT_MEM_LSR, &nfit_mem->flags);
 	}
 
-	if (nfit_mem->has_lsr && acpi_nvdimm_has_method(adev_dimm, "_LSW")) {
+	if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)
+			&& acpi_nvdimm_has_method(adev_dimm, "_LSW")) {
 		dev_dbg(dev, "%s: has _LSW\n", dev_name(&adev_dimm->dev));
-		nfit_mem->has_lsw = true;
+		set_bit(NFIT_MEM_LSW, &nfit_mem->flags);
 	}
 
 	return 0;
@@ -1902,11 +1907,11 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 			cmd_mask |= nfit_mem->dsm_mask & NVDIMM_STANDARD_CMDMASK;
 		}
 
-		if (nfit_mem->has_lsr) {
+		if (test_bit(NFIT_MEM_LSR, &nfit_mem->flags)) {
 			set_bit(ND_CMD_GET_CONFIG_SIZE, &cmd_mask);
 			set_bit(ND_CMD_GET_CONFIG_DATA, &cmd_mask);
 		}
-		if (nfit_mem->has_lsw)
+		if (test_bit(NFIT_MEM_LSW, &nfit_mem->flags))
 			set_bit(ND_CMD_SET_CONFIG_DATA, &cmd_mask);
 
 		flush = nfit_mem->nfit_flush ? nfit_mem->nfit_flush->flush
diff --git a/drivers/acpi/nfit/nfit.h b/drivers/acpi/nfit/nfit.h
index 36c8695a3d27..74706d1821df 100644
--- a/drivers/acpi/nfit/nfit.h
+++ b/drivers/acpi/nfit/nfit.h
@@ -174,6 +174,11 @@ struct nfit_memdev {
 	struct acpi_nfit_memory_map memdev[0];
 };
 
+enum nfit_mem_flags {
+	NFIT_MEM_LSR,
+	NFIT_MEM_LSW,
+};
+
 #define NFIT_DIMM_ID_LEN	22
 
 /* assembled tables for a given dimm/memory-device */
@@ -195,9 +200,8 @@ struct nfit_mem {
 	struct acpi_nfit_desc *acpi_desc;
 	struct resource *flush_wpq;
 	unsigned long dsm_mask;
+	unsigned long flags;
 	int family;
-	bool has_lsr;
-	bool has_lsw;
 	char id[NFIT_DIMM_ID_LEN+1];
 };

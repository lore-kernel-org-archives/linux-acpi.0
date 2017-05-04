From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/2] libnvdimm: handle locked label storage areas
Date: Thu, 04 May 2017 15:43:10 -0700
Message-ID: <149393778992.34042.6110586296081480841.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149393778452.34042.11808841820577827779.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <149393778452.34042.11808841820577827779.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

Per the latest version of the "NVDIMM DSM Interface Example" [1], the
label data retrieval routine can report a "locked" status. In this case
all regions associated with that DIMM are disabled until the label area
is unlocked. Provide generic libnvdimm enabling for NVDIMMs with label
data area locking capabilities.

[1]: http://pmem.io/documents/

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c        |   21 ++++++++++++++++++---
 drivers/nvdimm/dimm.c           |    2 ++
 drivers/nvdimm/dimm_devs.c      |    8 ++++++--
 drivers/nvdimm/namespace_devs.c |   17 ++++++++++++-----
 include/uapi/linux/ndctl.h      |    1 +
 5 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index a26c2297c1ed..891bd49ada0b 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -184,14 +184,29 @@ static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
 	return 0;
 }
 
+static int xlat_nvdimm_status(void *buf, unsigned int cmd, u32 status)
+{
+	switch (cmd) {
+	case ND_CMD_GET_CONFIG_SIZE:
+		if (status >> 16 & ND_CONFIG_LOCKED)
+			return -EACCES;
+		break;
+	default:
+		break;
+	}
+
+	/* all other non-zero status results in an error */
+	if (status)
+		return -EIO;
+	return 0;
+}
+
 static int xlat_status(struct nvdimm *nvdimm, void *buf, unsigned int cmd,
 		u32 status)
 {
 	if (!nvdimm)
 		return xlat_bus_status(buf, cmd, status);
-	if (status)
-		return -EIO;
-	return 0;
+	return xlat_nvdimm_status(buf, cmd, status);
 }
 
 int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
diff --git a/drivers/nvdimm/dimm.c b/drivers/nvdimm/dimm.c
index ee0b412827bf..e0f0e3ce1a32 100644
--- a/drivers/nvdimm/dimm.c
+++ b/drivers/nvdimm/dimm.c
@@ -49,6 +49,8 @@ static int nvdimm_probe(struct device *dev)
 	kref_init(&ndd->kref);
 
 	rc = nvdimm_init_nsarea(ndd);
+	if (rc == -EACCES)
+		nvdimm_set_locked(dev);
 	if (rc)
 		goto err;
 
diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 7d1a3dbc7d5d..fac1e9fbd11d 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -67,6 +67,7 @@ int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
 	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(ndd->dev);
 	struct nvdimm_bus_descriptor *nd_desc;
 	int rc = validate_dimm(ndd);
+	int cmd_rc = 0;
 
 	if (rc)
 		return rc;
@@ -76,8 +77,11 @@ int nvdimm_init_nsarea(struct nvdimm_drvdata *ndd)
 
 	memset(cmd, 0, sizeof(*cmd));
 	nd_desc = nvdimm_bus->nd_desc;
-	return nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
-			ND_CMD_GET_CONFIG_SIZE, cmd, sizeof(*cmd), NULL);
+	rc = nd_desc->ndctl(nd_desc, to_nvdimm(ndd->dev),
+			ND_CMD_GET_CONFIG_SIZE, cmd, sizeof(*cmd), &cmd_rc);
+	if (rc < 0)
+		return rc;
+	return cmd_rc;
 }
 
 int nvdimm_init_config_data(struct nvdimm_drvdata *ndd)
diff --git a/drivers/nvdimm/namespace_devs.c b/drivers/nvdimm/namespace_devs.c
index 2f2d8afc684a..2f9dfbd2dbec 100644
--- a/drivers/nvdimm/namespace_devs.c
+++ b/drivers/nvdimm/namespace_devs.c
@@ -2236,14 +2236,21 @@ static int init_active_labels(struct nd_region *nd_region)
 		int count, j;
 
 		/*
-		 * If the dimm is disabled then prevent the region from
-		 * being activated if it aliases DPA.
+		 * If the dimm is disabled then we may need to prevent
+		 * the region from being activated.
 		 */
 		if (!ndd) {
-			if (!test_bit(NDD_ALIASING, &nvdimm->flags))
+			if (test_bit(NDD_LOCKED, &nvdimm->flags))
+				/* fail, label data may be unreadable */;
+			else if (test_bit(NDD_ALIASING, &nvdimm->flags))
+				/* fail, labels needed to disambiguate dpa */;
+			else
 				return 0;
-			dev_dbg(&nd_region->dev, "%s: is disabled, failing probe\n",
-					dev_name(&nd_mapping->nvdimm->dev));
+
+			dev_err(&nd_region->dev, "%s: is %s, failing probe\n",
+					dev_name(&nd_mapping->nvdimm->dev),
+					test_bit(NDD_LOCKED, &nvdimm->flags)
+					? "locked" : "disabled");
 			return -ENXIO;
 		}
 		nd_mapping->ndd = ndd;
diff --git a/include/uapi/linux/ndctl.h b/include/uapi/linux/ndctl.h
index ede5c6a62164..7ad3863cb88b 100644
--- a/include/uapi/linux/ndctl.h
+++ b/include/uapi/linux/ndctl.h
@@ -169,6 +169,7 @@ enum {
 enum {
 	ND_ARS_VOLATILE = 1,
 	ND_ARS_PERSISTENT = 2,
+	ND_CONFIG_LOCKED = 1,
 };
 
 static inline const char *nvdimm_bus_cmd_name(unsigned cmd)

From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 4/5] acpi, nfit: fix bus vs dimm confusion in xlat_status
Date: Tue, 06 Dec 2016 16:39:41 -0800
Message-ID: <148107118149.25138.14111118284998590831.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <148107115997.25138.3445497812509173966.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <148107115997.25138.3445497812509173966.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Given dimms and bus commands share the same command number space we need
to be careful that we are translating status in the correct context.
Otherwise we can, for example, fail an ND_CMD_GET_CONFIG_SIZE command
because max_xfer is zero. It fails because that condition erroneously
correlates with the 'cleared == 0' failure of ND_CMD_CLEAR_ERROR.

Cc: <stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Fixes: aef253382266 ("libnvdimm, nfit: centralize command status translation")
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/acpi/nfit/core.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 4b8b4f520d76..9690b28f0da7 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -94,7 +94,7 @@ static struct acpi_device *to_acpi_dev(struct acpi_nfit_desc *acpi_desc)
 	return to_acpi_device(acpi_desc->dev);
 }
 
-static int xlat_status(void *buf, unsigned int cmd, u32 status)
+static int xlat_bus_status(void *buf, unsigned int cmd, u32 status)
 {
 	struct nd_cmd_clear_error *clear_err;
 	struct nd_cmd_ars_status *ars_status;
@@ -175,6 +175,15 @@ static int xlat_status(void *buf, unsigned int cmd, u32 status)
 	return 0;
 }
 
+static int xlat_status(struct nvdimm *nvdimm, void *buf, unsigned int cmd,
+		u32 status)
+{
+	if (!nvdimm)
+		return xlat_bus_status(buf, cmd, status);
+	if (status)
+		return -EIO;
+}
+
 static int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc,
 		struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		unsigned int buf_len, int *cmd_rc)
@@ -335,7 +344,8 @@ static int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc,
 			 */
 			rc = buf_len - offset - in_buf.buffer.length;
 			if (cmd_rc)
-				*cmd_rc = xlat_status(buf, cmd, fw_status);
+				*cmd_rc = xlat_status(nvdimm, buf, cmd,
+						fw_status);
 		} else {
 			dev_err(dev, "%s:%s underrun cmd: %s buf_len: %d out_len: %d\n",
 					__func__, dimm_name, cmd_name, buf_len,
@@ -345,7 +355,7 @@ static int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc,
 	} else {
 		rc = 0;
 		if (cmd_rc)
-			*cmd_rc = xlat_status(buf, cmd, fw_status);
+			*cmd_rc = xlat_status(nvdimm, buf, cmd, fw_status);
 	}
 
  out:

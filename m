From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 2/5] tools/testing/nvdimm: allow custom error code injection
Date: Tue, 10 Apr 2018 15:39:19 -0700
Message-ID: <152339995956.16061.8063508678567328863.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Given that libnvdimm driver stack takes specific actions on DIMM command
error codes like -EACCES, provide a facility to inject custom failures.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 tools/testing/nvdimm/test/nfit.c |   38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index cb166be4918d..dc6cf5630280 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -138,6 +138,7 @@ static u32 handle[] = {
 };
 
 static unsigned long dimm_fail_cmd_flags[NUM_DCR];
+static int dimm_fail_cmd_code[NUM_DCR];
 
 struct nfit_test_fw {
 	enum intel_fw_update_state state;
@@ -892,8 +893,11 @@ static int get_dimm(struct nfit_mem *nfit_mem, unsigned int func)
 	if (i >= ARRAY_SIZE(handle))
 		return -ENXIO;
 
-	if ((1 << func) & dimm_fail_cmd_flags[i])
+	if ((1 << func) & dimm_fail_cmd_flags[i]) {
+		if (dimm_fail_cmd_code[i])
+			return dimm_fail_cmd_code[i];
 		return -EIO;
+	}
 
 	return i;
 }
@@ -1225,8 +1229,40 @@ static ssize_t fail_cmd_store(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RW(fail_cmd);
 
+static ssize_t fail_cmd_code_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	int dimm = dimm_name_to_id(dev);
+
+	if (dimm < 0)
+		return dimm;
+
+	return sprintf(buf, "%d\n", dimm_fail_cmd_code[dimm]);
+}
+
+static ssize_t fail_cmd_code_store(struct device *dev, struct device_attribute *attr,
+		const char *buf, size_t size)
+{
+	int dimm = dimm_name_to_id(dev);
+	unsigned long val;
+	ssize_t rc;
+
+	if (dimm < 0)
+		return dimm;
+
+	rc = kstrtol(buf, 0, &val);
+	if (rc)
+		return rc;
+
+	dimm_fail_cmd_code[dimm] = val;
+	return size;
+}
+static DEVICE_ATTR_RW(fail_cmd_code);
+
+
 static struct attribute *nfit_test_dimm_attributes[] = {
 	&dev_attr_fail_cmd.attr,
+	&dev_attr_fail_cmd_code.attr,
 	&dev_attr_handle.attr,
 	NULL,
 };

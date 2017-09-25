From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] libnvdimm: introduce 'flags' attribute for DIMM 'lock' and
 'alias' status
Date: Mon, 25 Sep 2017 13:50:24 -0700
Message-ID: <150637262477.11427.4877320960461490551.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
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

Given that we now how have two mechanisms for a DIMM to indicate that it
is locked:

    * NVDIMM_FAMILY_INTEL 'get_config_size' _DSM command

    * ACPI 6.2 Label Storage Read / Write commands

...export the generic libnvdimm DIMM status in a new 'flags' attribute.

This attribute can also reflect the 'alias' state which indicates
whether the nvdimm core is enforcing labels for aliased-region-capacity
that the given dimm is an interleave-set member.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/dimm_devs.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvdimm/dimm_devs.c b/drivers/nvdimm/dimm_devs.c
index 5f1385b96b13..097794d9f786 100644
--- a/drivers/nvdimm/dimm_devs.c
+++ b/drivers/nvdimm/dimm_devs.c
@@ -331,6 +331,17 @@ static ssize_t commands_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(commands);
 
+static ssize_t flags_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvdimm *nvdimm = to_nvdimm(dev);
+
+	return sprintf(buf, "%s%s\n",
+			test_bit(NDD_ALIASING, &nvdimm->flags) ? "alias " : "",
+			test_bit(NDD_LOCKED, &nvdimm->flags) ? "lock " : "");
+}
+static DEVICE_ATTR_RO(flags);
+
 static ssize_t state_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
@@ -372,6 +383,7 @@ static DEVICE_ATTR_RO(available_slots);
 
 static struct attribute *nvdimm_attributes[] = {
 	&dev_attr_state.attr,
+	&dev_attr_flags.attr,
 	&dev_attr_commands.attr,
 	&dev_attr_available_slots.attr,
 	NULL,

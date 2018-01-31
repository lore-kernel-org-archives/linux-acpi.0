From: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v4 3/4] libnvdimm: expose platform persistence attribute for
 nd_region
Date: Tue, 30 Jan 2018 17:21:33 -0700
Message-ID: <151735809380.47256.16089920429804758437.stgit@djiang5-desk3.ch.intel.com>
References: <151735800899.47256.2204307128644539213.stgit@djiang5-desk3.ch.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <151735800899.47256.2204307128644539213.stgit-Cxk7aZI4ujnJARH06PadV2t3HXsI98Cx0E9HWUfgJXw@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org
Cc: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Providing a sysfs attribute for nd_region that shows the persistence
capabilities for the platform.

Signed-off-by: Dave Jiang <dave.jiang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Reviewed-by: Ross Zwisler <ross.zwisler-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
---
 drivers/nvdimm/region_devs.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index abaf38c61220..e6d01911e092 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -528,6 +528,18 @@ static ssize_t resource_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(resource);
 
+static ssize_t persistence_domain_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nd_region *nd_region = to_nd_region(dev);
+	unsigned long flags = nd_region->flags;
+
+	return sprintf(buf, "%s%s\n",
+			flags & BIT(ND_REGION_PERSIST_CACHE) ? "cpu_cache " : "",
+			flags & BIT(ND_REGION_PERSIST_MEMCTRL) ? "memory_controller " : "");
+}
+static DEVICE_ATTR_RO(persistence_domain);
+
 static struct attribute *nd_region_attributes[] = {
 	&dev_attr_size.attr,
 	&dev_attr_nstype.attr,
@@ -543,6 +555,7 @@ static struct attribute *nd_region_attributes[] = {
 	&dev_attr_init_namespaces.attr,
 	&dev_attr_badblocks.attr,
 	&dev_attr_resource.attr,
+	&dev_attr_persistence_domain.attr,
 	NULL,
 };

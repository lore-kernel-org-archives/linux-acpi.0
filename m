From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2 11/17] libnvdimm,
 pmem: flush posted-write queues on shutdown
Date: Sat, 09 Jul 2016 20:25:27 -0700
Message-ID: <146812112775.32932.16750910979264437016.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <146812106839.32932.2870621200867047059.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <146812106839.32932.2870621200867047059.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Commit writes to media on system shutdown or pmem driver unload.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/bus.c  |   16 ++++++++++++++++
 drivers/nvdimm/pmem.c |    8 ++++++++
 include/linux/nd.h    |    1 +
 3 files changed, 25 insertions(+)

diff --git a/drivers/nvdimm/bus.c b/drivers/nvdimm/bus.c
index e4882e63bece..1cc7880320fe 100644
--- a/drivers/nvdimm/bus.c
+++ b/drivers/nvdimm/bus.c
@@ -136,6 +136,21 @@ static int nvdimm_bus_remove(struct device *dev)
 	return rc;
 }
 
+static void nvdimm_bus_shutdown(struct device *dev)
+{
+	struct nvdimm_bus *nvdimm_bus = walk_to_nvdimm_bus(dev);
+	struct nd_device_driver *nd_drv = NULL;
+
+	if (dev->driver)
+		nd_drv = to_nd_device_driver(dev->driver);
+
+	if (nd_drv && nd_drv->shutdown) {
+		nd_drv->shutdown(dev);
+		dev_dbg(&nvdimm_bus->dev, "%s.shutdown(%s)\n",
+				dev->driver->name, dev_name(dev));
+	}
+}
+
 void nd_device_notify(struct device *dev, enum nvdimm_event event)
 {
 	device_lock(dev);
@@ -214,6 +229,7 @@ static struct bus_type nvdimm_bus_type = {
 	.match = nvdimm_bus_match,
 	.probe = nvdimm_bus_probe,
 	.remove = nvdimm_bus_remove,
+	.shutdown = nvdimm_bus_shutdown,
 };
 
 static ASYNC_DOMAIN_EXCLUSIVE(nd_async_domain);
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 18cd95719da0..3f3fdb9586b9 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -351,9 +351,16 @@ static int nd_pmem_remove(struct device *dev)
 {
 	if (is_nd_btt(dev))
 		nvdimm_namespace_detach_btt(to_nd_btt(dev));
+	nvdimm_flush(to_nd_region(dev->parent));
+
 	return 0;
 }
 
+static void nd_pmem_shutdown(struct device *dev)
+{
+	nvdimm_flush(to_nd_region(dev->parent));
+}
+
 static void nd_pmem_notify(struct device *dev, enum nvdimm_event event)
 {
 	struct pmem_device *pmem = dev_get_drvdata(dev);
@@ -393,6 +400,7 @@ static struct nd_device_driver nd_pmem_driver = {
 	.probe = nd_pmem_probe,
 	.remove = nd_pmem_remove,
 	.notify = nd_pmem_notify,
+	.shutdown = nd_pmem_shutdown,
 	.drv = {
 		.name = "nd_pmem",
 	},
diff --git a/include/linux/nd.h b/include/linux/nd.h
index aee2761d294c..1ecd64643512 100644
--- a/include/linux/nd.h
+++ b/include/linux/nd.h
@@ -26,6 +26,7 @@ struct nd_device_driver {
 	unsigned long type;
 	int (*probe)(struct device *dev);
 	int (*remove)(struct device *dev);
+	void (*shutdown)(struct device *dev);
 	void (*notify)(struct device *dev, enum nvdimm_event event);
 };

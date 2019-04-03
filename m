From: Pankaj Gupta <pagupta-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: [PATCH v4 3/5] libnvdimm: add dax_dev sync flag
Date: Wed,  3 Apr 2019 16:10:16 +0530
Message-ID: <20190403104018.23947-4-pagupta@redhat.com>
References: <20190403104018.23947-1-pagupta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20190403104018.23947-1-pagupta-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, virtualization-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-fsdevel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, linux-ext4-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-xfs-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: jack-AlSwsSmVLrQ@public.gmane.org, mst-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, david-FqsqvQoI3Ljby3iVrkZq2A@public.gmane.org, lcapitulino-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, adilger.kernel-m1MBpc4rdrD3fQ9qLvQP4Q@public.gmane.org, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, darrick.wong-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org, david-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, willy-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, hch-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, nilal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, riel-ebMLmSuQjDVBDgjK7y7TUQ@public.gmane.org, stefanha-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, kwolf-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, tytso-3s7WtUTddSA@public.gmane.org, xiaoguangrong.eric-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cohuck-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, imammedo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

This patch adds 'DAXDEV_SYNC' flag which is set
for nd_region doing synchronous flush. This later 
is used to disable MAP_SYNC functionality for 
ext4 & xfs filesystem for devices don't support
synchronous flush.

Signed-off-by: Pankaj Gupta <pagupta-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
---
 drivers/dax/bus.c            |  2 +-
 drivers/dax/super.c          | 13 ++++++++++++-
 drivers/md/dm.c              |  2 +-
 drivers/nvdimm/pmem.c        |  3 ++-
 drivers/nvdimm/region_devs.c |  7 +++++++
 include/linux/dax.h          |  9 +++++++--
 include/linux/libnvdimm.h    |  1 +
 7 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
index 2109cfe80219..431bf7d2a7f9 100644
--- a/drivers/dax/bus.c
+++ b/drivers/dax/bus.c
@@ -388,7 +388,7 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
 	 * No 'host' or dax_operations since there is no access to this
 	 * device outside of mmap of the resulting character device.
 	 */
-	dax_dev = alloc_dax(dev_dax, NULL, NULL);
+	dax_dev = alloc_dax(dev_dax, NULL, NULL, true);
 	if (!dax_dev)
 		goto err;
 
diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 0a339b85133e..bd6509308d05 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -186,6 +186,8 @@ enum dax_device_flags {
 	DAXDEV_ALIVE,
 	/* gate whether dax_flush() calls the low level flush routine */
 	DAXDEV_WRITE_CACHE,
+	/* flag to check if device supports synchronous flush */
+	DAXDEV_SYNC,
 };
 
 /**
@@ -354,6 +356,12 @@ bool dax_write_cache_enabled(struct dax_device *dax_dev)
 }
 EXPORT_SYMBOL_GPL(dax_write_cache_enabled);
 
+bool dax_synchronous(struct dax_device *dax_dev)
+{
+	return test_bit(DAXDEV_SYNC, &dax_dev->flags);
+}
+EXPORT_SYMBOL_GPL(dax_synchronous);
+
 bool dax_alive(struct dax_device *dax_dev)
 {
 	lockdep_assert_held(&dax_srcu);
@@ -511,7 +519,7 @@ static void dax_add_host(struct dax_device *dax_dev, const char *host)
 }
 
 struct dax_device *alloc_dax(void *private, const char *__host,
-		const struct dax_operations *ops)
+		const struct dax_operations *ops, bool sync)
 {
 	struct dax_device *dax_dev;
 	const char *host;
@@ -534,6 +542,9 @@ struct dax_device *alloc_dax(void *private, const char *__host,
 	dax_add_host(dax_dev, host);
 	dax_dev->ops = ops;
 	dax_dev->private = private;
+	if (sync)
+		set_bit(DAXDEV_SYNC, &dax_dev->flags);
+
 	return dax_dev;
 
  err_dev:
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index 68d24056d0b1..534e12ca6329 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1965,7 +1965,7 @@ static struct mapped_device *alloc_dev(int minor)
 	sprintf(md->disk->disk_name, "dm-%d", minor);
 
 	if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
-		dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops);
+		dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops, true);
 		if (!dax_dev)
 			goto bad;
 	}
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 5a5b3ea4d073..78f71ba0e7cf 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -466,7 +466,8 @@ static int pmem_attach_disk(struct device *dev,
 	nvdimm_badblocks_populate(nd_region, &pmem->bb, &bb_res);
 	disk->bb = &pmem->bb;
 
-	dax_dev = alloc_dax(pmem, disk->disk_name, &pmem_dax_ops);
+	dax_dev = alloc_dax(pmem, disk->disk_name, &pmem_dax_ops,
+					is_nvdimm_sync(nd_region));
 
 	if (!dax_dev) {
 		put_disk(disk);
diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
index fb1041ab32a6..8c7aa047fe2b 100644
--- a/drivers/nvdimm/region_devs.c
+++ b/drivers/nvdimm/region_devs.c
@@ -1231,6 +1231,13 @@ int nvdimm_has_cache(struct nd_region *nd_region)
 }
 EXPORT_SYMBOL_GPL(nvdimm_has_cache);
 
+bool is_nvdimm_sync(struct nd_region *nd_region)
+{
+	return is_nd_pmem(&nd_region->dev) &&
+		!test_bit(ND_REGION_ASYNC, &nd_region->flags);
+}
+EXPORT_SYMBOL_GPL(is_nvdimm_sync);
+
 struct conflict_context {
 	struct nd_region *nd_region;
 	resource_size_t start, size;
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 0dd316a74a29..9bdd50d06ef6 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -32,18 +32,19 @@ extern struct attribute_group dax_attribute_group;
 #if IS_ENABLED(CONFIG_DAX)
 struct dax_device *dax_get_by_host(const char *host);
 struct dax_device *alloc_dax(void *private, const char *host,
-		const struct dax_operations *ops);
+		const struct dax_operations *ops, bool sync);
 void put_dax(struct dax_device *dax_dev);
 void kill_dax(struct dax_device *dax_dev);
 void dax_write_cache(struct dax_device *dax_dev, bool wc);
 bool dax_write_cache_enabled(struct dax_device *dax_dev);
+bool dax_synchronous(struct dax_device *dax_dev);
 #else
 static inline struct dax_device *dax_get_by_host(const char *host)
 {
 	return NULL;
 }
 static inline struct dax_device *alloc_dax(void *private, const char *host,
-		const struct dax_operations *ops)
+		const struct dax_operations *ops, bool sync)
 {
 	/*
 	 * Callers should check IS_ENABLED(CONFIG_DAX) to know if this
@@ -64,6 +65,10 @@ static inline bool dax_write_cache_enabled(struct dax_device *dax_dev)
 {
 	return false;
 }
+static inline bool dax_synchronous(struct dax_device *dax_dev)
+{
+	return false;
+}
 #endif
 
 struct writeback_control;
diff --git a/include/linux/libnvdimm.h b/include/linux/libnvdimm.h
index d9d2ab8a6e64..9a8aea370cbc 100644
--- a/include/linux/libnvdimm.h
+++ b/include/linux/libnvdimm.h
@@ -270,6 +270,7 @@ int generic_nvdimm_flush(struct nd_region *nd_region);
 int nvdimm_has_flush(struct nd_region *nd_region);
 int nvdimm_has_cache(struct nd_region *nd_region);
 int nvdimm_in_overwrite(struct nvdimm *nvdimm);
+bool is_nvdimm_sync(struct nd_region *nd_region);
 
 static inline int nvdimm_ctl(struct nvdimm *nvdimm, unsigned int cmd, void *buf,
 		unsigned int buf_len, int *cmd_rc)
-- 
2.20.1

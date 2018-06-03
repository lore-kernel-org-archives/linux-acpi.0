From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH] acpi, nfit: Remove ecc_unit_size
Date: Sun, 03 Jun 2018 12:55:34 -0700
Message-ID: <152805573421.36904.10280982218277525255.stgit@dwillia2-desk3.amr.corp.intel.com>
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

The "Clear Error Unit" may be smaller than the ECC unit size on some
devices. For example, poison may be tracked at 64-byte alignment even
though the ECC unit is larger. Unless / until the ACPI specification
provides a non-ambiguous way to communicate this property do not expose
this to userspace.

Software that had been using this property must already be prepared for
the case where the property is not provided on older kernels, so it is
safe to remove this attribute.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 Documentation/ABI/removed/sysfs-bus-nfit |   17 +++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-nfit |   19 -------------------
 drivers/acpi/nfit/core.c                 |   11 -----------
 3 files changed, 17 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/ABI/removed/sysfs-bus-nfit

diff --git a/Documentation/ABI/removed/sysfs-bus-nfit b/Documentation/ABI/removed/sysfs-bus-nfit
new file mode 100644
index 000000000000..ae8c1ca53828
--- /dev/null
+++ b/Documentation/ABI/removed/sysfs-bus-nfit
@@ -0,0 +1,17 @@
+What:		/sys/bus/nd/devices/regionX/nfit/ecc_unit_size
+Date:		Aug, 2017
+KernelVersion:	v4.14 (Removed v4.18)
+Contact:	linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
+Description:
+		(RO) Size of a write request to a DIMM that will not incur a
+		read-modify-write cycle at the memory controller.
+
+		When the nfit driver initializes it runs an ARS (Address Range
+		Scrub) operation across every pmem range. Part of that process
+		involves determining the ARS capabilities of a given address
+		range. One of the capabilities that is reported is the 'Clear
+		Uncorrectable Error Range Length Unit Size' (see: ACPI 6.2
+		section 9.20.7.4 Function Index 1 - Query ARS Capabilities).
+		This property indicates the boundary at which the NVDIMM may
+		need to perform read-modify-write cycles to maintain ECC (Error
+		Correcting Code) blocks.
diff --git a/Documentation/ABI/testing/sysfs-bus-nfit b/Documentation/ABI/testing/sysfs-bus-nfit
index 619eb8ca0f99..a1cb44dcb908 100644
--- a/Documentation/ABI/testing/sysfs-bus-nfit
+++ b/Documentation/ABI/testing/sysfs-bus-nfit
@@ -212,22 +212,3 @@ Description:
 		range. Used by NVDIMM Region Mapping Structure to uniquely refer
 		to this structure. Value of 0 is reserved and not used as an
 		index.
-
-
-What:		/sys/bus/nd/devices/regionX/nfit/ecc_unit_size
-Date:		Aug, 2017
-KernelVersion:	v4.14
-Contact:	linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
-Description:
-		(RO) Size of a write request to a DIMM that will not incur a
-		read-modify-write cycle at the memory controller.
-
-		When the nfit driver initializes it runs an ARS (Address Range
-		Scrub) operation across every pmem range. Part of that process
-		involves determining the ARS capabilities of a given address
-		range. One of the capabilities that is reported is the 'Clear
-		Uncorrectable Error Range Length Unit Size' (see: ACPI 6.2
-		section 9.20.7.4 Function Index 1 - Query ARS Capabilities).
-		This property indicates the boundary at which the NVDIMM may
-		need to perform read-modify-write cycles to maintain ECC (Error
-		Correcting Code) blocks.
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index e2235ed3e4be..b87252bf4571 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1978,19 +1978,8 @@ static ssize_t range_index_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(range_index);
 
-static ssize_t ecc_unit_size_show(struct device *dev,
-		struct device_attribute *attr, char *buf)
-{
-	struct nd_region *nd_region = to_nd_region(dev);
-	struct nfit_spa *nfit_spa = nd_region_provider_data(nd_region);
-
-	return sprintf(buf, "%d\n", nfit_spa->clear_err_unit);
-}
-static DEVICE_ATTR_RO(ecc_unit_size);
-
 static struct attribute *acpi_nfit_region_attributes[] = {
 	&dev_attr_range_index.attr,
-	&dev_attr_ecc_unit_size.attr,
 	NULL,
 };

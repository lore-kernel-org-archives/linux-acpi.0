From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH v2] acpi, nfit: kill ACPI_NFIT_DEBUG
Date: Fri, 28 Apr 2017 16:48:12 -0700
Message-ID: <149342311149.438.10499300640043562280.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149341494933.35578.4269653029034926839.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <149341494933.35578.4269653029034926839.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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
Cc: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

Inevitably when one actually needs to debug a DSM issue it's on a
distribution kernel that has CONFIG_ACPI_NFIT_DEBUG=n. The config symbol
was only there to avoid the compile error due to the missing fallback for
print_hex_dump_debug in the CONFIG_DYNAMIC_DEBUG=n case. That was fixed
with commit cdf17449af1d "hexdump: do not print debug dumps for
!CONFIG_DEBUG", so the config symbol can just be dropped.

Cc: Joe Perches <joe-6d6DIl74uiNBDgjK7y7TUQ@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
Changes in v2:
* Thanks to Joe for pointing out the misunderstanding about
  print_hex_dump_debug() compilation being broken in the
  CONFIG_DYNAMIC_DEBUG=n case. Since commit cdf17449af1d we can rely on
  print_hex_dump_debug() to do the right thing by default.

 drivers/acpi/nfit/Kconfig |   12 ------------
 drivers/acpi/nfit/core.c  |   21 ++++++++-------------
 2 files changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/nfit/Kconfig b/drivers/acpi/nfit/Kconfig
index dd0d53c52552..6d3351452ea2 100644
--- a/drivers/acpi/nfit/Kconfig
+++ b/drivers/acpi/nfit/Kconfig
@@ -12,15 +12,3 @@ config ACPI_NFIT
 
 	  To compile this driver as a module, choose M here:
 	  the module will be called nfit.
-
-config ACPI_NFIT_DEBUG
-	bool "NFIT DSM debug"
-	depends on ACPI_NFIT
-	depends on DYNAMIC_DEBUG
-	default n
-	help
-	  Enabling this option causes the nfit driver to dump the
-	  input and output buffers of _DSM operations on the ACPI0012
-	  device and its children.  This can be very verbose, so leave
-	  it disabled unless you are debugging a hardware / firmware
-	  issue.
diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 261eea1d2906..ced95a79c1a1 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -268,14 +268,11 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		in_buf.buffer.length = call_pkg->nd_size_in;
 	}
 
-	if (IS_ENABLED(CONFIG_ACPI_NFIT_DEBUG)) {
-		dev_dbg(dev, "%s:%s cmd: %d: func: %d input length: %d\n",
-				__func__, dimm_name, cmd, func,
-				in_buf.buffer.length);
-		print_hex_dump_debug("nvdimm in  ", DUMP_PREFIX_OFFSET, 4, 4,
+	dev_dbg(dev, "%s:%s cmd: %d: func: %d input length: %d\n",
+			__func__, dimm_name, cmd, func, in_buf.buffer.length);
+	print_hex_dump_debug("nvdimm in  ", DUMP_PREFIX_OFFSET, 4, 4,
 			in_buf.buffer.pointer,
 			min_t(u32, 256, in_buf.buffer.length), true);
-	}
 
 	out_obj = acpi_evaluate_dsm(handle, uuid, 1, func, &in_obj);
 	if (!out_obj) {
@@ -307,13 +304,11 @@ int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		goto out;
 	}
 
-	if (IS_ENABLED(CONFIG_ACPI_NFIT_DEBUG)) {
-		dev_dbg(dev, "%s:%s cmd: %s output length: %d\n", __func__,
-				dimm_name, cmd_name, out_obj->buffer.length);
-		print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4,
-				4, out_obj->buffer.pointer, min_t(u32, 128,
-					out_obj->buffer.length), true);
-	}
+	dev_dbg(dev, "%s:%s cmd: %s output length: %d\n", __func__, dimm_name,
+			cmd_name, out_obj->buffer.length);
+	print_hex_dump_debug(cmd_name, DUMP_PREFIX_OFFSET, 4, 4,
+			out_obj->buffer.pointer,
+			min_t(u32, 128, out_obj->buffer.length), true);
 
 	for (i = 0, offset = 0; i < desc->out_num; i++) {
 		u32 out_size = nd_cmd_out_size(nvdimm, cmd, desc, i, buf,

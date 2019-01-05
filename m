From: Xiaochun Lee <lixiaochun.2888-9Onoh4P/yGk@public.gmane.org>
Subject: [PATCH] ACPI/nfit: delete the function to_acpi_nfit_desc
Date: Sat,  5 Jan 2019 16:08:38 +0800
Message-ID: <1546675718-31174-2-git-send-email-lixiaochun.2888@163.com>
References: <1546675718-31174-1-git-send-email-lixiaochun.2888@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <1546675718-31174-1-git-send-email-lixiaochun.2888-9Onoh4P/yGk@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Cc: rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Xiaochun Lee <lixc17-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>, zwisler-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Xiaochun Lee <lixc17-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>

The function to_acpi_nfit_desc and function to_acpi_desc
do the same things,delete the function to_acpi_nfit_desc,
and keep the inline function to_acpi_desc.

Signed-off-by: Xiaochun Lee <lixc17-6jq1YtArVR3QT0dZR+AlfA@public.gmane.org>
---
 drivers/acpi/nfit/core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 011d3db..8f09410 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -78,12 +78,6 @@ const guid_t *to_nfit_uuid(enum nfit_uuids id)
 }
 EXPORT_SYMBOL(to_nfit_uuid);
 
-static struct acpi_nfit_desc *to_acpi_nfit_desc(
-		struct nvdimm_bus_descriptor *nd_desc)
-{
-	return container_of(nd_desc, struct acpi_nfit_desc, nd_desc);
-}
-
 static struct acpi_device *to_acpi_dev(struct acpi_nfit_desc *acpi_desc)
 {
 	struct nvdimm_bus_descriptor *nd_desc = &acpi_desc->nd_desc;
@@ -419,7 +413,7 @@ static bool payload_dumpable(struct nvdimm *nvdimm, unsigned int func)
 int acpi_nfit_ctl(struct nvdimm_bus_descriptor *nd_desc, struct nvdimm *nvdimm,
 		unsigned int cmd, void *buf, unsigned int buf_len, int *cmd_rc)
 {
-	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 	struct nfit_mem *nfit_mem = nvdimm_provider_data(nvdimm);
 	union acpi_object in_obj, in_buf, *out_obj;
 	const struct nd_cmd_desc *desc = NULL;
@@ -3367,7 +3361,7 @@ int acpi_nfit_init(struct acpi_nfit_desc *acpi_desc, void *data, acpi_size sz)
 
 static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 {
-	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 	struct device *dev = acpi_desc->dev;
 
 	/* Bounce the device lock to flush acpi_nfit_add / acpi_nfit_notify */
@@ -3384,7 +3378,7 @@ static int acpi_nfit_flush_probe(struct nvdimm_bus_descriptor *nd_desc)
 static int __acpi_nfit_clear_to_send(struct nvdimm_bus_descriptor *nd_desc,
 		struct nvdimm *nvdimm, unsigned int cmd)
 {
-	struct acpi_nfit_desc *acpi_desc = to_acpi_nfit_desc(nd_desc);
+	struct acpi_nfit_desc *acpi_desc = to_acpi_desc(nd_desc);
 
 	if (nvdimm)
 		return 0;
-- 
1.8.3.1

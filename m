From: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: [PATCH AUTOSEL 4.20 052/105] acpi/nfit: Fix race accessing memdev in
 nfit_get_smbios_id()
Date: Tue, 12 Feb 2019 21:32:43 -0500
Message-ID: <20190213023336.19019-52-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <20190213023336.19019-1-sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.01.org/mailman/options/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.01.org/pipermail/linux-nvdimm/>
List-Post: <mailto:linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
List-Help: <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=help>
List-Subscribe: <https://lists.01.org/mailman/listinfo/linux-nvdimm>,
 <mailto:linux-nvdimm-request-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org?subject=subscribe>
Errors-To: linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
Sender: "Linux-nvdimm" <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
To: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stable-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-nvdimm-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org
List-Id: linux-acpi@vger.kernel.org

From: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>

[ Upstream commit 0919871ac37fdcf46c7657da0f1742efe096b399 ]

Possible race accessing memdev structures after dropping the
mutex. Dan Williams says this could race against another thread
that is doing:

 # echo "ACPI0012:00" > /sys/bus/acpi/drivers/nfit/unbind

Reported-by: Jane Chu <jane.chu-QHcLZuEGTsvQT0dZR+AlfA@public.gmane.org>
Fixes: 23222f8f8dce ("acpi, nfit: Add function to look up nvdimm...")
Signed-off-by: Tony Luck <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Signed-off-by: Sasha Levin <sashal-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
---
 drivers/acpi/nfit/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 8535e7999769..2a2d7ec77252 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -724,6 +724,7 @@ int nfit_get_smbios_id(u32 device_handle, u16 *flags)
 	struct acpi_nfit_memory_map *memdev;
 	struct acpi_nfit_desc *acpi_desc;
 	struct nfit_mem *nfit_mem;
+	u16 physical_id;
 
 	mutex_lock(&acpi_desc_lock);
 	list_for_each_entry(acpi_desc, &acpi_descs, list) {
@@ -731,10 +732,11 @@ int nfit_get_smbios_id(u32 device_handle, u16 *flags)
 		list_for_each_entry(nfit_mem, &acpi_desc->dimms, list) {
 			memdev = __to_nfit_memdev(nfit_mem);
 			if (memdev->device_handle == device_handle) {
+				*flags = memdev->flags;
+				physical_id = memdev->physical_id;
 				mutex_unlock(&acpi_desc->init_mutex);
 				mutex_unlock(&acpi_desc_lock);
-				*flags = memdev->flags;
-				return memdev->physical_id;
+				return physical_id;
 			}
 		}
 		mutex_unlock(&acpi_desc->init_mutex);
-- 
2.19.1

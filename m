From: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 6/9] libnvdimm,
 label: update 'nlabel' and 'position' handling for local namespaces
Date: Thu, 08 Jun 2017 22:09:22 -0700
Message-ID: <149698496243.11651.2837723446573437905.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <149698493023.11651.13036549892428981091.stgit@dwillia2-desk3.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-nvdimm-bounces-hn68Rpc1hR1g9hUCZPvPmw@public.gmane.org>
In-Reply-To: <149698493023.11651.13036549892428981091.stgit-p8uTFz9XbKj2zm6wflaqv1nYeNYlB/vhral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
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

The v1.2 namespace label specification requires 'nlabel' and 'position'
to be valid for the first ("lowest dpa") label in the set. It also
requires all non-first labels to set those fields to 0xff.

Linux does not much care if these values are correct, because we can
just trust the count of labels with the matching uuid like the v1.1
case. However, we set them correctly in case other environments care.

Signed-off-by: Dan Williams <dan.j.williams-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
---
 drivers/nvdimm/label.c |   33 +++++++++++++++++++++++++++------
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/nvdimm/label.c b/drivers/nvdimm/label.c
index ba0582fb0e21..d7f9916c6ed5 100644
--- a/drivers/nvdimm/label.c
+++ b/drivers/nvdimm/label.c
@@ -696,6 +696,7 @@ static int __blk_label_update(struct nd_region *nd_region,
 	struct resource *res, **old_res_list;
 	struct nd_label_id label_id;
 	u8 uuid[NSLABEL_UUID_LEN];
+	int min_dpa_idx = 0;
 	LIST_HEAD(list);
 	u32 nslot, slot;
 
@@ -767,6 +768,18 @@ static int __blk_label_update(struct nd_region *nd_region,
 		}
 	}
 
+	/*
+	 * Find the resource associated with the first label in the set
+	 * per the v1.2 namespace specification.
+	 */
+	for (i = 0; i < nsblk->num_resources; i++) {
+		struct resource *min = nsblk->res[min_dpa_idx];
+
+		res = nsblk->res[i];
+		if (res->start < min->start)
+			min_dpa_idx = i;
+	}
+
 	for (i = 0; i < nsblk->num_resources; i++) {
 		size_t offset;
 
@@ -785,18 +798,26 @@ static int __blk_label_update(struct nd_region *nd_region,
 			memcpy(nd_label->name, nsblk->alt_name,
 					NSLABEL_NAME_LEN);
 		nd_label->flags = __cpu_to_le32(NSLABEL_FLAG_LOCAL);
-		nd_label->nlabel = __cpu_to_le16(0); /* N/A */
-		nd_label->position = __cpu_to_le16(0); /* N/A */
 
 		/*
 		 * Use the presence of the type_guid as a flag to
-		 * determine isetcookie usage for blk-aperture
-		 * namespaces.
+		 * determine isetcookie usage and nlabel + position
+		 * policy for blk-aperture namespaces.
 		 */
-		if (namespace_label_has(ndd, type_guid))
+		if (namespace_label_has(ndd, type_guid)) {
+			if (i == min_dpa_idx) {
+				nd_label->nlabel = __cpu_to_le16(nsblk->num_resources);
+				nd_label->position = __cpu_to_le16(0);
+			} else {
+				nd_label->nlabel = __cpu_to_le16(0xffff);
+				nd_label->position = __cpu_to_le16(0xffff);
+			}
 			nd_label->isetcookie = __cpu_to_le64(nd_set->cookie2);
-		else
+		} else {
+			nd_label->nlabel = __cpu_to_le16(0); /* N/A */
+			nd_label->position = __cpu_to_le16(0); /* N/A */
 			nd_label->isetcookie = __cpu_to_le64(0); /* N/A */
+		}
 
 		nd_label->dpa = __cpu_to_le64(res->start);
 		nd_label->rawsize = __cpu_to_le64(resource_size(res));

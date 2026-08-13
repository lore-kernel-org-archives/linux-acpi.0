Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D5437F8C3;
	Thu, 13 Aug 2026 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786637152; cv=none; b=dqL5AWRDNtcdo9NF3R1N6arbRZ1EI9H3FhY5/elrf97Y+ZWUCI7OIJwot8zkJ4PeXiGFQ+Pi5/81F3x2wWhKjgI+7Z6nS7zvSje7GSBC5j8U7kAnZscGorosTAabW/YW80c0kb6uJwiHODj3GnEBSGufj+sCEcQ6t7HI8iOyzkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786637152; c=relaxed/simple;
	bh=tiR2SAWoFJgNdFTsPEU90nhOLXG6ibnAMGSGwfmNFAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pVQ6WxsmtBPIUiA41ys6tR82tC7NVKv6bc4XtsK06oJzI4NmMYs2pqIb5W7DN3SdqfLT4v+yVQtXOWcRMsZygN/RhBdFBZuPMICYNyGhXSv6uZ9IQpIZjmoi2CbQhmMZVPqPA8Dv18QNw6i/HWF+ielXdtGTxSippaLcZmG95F4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAAX7O9V631qIEh7BQ--.56475S2;
	Fri, 14 Aug 2026 00:05:41 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2 2/2] ACPI: IORT: validate RMR node array extents
Date: Fri, 14 Aug 2026 00:05:40 +0800
Message-ID: <20260813160540.72395-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260813160118.69153-1-pengpeng@iscas.ac.cn>
References: <20260813160118.69153-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAX7O9V631qIEh7BQ--.56475S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJw1UGF15uFWkZF4xGrW7urg_yoW5CFykpF
	4DGry5Aws5JF12grWSv3Z5AFWYqw1kGrWakrZa93yqyFn0yrnIya109FyY9F15JFW8ua1x
	Krs8tFW7CF1DZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_
	JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbtxhJUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

IORT RMR nodes carry offsets and counts for reserved-memory descriptors and
ID mappings.  iort_node_get_rmr_info() trusts both arrays and later loops
over the firmware counts without proving that either array fits in the
containing node.

Require the fixed RMR payload, then validate each non-empty array with
checked multiplication and subtraction-based bounds before constructing
an element pointer.  Keep the helpers under CONFIG_IOMMU_API with their
users.

Fixes: 491cf4a6735a ("ACPI/IORT: Add support to retrieve IORT RMR reserved regions")
Assisted-by: Codex:gpt-5
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/arm64/iort.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 101d54eec544..17d904f4c1ee 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -15,6 +15,7 @@
 #include <linux/iommu.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
+#include <linux/overflow.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -962,6 +963,48 @@ void acpi_configure_pmsi_domain(struct device *dev)
 }
 
 #ifdef CONFIG_IOMMU_API
+static bool iort_node_array_valid(struct acpi_iort_node *node, u32 offset,
+				  u32 count, size_t elem_size,
+				  size_t min_offset, const char *name)
+{
+	size_t bytes;
+
+	/* An empty array has no elements to access, regardless of its offset. */
+	if (!count)
+		return true;
+
+	if (!offset || offset < min_offset || offset > node->length) {
+		pr_err(FW_BUG "Invalid %s offset in IORT node %p\n", name,
+		       node);
+		return false;
+	}
+
+	if (check_mul_overflow(count, elem_size, &bytes) ||
+	    bytes > node->length - offset) {
+		pr_err(FW_BUG "Invalid %s array in IORT node %p\n", name,
+		       node);
+		return false;
+	}
+
+	return true;
+}
+
+static bool iort_rmr_node_valid(struct acpi_iort_node *node)
+{
+	struct acpi_iort_rmr *rmr;
+
+	if (node->length < sizeof(*node) + sizeof(*rmr)) {
+		pr_err(FW_BUG "Truncated RMR node in IORT table\n");
+		return false;
+	}
+
+	rmr = (struct acpi_iort_rmr *)node->node_data;
+	return iort_node_array_valid(node, rmr->rmr_offset, rmr->rmr_count,
+				     sizeof(struct acpi_iort_rmr_desc),
+				     sizeof(*node) + sizeof(*rmr),
+				     "RMR descriptor");
+}
+
 static void iort_rmr_free(struct device *dev,
 			  struct iommu_resv_region *region)
 {
@@ -1152,12 +1195,22 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
 	u32 num_sids = 0;
 	int i;
 
+	if (!iort_rmr_node_valid(node))
+		return;
+
 	if (!node->mapping_offset || !node->mapping_count) {
 		pr_err(FW_BUG "Invalid ID mapping, skipping RMR node %p\n",
 		       node);
 		return;
 	}
 
+	if (!iort_node_array_valid(node, node->mapping_offset,
+				   node->mapping_count,
+				   sizeof(struct acpi_iort_id_mapping),
+				   sizeof(*node) + sizeof(*rmr),
+				   "ID mapping"))
+		return;
+
 	rmr = (struct acpi_iort_rmr *)node->node_data;
 	if (!rmr->rmr_offset || !rmr->rmr_count)
 		return;
-- 
2.50.1 (Apple Git-155)


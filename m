Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA5442A160;
	Mon,  6 Jul 2026 09:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330704; cv=none; b=broF3lp4dmiLWQCtniD/tNxCBie7HRTd9v5bNoDmgc+BY8B5oiAin2VqOgGey4BOPo4ucLWBDrUZ7ygUiHi75Cs3Y5QMmdPuMViIxlkvxNzdoaPD3BYXMMA2dfvNkqwnKJEWTwC38Ys8wdjpbTr0dcg+/nFJ+LMgQl+i1yA5j0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330704; c=relaxed/simple;
	bh=AkgYxjUC4GndVwhKvwexqKpIWOdC6wvQhtp0vH7diwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sRojDYQA0JAnXgzGcxgPez/IKW0+N8lHbt7F2p0CdVYVEJRNMogLXHu1+47pbBt6zi2yxyQCA8js3R1rKXi4JM1KM1iF7QSU5lLhNwLo+mG1KII7lTZmO810tXpLXkdOQTjIKqzvRpAIrX9Mk9dqPcU6FvK5nJQCQfytc7GSMrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACnQMmFd0tq06jxBA--.1377S2;
	Mon, 06 Jul 2026 17:38:13 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: APMT: validate node bounds before device registration
Date: Mon,  6 Jul 2026 17:38:11 +0800
Message-ID: <20260706093811.81850-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACnQMmFd0tq06jxBA--.1377S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr43Cw4rGF4UCF4xAryxXwb_yoW8Cr1DpF
	W2gay5trWDKr4xWwsavw4rZ3y3Aa1IyrW7KrWDG3yqg3Z8Kry7GFyFyFyjv3W8JFZ7Jw4a
	qF45tFyUGFWUAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9I14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr
	1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j
	6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJb
	IYCTnIWIevJa73UjIFyTuYvjfU5byZUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The APMT parser walks variable-length nodes from the ACPI table and
passes each node pointer to the platform device that is later consumed by
the Arm Coresight PMU driver. The loop only checked that the node start
was before the table end before reading the full struct acpi_apmt_node and
advancing by node->length.

Validate the fixed node body and the declared node length before using the
node. This keeps malformed short nodes from being consumed locally or
propagated to the runtime PMU driver as platform data.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/arm64/apmt.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/acpi/arm64/apmt.c b/drivers/acpi/arm64/apmt.c
index bb010f6164e5..5f341fa86fab 100644
--- a/drivers/acpi/arm64/apmt.c
+++ b/drivers/acpi/arm64/apmt.c
@@ -23,6 +23,21 @@
 /* Root pointer to the mapped APMT table */
 static struct acpi_table_header *apmt_table;
 
+static bool __init apmt_node_valid(struct acpi_table_apmt *apmt, u64 offset,
+				   u64 end)
+{
+	struct acpi_apmt_node *node;
+
+	if (offset > end || end - offset < sizeof(*node))
+		return false;
+
+	node = ACPI_ADD_PTR(struct acpi_apmt_node, apmt, offset);
+	if (node->length < sizeof(*node))
+		return false;
+
+	return node->length <= end - offset;
+}
+
 static int __init apmt_init_resources(struct resource *res,
 				      struct acpi_apmt_node *node)
 {
@@ -129,8 +144,13 @@ static int __init apmt_init_platform_devices(void)
 	apmt = (struct acpi_table_apmt *)apmt_table;
 	offset = sizeof(*apmt);
 	end = apmt->header.length;
+	if (end < sizeof(*apmt))
+		return -EINVAL;
 
 	while (offset < end) {
+		if (!apmt_node_valid(apmt, offset, end))
+			return -EINVAL;
+
 		apmt_node = ACPI_ADD_PTR(struct acpi_apmt_node, apmt,
 				 offset);
 
-- 
2.43.0


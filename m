Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75D86BB5B;
	Mon,  6 Jul 2026 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783331112; cv=none; b=Cy3lq3XkQ307Nv8QK76HLlPSM6jWU3IRyWG6nHZmmTOabmXscDy7DzYfGveC5/lFQPk0kHlLFAj3bmLt9XtxGar/Hz4zXAVioGviJL6KRKoNlt5Qe918kfxHdL/RP0wTq5b94MPQJg/uwOFPNrBZsXzLIE9+teE7hCtcD9vgEVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783331112; c=relaxed/simple;
	bh=pFPoguddSW5Hdy/2TcUqpEiTofUunUxa/awOfwD2iVI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C2+jhLPRq790Ehx8xDwE7cO3rpc6JIlLDDboXtSiS0m4ny3hdyzWpSW5K0L0GMBnLE+R+2OWVOAvOobvhElWsrepz1nxQHEhMawTMOSTGIePi4J5Wy+iXbBi/SrvU9wvN8yS4N7rqTlhd2agqoMNxJsdglCpFUzSy6Adnpwesw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowABH5s4heUtqb9TxBA--.35409S2;
	Mon, 06 Jul 2026 17:45:05 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ACPI: PRMT: validate module handler bounds
Date: Mon,  6 Jul 2026 17:45:04 +0800
Message-ID: <20260706094504.82920-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABH5s4heUtqb9TxBA--.35409S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCFW5XFW7JrW8AFW3ZF18Xwb_yoW5Zr17pF
	Z5K345AF45GFW29Fs3AFs5AF13A3y8Gr42qFZxKry7Jw12gF95ZF4UW3WYvr4DAr18WF1I
	yr1UtFyUCF45XF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvj14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jw0_WrylYx0Ex4A2jsIE14v26r4j6F4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j
	6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU8-
	B_UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

PRMT module entries carry handler array offsets and counts inside
firmware data.  Validate the current module length and handler
array bounds before allocating kernel-side handler storage or
walking the handler records.

This also rejects zero-handler modules, since the existing loop
expects at least one handler record before it starts copying
handler metadata.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/acpi/prmt.c | 54 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/acpi/prmt.c b/drivers/acpi/prmt.c
index 7f5851371e5f..e531f2cd724e 100644
--- a/drivers/acpi/prmt.c
+++ b/drivers/acpi/prmt.c
@@ -17,6 +17,7 @@
 #include <linux/kernel.h>
 #include <linux/efi.h>
 #include <linux/acpi.h>
+#include <linux/overflow.h>
 #include <linux/prmt.h>
 #include <asm/efi.h>
 
@@ -91,6 +92,56 @@ static u64 efi_pa_va_lookup(efi_guid_t *guid, u64 pa)
 #define get_first_handler(a) ((struct acpi_prmt_handler_info *) ((char *) (a) + a->handler_info_offset))
 #define get_next_handler(a) ((struct acpi_prmt_handler_info *) (sizeof(struct acpi_prmt_handler_info) + (char *) a))
 
+static bool __init prmt_module_info_valid(struct acpi_prmt_module_info *module_info,
+					  const unsigned long end)
+{
+	struct acpi_prmt_handler_info *handler_info;
+	unsigned long start = (unsigned long)module_info;
+	size_t handler_bytes;
+	size_t remaining;
+	int i;
+
+	if (start >= end)
+		return false;
+
+	remaining = end - start;
+	if (remaining < sizeof(*module_info) ||
+	    module_info->length < sizeof(*module_info) ||
+	    module_info->length > remaining) {
+		pr_err(FW_BUG "Invalid PRMT module length\n");
+		return false;
+	}
+
+	if (!module_info->handler_info_count) {
+		pr_err(FW_BUG "PRMT module has no handlers\n");
+		return false;
+	}
+
+	if (module_info->handler_info_offset < sizeof(*module_info) ||
+	    module_info->handler_info_offset > module_info->length) {
+		pr_err(FW_BUG "Invalid PRMT handler offset\n");
+		return false;
+	}
+
+	if (check_mul_overflow(module_info->handler_info_count,
+			       sizeof(*handler_info), &handler_bytes) ||
+	    handler_bytes > module_info->length -
+			    module_info->handler_info_offset) {
+		pr_err(FW_BUG "Invalid PRMT handler array\n");
+		return false;
+	}
+
+	handler_info = get_first_handler(module_info);
+	for (i = 0; i < module_info->handler_info_count; i++) {
+		if (handler_info[i].length < sizeof(*handler_info)) {
+			pr_err(FW_BUG "Invalid PRMT handler length\n");
+			return false;
+		}
+	}
+
+	return true;
+}
+
 static int __init
 acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 {
@@ -105,6 +156,9 @@ acpi_parse_prmt(union acpi_subtable_headers *header, const unsigned long end)
 	void *temp_mmio;
 
 	module_info = (struct acpi_prmt_module_info *) header;
+	if (!prmt_module_info_valid(module_info, end))
+		return -EINVAL;
+
 	module_info_size = struct_size(tm, handlers, module_info->handler_info_count);
 	tm = kmalloc(module_info_size, GFP_KERNEL);
 	if (!tm)
-- 
2.43.0


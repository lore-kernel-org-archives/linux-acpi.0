Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820ED3E168F
	for <linux-acpi@vger.kernel.org>; Tue, 30 Jun 2026 06:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800117; cv=none; b=TB0+G+B08ju0/YWzVowB6UdbrlNzaLG8EWavUNwVFbej3AJL6K2Fe9d8FwFYrfbHOS3bSofyFq1sP5j/Buk6LWb2vIezUKZkZuKNImB+/z7F0BoVOYlFpSlb94A8BIb9xJ+LZ7QWQu1MrWem2uyZNTIw0dqMLrGjSzAu6dA+dBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800117; c=relaxed/simple;
	bh=oAhc1O7naflREJx2lE9TJs0yvc+NtZikz5Go7df5y6I=;
	h=Cc:Message-Id:To:Content-Type:Subject:Mime-Version:From:Date; b=ItSO5sjrqdNC+/VX/toMzbDDAWkRRCQbOtGzaMb0vjBjGcCyU6cS7bbhunJdx6evxVo3JsRZFrEwVHOOFt5WxKhyeDVkLL1OstlKWttpX8Qs/YKP6jkpysHgEI7StFwZVPCeS43tl0D9/Kb5Az4zxHD9sr+mi6jSzeZLdFMiK8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=exm+zM95; arc=none smtp.client-ip=209.127.231.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="exm+zM95"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1782800107; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=qUY9LF1Vb/OCHQFZaL8yTCCkimmNJyu/uR6gvcnbILc=;
 b=exm+zM95rifu5gbQNLC20xlYdLqaqC2t0jc8ecMCHu9ohvZ0T4bQUebIZxH5Onc5rwyE7X
 rF+L+5QKv3VHhb7Ho6icjZ8/9JTJ48oTLyvvBkiq/2a5HqyFnuojFMNuNgQQpmEudnmgBZ
 WXOfp8iiKWLR2bBunqqimpH20qsIe2bdS6u6H15aJmwLvhGqc+GU7MaFiyGi911BGYlEEU
 xKyH1GeOs0v6XFJr5Cqqa4WLtqIPTaGnro3ETDuVha8FF5XTnPu+CBeP1+u/WHaJlXUeWP
 ydOceOVUhwihsPW4t/9Fduh/ZKf49LTewqIcl4XcM3wFaMbrHtv4L0BlPlQWgw==
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, "Rui Qi" <qirui.001@bytedance.com>
Message-Id: <20260630061445.2191731-1-qirui.001@bytedance.com>
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+26a435ee9+be3b82+vger.kernel.org+qirui.001@bytedance.com>
To: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>, 
	<guohanjun@huawei.com>, <mchehab@kernel.org>, 
	<xueshuai@linux.alibaba.com>, <lenb@kernel.org>, <pjw@kernel.org>, 
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>, 
	<jonathan.cameron@huawei.com>, <fabio.m.de.francesco@linux.intel.com>, 
	<leitao@debian.org>, <jason@os.amperecomputing.com>
X-Mailer: git-send-email 2.20.1
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH v2] ACPI: APEI: GHES: Mark ghes_in_nmi_spool_from_list() as maybe unused
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: Rui Qi <qirui.001@bytedance.com>
From: "Rui Qi" <qirui.001@bytedance.com>
Date: Tue, 30 Jun 2026 14:14:45 +0800

When CONFIG_ACPI_APEI_SEA and CONFIG_HAVE_ACPI_APEI_NMI are both
disabled, ghes_in_nmi_spool_from_list() becomes an unused static
function and triggers -Werror=unused-function in some configs, for
example riscv defconfig with APEI disabled.

Mark it as __maybe_unused to silence the warning while keeping the
code available for configurations that use SEA or APEI NMI.

Reviewed-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Hanjun Guo <guohanjun@huawei.com>
Reviewed-by: Shuai Xue <xueshuai@linux.alibaba.com>
Signed-off-by: Rui Qi <qirui.001@bytedance.com>
---
Changes since the original submission:
- Resend with corrected Cc entries:
  linux-acpi@vger.kernel.org and linux-riscv@lists.infradead.org.
- Add Reviewed-by tags received in the original thread.

Original thread:
https://lore.kernel.org/all/20260316082842.84356-1-qirui.001@bytedance.com/

No code changes.

 drivers/acpi/apei/ghes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 3236a3ce79d6..48f915ee5a0d 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -1397,8 +1397,8 @@ static int ghes_in_nmi_queue_one_entry(struct ghes *ghes,
 	return rc;
 }
 
-static int ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
-				       enum fixed_addresses fixmap_idx)
+static int __maybe_unused ghes_in_nmi_spool_from_list(struct list_head *rcu_list,
+			       enum fixed_addresses fixmap_idx)
 {
 	int ret = -ENOENT;
 	struct ghes *ghes;
-- 
2.20.1

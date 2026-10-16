Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4768C4E50DE;
	Fri, 16 Oct 2026 14:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160060; cv=none; b=r7ePL1Ap/BJqfcESM2opDpMiiYT0uyJRZW8P3AIxLAfjxkMfXAe5BFFkkKsgthgFAg9/N2FW3wR2bjuPzLQ9JwgtJQsfFCpYCAAGbGMuhtR4B+dDTuf8Wv8sDXl1DED6L/C/EWMDjKkfNLT81x2R8ATGQzKBXgdNj2qePMNOCaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160060; c=relaxed/simple;
	bh=TTr8DMk32vtgtDqiSSMyoDHCGT2H1Sbf0XwXv+nC9HM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i0lNt4X3h67IQ9zIIIgWzrewdG6rPGw/Oykxw1ijq/8OlX3kH1Wp0e2M2ZKei9P3KnyCPU7SiQzdu6PEfKZrF5NqK8TrMXpDomdDKQmLHvXHwyKEmlEtGOAYxCi/xdeKPGuI3aeJ1wNlhmGNUKVfSX00K0hhiFYABSVYvn/0mvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=dRUHCDEw; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="dRUHCDEw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=dR
	BV4VXizTbH5tU+1WEQjXwW89Zt3BEC8iSH4iniETY=; b=dRUHCDEwfgpquuo4/l
	ehWbyPYSnFbHsKnRL26KUvaVrxzRqOiunAutb6z3MhJhqKpK/Wh7jwx1YqXo9diK
	Qjw31+65BfB3l3cPFemo3ugkth1DMFQpbMfbde+Wj5587GCGlqJUiUkHE0atTEaB
	WFJFIkpnqSR0DIR9r+2AIhCpM=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3NysnMdJq1dUUAg--.27711S3;
	Fri, 16 Oct 2026 22:14:01 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 1/6] ACPI: irqchip: validate MADT entry bounds before probing
Date: Fri, 16 Oct 2026 22:13:52 +0800
Message-Id: <20261016141357.2793046-2-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261016141357.2793046-1-yaojiale02@163.com>
References: <20261016141357.2793046-1-yaojiale02@163.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NysnMdJq1dUUAg--.27711S3
X-Coremail-Antispam: 1Uf129KBjvdXoW7Wry8Kr4fWr4DWFW3XFWkJFb_yoWkKFg_Z3
	s3ZryDWFyDWF95tFsxGr1rZrWrKay0vFn5ZF10qrZYyw18ArySgFWqgF1DJr1UWrW8CF9I
	qw1DWryxur4jqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRmD733UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8Aml32rSMSmrNwAA3-

IRQ chip probing invokes validation and probe callbacks after the common
table walker has only established that a generic subtable header is
readable. A malformed length can leave callback field accesses outside
the MADT.

Validate the generic header length and ensure the complete declared
entry is contained in the table before invoking IRQ chip callbacks.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/acpi/scan.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 163a3cccf197..ef8e8441b6ef 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -2889,6 +2889,13 @@ static DEFINE_MUTEX(acpi_probe_mutex);
 static int __init acpi_match_madt(union acpi_subtable_headers *header,
 				  const unsigned long end)
 {
+	unsigned long start = (unsigned long)header;
+
+	if (start >= end || end - start < sizeof(header->common) ||
+	    header->common.length < sizeof(header->common) ||
+	    header->common.length > end - start)
+		return -EINVAL;
+
 	if (!ape->subtable_valid || ape->subtable_valid(&header->common, ape))
 		if (!ape->probe_subtbl(header, end))
 			acpi_probe_count++;
-- 
2.34.1


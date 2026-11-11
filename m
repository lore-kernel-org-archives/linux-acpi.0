Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.216
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398260;
	b=p92rKAq8TucuqOoynvdIZxsC9GWyYuIEaw561MQFlN0IZZawyIrODhArJ0lkO3bijcx2
	 4yH+c0Ef6WFJlk2tGUxaIsUVZWfJW2deXQmyBrz6aHRRcuDgTWFRhlcMSjIhRWQ2ROkQf
	 qNfr7n6XZ6Sec2+ROfgCbaK2QVYhz+rNU4l1xhx+wi1WBsA2hGecTY6PowHiIDddZw3KT
	 ZoZY8sHVA1w9DmwWavR+b5sFFYVROWepBxeZb3hQsMMYPB9IWP6NbxfAC9vVXeGuHnHPD
	 pOn64s5VUZXSTCKZcsxHKI09IzGL0ZMHYEu+aXp8aWKzwz0Q8z66wesDP4hU9+wDByA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398260;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=+ix7ZxXwwyqmcU7u9cOhuAPx4chAnMzU/ydV2LHbUqQ=;
	b=4UDZFd+cX/mOiPAAhlyFHVlKNZVwt/8CcKSjbwUSRw2JlanQX0eSWs4LucXuWFc7+fo9
	 UzIUtZJxsm6Go6PWVfY+32XpTn1QGod6qoLOwn7GPJ04rK58J0JuSKmYK3ckztRNoBAzg
	 siLByaBA0SoDqs0QIJuMZXkmUgzV0HgtuUYqgjUFj5ZAmTVZLMjuz5sgEBsfPPTX6i61U
	 dG+XlUr4QxUm4LIoRiTPQ9wB6labMm5mLPBrxv+WYEJwGQ5SLs9WqDqNutvbq9VNNGzSC
	 B8DF67SiwyCk0zkpfkeeNDpWCRkAeeQV3ErTqmoyAzOrHnXERnlwRzKBYt5hQkOlS4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=20zr1sEy;
	arc=none smtp.remote-ip=113.46.200.216
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F79606A324;
	Wed, 11 Nov 2026 11:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 01F79606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=20zr1sEy
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+ix7ZxXwwyqmcU7u9cOhuAPx4chAnMzU/ydV2LHbUqQ=;
	b=20zr1sEyMPdc4qs5Tpvtkv9CImjZ5JfKwuZ8vyIwFbUPMaA0Xi1E4HAahDgw18AVzZ2g4LZIU
	uZCqNvh8GjttmBzKMJtrkOBJ7Ulq3ymn+EwrD4wgzIhcZcxGXgHgwpbPn0iksXsowYrsjjLyn74
	6C3Ebpqfmgvoao0Ixv1yyxw=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4jPhp76H2Yz1T4HZ;
	Wed, 11 Nov 2026 19:57:03 +0800 (CST)
Received: from whupemo200006.china.huawei.com (unknown [7.152.185.252])
	by mail.maildlp.com (Postfix) with ESMTPS id B505A40579;
	Wed, 11 Nov 2026 19:57:33 +0800 (CST)
Received: from DESKTOP-8RFUVS3.china.huawei.com (10.174.178.219) by
 whupemo200006.china.huawei.com (7.152.185.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 11 Nov 2026 19:57:32 +0800
From: Zenghui Yu <yuzenghui@huawei.com>
To: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <rafael@kernel.org>, <tony.luck@intel.com>, <bp@alien8.de>,
	<guohanjun@huawei.com>, <mchehab@kernel.org>, <xueshuai@linux.alibaba.com>,
	<lenb@kernel.org>, <wangzhigang17@huawei.com>, Zenghui Yu
	<yuzenghui@huawei.com>
Subject: [PATCH] ACPI: APEI: EINJ: Validate length of the Vendor Error Type Extension structure
Date: Wed, 11 Nov 2026 19:57:29 +0800
Message-ID: <20261111115729.253-1-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 whupemo200006.china.huawei.com (7.152.185.252)

Add a sanity check for the length field of the Vendor Error Type Extension
structure to guard against a buggy BIOS, in the same way einjv2_init()
checks the EINJv2 Extension length.

The BIOS on my machine provides a zeroed structure, so the length is 0 and
vendor_size in get_oem_vendor_struct() underflows to a huge value. The
vendor error data is then exposed to user sapce through the "oem_error"
debugfs file with that bogus size, and reading it walks out of the mapped
area and panics the kernel.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---

The BIOS on my machine is obviously buggy (non-zero Vendor Extension offset
pointing to zeroed memory, and bit 31 is not set in the error type either)
and needs fixing. I'm not sure if it is necessary to add such a sanity
check for EINJ at all.

The PAGE_SIZE upper bound is borrowed from the EINJv2 check in
einjv2_init(). Not sure if it is reasonable here.

 drivers/acpi/apei/einj-core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 1f3fa2278584..947f32812cfe 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -275,6 +275,12 @@ static void check_vendor_extension(u64 paddr,
 	if (!p)
 		return;
 	memcpy_fromio(&v, p, sizeof(v));
+	if (v.length < sizeof(v) || v.length > PAGE_SIZE) {
+		pr_warn(FW_BUG "Invalid vendor error extension length %u\n",
+			v.length);
+		acpi_os_unmap_iomem(p, sizeof(v));
+		return;
+	}
 	get_oem_vendor_struct(paddr, offset, &v);
 	sbdf = v.pcie_sbdf;
 	sprintf(vendor_dev, "%x:%x:%x.%x vendor_id=%x device_id=%x rev_id=%x\n",
-- 
2.33.0


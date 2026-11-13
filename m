Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=52.12.53.23
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794566565;
	b=ZD5tsL2bK8vhGS4K6u+Og/Zo9rM15j7QVXBQyCclBo4Urzr+MdfPnPOosrKURqoameZT
	 ygBXzmXYUkW6HnG50t7axMsBCcpDry1sUA5yN3IQ3fEVqp9IuPbMZEZf3zzvY49zxSomC
	 zyBz0VTgs1tq3hNTtVo1ilVmdqYi/W90EOF40ZvPiDOZDvO3SL5o3pHGewzdcovnbnjbW
	 g2chnpO17trEmoeNSLvFo1qu2X34GCW+3TNehy0rN6i7FBcMrMpB76ecLQAh5Qeb+9e7v
	 pJ4AqWXC2CYSt8KrXvSCmUsDMo7fAFWk/Zp5VWrxnn2bHYNqvrsXgADLBFcpYvgjmqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794566565;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=JpfG/3aBXx1rKxk956ChNxo8T4iBYqWt9/juBC5bREs=;
	b=1ItpP1LtzrtqPoikddzriA54+uGIJLUKXZk87uXebHIAUpcZasquBt31hMUk3e6tEtPn
	 6kb/uMutbP1xVyBQS8LacXLe+u4fhGLY0AKyNWx2lAWzqJP5KkKd50jpP+SEunjQkuIKc
	 MSf1cSOwhftKVp0kE1bdE8eXZDzqmi/LGlNxTCzOxVUXDGhNrytQZ8ccQvUImoE1XGfFQ
	 jqZq3jveaITc1tbgcC4BINh57yOSl317C90FkcpmsXh+u0RU75B/G2ZBmbcDAMrR1Ijuu
	 XptZAySQyLUzmVo3FsqpyhWeKnENIKhRsgwkj4CCi2G7CwASDWULmOLtJNpsAbe49Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.com;
	spf=pass smtp.mailfrom=amazon.com;
	dkim=pass header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=EfjIOPoh;
	arc=none smtp.remote-ip=52.12.53.23
Received: from pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com [52.12.53.23])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A515F606A886;
	Fri, 13 Nov 2026 10:42:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A515F606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.a=rsa-sha256 header.s=amazoncorp2 header.b=EfjIOPoh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1794566564; x=1826102564;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JpfG/3aBXx1rKxk956ChNxo8T4iBYqWt9/juBC5bREs=;
  b=EfjIOPohZFKmvaHGRNugBlJde7yVCKNxQEV5cslM5J9LdDnUizpoExfI
   oy0k1dgh9cjE5I0/25Stmcf1dfwk/fCvg91vH7z+m1milZaqrAgT7Sal6
   Bm5YYkotVkKV1wcDTfXIA/X6F+uOpnZiPKQLNgldkCNfus5T7+IEH2h4y
   6HHsBm4JKi9mmBOjoyR5jUiCIoSK5MnwUPjGp1DYTR1yorMCrB2cYYa4A
   FY/IAiJVAX+NCMxldwDvUSg0PX3T+aKS06cf5IwnPvnAmHAMdA3yGCsG7
   3BOlx3mnp7xq3cPk0QHuRhv43naEtnspBG1dg5kO9XPf0Jowd6iYoTXLH
   g==;
X-CSE-ConnectionGUID: ZIoiaqvDSJSt9TXTWLMcGA==
X-CSE-MsgGUID: iPbRX6dFRnuCsoQjB10NKA==
X-IronPort-AV: E=Sophos;i="6.27,211,1787011200"; 
   d="scan'208";a="33745501"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-010.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2026 10:42:44 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.53:27579]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.142:2525] with esmtp (Farcaster)
 id 093b2b8f-8379-4905-919d-e95002cffb8f; Fri, 13 Nov 2026 10:42:44 +0000 (UTC)
X-Farcaster-Flow-ID: 093b2b8f-8379-4905-919d-e95002cffb8f
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56;
 Fri, 13 Nov 2026 10:42:43 +0000
Received: from dev-dsk-farbere-1a-46ecabed.eu-west-1.amazon.com
 (172.19.116.181) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.56; Fri, 13 Nov 2026
 10:42:40 +0000
From: Eliav Farber <farbere@amazon.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov
	<dmitry.torokhov@gmail.com>, Laurent Pinchart
	<laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, Armin Wolf
	<W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>
CC: Eliav Farber <farbere@amazon.com>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>, Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, "Mauro
 Carvalho Chehab" <mchehab@kernel.org>, Shuai Xue
	<xueshuai@linux.alibaba.com>, Len Brown <lenb@kernel.org>, Dave Jiang
	<dave.jiang@intel.com>, "Fabio M. De Francesco"
	<fabio.m.de.francesco@linux.intel.com>, Breno Leitao <leitao@debian.org>,
	Terry Bowman <terry.bowman@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Andy Shevchenko <andy@kernel.org>, Kai-Heng
 Feng <kaihengf@nvidia.com>
Subject: [PATCH v6 4/7] ACPI: APEI: GHES: use devm_blocking_notifier_chain_register()
Date: Fri, 13 Nov 2026 10:42:06 +0000
Message-ID: <20261113104218.32566-5-farbere@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113104218.32566-1-farbere@amazon.com>
References: <20261113104218.32566-1-farbere@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

Replace the blocking_notifier_chain_register() +
devm_add_action_or_reset() pattern with a single call to
devm_blocking_notifier_chain_register(), removing the
ghes_vendor_record_notifier_destroy() callback.

Signed-off-by: Eliav Farber <farbere@amazon.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
Changes in v6:
- Rebased onto v7.4-rc1. No functional change since v4.
- Jonathan Cameron's Reviewed-by retained; the code is unchanged since
  v4, when it was given.

Changes in v4:
- Split removal of unused code into a separate preceding patch
  (Andy Shevchenko)

 drivers/acpi/apei/ghes.c | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index a81ffacb16d0..92184ced12b8 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -679,23 +679,12 @@ static void ghes_handle_aer(struct acpi_hest_generic_data *gdata)
 
 static BLOCKING_NOTIFIER_HEAD(vendor_record_notify_list);
 
-static void ghes_vendor_record_notifier_destroy(void *data)
-{
-	struct notifier_block *nb = data;
-
-	blocking_notifier_chain_unregister(&vendor_record_notify_list, nb);
-}
-
 int devm_ghes_register_vendor_record_notifier(struct device *dev,
 					      struct notifier_block *nb)
 {
-	int ret;
-
-	ret = blocking_notifier_chain_register(&vendor_record_notify_list, nb);
-	if (ret)
-		return ret;
-
-	return devm_add_action_or_reset(dev, ghes_vendor_record_notifier_destroy, nb);
+	return devm_blocking_notifier_chain_register(dev,
+						     &vendor_record_notify_list,
+						     nb);
 }
 EXPORT_SYMBOL_GPL(devm_ghes_register_vendor_record_notifier);
 
-- 
2.47.3


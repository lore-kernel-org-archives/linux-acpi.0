Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.223
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793847898;
	b=P2ZHbltW5OT4kStliH1ogOQZUUHpA+2ys4k6UVQ5cRhuQyB9hw+KlVPG0nF7BhWrH/Fs
	 c7+3OZvUSMU+2+BDj3JfEKO5VRJcmP0QB5Wv2ZwGr8uUI6fGdd8E7sv3GXiLOCK4X26Cx
	 VO9HfvBUyZOd93GNo4pwfFy59wdUbe4U/75LNqCH7h/aqU59/v0c4D0NFlWqW8yGLgJ1Q
	 qyMeQVGfrCe9yqRKZK+HiihuVfCsxeTJzqFYXBUrE+KnxjtlPSO6+Mp5aPm+8xeSmmufA
	 Vug/O+x5g/v3S3WZAsCEsxfX6a993Km1e73Ax/qiUBe+H718wGqVCkRxZ2XKBw/KTlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793847898;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=0TcPf4DJz9oCjCryBdJAxQ8ySyJ27lYq/N7TwYPrzG0=;
	b=Oesn+KuFWQtRgcwEgJl9Ep4AsFbu+vMapuibehDGWchSrKb1a4AfNWXFzQXMwyDdGOl8
	 cXu6CxfttIgvpmqYVQbWtBjTV4xzHMU4WwptcSEB8+lMfUDGADkuEshBjFAje1uHmRIL3
	 GH6x4BMX1sdSRPn5VMXzI/QSSYaPyhhCWIvuHuQcQr5wWRx3InKS87I4wa1SFxreZV//5
	 395psREFSh2CfObwYQV2TP+6cIpp6ZoQqHM9fHTJeuCOYVkTdvdVwv2kyKWOUpHxsRA/V
	 Q/AXO3Q+auosDY8lG/hbTf1h1dEtYnMUrsvGQS/zDCqjS2bq5oH6sS0fUDSDYyhtO+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=r6mBL1rd;
	arc=none smtp.remote-ip=113.46.200.223
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39193606A328;
	Thu,  5 Nov 2026 03:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 39193606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=r6mBL1rd
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0TcPf4DJz9oCjCryBdJAxQ8ySyJ27lYq/N7TwYPrzG0=;
	b=r6mBL1rdSQv+jEsyjdtrI4VFJPJcWl6VlNZE1OItyv7IKiNXHX8URVkyX19R6QR2yz4NaVRBl
	8ZMoJAKepCtqULwXR+KW6VpLbzvSFdB2qj56wkzqAZQWIGi33Ku36R5qB8tc31VwcZtZcKV6PQv
	DMSO6kkTE3YNpnc/oa3kweg=
Received: from mail.maildlp.com (unknown [172.19.163.163])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4jKnGc67PSzmVBV;
	Thu,  5 Nov 2026 11:04:40 +0800 (CST)
Received: from kwepemo100017.china.huawei.com (unknown [7.202.195.215])
	by mail.maildlp.com (Postfix) with ESMTPS id 10BC64048B;
	Thu,  5 Nov 2026 11:04:52 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemo100017.china.huawei.com (7.202.195.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 5 Nov 2026 11:04:51 +0800
From: Bowen Yu <yubowen8@huawei.com>
To: <linuxarm@huawei.com>, <rafael@kernel.org>, <linux-acpi@vger.kernel.org>
CC: <lenb@kernel.org>, <linux-kernel@vger.kernel.org>,
	<zhanjie9@hisilicon.com>, <prime.zeng@hisilicon.com>,
	<wanghuiqiang@huawei.com>, <xuwei5@huawei.com>, <yubowen8@huawei.com>,
	<ouyiyong1@huawei.com>, <dengtao44@huawei.com>, <tangbin55@huawei.com>,
	<mojunjun4@huawei.com>, <wuzhanlong@h-partners.com>
Subject: [PATCH] ACPI: platform: Assign names to MEM resources from _DSD "reg-names"
Date: Thu, 5 Nov 2026 11:04:50 +0800
Message-ID: <20261105030450.1946871-1-yubowen8@huawei.com>
X-Mailer: git-send-email 2.33.0
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
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemo100017.china.huawei.com (7.202.195.215)

ACPI _CRS resources carry no names, so platform_get_resource_byname()
always fails for ACPI-created platform devices -- it skips any resource
whose name is NULL. This prevents drivers shared between Device Tree
and ACPI (via PRP0001) from using byname resource lookup.

Add a new helper, acpi_platform_set_resource_names(), that reads the
"reg-names" string array from _DSD and assigns names to MEM resources
in the order they appear in _CRS. This mirrors the Device Tree
"reg-names" property semantics. This property is optional, if absent
the behavior will be unchanged.

Tested on arm64 by injecting an SSDT through the initrd table upgrade
mechanism that describes a PRP0001 test device with three MMIO
resources and a matching "reg-names" package: a test driver using
platform_get_resource_byname() resolved all three regions, and
/proc/iomem shows the assigned names:

  f0000000-f0000fff : reg0
  f0001000-f0001fff : reg1
  f0002000-f0002fff : reg2

Signed-off-by: Bowen Yu <yubowen8@huawei.com>
---
 drivers/acpi/acpi_platform.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/acpi/acpi_platform.c b/drivers/acpi/acpi_platform.c
index 80ea7121744d..61f04eacc2f0 100644
--- a/drivers/acpi/acpi_platform.c
+++ b/drivers/acpi/acpi_platform.c
@@ -108,6 +108,39 @@ static unsigned int acpi_platform_adjust_resources(struct acpi_device *adev,
 	return count;
 }
 
+static void acpi_platform_set_resource_names(struct acpi_device *adev,
+					     struct resource *resources,
+					     int count)
+{
+	const char **names;
+	int mem_count = 0, mem_idx = 0;
+	int i, num;
+
+	/* reg-names is optional; skip entirely if not present in _DSD */
+	if (!fwnode_property_present(acpi_fwnode_handle(adev), "reg-names"))
+		return;
+
+	for (i = 0; i < count; i++)
+		if (resource_type(&resources[i]) == IORESOURCE_MEM)
+			mem_count++;
+	if (mem_count == 0)
+		return;
+
+	names = kcalloc(mem_count, sizeof(*names), GFP_KERNEL);
+	if (!names)
+		return;
+
+	num = fwnode_property_read_string_array(acpi_fwnode_handle(adev),
+						"reg-names", names, mem_count);
+	if (num == mem_count) {
+		for (i = 0; i < count; i++) {
+			if (resource_type(&resources[i]) == IORESOURCE_MEM)
+				resources[i].name = names[mem_idx++];
+		}
+	}
+	kfree(names);
+}
+
 static void acpi_platform_fill_resource(struct device *parent,
 					const struct resource *src,
 					struct resource *dest)
@@ -194,6 +227,10 @@ struct platform_device *acpi_create_platform_device(struct acpi_device *adev,
 				acpi_platform_fill_resource(parent, rentry->res,
 							    &resources[count++]);
 			}
+
+			acpi_platform_set_resource_names(adev, resources,
+							 count);
+
 			acpi_dev_free_resource_list(&resource_list);
 		}
 	}
-- 
2.33.0


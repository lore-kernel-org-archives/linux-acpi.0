Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794300387;
	b=rVbuB2Lf8dDcNIwwnQuc4IagY4VNZYuDJ/IE5jqr3bhhd5g2K7x9IzDOeyRHADN/Ylc1
	 XzBO7PqNkiFB40zTvJH8LBuKvWaanrtt2zgiPmQOJaiMlTwPZYB6De4H6mRzOsaYlTzHU
	 2dVS1ihUJRBa0ERO4NrPHCs1E+lOIgqELGaMQwzJlvn2uX2PHaycr1w9bDJef3YuZ2zur
	 S+94kc8jsaoGEnSZnUT0G4dv3BMVdrXZ4KEO5WUcbUoGT1WZFuhpHDiMhJR8kh0lUcjyy
	 HgUxJrO3hLZMfSGjK+QVSrvZd4fbnz9hJt7ptIwFF+LHsXm/ryak1rIxAtbyQEA4Lvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794300387;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-CM-TRANSID:
	 X-CM-SenderInfo:X-Coremail-Antispam;
	bh=+GhJ9fs5NbjgmK1djHLrHpGVl3Bo/x6xoGUKT1hzhQM=;
	b=r2JrMMdi1Rvjmg15TD1w5owZGfz5SdesJg2ZZpP1/VZXOgQKMn8FBJRMAzF/lPSMtz1o
	 wIwA3Zz/lRToHV6/5DSZMQnuN8eqJM9hNLMItzR+6RHE8Prf1QNi/22P9n//s3UQRVmf3
	 59UqmxAhTVfxynv60kjd81SSepu2dH3ZjVZydXsiXN1XhAw6o0NioA/7+rovXrqWbJWlR
	 2/0g4Tb9YkFnEGGL96rEoWZVm9Ybwq+2sryispNWFNitgM4HM4z/+BlGprOzWAJB2mlhx
	 qsfYLLjU3Mid1/3pWaJNcF1fE7BcTSAHCqL85WFpd0nFCXg7cZKmWoUdm2I+eH7LzUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6F4606A332;
	Tue, 10 Nov 2026 08:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F6F4606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [10.2.5.213])
	by gateway (Coremail) with SMTP id _____8DxpvDf2fJqcB8eAA--.21567S3;
	Tue, 10 Nov 2026 16:46:23 +0800 (CST)
Received: from localhost.localdomain (unknown [127.0.0.1])
	by front1 (Coremail) with SMTP id qMiowJCxe87e2fJqWXMzAA--.22061S2;
	Tue, 10 Nov 2026 16:46:22 +0800 (CST)
From: Bibo Mao <maobibo@loongson.cn>
To: Huacai Chen <chenhuacai@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
	Pawel Chmielewski <pawel.chmielewski@intel.com>
Cc: Len Brown <lenb@kernel.org>,
	linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	lixianglai@loongson.cn
Subject: [PATCH 0/2] ACPI: LoongArch: Fix IOVT table parsing and add checksum validation
Date: Tue, 10 Nov 2026 16:46:11 +0800
Message-Id: <20261110084613.2746641-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.39.3
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
X-CM-TRANSID:qMiowJCxe87e2fJqWXMzAA--.22061S2
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7
	ZEXasCq-sGcSsGvfJ3UbIjqfuFe4nvWSU5nxnvy29KBjDU0xBIdaVrnUUvcSsGvfC2Kfnx
	nUUI43ZEXa7xR_UUUUUUUUU==

In acpi_iovt_init(), hdr is already a pointer, so passing &hdr is
incorrect. Pass hdr directly instead.

Also add checksum calculation/validation for the IOVT table.

Bibo Mao (2):
  ACPI: LoongArch: Fix incorrect pointer argument in acpi_iovt_init()
  ACPI: LoongArch: Add checksum support with IOVT table

 drivers/acpi/loongarch/iovt.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.39.3


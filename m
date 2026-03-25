Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012058.outbound.protection.outlook.com [52.101.43.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65ED01E492D;
	Wed, 25 Mar 2026 16:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774454544; cv=fail; b=Eb9Qh9KKqqJAndj8i2m+eGzsRxfTt6Mn6rwSgKYezvlClvdWjVSRNDGVV7JYuU8UfHPYPA93knAGTad4I4jZ1w1GXkvnedWCc3FmGdrnZZBfPisLn6QbK0/xTaO+rjXN1xZ1ZidiaJ8tMiYm5pvR0tulXsxL78Rg3pF7+qbiIdM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774454544; c=relaxed/simple;
	bh=Bmfo8Xmv8ionqBZ5guintRXzIXzIMmUQsHUxa8QiRfU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qfAQaEGhyO69+tmJFh9GBMg8m2yXZDhYw47ObRgbdzR3qkvvqRl6mnafOHh8+IZVeURaC7+zAGycoZ++MJ3qRqMSGmHTmdeUSP/Yh67tcuUkQ/pzs6a+ewilNlA014Gef3PpbRInYHTvda9TPMy6wAUxCK3GrZBwBPIOfS2a4iw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vevJM1wd; arc=fail smtp.client-ip=52.101.43.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vevJM1wd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBh7p3ZRtyOugeA6zQovXmKz906JT8I2PZDj0Ch8Jk+9UaeVzCvRTimQJZk1gVlFvi0KxX4BvtIobS9wqXZ0W8rPbhp4HE8iuufNdeQmkQXpACv2kitHB4m7MgB2MKSEhzJTn1Qo56QrVSK7H2mOy1gbdHThuHwWjAOaA8GWQlbsqecgrEF84BvU5Yi4EfYUj12jQSonYUjcv3mDM3jPaHr5eGM9uVM2xY0b2GRcOVbTufnfp2Wajc4xIaire0NtWPsZjWRdAjoBLMRi3oFYYUCcjUNQi6qxyNP6jR0kspKbC4sPTNvvHFSclhxqkoyUlsuASv8hDzB7S2ixknttNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=boCgFGNbzmgbKRhXpiEMhKFT6Zba6k9xk7DOMXTP5iU=;
 b=xysT5pIj81QlOXm0rJor3MSAUnDDzk6loEqf3kp4bbElbJs2ah/Ly0rEKGcsfOwd8OkTtUlRTqZVTzg4ApS9JeZTzFi48Rka7xdGpEzIVT9Y0Gdvs3fOpA8DIUP6QyYhSguyJSmriQGEEsMdxz94GVHpd2kjtYfjgd4Ym4NegC98soS6nZlKgPNctCyL0GnCz8P7HyDmXKWuvzwqYDsYPJnb9R+1iNE8okGtgtAgLB44kGBoGtWdoAESfle/q3oTt6638A07EynPjV2DxgPUTP6KNCltu2NqWOOiV/ffmzU6STLztTTi+LMyWhFvgKNcqRIy94zlVbAM+RtKAj+WBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=boCgFGNbzmgbKRhXpiEMhKFT6Zba6k9xk7DOMXTP5iU=;
 b=vevJM1wddv8lYvyo8KZ76BqDcPJkeUaWeTF+KzmMEsDaieKlBvlzkRDP4tSHPiyjNaAa/40FMI9BiLTvR44slNVnsb5k+h1zwW7lx9DFT+yyd0V8tty06AUEHZZkcrNzhlpbALnK7f9Ik38UF7cHWUSUvZqeQpogfbKdMD7JStM=
Received: from CH2PR15CA0009.namprd15.prod.outlook.com (2603:10b6:610:51::19)
 by CH3PR12MB9453.namprd12.prod.outlook.com (2603:10b6:610:1c9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 16:02:12 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:51:cafe::3b) by CH2PR15CA0009.outlook.office365.com
 (2603:10b6:610:51::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.33 via Frontend Transport; Wed,
 25 Mar 2026 16:02:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 16:02:10 +0000
Received: from [10.31.195.148] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Mar
 2026 11:02:09 -0500
Message-ID: <78660163-0f51-4989-9bbf-ea60519fb183@amd.com>
Date: Wed, 25 Mar 2026 11:02:08 -0500
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ACPI: APEI: EINJ: make einj_initialized static
To: "Luck, Tony" <tony.luck@intel.com>, Padmashree S S
	<padmashreess2006@gmail.com>, "rafael@kernel.org" <rafael@kernel.org>,
	"Williams, Dan J" <dan.j.williams@intel.com>
CC: "bp@alien8.de" <bp@alien8.de>, "guohanjun@huawei.com"
	<guohanjun@huawei.com>, "mchehab@kernel.org" <mchehab@kernel.org>,
	"xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260325034626.405366-1-padmashreess2006@gmail.com>
 <SJ1PR11MB6083D15B882275321105286EFC49A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: "Cheatham, Benjamin" <benjamin.cheatham@amd.com>
In-Reply-To: <SJ1PR11MB6083D15B882275321105286EFC49A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|CH3PR12MB9453:EE_
X-MS-Office365-Filtering-Correlation-Id: 5104af9a-f33f-4bc5-a8a8-08de8a87df3e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	12GBAbuoohI5I7I1uxeJw/QZvleN7W8p8v3RlEqFdD63EddpLivMTQ2hxbgGQVFrNabgxsgYMhfHljObK7io5/dMgIkZjgHABLjBKagOiE25ooaaGLztwLui6x7U8PbdMT93/ZlmwTUnUVt80deHpl6agN0Jr2Y/vAgHukXGJa4Vy8MldMfvGT+Ft24EMrMgIrZgjIXUBi0PNdeFZrWN7mYdB/bZrH6pAV3QSNOCw9JBvBcBL+z6CZwJ97LGFuLn0bqI0Wt9qSatsakKYEBAd5bLsuI2zlIiv9qpNZAv9eJUwPIozqzhqkJ3K1fSkm+bIlGXuOelhUHLAVmPAnVYptQer4hrA32dnVNcpj7bwXaWBVqmMq5i6LXR1uEoUsjskMCkP6GzBrmGFT/htFtUUb0+dDEr55Q9deZST4W0LI0dW4+OTy24NKFcE7XCzDiHIdNc4DRcu07CLSEsp/141ae1gngXg7sEadpg9rsVd3YPRKSxzUWE1sNd4IHEDanWG6cxxih6CG5s6dzJQtQ8WwNooAtH+vmZih97tV7W32NgyErmZoF56mcHKptKkgLmXbh9iFPX5+jMjlDigWTcmktqJQnSjXXrHT8tJ9wwIkexQo4A3CX7tdqo9IYaA/Bw4+voVLQeaDahauwqbcmK+o85BxVNrDatE4zoUgFk+fb7APxzBjU5dS5sNvbN4sf1f0xsWD6GGT/ruS/Wno0WkZ1IVZebchxqet1WKpqJzhtMfRCUqEki94z008yeBCyJPkkEsLx+Wtk1XQA0RrBF9g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	r3up/jZ2s5GeuoSQi/opjt0xYDTSOrjtlMF8Lrf2zn0FvKJruJ96QgbOGVdGyw8FWVhRRk8+wSVASAybpJQgkdtexaOoHSuicXWYPWyitH+EfYUMd+1Amo192o/DMoPmmPELVYVb33HVJYEkD9u51un3Qd5skObYXC1bdnfZdyfxDHpHytcutv6fPPjbdW/QrcWsWUGP/Bl6wfgFaSMd5ADo+zJ8EkX7Yp1h5lfd+dJw7HacX6Qmqa/cgnRRIs9Fkk5tlah4X7IHsZ+tZUU3QeWDUljAONqjTQq2hUZeraM2NlLiogbsyr2p9nM9b8nWfWsm38NpWk84kSraaqpeyoMb994bFSioeOA7JUcUpi4bgbL4Hu3Xfbk5DOAlsrMaox11dA8/HHiSi5WMDuvXo6zit6kivnVdgXnIps3KBVH40Y599TLoMsDtXAa1RrEG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 16:02:10.3296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5104af9a-f33f-4bc5-a8a8-08de8a87df3e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9453

On 3/25/2026 10:41 AM, Luck, Tony wrote:
>> Sparse reports a warning for einj_initialized being a global symbol
>> that is not declared static. The variable is only used within
>> einj-core.c, so mark it static to limit its scope and resolve the warning.
> 
> "git grep" is your friend:
> 
> $ git grep einj_initialized
> drivers/acpi/apei/einj-core.c:bool einj_initialized __ro_after_init;
> drivers/acpi/apei/einj-core.c:          einj_initialized = true;
> drivers/acpi/apei/einj-cxl.c:extern bool einj_initialized;
> drivers/acpi/apei/einj-cxl.c:   return einj_initialized;
> 
> Ben, Dan: Is there some header file that could carry the declaration of einj_initialized
> instead of the "extern" in drivers/acpi/apei/einj-cxl.c

It *could* go into include/cxl/einj.h, but it's not really a cxl-specific symbol. If you (and Dan) are
fine with muddying the waters on the cxl/einj divide, I think the patch below would work. I added a comment
to hopefully avoid confusion in the future, but I'm not attached to it. I haven't built or tested it,
so YMMV:

Subject: [PATCH] ACPI: APEI: EINJ: Move einj_cxl_is_initialized() to einj-core

Move einj_cxl_is_initialized() to einj-core.c to fix a sparse warning
about einj_initialized being a non-static global symbol.

Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>
---
 drivers/acpi/apei/einj-core.c | 8 ++++++++
 drivers/acpi/apei/einj-cxl.c  | 9 ---------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/acpi/apei/einj-core.c b/drivers/acpi/apei/einj-core.c
index 305c240a303f..6ec4fb3632ad 100644
--- a/drivers/acpi/apei/einj-core.c
+++ b/drivers/acpi/apei/einj-core.c
@@ -23,6 +23,7 @@
 #include <linux/mm.h>
 #include <linux/device/faux.h>
 #include <linux/unaligned.h>
+#include <cxl/einj.h>
 
 #include "apei-internal.h"
 
@@ -1173,6 +1174,13 @@ static struct faux_device_ops einj_device_ops = {
 	.remove = einj_remove,
 };
 
+/* Used by CXL core to publish CXL-specific EINJ interface in CXL debugfs */
+bool einj_cxl_is_initialized(void)
+{
+	return einj_initialized;
+}
+EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, "CXL");
+
 static int __init einj_init(void)
 {
 	if (acpi_disabled) {
diff --git a/drivers/acpi/apei/einj-cxl.c b/drivers/acpi/apei/einj-cxl.c
index e70a416ec925..a3070988f2b4 100644
--- a/drivers/acpi/apei/einj-cxl.c
+++ b/drivers/acpi/apei/einj-cxl.c
@@ -13,9 +13,6 @@
 
 #include "apei-internal.h"
 
-/* Defined in einj-core.c */
-extern bool einj_initialized;
-
 static struct { u32 mask; const char *str; } const einj_cxl_error_type_string[] = {
 	{ ACPI_EINJ_CXL_CACHE_CORRECTABLE, "CXL.cache Protocol Correctable" },
 	{ ACPI_EINJ_CXL_CACHE_UNCORRECTABLE, "CXL.cache Protocol Uncorrectable non-fatal" },
@@ -105,9 +102,3 @@ int einj_cxl_inject_error(struct pci_dev *dport, u64 type)
 	return einj_error_inject(type, 0x4, 0, 0, 0, param4);
 }
 EXPORT_SYMBOL_NS_GPL(einj_cxl_inject_error, "CXL");
-
-bool einj_cxl_is_initialized(void)
-{
-	return einj_initialized;
-}
-EXPORT_SYMBOL_NS_GPL(einj_cxl_is_initialized, "CXL");
-- 
2.52.0

base-commit: 63fbf275fa9f18f7020fb8acf54fa107e51d0f23 (cxl-next in cxl.git)

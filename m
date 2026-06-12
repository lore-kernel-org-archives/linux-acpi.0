Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058B03C73C9;
	Fri, 12 Jun 2026 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266496; cv=fail; b=lQYW8vfpWyEWG9WIVJeqLttWqSuoYGDiZzY7i2k6ilBTD6Fr4UXYF7z5U5vJKPgyu4sENdHpytglez6mblq5+wkA03GHtMA5FCph6KXYUE1dQY2KXlkOOgBEID6kQh4hbAVoJGyya57ceorB22PC+1t76p5hMOhvxB/vLcbgvnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266496; c=relaxed/simple;
	bh=62/pgBgV8Bsa1fbCEtVSNENg7cUrrL7gRii+hT/bq7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DTxZRPxx2YvnYRaVVT/dw91LY0gC/8s4dM0zXjpMIPeDr0OtLNc7Udz4cdqZoV7xavnYFyw1CjDskQcBe4fohabx4qiDpGUz4wTxZY8b8kiDFjhPBD7D7SVuUZ8cxNFBs7hL29X9FcHe23RS0zVJNgUZQmkpQOQugbfx5PYHO6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZnbCYOt5; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZnbCYOt5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahkarYwlrPFLl5FLX/hoIG8TD89YDb/TGPXrgfJeqHB+Q86UqDpr4URG+gwwjBKupGcFsB6sFsqWnPXzH2OBNt040oudbM37Ad4a/dfYpYgkvvEh8Xv1mgioMaBbC/awWYyYd3ta6mzKToLcEhfxV37SIb/c5qdGuG/SdaOSZSah8vMvlCtk7gU20yxtDyjoo+XkGtbS+lSNrCI0RYlq38l9RMwnNvzJKAhKgsBEWqtLqmJIOutlUbixhfNTIdIZqCp2tS85hH4bj6N04Q4IxYK7qgkJyq+qZLUTXnk46keGqtuuBsTfVFbKgzGfSDOwldl1kgpVLmdLl6Cq5y+Hwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlmgzACLb1WQPGjnfDt8yY7eilPJOYKy+NC+QsvwCVc=;
 b=DdvhlJqY9YLbDf4BWubAUkZyIaxETpNvqHuGS1Ua3Ya0OWkamz8CCNt4lGOiy750LaxDZSebV0ByWaLLYhfxub/QA0d8N7nbU2AMKXVvm9ezTrp78LxpH001HMkn77ZmwvpAWMsPfQxnlwtEw8144NJ+N7hlAzD2Prbc6w97L9Q/KKktgJmsKWMcO1KVARDASySqh5alKH8pwsYYGZSwgNYIfIxV8E8OGjlTTS507WaBgB6NcRJdViD5MMhwf0zU91Z/4C8B8BTeEeZXSrXt95no7wy+kHJgkD39KPhWxKUE1tS/9Efevg+gHPcAMAtsfNbOdbeRs08RNpPAPnXWew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlmgzACLb1WQPGjnfDt8yY7eilPJOYKy+NC+QsvwCVc=;
 b=ZnbCYOt5xBkYYf8r17QJ1CIXdqESnmnoprD9o3Uc0Wo3xk5IVOcaKkwAxtW/LltL6jPJ9bb7kbDamkG3VKFnizEerw88qJkWQiCNMbC1lqYNIGtCGojBJseEZ0GMFRTDUQhvse7YQVFaZ/lYdNOY2IL8MTAMtFS5+sPk++fzrIBofElczsA4qKEih5l7eqbesP/Cyv5LpnYr/WQTEHMlRg2CoUMek1JRMNcSRdVmGxPpjRxUMJWwdcKAAGqJU7Yu8fG8eH8+E1Ncb5bqRDSXCtZCZpabwyhANd9U+iu8+P3frRoLbhlVwnw7wkuEo8xBHZniq1lUC1IqWgdiKv8fMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com (2603:10b6:a03:477::9)
 by MW3PR12MB4459.namprd12.prod.outlook.com (2603:10b6:303:56::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.14; Fri, 12 Jun
 2026 12:14:49 +0000
Received: from SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97]) by SJ0PR12MB6733.namprd12.prod.outlook.com
 ([fe80::f00d:2f6b:6f9b:8f97%6]) with mapi id 15.21.0113.013; Fri, 12 Jun 2026
 12:14:48 +0000
From: Kai-Heng Feng <kaihengf@nvidia.com>
To: rafael@kernel.org,
	shuah@kernel.org,
	kees@kernel.org
Cc: csoto@nvidia.com,
	mochs@nvidia.com,
	Kai-Heng Feng <kaihengf@nvidia.com>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Len Brown <lenb@kernel.org>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/4] ACPI: APEI: GHES: Add NVIDIA Vera decoder
Date: Fri, 12 Jun 2026 20:09:07 +0800
Message-ID: <20260612120929.28965-3-kaihengf@nvidia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260612120929.28965-1-kaihengf@nvidia.com>
References: <20260612120929.28965-1-kaihengf@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TP0P295CA0002.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:2::15) To SJ0PR12MB6733.namprd12.prod.outlook.com
 (2603:10b6:a03:477::9)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB6733:EE_|MW3PR12MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: c6263b1d-69e9-499e-39e4-08dec87c3278
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	OWp1rExCHRJzxUuIrqqxHJ3RL4Oo+yG3hDBWa6PwAdeRG5FB/cG0krPWBUjZ/6iIO4AsFkxR6XoXoLUG4ewqjGHIyTFPaByjZvx+dh/h29lDBEN3SGWZcYybnPL36jloI+cw1aYTBNTgaRNkuTg+tSFkRsC3OdL+j6tUPIi3QgwnJ7RJxbbg35rgllZ3Hvo22jNN8QujUffQVzD32ustCMTIBcbPi5swWeAx/K/LxLT3ZCu8VqmaIDAukrVbDHMKM7ija+L+l3f0rbUsdy6np2k7BhsRMuChhm7U2nWVnSjqpnR5c7uPx3Z0lDWtosjOIG+Yx7+9wKfGhtDQoMlQmFAk9Q18WaJ2YbuFOSJUPUR5D/ArgZ/121Wfyuj6K27ul6DfhPTBMrOfxsiaUYeIeQc9koPTgNXZSq8D0R9Luu50Wd9KO1krRq+SKfX6Obpln3QjiTwiBc5mHd3IPr3S2LqxQ23Ri6D3ioBv1e/Ml5SGgYIrNEYPg1CpLWlM23yKgfi4F4TitafQpmw+smcnEZ3apkatwAZ9ZZti40gpzezXOZ2D6Rex0me38LMLO6vnE0pw8OFvbSeWI1jCHRcaTjoOr1zz0wCr1JdiL8vAPi3I8F7i9zZV9GqaHQve3zggsG33kiFcRSaF5nydzWZb6x8qNEOjGOUB+riUCuFCNZMt2vODQ8AwlUvD0j81+T/g
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR12MB6733.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6V9Uv5bEiz0wEIyQPTR8VFTi5kLOeB3m612XJhvIHY30nQtMtpvbX8W1Leob?=
 =?us-ascii?Q?tzF0zu8e4TpWJZjjtL3Iyxp0JO7eZI86j1qinS/V2FbF29RbwTJ7C0rrwIUi?=
 =?us-ascii?Q?wtVxiLwG+HovdKhd3sY4rKK8F5C5VHC7oKGVUUvwXqdtB7bFmguJxsbwDxRl?=
 =?us-ascii?Q?ilDm8hfBhkbc2HzgTcKhH56HYwpJIoUbdAReH04fWb55BDrm3qeS4WLSLVTs?=
 =?us-ascii?Q?AQqR1UG+84vaPYFELk2vI0fvSN9xePBKaHq6Lcn2ostSVXrWL7Y0kvH+X4NT?=
 =?us-ascii?Q?NTJ0ZHeLir6swe8z+3gLe0zUYhncX/fdygX5JTU3N+jkbZ77eyPmdRiJFgT0?=
 =?us-ascii?Q?8CafO8JW/8Fep4Lcvqhi+1+VlO4qHc6H9qrYfIqx/RPfC51iIA0ZrJ7l7A09?=
 =?us-ascii?Q?w0ZKxdsySUlme00/L7Ry2L4Eeaoc0JWcHwBvJRi+fk3iQpzOtT3qdeJI+xar?=
 =?us-ascii?Q?AHdHLXZOipREQcAnYgYVrocEsnYSBfBvag6+2X1q8bbMF+XnLtIe+Szzm3Ed?=
 =?us-ascii?Q?hdUWCUrcmzdiEV1nsag/a7MuL0FOXlkM91yi34Ipqx/cDz/fHawdo+dJHnPG?=
 =?us-ascii?Q?BJ7zEBEgO04ep8OuRrbIb9uMV0f2fbdvdhoEp9npb8xvBV25HgSgcWgKp1GO?=
 =?us-ascii?Q?cDTxNt1Y39S461dqUPhkq+TjwQxWtl+IrPrGfdD3ZDd3+OGrs+pjlHL0VAD6?=
 =?us-ascii?Q?I8s4qHNreNcanj5Z95FrUDxdY9XBlJUnRo8z1IrUZeeNc2U9YbJKMeNZfx7G?=
 =?us-ascii?Q?QylIT3MZFEkYzF5335vJtTOIGrxFaPEbKi8k/R8EpJG7iiYHD/AHdnBDK6IV?=
 =?us-ascii?Q?RHSttomEFCCbFSWVsFzs0g6fw4/lBg19SsgZdUoFj6hFXBynCHGILvqrptHS?=
 =?us-ascii?Q?rnb0nyqhohn632QQnM0x/RyZPSkn59KwgrX69aVLXslIIqDbfnbfAIcTs7SV?=
 =?us-ascii?Q?/MTx2sci7qVx+72lQW2e+oRJZbHTQ4ketCZT8Q6dExxuVtHygfoNzmACI03o?=
 =?us-ascii?Q?RFzI75jHAWYpEdMisc+/klz159mFbSCL58c3+LVhUvYcgwUBfDtjCHFuZ6MM?=
 =?us-ascii?Q?er+3hCJfVOs0KF/B96606TlcW2fhyswA64yVZFq5I/+uyvi8IfMDPDrg7PsM?=
 =?us-ascii?Q?aru+pGGR/1Qv1JzwEtd1BzNcDC/rkO+nV+AGmNVtzN0BjRm8XntzVBywhqGP?=
 =?us-ascii?Q?XyBK30Q+OxQYQo3aeorSlccu2w6BvUtpPuBXMZauzlpLfsNMGOwpVyAB5WH6?=
 =?us-ascii?Q?law/IaRtaZXuTuysj3Yb0otZM9S3ojadvpQdg6xV+vfhINS17nkIzgmDNfqQ?=
 =?us-ascii?Q?feJILCYudUskRVjjueP7cLFdnuKuGoNW5tGhkS0XxGzu0xI+czYnjbMxrVxB?=
 =?us-ascii?Q?YPTokBDicZE7QqmRsoc0zwRm4nrxbLq5W/n+GPYcb3ARt/d3odcixLlsxqWL?=
 =?us-ascii?Q?lgL75U57obr20Br1qG3CoTK8PLygUV6Yc2Mp0q8Uu6poB2kuzyNK8Lj2E+au?=
 =?us-ascii?Q?M7BXMZf7O6kXi5rlRJ89USw8ZEgRU++sPOCl0GUbSTkaWkJRRPqo2LkSugl6?=
 =?us-ascii?Q?EW5AdejJJIIyVgltFxzduDlyxfDg31Y3JwVuFjZLh2uw0QGUa5JpI3Ep48rS?=
 =?us-ascii?Q?ma3ZNfkmuCTVrcOvuj87MsmOVFflQLRMo5/bUE1kJFZmr9e8Zfs2hlqXMK/c?=
 =?us-ascii?Q?1yjpEOIUu8Mu9OpUkOaTvsEKGx8B6fr6bcZnzW5yqIlTJ26mq2ib/rYgiPWY?=
 =?us-ascii?Q?TwD+6uZf4A=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6263b1d-69e9-499e-39e4-08dec87c3278
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB6733.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2026 12:14:48.3265
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xl94NfGdcQ+4n3lj2jU6MXTxPLB29sIo0oGUwQHpj0qxaJQaiYmjJxKfxgsI2HWPXnaxqbU1ICY60GsGWuLYSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4459

Vera is NVIDIA's next-generation server SoC. Its CPER section uses a
different GUID and a different binary layout from Grace, so it needs
its own decoder. Without this, firmware-reported hardware errors on
Vera platforms are received but not decoded.

Signed-off-by: Kai-Heng Feng <kaihengf@nvidia.com>
---
 drivers/acpi/apei/ghes-nvidia.c | 368 ++++++++++++++++++++++++++++++--
 drivers/acpi/apei/ghes-nvidia.h |  29 ++-
 2 files changed, 382 insertions(+), 15 deletions(-)

diff --git a/drivers/acpi/apei/ghes-nvidia.c b/drivers/acpi/apei/ghes-nvidia.c
index af445152def0..c74c155dd2ba 100644
--- a/drivers/acpi/apei/ghes-nvidia.c
+++ b/drivers/acpi/apei/ghes-nvidia.c
@@ -7,18 +7,27 @@

 #include <linux/acpi.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
+#include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/uuid.h>
+#include <kunit/visibility.h>
 #include <acpi/ghes.h>

-#include <kunit/visibility.h>
 #include "ghes-nvidia.h"

+#define NVIDIA_GHES_VERA_VERSION	1
+
 static const guid_t nvidia_grace_sec_guid =
 	GUID_INIT(0x6d5244f2, 0x2712, 0x11ec,
 		  0xbe, 0xa7, 0xcb, 0x3f, 0xdb, 0x95, 0xc7, 0x86);

+static const guid_t nvidia_vera_sec_guid =
+	GUID_INIT(0x9068e568, 0x6ca0, 0x11f0,
+		  0xae, 0xaf, 0x15, 0x93, 0x43, 0x59, 0x1e, 0xac);
+
 struct cper_sec_nvidia {
 	char	signature[16];
 	__le16	error_type;
@@ -31,11 +40,51 @@ struct cper_sec_nvidia {
 	struct nvidia_ghes_grace_reg regs[] __counted_by(number_regs);
 };

+struct cper_sec_nvidia_vera_event {
+	u8	version;
+	u8	event_context_count;
+	u8	source_device_type;
+	u8	reserved;
+	__le16	event_type;
+	__le16	event_sub_type;
+	__le64	event_link_id;
+	char	source_module_signature[16];
+} __packed;
+
+struct cper_sec_nvidia_vera_cpu_info {
+	__le16	info_version;
+	u8	info_size;
+	u8	socket_number;
+	__le32	architecture;
+	u8	chip_serial_number[16];
+	__le64	instance_base;
+} __packed;
+
+struct cper_sec_nvidia_vera_context {
+	__le32	context_size;
+	__le16	context_version;
+	__le16	reserved;
+	__le16	data_format_type;
+	__le16	data_format_version;
+	__le32	data_size;
+} __packed;
+
 struct nvidia_ghes_private {
 	struct notifier_block	nb;
 	struct device		*dev;
 };

+VISIBLE_IF_KUNIT
+enum nvidia_ghes_format nvidia_ghes_format_from_guid(const guid_t *guid)
+{
+	if (guid_equal(guid, &nvidia_grace_sec_guid))
+		return NVIDIA_GHES_FORMAT_GRACE;
+	if (guid_equal(guid, &nvidia_vera_sec_guid))
+		return NVIDIA_GHES_FORMAT_VERA;
+	return NVIDIA_GHES_FORMAT_UNKNOWN;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_format_from_guid);
+
 VISIBLE_IF_KUNIT
 int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
 			     size_t len,
@@ -81,7 +130,7 @@ EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_grace);

 VISIBLE_IF_KUNIT
 int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
-				      unsigned int index, u64 *addr, u64 *val)
+			       unsigned int index, u64 *addr, u64 *val)
 {
 	const struct nvidia_ghes_grace_reg *regs;

@@ -98,6 +147,220 @@ int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
 }
 EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_grace_reg_pair);

+static int nvidia_ghes_vera_validate_context_data(u16 data_format_type,
+						  u32 data_size)
+{
+	switch (data_format_type) {
+	case 0:
+		return 0;
+	case 1:
+		return data_size % 16 ? -EINVAL : 0;
+	case 2:
+	case 3:
+		return data_size % 8 ? -EINVAL : 0;
+	case 4:
+		return data_size % 4 ? -EINVAL : 0;
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_decode_vera(struct device *dev, const void *buf,
+			    size_t len,
+			    struct nvidia_ghes_decoded *decoded)
+{
+	const struct cper_sec_nvidia_vera_event *event = buf;
+	const struct cper_sec_nvidia_vera_cpu_info *cpu_info;
+	const struct cper_sec_nvidia_vera_context *context;
+	const u8 *bytes = buf;
+	size_t data_end_advance;
+	size_t advance;
+	size_t offset;
+	int ret;
+
+	if (!buf || !decoded)
+		return -EINVAL;
+	if (len < sizeof(*event)) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera event header truncated (%zu < %zu)\n",
+					    len, sizeof(*event));
+		return -ENODATA;
+	}
+	if (event->version != NVIDIA_GHES_VERA_VERSION)
+		return -EOPNOTSUPP;
+	if (event->source_device_type != 0)
+		return -EOPNOTSUPP;
+
+	offset = sizeof(*event);
+	if (len - offset < sizeof(*cpu_info)) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera CPU info truncated (%zu < %zu)\n",
+					    len - offset, sizeof(*cpu_info));
+		return -ENODATA;
+	}
+
+	cpu_info = (const void *)(bytes + offset);
+	if (cpu_info->info_size < sizeof(*cpu_info)) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera CPU info size %u smaller than header %zu\n",
+					    cpu_info->info_size, sizeof(*cpu_info));
+		return -EINVAL;
+	}
+	if (len - offset < cpu_info->info_size) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera CPU info extends past section (%u > %zu)\n",
+					    cpu_info->info_size, len - offset);
+		return -ENODATA;
+	}
+
+	offset += cpu_info->info_size;
+	if (event->event_context_count > NVIDIA_GHES_MAX_CONTEXTS) {
+		if (dev)
+			dev_err_ratelimited(dev, "Vera context count %u exceeds maximum %u\n",
+					    event->event_context_count,
+					    NVIDIA_GHES_MAX_CONTEXTS);
+		return -E2BIG;
+	}
+
+	memset(decoded, 0, sizeof(*decoded));
+	decoded->format = NVIDIA_GHES_FORMAT_VERA;
+	memcpy(decoded->signature, event->source_module_signature,
+	       sizeof(event->source_module_signature));
+	decoded->signature[sizeof(event->source_module_signature)] = '\0';
+	decoded->event_context_count = event->event_context_count;
+	decoded->source_device_type = event->source_device_type;
+	decoded->event_type = get_unaligned_le16(&event->event_type);
+	decoded->event_sub_type = get_unaligned_le16(&event->event_sub_type);
+	decoded->event_link_id = get_unaligned_le64(&event->event_link_id);
+	decoded->socket = cpu_info->socket_number;
+	decoded->architecture = get_unaligned_le32(&cpu_info->architecture);
+	memcpy(decoded->chip_serial_number, cpu_info->chip_serial_number,
+	       sizeof(cpu_info->chip_serial_number));
+	decoded->instance_base = get_unaligned_le64(&cpu_info->instance_base);
+
+	for (int i = 0; i < event->event_context_count; i++) {
+		struct nvidia_ghes_vera_context *decoded_context = &decoded->contexts[i];
+		u32 context_size;
+		u32 data_size;
+		u16 data_format_type;
+
+		if (len - offset < sizeof(*context)) {
+			if (dev)
+				dev_err_ratelimited(dev, "Vera context[%d] header truncated (%zu < %zu)\n",
+						    i, len - offset, sizeof(*context));
+			return -ENODATA;
+		}
+
+		context = (const void *)(bytes + offset);
+		context_size = get_unaligned_le32(&context->context_size);
+		data_format_type = get_unaligned_le16(&context->data_format_type);
+		data_size = get_unaligned_le32(&context->data_size);
+
+		if (context_size < sizeof(*context)) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] size %u smaller than header %zu\n",
+						    i, context_size, sizeof(*context));
+			return -EINVAL;
+		}
+		if (data_format_type > 4) {
+			if (dev)
+				dev_dbg(dev,
+					"Vera context[%d] unsupported data format %u\n",
+					i, data_format_type);
+			return -EOPNOTSUPP;
+		}
+		if (check_add_overflow((size_t)data_size, sizeof(*context),
+				       &data_end_advance)) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] data_size %u overflows section accounting\n",
+						    i, data_size);
+			return -EOVERFLOW;
+		}
+
+		if (data_end_advance > len - offset) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] data extends past section (%zu > %zu)\n",
+						    i, data_end_advance, len - offset);
+			return -ENODATA;
+		}
+
+		/*
+		 * Some Vera payloads use only the header size here and
+		 * place the format-specific payload immediately after it.
+		 */
+		if (context_size == sizeof(*context))
+			advance = data_end_advance;
+		else if (data_size <= context_size - sizeof(*context))
+			advance = context_size;
+		else {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] data_size %u exceeds context_size %u\n",
+						    i, data_size, context_size);
+			return -EINVAL;
+		}
+
+		if (advance > len - offset) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] advance %zu extends past section (%zu)\n",
+						    i, advance, len - offset);
+			return -ENODATA;
+		}
+
+		ret = nvidia_ghes_vera_validate_context_data(data_format_type, data_size);
+		if (ret) {
+			if (dev)
+				dev_err_ratelimited(dev,
+						    "Vera context[%d] format %u rejected data_size %u (ret=%d)\n",
+						    i, data_format_type, data_size, ret);
+			return ret;
+		}
+
+		decoded_context->context_size = context_size;
+		decoded_context->context_version =
+			get_unaligned_le16(&context->context_version);
+		decoded_context->data_format_type = data_format_type;
+		decoded_context->data_format_version =
+			get_unaligned_le16(&context->data_format_version);
+		decoded_context->data_size = data_size;
+		decoded_context->data = bytes + offset + sizeof(*context);
+		offset += advance;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_decode_vera);
+
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_entry_count(const struct nvidia_ghes_vera_context *ctx)
+{
+	if (!ctx)
+		return -EINVAL;
+	if (ctx->data_size > INT_MAX)
+		return -EOVERFLOW;
+
+	switch (ctx->data_format_type) {
+	case 0:
+		return 0;
+	case 1:
+		return ctx->data_size / 16;
+	case 2:
+		return ctx->data_size / 8;
+	case 3:
+		return ctx->data_size / 8;
+	case 4:
+		return ctx->data_size / 4;
+	default:
+		return -EINVAL;
+	}
+}
+EXPORT_SYMBOL_IF_KUNIT(nvidia_ghes_vera_context_entry_count);
+
 static void nvidia_ghes_print_grace(struct device *dev,
 				    const struct nvidia_ghes_decoded *decoded,
 				    bool fatal)
@@ -111,7 +374,8 @@ static void nvidia_ghes_print_grace(struct device *dev,
 	dev_printk(level, dev, "severity: %u\n", decoded->severity);
 	dev_printk(level, dev, "socket: %u\n", decoded->socket);
 	dev_printk(level, dev, "number_regs: %u\n", decoded->number_regs);
-	dev_printk(level, dev, "instance_base: 0x%016llx\n", decoded->instance_base);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n",
+		   decoded->instance_base);

 	for (int i = 0; i < decoded->number_regs; i++) {
 		if (nvidia_ghes_grace_reg_pair(decoded, i, &addr, &val))
@@ -121,12 +385,52 @@ static void nvidia_ghes_print_grace(struct device *dev,
 	}
 }

+static void nvidia_ghes_print_vera(struct device *dev,
+				   const struct nvidia_ghes_decoded *decoded,
+				   bool fatal, unsigned long ghes_severity)
+{
+	const char *level = fatal ? KERN_ERR : KERN_INFO;
+
+	dev_printk(level, dev, "signature: %s\n", decoded->signature);
+	dev_printk(level, dev, "event_type: %u\n", decoded->event_type);
+	dev_printk(level, dev, "event_sub_type: %u\n", decoded->event_sub_type);
+	dev_printk(level, dev, "ghes_severity: %lu\n", ghes_severity);
+	dev_printk(level, dev, "event_link_id: 0x%016llx\n",
+		   decoded->event_link_id);
+	dev_printk(level, dev, "socket: %u\n", decoded->socket);
+	dev_printk(level, dev, "architecture: 0x%x\n", decoded->architecture);
+	dev_printk(level, dev, "chip_serial_number: %*phN\n",
+		   (int)sizeof(decoded->chip_serial_number),
+		   decoded->chip_serial_number);
+	dev_printk(level, dev, "instance_base: 0x%016llx\n", decoded->instance_base);
+	dev_printk(level, dev, "event_context_count: %u\n", decoded->event_context_count);
+
+	for (int i = 0; i < decoded->event_context_count; i++) {
+		const struct nvidia_ghes_vera_context *ctx = &decoded->contexts[i];
+		int entries = nvidia_ghes_vera_context_entry_count(ctx);
+
+		dev_printk(level, dev,
+			   "context[%d]: version=%u format=%u format_version=%u context_size=%u data_size=%u\n",
+			   i, ctx->context_version, ctx->data_format_type,
+			   ctx->data_format_version, ctx->context_size, ctx->data_size);
+		if (ctx->data_format_type == 0 && ctx->data_size > 0) {
+			int prefix_len = ctx->data_size > 16 ? 16 : ctx->data_size;
+
+			dev_printk(level, dev, "context[%d]_opaque_prefix: %*phN\n",
+				   i, prefix_len, ctx->data);
+		} else if (entries >= 0) {
+			dev_printk(level, dev, "context[%d]_entries: %d\n", i, entries);
+		}
+	}
+}
+
 static int nvidia_ghes_notify(struct notifier_block *nb,
 			      unsigned long event, void *data)
 {
 	struct acpi_hest_generic_data *gdata = data;
-	struct nvidia_ghes_decoded decoded;
+	struct nvidia_ghes_decoded *decoded;
 	struct nvidia_ghes_private *priv;
+	enum nvidia_ghes_format format;
 	const void *payload;
 	guid_t sec_guid;
 	u32 len;
@@ -134,26 +438,64 @@ static int nvidia_ghes_notify(struct notifier_block *nb,
 	bool fatal;

 	import_guid(&sec_guid, gdata->section_type);
-	if (!guid_equal(&sec_guid, &nvidia_grace_sec_guid))
+	format = nvidia_ghes_format_from_guid(&sec_guid);
+	if (format == NVIDIA_GHES_FORMAT_UNKNOWN)
 		return NOTIFY_DONE;

 	priv = container_of(nb, struct nvidia_ghes_private, nb);
 	len = acpi_hest_get_error_length(gdata);
+
 	payload = acpi_hest_get_payload(gdata);
 	fatal = event >= GHES_SEV_RECOVERABLE;
+	decoded = kzalloc_obj(*decoded);
+	if (!decoded) {
+		dev_err_ratelimited(priv->dev,
+				    "Failed to allocate NVIDIA CPER decode buffer\n");
+		return NOTIFY_OK;
+	}
+
+	switch (format) {
+	case NVIDIA_GHES_FORMAT_GRACE:
+		ret = nvidia_ghes_decode_grace(priv->dev, payload, len, decoded);
+		break;
+	case NVIDIA_GHES_FORMAT_VERA:
+		ret = nvidia_ghes_decode_vera(priv->dev, payload, len, decoded);
+		break;
+	default:
+		ret = -EOPNOTSUPP;
+		break;
+	}

-	ret = nvidia_ghes_decode_grace(priv->dev, payload, len, &decoded);
 	if (ret) {
-		dev_err(priv->dev,
-			"Malformed NVIDIA CPER section, error_data_length: %u, ret: %d\n",
-			len, ret);
-		return NOTIFY_OK;
+		if (ret == -EOPNOTSUPP && format == NVIDIA_GHES_FORMAT_VERA)
+			dev_info(priv->dev,
+				 "Unsupported NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
+				 len, ret);
+		else if (format == NVIDIA_GHES_FORMAT_GRACE)
+			dev_err(priv->dev,
+				"Malformed NVIDIA Grace CPER section, error_data_length: %u, ret: %d\n",
+				len, ret);
+		else
+			dev_err(priv->dev,
+				"Malformed NVIDIA Vera CPER section, error_data_length: %u, ret: %d\n",
+				len, ret);
+		goto out;
 	}

-	dev_printk(fatal ? KERN_ERR : KERN_INFO, priv->dev,
-		   "NVIDIA CPER section, error_data_length: %u\n", len);
-	nvidia_ghes_print_grace(priv->dev, &decoded, fatal);
+	if (format == NVIDIA_GHES_FORMAT_GRACE)
+		dev_printk(fatal ? KERN_ERR : KERN_INFO, priv->dev,
+			   "NVIDIA Grace CPER section, error_data_length: %u\n", len);
+	else
+		dev_printk(fatal ? KERN_ERR : KERN_INFO, priv->dev,
+			   "NVIDIA Vera CPER section, error_data_length: %u\n", len);
+
+	if (format == NVIDIA_GHES_FORMAT_VERA)
+		nvidia_ghes_print_vera(priv->dev, decoded, fatal, event);
+	else
+		nvidia_ghes_print_grace(priv->dev, decoded, fatal);

+out:
+	kfree(decoded);
 	return NOTIFY_OK;
 }

diff --git a/drivers/acpi/apei/ghes-nvidia.h b/drivers/acpi/apei/ghes-nvidia.h
index f0592fa41abf..7fff088e1dc1 100644
--- a/drivers/acpi/apei/ghes-nvidia.h
+++ b/drivers/acpi/apei/ghes-nvidia.h
@@ -3,36 +3,61 @@
 #define GHES_NVIDIA_H

 #include <linux/types.h>
+#include <linux/uuid.h>
 #include <kunit/visibility.h>

-struct device;
-
 enum nvidia_ghes_format {
 	NVIDIA_GHES_FORMAT_UNKNOWN,
 	NVIDIA_GHES_FORMAT_GRACE,
+	NVIDIA_GHES_FORMAT_VERA,
 };

+#define NVIDIA_GHES_MAX_CONTEXTS 16
+
 struct nvidia_ghes_grace_reg {
 	__le64 addr;
 	__le64 val;
 };

+struct nvidia_ghes_vera_context {
+	u32 context_size;
+	u16 context_version;
+	u16 data_format_type;
+	u16 data_format_version;
+	u32 data_size;
+	const u8 *data;
+};
+
 struct nvidia_ghes_decoded {
 	enum nvidia_ghes_format format;
 	char signature[17];
 	u16 error_type;
 	u16 error_instance;
+	u16 event_type;
+	u16 event_sub_type;
 	u8 severity;
 	u8 socket;
 	u8 number_regs;
+	u8 source_device_type;
+	u8 event_context_count;
+	u32 architecture;
+	u64 event_link_id;
 	u64 instance_base;
+	u8 chip_serial_number[16];
 	const struct nvidia_ghes_grace_reg *grace_regs;
+	struct nvidia_ghes_vera_context contexts[NVIDIA_GHES_MAX_CONTEXTS];
 };

+VISIBLE_IF_KUNIT enum nvidia_ghes_format nvidia_ghes_format_from_guid(const guid_t *guid);
 VISIBLE_IF_KUNIT int nvidia_ghes_decode_grace(struct device *dev, const void *buf,
 					      size_t len,
 					      struct nvidia_ghes_decoded *decoded);
 VISIBLE_IF_KUNIT int nvidia_ghes_grace_reg_pair(const struct nvidia_ghes_decoded *decoded,
 						unsigned int index, u64 *addr, u64 *val);
+VISIBLE_IF_KUNIT int nvidia_ghes_decode_vera(struct device *dev, const void *buf,
+					     size_t len,
+					     struct nvidia_ghes_decoded *decoded);
+VISIBLE_IF_KUNIT
+int nvidia_ghes_vera_context_entry_count(const struct nvidia_ghes_vera_context *ctx);

 #endif
-- 
2.50.1 (Apple Git-155)


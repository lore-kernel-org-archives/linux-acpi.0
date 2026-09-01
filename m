Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011017.outbound.protection.outlook.com [40.107.208.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B964A2613;
	Tue,  1 Sep 2026 19:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290998; cv=fail; b=Zcdm9YVv2xfp0N+UXrrCf3ZOMAO6zus1kuvFDJBlOLSF912+02lAZN92ZiITK1Z82wBBl05FU0GehdmSCp01U+cUP7lG/U1LLWHhi1mSfYQ14NrRM/cX8IPt5wpSSRUJo5SJV3OO5Q6XHgNzRUGsPZxHR7U6o4lVYVNscVMLrM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290998; c=relaxed/simple;
	bh=Hxy+yXNQHtg2qfXYZxJ9lXKh+kZLtHpYHhmd75ADPKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HF1op0HEWlj4RzuwGrWql+eyqOl3mLg1uEynvYHlRqdeoRP8+Pm0vbJ7ros3n1eqa97s0HdgPX0lTeFMXNOMM9giTDU+4KDMAGNrBBr45bJPX1BeMdM9f464YlcAQA7EUHhEVIZSQ8edwN4hFQAC96Kq41lq+HVT5FeW/u+UnDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RJKgLQk8; arc=fail smtp.client-ip=40.107.208.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RJKgLQk8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eyVE/YZ6z5UEceHJ4DHT9hLsLUx0gek4sVCVmoRrJJvX5cx9NEJgUJ0O8ab/c0jvbM9jxKmqNP9SG6qhFeFA3EMZvYuZ6FHrkAnI+OhY5LVHNE5Muv6FHWHcNt14QARJv6idZbpqvEic8mNILRGcy7NBM3ABtFm8aHWMBEucIgicxk26u9E+zqhkPpncFaytuIFWj5Ze+8dS57CLLUlSs4XupeK97BX2ydI6QVwSpmH0IgJ9+tcGRZ3ErU8aTD46Rc3n6FgG3y5idhIB1nvBS8qqpUtm8O6/CnZoSX9fTG8jXX+FneV2ng/DMLTaj+ECeeqCn1gHaosPXflq8g7KYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP765eIK3i1h4ElPABCA1IyV3GB75Wkk4F2PfSzC7Fs=;
 b=D2N2aWuI3IIlmZkRTjgj/uE29eBEZLDm/N2rFyPFewn0Se5TrHbwRxpPeBkmLkBKN9PKAmarlU0KdE6PcMVI0LnWjkVvT96z//k0hq74xLI2Ej3B/KPHmuTmse9s4uJxl3bOYjZWFnvhBDalcbIC9Ph0j/FYbqQ5wzr7g01prcLhNA6Wco2Glp3k0jlG+p5R1cgzGHqxqDubhUBOFeC/8gFs8NJ6w7x1SW7ptQBKqziGLcenNm7D5I2dzu695feQp6hgKbhf8M53TUBidaqlOOKwCafnovh6uJZxZ4h74NBDIPUvlFiuCyCqxqpT9xQg4zStYqNUiG9OSf1XZB+cxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NP765eIK3i1h4ElPABCA1IyV3GB75Wkk4F2PfSzC7Fs=;
 b=RJKgLQk8yTy6HQX9FXjjhQEmzyBBe8nJBHg+TO7XQOMhtuZMoqLRNgnh/YEAaXyyacUjHq/XY5k0GrEp4KO85qsuNQe2rZWDecUMBP6ujGYCSGwDmja4+7bfQXfiBwGqrYxpzVhnyNDEE/kNK4BSaFD8tMI2t1/tnprURSQsQ/ESEH5c34PS5R4A9FCnDHFLqF89IlVFd0qMSQnQy6ak/ZDP0IXTGD5SXNJNcFAX8kKuM8bXOAV6ITsP1YN4UbmrI8K2hkDf0J9cUeaS24BED+vMJpveSy3Phku34ay3sX/sMTixc9CmirmkutndU79npoVfmLstop9OGLC5CITBLg==
Received: from BN0PR03CA0039.namprd03.prod.outlook.com (2603:10b6:408:e7::14)
 by LVUPR12MB999138.namprd12.prod.outlook.com (2603:10b6:408:39e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:29:51 +0000
Received: from BN3PEPF00022BC0.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::9) by BN0PR03CA0039.outlook.office365.com
 (2603:10b6:408:e7::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:29:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF00022BC0.mail.protection.outlook.com (10.167.248.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:29:49 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 12:29:16 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 12:29:15 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 12:29:15 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jamie Nguyen <jamien@nvidia.com>
Subject: [PATCH v2 3/3] firmware: arm_ffa: Back the ACPI FF-A FFH Operation Region
Date: Tue, 1 Sep 2026 12:29:06 -0700
Message-ID: <20260901192906.133670-4-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260901192906.133670-1-jamien@nvidia.com>
References: <20260901192906.133670-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC0:EE_|LVUPR12MB999138:EE_
X-MS-Office365-Filtering-Correlation-Id: bf64c89b-b66e-47cb-1012-08df085f63c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|7416014|376014|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	7lsNEmAyn0Otubvs/OkrOvlVbCRxj0FjD74FcqBwnYfbl1qLvyYvOUKXVpKq/J/Hu2cTma+fMYvCb3NWGJBx+eur3AP0zZbZ6OYL09G9dfgJvir9dZNDu56aK3QDlLiWvk93lnUdnKI2DPSH3ajyqaLaScl3JCWGts9mZXvVFZGzC0AkvR1S/5IWXa2DbXSyaJX/VZDMNdPc4VQzHSRaTTwEtgjoMxnCP3kUkWQhdjG1C2ZgTGG2CXGc8GjN8Ry9j6i7zA0o9C7kBNAysE2nR3r34ejKV38N3/+88Q2YQPp+QQ3XJTRax7Gs4PGDUwQ35QSMLhfg9vF93scDUvN69tuuc7P6NycLnpiyR5vAkEg/gOJpO+8EsY/lDpJOLL3FU2iBOgZLj17IrYrddvVlYegsG6pgiikMdXPQI9OoFQYEB6HAmoJWOXpX0Et3HKPQ/2qbSB5R0KfyS646W64y6vYKkfsjRwnem7s4tRDb0otW5aZMVlSYzneGqcaTuqDkh9MWlkPcAF385XToMX3VLepyhHxuNWYAt+WkuzrNlUBmbqIe4qYM4Uxo1jtaqGw+ss0phiabEz4gfQmXxMme0hRO8uZfW2YiWZOoYIhAhh5lo+SIJFLI/2o3/B5c/sj1fex0Y7o0frEKIeKzdh3qerdLBcMc97DlTgcDmlivgzsuPkLKEi/KkF4E++SWHvVnXva8bjNfFe2ULVaQn1af2w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(376014)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	35tC+pRezPjV24WvUCf3mPhtxi0h984qzgERjkB++UuVei4YBEM3a2b7uP+mkayNtfTesWyKg+8jeBvXW/2DHk7IZ7MkzvawS8XrR9/HGIsh+pgB8liiRE995Fk5r+l7Sunm4+HWRpfo0MTrNJ9juvXs/djQiraFnZdF4h8nOmCNRvWVm1CsDwvf6TGKDkV2Ix9OaDYWCwdOOgJYvNawg7gJzXUasj5kY+ag9xvHMRu7HE7NI6nzlAH0mPQB0MMFlQ3BeGkrFPLfKjJIqlv0NHL3tHQz6cxnLei4O4ojL4uvNmMqq8Ls9m3L8g43AWvCjsbZixxO4fUK2DVJDy4pei4jf6dj2NXCEBFaQKwYagbYaVvlH45sKegNvPLlPfydYFXQRnZR7KGTqkzG5KJhr5jTR2UkfN+JCAfMEDsJYiTiAfGbSTyEbjrlQpdH9Xu8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:29:49.7128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf64c89b-b66e-47cb-1012-08df085f63c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR12MB999138

Add the FFA_MSG_SEND_DIRECT_REQ2 backend behind FFH Operation Regions
declared with an Offset of 0x2, as described in Arm DEN0048D section
2.3.1.2, and register it once partition setup has completed.

None of what the Operation Region handler needs was reachable through the
existing ffa_device based interface. Resolving a service UUID to an
endpoint ID had no user yet. ffa_sync_send_receive2() always addresses
dev->vm_id, so a receiver endpoint ID that AML supplied in X1 cannot be
honoured. And the response registers DEN0048D wants copied back to AML are
discarded by ffa_msg_send_direct_req2(), which folds the FF-A error code
into an errno instead; patch 1 dealt with that one.

DEN0048D only requires the resolved endpoint to be unique, and a single
partition may be described by more than one entry, so compare endpoint IDs
instead of insisting on exactly one descriptor.

Where the endpoint was enumerated at probe time, check first that it can
receive direct request2 messages. AML then gets FFH_FFA_NOT_SUPPORTED
instead of a call that was never going to work. An endpoint with no
matching device is passed through and left for the callee to reject.

Assisted-by: Claude:claude-opus-5
Co-developed-by: Dat Mach <dmach@nvidia.com>
Signed-off-by: Dat Mach <dmach@nvidia.com>
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
 drivers/firmware/arm_ffa/driver.c | 118 +++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 3236cd0a731ab..0577c7d5685ee 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -2146,6 +2146,114 @@ static void ffa_notifications_setup(void)
 	ffa_notifications_cleanup();
 }
 
+/*
+ * Backend for FFH Operation Regions declared with an Offset of 0x2, see Arm
+ * DEN0048D (Functional Fixed Hardware Specification v1.3) section 2.3.1.2.
+ * The Operation Region handler itself lives in drivers/acpi/arm64/ffh.c and
+ * is built in, so it reaches this driver, which may be a module, through the
+ * ops registered below.
+ */
+static int ffa_acpi_ffh_partition_id(const uuid_t *uuid, u16 *dst_id)
+{
+	struct ffa_partition_info *pbuf;
+	int count, idx, ret = 0;
+	u16 id;
+
+	count = ffa_partition_probe(uuid, &pbuf);
+	if (count <= 0)
+		return count ? : -ENOENT;
+
+	/*
+	 * DEN0048D only requires the endpoint ID to be unique. A partition may
+	 * be described by more than one entry, so compare IDs rather than
+	 * insisting on a single descriptor.
+	 */
+	id = pbuf[0].id;
+	for (idx = 1; idx < count; idx++) {
+		if (pbuf[idx].id != id) {
+			ret = -ENOTUNIQ;
+			goto out;
+		}
+	}
+
+	*dst_id = id;
+out:
+	kfree(pbuf);
+	return ret;
+}
+
+static int ffa_acpi_ffh_match_id(struct device *dev, const void *data)
+{
+	const u16 *dst_id = data;
+
+	return to_ffa_dev(dev)->vm_id == *dst_id;
+}
+
+static int ffa_acpi_ffh_check_partition(u16 dst_id)
+{
+	struct device *dev;
+	bool supported;
+
+	dev = bus_find_device(&ffa_bus_type, NULL, &dst_id,
+			      ffa_acpi_ffh_match_id);
+	/*
+	 * Only partitions reported by FFA_PARTITION_INFO_GET at probe time have
+	 * a device here. AML may name an endpoint that was never enumerated, so
+	 * an unknown one is left to the callee to reject rather than refused
+	 * outright.
+	 */
+	if (!dev)
+		return 0;
+
+	supported = ffa_partition_supports_direct_req2_recv(to_ffa_dev(dev));
+	put_device(dev);
+
+	return supported ? 0 : -EOPNOTSUPP;
+}
+
+static int ffa_acpi_ffh_direct_req2(u16 dst_id, const uuid_t *uuid,
+				    u64 *payload, unsigned int nr_payload,
+				    u64 resp_regs[3])
+{
+	struct ffa_send_direct_data2 req = {}, resp;
+	int ret;
+
+	BUILD_BUG_ON(sizeof(req.data[0]) != sizeof(*payload));
+
+	if (!drv_info->msg_direct_req2_supp)
+		return -EOPNOTSUPP;
+
+	if (!nr_payload || nr_payload > ARRAY_SIZE(req.data))
+		return -EINVAL;
+
+	ret = ffa_acpi_ffh_check_partition(dst_id);
+	if (ret)
+		return ret;
+
+	/*
+	 * Registers not represented in the Operation Region stay zero, as
+	 * required by DEN0048D.
+	 */
+	memcpy(req.data, payload, nr_payload * sizeof(*payload));
+
+	ret = __ffa_msg_send_direct_req2(drv_info->vm_id, dst_id, uuid, &req,
+					 &resp, resp_regs);
+
+	/*
+	 * DEN0048D asks for the registers to be copied back once the call has
+	 * completed, whatever the outcome, so this runs on the FFA_ERROR path
+	 * too rather than leaving AML looking at its own request.
+	 */
+	memcpy(payload, resp.data, nr_payload * sizeof(*payload));
+
+	return ret;
+}
+
+static const struct acpi_ffh_ffa_ops ffa_acpi_ffh_ops = {
+	.partition_id	= ffa_acpi_ffh_partition_id,
+	.direct_req2	= ffa_acpi_ffh_direct_req2,
+};
+
 static int ffa_probe(struct platform_device *pdev)
 {
 	int ret;
@@ -2228,8 +2336,13 @@ static int ffa_probe(struct platform_device *pdev)
 	ffa_notifications_setup();
 
 	ret = ffa_setup_partitions();
-	if (!ret)
-		return ret;
+	if (!ret) {
+		ret = acpi_ffh_ffa_register(&ffa_acpi_ffh_ops);
+		if (ret && ret != -EOPNOTSUPP)
+			pr_warn("failed to register ACPI FFH backend (%d)\n",
+				ret);
+		return 0;
+	}
 
 	pr_err("failed to setup partitions\n");
 	ffa_notifications_cleanup();
@@ -2249,6 +2362,7 @@ static void ffa_remove(struct platform_device *pdev)
 {
 	struct ffa_drv_info *info = platform_get_drvdata(pdev);
 
+	acpi_ffh_ffa_unregister(&ffa_acpi_ffh_ops);
 	ffa_notifications_cleanup();
 	ffa_partitions_cleanup();
 	ffa_rxtx_unmap();
-- 
2.43.0


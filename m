Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9104449E5EB;
	Tue,  1 Sep 2026 19:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290996; cv=fail; b=TQhptVFG9sigB3T9ktWQx2spGPj5Zk6TFkbQieuMRvSpG6i883D4fOGEhw4HFFfZbr8sQmJD8p23/uTZ4dQLd9X2Ec7U0I8EFyr0pSp6yvtPr2fBCavEtNbLLvINTV4ddR7eGUPtVKzsKMG88PzIC9KI/PaZ0eCjl6C4gpIVuvk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290996; c=relaxed/simple;
	bh=S98aUlrC/P8DAIDRiqA6MBuF9n3nN4DdEUYpGX5mVjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aD6MRO5EaIQCXdR/kQeULR3OY1yfJphpE4VVa2HchHnYPaE/5f8fulMUhJ0NVca5Z8axa3joIqwbzzLESAxJO5BB38udpfvu9ZVexSZbP1jIakPkIZhr9s/HNvv36b4pSTFQsHfUnPuXZPJ+3ytJUZ3w5Q/f+F3rsiIFJo8iInc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r8y43J9a; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r8y43J9a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sk06zWymX3HGG/pSSuVbCLfKmttYONaWzxcqc6KnLRHWG+gtElodAj4Zl28qqdiPPOHpXBPzV6BHmafjbXJk73VWjmCRgf5QQoKSjH0kLk5Zyxqc44rKGpkJ9f4QDKRm9T1M6djWCOtbpdp39o23/YBhPWBswmrB7tlXm16uN6263SZ+e9i8nZjVH9QQSOOitkwkcUhiIF8lLXDOSzXHX4zGDcu0B96r6Ml0Sdv1J4VZ+ZJy2e9bcyveSODX/cz2wqnmDycswC0J6VOpy6o0lRhIxZGkSnVdiRcSTl/g6G1t8KX+CK9zEiRhlXD3uhwvtJArLK9N1kRlO8Rl2DmqUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yI5E2roj7qAoB4uTIQksSLEJkJTR/dGIWafk1IZFcEE=;
 b=M0pmZl/GxNdDQcRHjcw4ToWeKIPCRCRbdDvn80rHBFTL4ZzXG7d00qb43x0XxBW6gqWemxkjn5EUgWk7sndakl8yRwWVwhyaxmAys2ad6x5rLZmnT8AbZQ2pXN2y6xEIC+FbDHccB6w+DuFjUL38MMPuHYo1YOMylwLj4eAu72/H53W1sv0WE6dmKOITz7ovgGkllW7uRw53T/uq7ACxs4xNuaD1HE8rVXAnkOpnoBuhubHCsYxMB1ZTAdzWgziNwAM3b4gPoFif9TjyiulI5+4a23eWdKaTO2UVR4teqzlOvrhaetZAKf6wo/rSmczupPtWFAMGACTJTc9vXOp+fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yI5E2roj7qAoB4uTIQksSLEJkJTR/dGIWafk1IZFcEE=;
 b=r8y43J9anooShvCyziBxTUaEfiAMof8FtG+zFrHMiKapvVrZctX6dFCXQaR3dzMmCryNfr5LiuIuI6CW+LXowwhZ2SSJ8xkcZEQ2fyPq6v/kVYexWxWP9776dFefOELPK0q6Xt7AXppG9FZGA+BWFpVrNrBNDlfydktWpoXEFiPSuxnG/TSAX+P+/PFvJBE855+vFbBQbs2ksUyQGCW2IvcGJrB8aWXbCaMlgPt1jbruvtytqb46sIPShOYfqfujS/hawJ01f8LWK0ZPZ17ShsaXMyVpsvLQc22kcFroPVl40smMq0JQryU5ngfY/grR5Bueoo1akBR9h3oMzmRm1Q==
Received: from DM6PR08CA0047.namprd08.prod.outlook.com (2603:10b6:5:1e0::21)
 by DS0PR12MB8320.namprd12.prod.outlook.com (2603:10b6:8:f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:29:45 +0000
Received: from CY4PEPF0000EE3B.namprd03.prod.outlook.com
 (2603:10b6:5:1e0:cafe::3f) by DM6PR08CA0047.outlook.office365.com
 (2603:10b6:5:1e0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3B.mail.protection.outlook.com (10.167.242.14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:29:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 12:29:14 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 12:29:14 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 12:29:13 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jamie Nguyen <jamien@nvidia.com>
Subject: [PATCH v2 1/3] firmware: arm_ffa: Split the response out of ffa_msg_send_direct_req2()
Date: Tue, 1 Sep 2026 12:29:04 -0700
Message-ID: <20260901192906.133670-2-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3B:EE_|DS0PR12MB8320:EE_
X-MS-Office365-Filtering-Correlation-Id: b00d0629-69e9-4c89-4423-08df085f60bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|23010399003|36860700016|82310400026|56012099006|5023799004|11063799006|6133799003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	JwEMyLU9ZgyYmC4FwdICdTCi7tIrofmLSgNX4NnX6vn6BMWySoC/yJU+f9w2PJsBl+nXq0R/aEO1k+HSybfVzYZAO881JZRBDekYRon289zM3rL/xi4sb7u2MZKv1bNOyEHpPgJeTB/3ffft5cK9phBsuBcgKzYh2BluxerFaFy6Op6txEQGk6GEkI4AGb3t6hozy1Y+opkRP9Dhqr9wIGe+vJL1te1+aQR0TwFUqTadkZZYYlDqa2m6cwzV6ctt1loWMlUVMYaDOWqa94YuRfMO5nrw4PAgoBV2RYT1QYhT9zuNJSFkKIXPdxKSCh/onCsLXlismulprLmu2HcS3JYeqirQz67OHvwjzzNPELZXNBFDtg3is/sqQk7HDTCnLf9I3po+YWbZWdevSHm1+FMQ6w5GymmEIv/FTQppqk4LzTiaYn7cYhBLuVzJOxgrYorPRYIqzq82K7lWQQvaoZ3J4rua4k5ebI3an1JzeCX6Jv6lx+qfo/9opqQKwDvG33SW4C5+8yll5aBxuYG2tnT/XCjpGreYS4Udr3+WMDjRyf/ReGgSk7jlXURaLgJh1F6dnQpUX7EUGV+Oq5cih3uf8ic2KQwXuDOYcX4G4y5kSWx8B74026sKRW1FnpMfwxLKg3ol4wr+1P8yEVIYSRDkeMgSGXk6RZR+I72JKKSYadEfiAyLJOCnRE2g8PY7Auw42W/fzDkIEi5UAP996Q==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(36860700016)(82310400026)(56012099006)(5023799004)(11063799006)(6133799003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ZU3ifJTZzYI0FRwoBUBHgj06++dH87goEPV1diXtkYbGiwr2vCMNU+0B6Gaaer/pKeTJWbDdh+bhyPWP9BwZKE0paDTcTmV3FumYhKfA6wA1BsePFeLMIn9pCBq78QLlvEpZisQqeIqMc+Asx5mXqtwk3VFcrDhdImAMnO4qyTJX2fCgU/iMNuIkuBWvfz3SEf+VhOBj8rNPU1ZmQJr+XaIM4XE2ZrBE6dnH0NmOIkaF2fXNIOlf8mFTMHCxhyXEZakMw/DTKeKaXjDmJmseYqF7yYLPDAEJ7ku+Ne/1JdgWdPEI5oJEcIrg61JLmWgv4Jn0Z/WXNZhLA6mEyH3VucWIrHPy/1yUd3uYj0gF4FFaHtjN3dc3h0P1e4tG3LhAogRfBMxYY4WHrlsXnnQfRKkFyfp7JnpqaCbOohu/Ud4GHH5Fw80X6UdDgdN16pZx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:29:44.6741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00d0629-69e9-4c89-4423-08df085f60bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8320

ffa_msg_send_direct_req2() uses one buffer for both the request and the
response, and it only ever reports a callee side FFA_ERROR as a translated
errno. The ACPI FFH Operation Region handler added later in this series
can work with neither. It has to hand every response register back to AML,
including on the paths where the call failed.

Move the body into __ffa_msg_send_direct_req2(). It writes the response to
a buffer of its own, returns X1-X3 through @resp_regs, and separates three
outcomes: success, a callee that returned FFA_ERROR (-EIO, with the FF-A
error code left in @resp_regs[1]), and anything else (-EPROTO).

ffa_msg_send_direct_req2() sits on top of that as a wrapper. It copies to
the caller's buffer only on success and returns the same errnos it did
before, so ffa_sync_send_receive2() and its users are untouched.

No functional change.

Assisted-by: Claude:claude-opus-5
Co-developed-by: Dat Mach <dmach@nvidia.com>
Signed-off-by: Dat Mach <dmach@nvidia.com>
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
 drivers/firmware/arm_ffa/driver.c | 51 ++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 8654b3365c9b6..3236cd0a731ab 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -560,8 +560,20 @@ static int ffa_msg_send2(struct ffa_device *dev, u16 src_id, void *buf, size_t s
 	return retval;
 }
 
-static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
-				    struct ffa_send_direct_data2 *data)
+/*
+ * Sends @req and reports the callee's X1-X3 through @resp_regs and its
+ * X4-X17 through @resp, both unconditionally, so that a caller bound by
+ * DEN0048D section 2.3.1.2 can copy every register back to AML even when the
+ * callee returned FFA_ERROR. Keeping the response out of @req leaves the
+ * caller free to decide when, if ever, to overwrite its own buffer. Returns
+ * -EIO for FFA_ERROR (the FF-A error code is left in @resp_regs[1] as X2) and
+ * -EPROTO for an unexpected response; both mean the call was made. Callers
+ * that only need an errno should use ffa_msg_send_direct_req2().
+ */
+static int __ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
+				      const struct ffa_send_direct_data2 *req,
+				      struct ffa_send_direct_data2 *resp,
+				      u64 resp_regs[3])
 {
 	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
 	union {
@@ -574,21 +586,46 @@ static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 		.a2 = le64_to_cpu(uuid_regs.regs[0]),
 		.a3 = le64_to_cpu(uuid_regs.regs[1]),
 	};
-	memcpy((void *)&args + offsetof(ffa_value_t, a4), data, sizeof(*data));
+	memcpy((void *)&args + offsetof(ffa_value_t, a4), req, sizeof(*req));
 
 	invoke_ffa_fn(args, &ret);
 
 	ffa_msg_send_wait_for_completion(&ret);
 
+	resp_regs[0] = ret.a1;
+	resp_regs[1] = ret.a2;
+	resp_regs[2] = ret.a3;
+	memcpy(resp, (void *)&ret + offsetof(ffa_value_t, a4), sizeof(*resp));
+
 	if (ret.a0 == FFA_ERROR)
-		return ffa_to_linux_errno((int)ret.a2);
+		return -EIO;
+
+	if (ret.a0 == FFA_MSG_SEND_DIRECT_RESP2)
+		return 0;
+
+	return -EPROTO;
+}
 
-	if (ret.a0 == FFA_MSG_SEND_DIRECT_RESP2) {
-		memcpy(data, (void *)&ret + offsetof(ffa_value_t, a4), sizeof(*data));
+static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
+				    struct ffa_send_direct_data2 *data)
+{
+	struct ffa_send_direct_data2 resp;
+	u64 resp_regs[3];
+	int ret;
+
+	ret = __ffa_msg_send_direct_req2(src_id, dst_id, uuid, data, &resp,
+					 resp_regs);
+	if (!ret) {
+		*data = resp;
 		return 0;
 	}
 
-	return -EINVAL;
+	if (ret == -EIO)
+		return ffa_to_linux_errno((int)resp_regs[1]);
+	if (ret == -EPROTO)
+		return -EINVAL;
+
+	return ret;
 }
 
 static int ffa_mem_first_frag(u32 func_id, phys_addr_t buf, u32 buf_sz,
-- 
2.43.0


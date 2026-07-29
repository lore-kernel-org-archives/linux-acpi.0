Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010006.outbound.protection.outlook.com [52.101.193.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701013A1A3F;
	Wed, 29 Jul 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347857; cv=fail; b=U/uwz/kARItoF0hs7pef7UxJPiORlqInB07mSJYDEvW/roM7Y8OYz472bAesyMoKjB6VW0uqp7fUYUXDUZrrKLgmAi0Qr5wHOFWyk2H/sZuC+cxpv76TA+XbKYpXVr5cIRz5MEY/x2zBRNKDD9uvV4CmV7FIPOT5kYWiV93D6+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347857; c=relaxed/simple;
	bh=gT8/oQIIdSX1w3EkrCk4ZzoKt1u770M5/fPCDoa+NdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MOq4nV9PbUGZD27N0PC5qEGAeq6DNVcI/63EoCm9yNKup3GBNpzDC1xehfV0EilSZms73wl6YMsbT0mBonK40S8NChW7jctOIVZ/JkSOIq4QHy8LyNwAo52SVXcARzi9HEbs2n7Cow/861YWqOTQJqspBtCCrRt7fMyBLdk7ig4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aSOXTOsQ; arc=fail smtp.client-ip=52.101.193.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aSOXTOsQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJKSYhIWuqOhAvVed4AvIMpxfGvDOcDmQ7wdhSgInHMOrUe9axK5ZVk4fcekmmfsd+g7DpN296JoC69L0zOFwQDsKeTCVdnN38gkoFUI68a5jKwwMTCxKkunyzzjASJvJv2MBVYuOQdWJJNLU0i4qIK614w6+Quu0XKRIay3TWRlegLvpLnmZanO9L+yJDrKT34kmzYIOJtf7SmBwoyWGsz0OQ7CJc4oqC35FZ3MJmAUD3TmXdDXm3+S1Zc442yz+hZwhlEwS6hcio4RiYHdJODTughF3fGghmZU7nf3NrMhdSXo6JkgjuSOyuQb6R3hkxmzOilRXOYgPmdHwIVKSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzu5fxQK9fTD26GTGLZPOxPNtqZZIOx+eaig8hNkzf8=;
 b=pJosVJY9x4wN90kEfVRHZBnkvsCerDTQWJwTo1+jSSXUBbOZ8oupHyKOB+L3ChwfsWYEvt/0bLbsYdE53hGJo9a1reMUxmmB0mIcujGvMavhVTzWSun1w5dR9Im3mY+mlKo0G6gerQ0DaPYb047DC9Eo6vrkkOTvBSs6APd0xyx3g70vhp4lVx5sDfke9zzKJP5utwqhKHMySyCQTa+LCM+q+pae+vt8ZiZBqYTIOKW3tWHRMvqvqmOzIBxoQLr19dq4YaCBlOA/KhQsHBs+oJ7k8sYiWcyanWNKHs/Qvs7ibgWWzBkxEJAo5inc4Sfd2gDr14991DmVnxSiHCr90Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzu5fxQK9fTD26GTGLZPOxPNtqZZIOx+eaig8hNkzf8=;
 b=aSOXTOsQmMrvQKEiWZrV+JCFn6m6yE1BhgGQ9ArV2C1l7VsDBQ3CGqFtm9gn8RXXU1uiAte+sQRnrDYsp7QaPqn1/D9aaJx1Ej+8lLudg26zE+z6uE89bPdD63Kc4IJ7KuNkgvUCsev6er6wrxuZUCaC19s/dRjWqRHiasvT/sGdRsUcTm4Zmo4OMcbgWA5pmVcC+BFb52LQYKI3GxK53aUwI3oRx/GWjNqd9nCaL0F8WCpZMNUEogTs6BodHNKHnlTmxsoHtICcGATGUvk+bp3VOMMhOcq3qEAi+e8Y6eiBEO/Egm9njblDosQ0I2PnBeif+oktGFYP2jguUZe8Pw==
Received: from BN1PR13CA0010.namprd13.prod.outlook.com (2603:10b6:408:e2::15)
 by DM3PR12MB9285.namprd12.prod.outlook.com (2603:10b6:0:49::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.12; Wed, 29 Jul 2026 17:57:20 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::5d) by BN1PR13CA0010.outlook.office365.com
 (2603:10b6:408:e2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.8 via Frontend Transport; Wed, 29
 Jul 2026 17:57:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Wed, 29 Jul 2026 17:57:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Jul
 2026 10:56:55 -0700
Received: from dgx-1v-42.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Jul
 2026 10:56:55 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jamie Nguyen <jamien@nvidia.com>
Subject: [RFC PATCH 1/3] firmware: arm_ffa: Split the response out of ffa_msg_send_direct_req2()
Date: Wed, 29 Jul 2026 10:56:36 -0700
Message-ID: <20260729175638.3796440-2-jamien@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729175638.3796440-1-jamien@nvidia.com>
References: <20260729175638.3796440-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DM3PR12MB9285:EE_
X-MS-Office365-Filtering-Correlation-Id: 32701700-7133-4c10-9f75-08deed9ad5ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|23010399003|82310400026|376014|7416014|11063799006|56012099006|5023799004|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	GUty73yDWkeK7yVdlZXLMSS9YjUNNPBeA/s9lAKpd4Sh6zvqzvJ/7iaa+i36GWFH9SH5yx4B8MPvqPSsg/emDifpwf98ht2OXchTMslT4LWEbwTYwUDfPn14McsWHeYpDLo59GyLzSjEObJYjWDPdcckgFCerB8hbkfPaBx80bQENXSiXMYNMD06O8cXQ7v+Cj+V8zOGhJj3OTfa/n4IRaoPcloriPn0PQjL2FFy9uFr1VuHKK8Va4Uaxu/mGxpa5wUYLyjiw5J1iavM2xNyi0/xjTksqHMSx2dJbxsPm9etNsO/BfWbNuC9X6yFMSeNiORVCwLau3CRPdtzfRNT7mLje2oRW4Erx3/uWpqC3rvBXyUim3ycHOUySPn40dbZGVyBlm8WRKyvuT6oYn4GEM+umMWlAgj0ZwBTUgFChI+tGxx5TNp/pOmCcDYGlkbjoFTVNMXGGlHh8QyGXxsFboCCD4K6v1jLJfez0FiCpijEk4UutT0j7yca8p5ewsOrBicdshqfvmyarVxXuAmbTN0pKJY7xfMeX2l8R1dzwKIiU9oWn0764czTtomOB0xYAmtIvS8eGrmcCH2qEVDIsu63n57YySLlyKJ3Sd9wOrBfS60EVPsownrljJqYF5YOEcrYa7nAWRzOmvxh7T5Q9HMdyfP80GWooQrQkhFqpIvC+xnJIVxoJHchHp+qcEYhdvGJWnHpTP8nq3j5h5F+YA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(23010399003)(82310400026)(376014)(7416014)(11063799006)(56012099006)(5023799004)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	I79KvOg5GaKeSmApRRYIllxkNNZhv+u4wPLdPyVQ4/LFlnXA9+LjaGK9Lvr78WVBeXJMxb+c83X/OZQA5u+QLz/hE0YXq2K9xys436YL0PcJPeUyW99ozYBVLSvlR28jCXvmoNvmmYkncl+76bd5J1xrUXrzSuLe79Fsy+hJzXasXNFfnvu5WH82Wqe3nwIHWDNEQ461DohTGQdE9GBFUdq/cDjLWN4CFo4ZKnc1xH4ZP/cZYWzeQ/D07vIfJFne5/dnSR8NdFwWZPChDNeEIQAalJTI/tokBzF6QcoWI4X/ZgWd1lbzTg2Y5zGQv802/y6dHw9z15DHO5zLvUQihw8YD7Ypigw6yW5BmGtARGuQC6ejXs5yjDbGomMIxgxO393kjTSC/U/Yq/0N6HNU6UPDyAoMUqAX93LDsYtCLTK5kow/KRqCNOod4AM9v2+P
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 17:57:20.1002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32701700-7133-4c10-9f75-08deed9ad5ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9285

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


Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012016.outbound.protection.outlook.com [52.101.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F123ABD88;
	Wed, 29 Jul 2026 17:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785347858; cv=fail; b=K/rmygjMBq7+Hf6bgj7v8G94QqYJJDOjpcq2NzCd8qRrVz5qDLPdY6Q0gIaSmDoqujZbOX7oPiit8U2ACc7sUJtCmQg3bDUw23cF3qoiW4TYVrSZtkzSyYB2HzwPOqhLOjyUjCrAxFuPzek7maJQsjGJV/fbwPHqZDCyjh1DHxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785347858; c=relaxed/simple;
	bh=I8Qntrmhw5/QYmsgFfWKeklX5Alv5W3PGrX3ZTY0lZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xmi55kpWN8aBs+1XJ5qSXJH6zUJxGjlppvH+hhXQHXDG6LbRiKxGS0/MrirkJ+WusDvYcs+xlRe7rghv9oxCF//QYLukA37ga7Gr86E+yaQ+00vN/4fiZHFPf72Z55/cakv8pWAB6OL5w2mc2WSH98UmWm7064/s7iL/QKcJFEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MXU4rfCn; arc=fail smtp.client-ip=52.101.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MXU4rfCn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rDcTl7CgqUezwyxGK67CJkc7UvUK2LrkZH8r7xZ4X2Zl1mVRJ/G/7agVIWcIYLnKMmeaj414OU/hwY7JpcoeaXKAV3eW/P2nwb3tHGm829sQtwg40WtxoZ+/j5AHQRLQX8fmDOVCNw9dfYDadalY60IRQ3gs1vPhV6DIcuWkYHtx1pFodR91owdf05Wj8LVyEdaiGhdi3YqS/vJXYmTRPqJPfFt+880jgD+fh0ei344G4FFsn0LNYeyptD9WwdnwzJX9nez7QsdcU8r8CID/YJTUSg2nxiPicPPhHng/pAgcjRMYdhMD5P3Zz71VAV8dyc489Vef5ifb8FPxp8IxzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4KpmFo3in5bNH1ATnZeklaHhsz9revGCHIdSN91eig=;
 b=cxrqTa6h+wZldHg8RMATqqikpAcExQGoC7XVWj1vec13o7/FRoVnaOhkS13PiA97bYoM3YHWFVFA0Yaj1FYliWTIJPjqlbP4HKaGKYot6mC6ZFvH17aEm35b4ipzLEZeXBD5DmdpBftOvVgeDeQfnjr1CznpdIfwwdCG05vfdXS5KcIVQs9ekT9eEsfSEJo4e9fY17XSy2766y6wtCni9fpl823Gww0I0wudcbjcnk5RwSt9W4Cg+ShQpzjqpS0mzBL8Rp0mUHJ6pX8xvjsIr3wWAahJY2Ar6dE59kSXtZ3XvTxbc05O+qr9/6Kx+IAs1Di2K73p2vogvx5flie9TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4KpmFo3in5bNH1ATnZeklaHhsz9revGCHIdSN91eig=;
 b=MXU4rfCnMZP8tvhdw33R5LCyT4MxOEZvIWnhq+vh9kJFQh/K8ba2QxV3QYL2lPAOL9MBFAcsl+H172a6GVetbGKBCJWfFY+nHAlkW6ndxjng/uLowp5nkHnm8jp0wD+VrJ8q3KkhB7qwxRdkXKwVzvJ+o8U+52xVRpNx6j4DOEFHtJadKhJFqKvmPvFTtQkYc9AysqENI/MAzhhiQML3r/vIE2iXby8tE33K8ue51PhbPlQOtsVMUSAJ/F+kna+M4817Fc52oDrNqfa/brG6xMB1APOsvlOL/87iqiFzr2zynnr0sVtwuFOr+aIb82Q7eGBpoNc916Ff32ONtQUiIA==
Received: from BN9PR03CA0889.namprd03.prod.outlook.com (2603:10b6:408:13c::24)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Wed, 29 Jul
 2026 17:57:23 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::a6) by BN9PR03CA0889.outlook.office365.com
 (2603:10b6:408:13c::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Wed,
 29 Jul 2026 17:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Wed, 29 Jul 2026 17:57:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Jul
 2026 10:56:57 -0700
Received: from dgx-1v-42.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Jul
 2026 10:56:57 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jamie Nguyen <jamien@nvidia.com>
Subject: [RFC PATCH 2/3] ACPI: arm64: Add support for the FF-A FFH Operation Region (offset 2)
Date: Wed, 29 Jul 2026 10:56:37 -0700
Message-ID: <20260729175638.3796440-3-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1bed7e-b35b-42ae-d8c5-08deed9ad779
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|23010399003|1800799024|6133799003|56012099006|11063799006|10067099003|5023799004|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	Whhmai+vWsrCExi/DIeqvIYlqv5La9jy4nTUpNCv+GiftFpowrR5c8tzNLi+IJ44hqKMGPvVvi+fTWQ2uK9N54f6PW2UUySpMkTnmOauJOYZv1BpcIvNZfolRnDzjK+HSefwWRwE3c0ivaYlM2ZIJwBrcS1+0A2sKKy/OfyVmdj/dd+W3rjdIJnV8WNv2Moq0NDw4WXLFQnsEzZiKeqtGABst0VQ9Y76aXxP9S2stwosB5wur3AzHUUJLenVUzsqjTotQZRr7YR4/vlMLm9/XJkVE6VsHBQlgWHsuPK781K340pUoT99riGbqG0Fb4Kf23b/8fBGzYlTO3saeZ+uzwqv/KzirzQseHUQFq1c0dVRzcr7/FDt6pgai3HF8eeo3SOPOqW95JJVTm0XfHBgruRpV9gnrh1zBiPOscAXriDV5VSKgGbj12bOlhD2jnKP+9BiCoCBJH4I8bZIgecOeupN/5fe1NrZdcHNBOLmX2lreBWQdlXJ6A7AAp8ifrKdLiDnri0vmze3zaib+oQcxK0CuXbK7hzJKmqz8jMWiodAfuBICpX9iK5O1ric6itbAtXJ5pfUHMR7FhGY10bS+72r9s6G5YEi3KZQPmKqPApgl9dfUoVLzeO/H4HxKhZ/4WC9JQc6b0bcyeVcGO/eMbJpT2Y0Hdv2cWd4vsFLTV2eUqNFL0U4ExuM7OuyuiM6x2uXZeU8aJjWM7aeLq+TIg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(23010399003)(1800799024)(6133799003)(56012099006)(11063799006)(10067099003)(5023799004)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5CxKwBiOCyeOLKY0W3FngJNQkpRdFmaigtQHFxfTuMV7DwiClR2FcUUQ2BprMx233vMUpu2Q1/1+3zGkhC311/iZg2zl/hJEVbrWWaiBwgWLiZslqwHLF0NWVCMauvJ3vHgxuzdLojk8HI43E8qVZvaujmhwQ3VghJVvjaeIdPkkt9YHBVBxv1Yt6jBwuiBDn3bTAspTfclBMoJ4fzuQN3gBKquaz3MBYYhdxjGncokf+0UmdEZ4owYVDgH/GZRc7vlcpjDP89tTgujXmYQQwHUd5+f/mkkBrS7+hIWWENoRGTjrQS2JRqgWhwMfs9W0zywNAai6rfUmEvJcma8IqQv0jE/VWAmEnRfAqNN+t9HyFZ5xzwUo91l7Qjx3ng/AhDBYRGdvvqyYGLFG+AlQBgO1y4wuLgW3S1HbUcfwa+cnv0Xv7YMLC/ug1y+U9izL
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 17:57:22.7588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1bed7e-b35b-42ae-d8c5-08deed9ad779
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430

Arm DEN0048D (Functional Fixed Hardware Specification v1.3, March 2026)
added a third FFH Operation Region flavour. An Operation Region declared
with an Offset of 0x2 triggers an FFA_MSG_SEND_DIRECT_REQ2 call instead of
a bare SMC or HVC, and each 64-bit field of the region is one register,
starting at X0:

  X0		call status, populated by OSPM on return
  X1		Bits[15:0] receiver endpoint ID, or zero to have OSPM
		resolve it from the service UUID
  X2-X3		service UUID of the callee partition, written by ACPI
		platform firmware using ToUUID()
  X4-X17	message payload, X4 is always present

DEN0048D recommends Offset 0x2 for new platforms, since not every OSPM
implements Offsets 0x0 and 0x1. Linux implements both and rejects anything
else, so AML using the recommended encoding simply fails today.

Add the Operation Region side of it. Region length validation, the X0-X17
layout, the ToUUID() to FF-A UUID byte order conversion and the DEN0048D
table 3 status codes all live here; they are ACPI semantics, not FF-A
ones. The call itself goes out through a small set of ops that the FF-A
driver registers. That indirection is needed because this file is built
in, while CONFIG_ARM_FFA_TRANSPORT is a tristate.

Anything that stops the call being made comes back to AML in the X0 status
field: a malformed region length, or a null service UUID when AML has
asked OSPM to find the endpoint itself. Once the call has gone out every
register is copied back, whatever the outcome, which is what DEN0048D
requires. That also takes care of table 3, because FFA_ERROR reports the
FF-A error code in X2 and FFH_FFA_CALL_FAILED wants it in the same place.
A response that is neither FFA_ERROR nor FFA_MSG_SEND_DIRECT_RESP2 is
handled the same way; the call did complete.

Co-developed-by: Dat Mach <dmach@nvidia.com>
Signed-off-by: Dat Mach <dmach@nvidia.com>
Signed-off-by: Jamie Nguyen <jamien@nvidia.com>
---
 drivers/acpi/arm64/ffh.c | 185 +++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h     |  41 +++++++++
 2 files changed, 226 insertions(+)

diff --git a/drivers/acpi/arm64/ffh.c b/drivers/acpi/arm64/ffh.c
index 04380bab193df..9f8a508cf2d4a 100644
--- a/drivers/acpi/arm64/ffh.c
+++ b/drivers/acpi/arm64/ffh.c
@@ -1,7 +1,9 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/acpi.h>
 #include <linux/arm-smccc.h>
+#include <linux/rwsem.h>
 #include <linux/slab.h>
+#include <linux/uuid.h>
 
 /*
  * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as
@@ -62,6 +64,183 @@ static bool acpi_ffh_smccc_owner_allowed(u32 fid)
 	return false;
 }
 
+/*
+ * FFH Operation Regions declared with an Offset of 0x2 trigger an
+ * FFA_MSG_SEND_DIRECT_REQ2 call, as described in Arm DEN0048D (Functional
+ * Fixed Hardware Specification v1.3) section 2.3.1.2. Every 64-bit field of
+ * the region maps to one register, ordered from X0:
+ *
+ *   X0		status, one of the ACPI_FFH_FFA_* codes below, populated by
+ *		OSPM on return
+ *   X1		Bits[15:0] hold the receiver endpoint ID, or zero to have OSPM
+ *		resolve it from the service UUID
+ *   X2-X3	service UUID of the callee partition, written by ACPI platform
+ *		firmware with the ToUUID() ASL operator
+ *   X4-X17	message payload, X4 is always present
+ *
+ * The region Length is "32 + 8 * N" bytes with 1 <= N <= 14, which is X0-X4
+ * at minimum and X0-X17 at most.
+ */
+#define ACPI_FFH_FFA_HDR_REGS		4	/* X0 - X3 */
+#define ACPI_FFH_FFA_MAX_PAYLOAD_REGS	14	/* X4 - X17 */
+#define ACPI_FFH_FFA_UUID_OFFSET	(2 * sizeof(u64))
+#define ACPI_FFH_FFA_MIN_LENGTH		((ACPI_FFH_FFA_HDR_REGS + 1) * sizeof(u64))
+#define ACPI_FFH_FFA_MAX_LENGTH		\
+	((ACPI_FFH_FFA_HDR_REGS + ACPI_FFH_FFA_MAX_PAYLOAD_REGS) * sizeof(u64))
+
+/* DEN0048D table 3, FFH Operation Region status codes for FFA calls */
+#define ACPI_FFH_FFA_CALL_FAILED		1
+#define ACPI_FFH_FFA_SUCCESS			0
+#define ACPI_FFH_FFA_NOT_SUPPORTED		(-1)
+#define ACPI_FFH_FFA_INVALID_PARAMETERS		(-2)
+#define ACPI_FFH_FFA_OUT_OF_MEMORY		(-3)
+#define ACPI_FFH_FFA_UNSPECIFIED_ERROR		(-4)
+
+static const struct acpi_ffh_ffa_ops *ffa_ops;
+static DECLARE_RWSEM(ffa_ops_sem);
+
+int acpi_ffh_ffa_register(const struct acpi_ffh_ffa_ops *ops)
+{
+	int ret = 0;
+
+	if (!ops || !ops->partition_id || !ops->direct_req2)
+		return -EINVAL;
+
+	down_write(&ffa_ops_sem);
+	if (ffa_ops)
+		ret = -EBUSY;
+	else
+		ffa_ops = ops;
+	up_write(&ffa_ops_sem);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(acpi_ffh_ffa_register);
+
+void acpi_ffh_ffa_unregister(const struct acpi_ffh_ffa_ops *ops)
+{
+	down_write(&ffa_ops_sem);
+	if (ffa_ops == ops)
+		ffa_ops = NULL;
+	up_write(&ffa_ops_sem);
+}
+EXPORT_SYMBOL_GPL(acpi_ffh_ffa_unregister);
+
+/*
+ * ToUUID() emits the UUID in mixed-endian (EFI GUID) byte order whereas FF-A
+ * expects the RFC4122 layout, which is exactly a guid_t to uuid_t conversion.
+ */
+static void acpi_ffh_ffa_uuid(uuid_t *uuid, const u8 *aml_buf)
+{
+	int i;
+
+	for (i = 0; i < UUID_SIZE; i++)
+		uuid->b[i] = aml_buf[guid_index[i]];
+}
+
+static int acpi_ffh_ffa_status(int err)
+{
+	switch (err) {
+	case 0:
+		return ACPI_FFH_FFA_SUCCESS;
+	case -EIO:
+	case -EPROTO:
+		return ACPI_FFH_FFA_CALL_FAILED;
+	case -EOPNOTSUPP:
+		return ACPI_FFH_FFA_NOT_SUPPORTED;
+	case -EINVAL:
+	case -ENOENT:
+	case -ENODEV:
+	case -ENOTUNIQ:
+		return ACPI_FFH_FFA_INVALID_PARAMETERS;
+	case -ENOMEM:
+		return ACPI_FFH_FFA_OUT_OF_MEMORY;
+	default:
+		return ACPI_FFH_FFA_UNSPECIFIED_ERROR;
+	}
+}
+
+static bool acpi_ffh_ffa_length_valid(u64 length)
+{
+	return length >= ACPI_FFH_FFA_MIN_LENGTH &&
+	       length <= ACPI_FFH_FFA_MAX_LENGTH &&
+	       !(length % sizeof(u64));
+}
+
+static void acpi_ffh_ffa_handler(struct acpi_ffh_info *info, void *value)
+{
+	int status = ACPI_FFH_FFA_INVALID_PARAMETERS;
+	u64 resp_regs[3] = {};
+	unsigned int nr_payload;
+	u64 *regs = value;
+	uuid_t uuid;
+	u16 dst_id;
+	int ret;
+
+	if (!acpi_ffh_ffa_length_valid(info->length))
+		goto out;
+
+	nr_payload = info->length / sizeof(u64) - ACPI_FFH_FFA_HDR_REGS;
+
+	acpi_ffh_ffa_uuid(&uuid, (u8 *)value + ACPI_FFH_FFA_UUID_OFFSET);
+
+	down_read(&ffa_ops_sem);
+	if (!ffa_ops) {
+		status = ACPI_FFH_FFA_NOT_SUPPORTED;
+		goto out_unlock;
+	}
+
+	/*
+	 * A zero receiver endpoint ID means ACPI platform firmware expects
+	 * OSPM to derive it from the service UUID.
+	 */
+	dst_id = regs[1] & GENMASK(15, 0);
+	if (!dst_id) {
+		/*
+		 * A null UUID means "every partition" to
+		 * FFA_PARTITION_INFO_GET, so reject it here rather than let a
+		 * bare read of the Operation Region, which arrives as a zeroed
+		 * buffer, resolve to an arbitrary endpoint.
+		 */
+		if (uuid_is_null(&uuid))
+			goto out_unlock;
+
+		ret = ffa_ops->partition_id(&uuid, &dst_id);
+		if (ret) {
+			status = acpi_ffh_ffa_status(ret);
+			goto out_unlock;
+		}
+	}
+
+	ret = ffa_ops->direct_req2(dst_id, &uuid, regs + ACPI_FFH_FFA_HDR_REGS,
+				   nr_payload, resp_regs);
+	status = acpi_ffh_ffa_status(ret);
+
+	/*
+	 * DEN0048D asks for the response registers to be copied back. That also
+	 * takes care of table 3: FFA_ERROR reports the FF-A error code in X2,
+	 * which is exactly where FFH_FFA_CALL_FAILED wants it. -EIO and -EPROTO
+	 * both mean the call completed, so the registers hold the callee's
+	 * response and not AML's own request.
+	 */
+	if (!ret || ret == -EIO || ret == -EPROTO) {
+		regs[1] = resp_regs[0];
+		regs[2] = resp_regs[1];
+		regs[3] = resp_regs[2];
+	}
+
+out_unlock:
+	up_read(&ffa_ops_sem);
+out:
+	/*
+	 * DEN0048D describes this field as 64 bits wide and gives the table 3
+	 * codes as signed values, so sign extend rather than write a narrower
+	 * quantity. 0xfffe or 0xfffffffe would read back as a positive number
+	 * in a 64-bit AML comparison.
+	 */
+	regs[0] = (u64)(s64)status;
+}
+
 int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_context)
 {
 	int ret = 0;
@@ -99,6 +278,12 @@ int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_contex
 			ffh_ctxt->invoke_ffh64_fn(r, r);
 			memcpy(value, r, ffh_ctxt->info.length);
 		}
+	} else if (ffh_ctxt->info.offset == 2) {
+		/* FFA_MSG_SEND_DIRECT_REQ2 call */
+		if (ffh_ctxt->info.length < sizeof(u64))
+			ret = AE_ERROR;
+		else
+			acpi_ffh_ffa_handler(&ffh_ctxt->info, value);
 	} else {
 		ret = AE_ERROR;
 	}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index ddacac8120947..9f219a75cffe6 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1649,6 +1649,35 @@ void acpi_init_pcc(void);
 static inline void acpi_init_pcc(void) { }
 #endif
 
+/**
+ * struct acpi_ffh_ffa_ops - FF-A backend for the FFH Operation Region
+ * @partition_id: Resolve @uuid to a unique endpoint ID. Must fail with a
+ *		  negative errno if the UUID resolves to no endpoint or to
+ *		  more than one distinct endpoint.
+ * @direct_req2:  Issue FFA_MSG_SEND_DIRECT_REQ2 towards @dst_id using @uuid
+ *		  as the service UUID. @payload holds the X4-X17 registers
+ *		  taken from the Operation Region and is updated in place
+ *		  with the response payload; @nr_payload is the number of
+ *		  registers in use (1 to 14). @resp_regs is filled with the
+ *		  X1-X3 registers returned by the callee, and @payload with
+ *		  the response, whenever the call was actually made. Returns
+ *		  0 on success, -EIO if the callee returned FFA_ERROR,
+ *		  -EPROTO if it returned something unexpected, or another
+ *		  negative errno if the call could not be made at all. -EIO
+ *		  and -EPROTO both mean the registers hold the callee's
+ *		  response and must be copied back to AML.
+ *
+ * Backend for FFH Operation Regions declared with an Offset of 0x2, as
+ * described in Arm DEN0048D (Functional Fixed Hardware Specification v1.3)
+ * section 2.3.1.2. Registered by the FF-A driver, which may be a module,
+ * while the Operation Region handler itself is built in.
+ */
+struct acpi_ffh_ffa_ops {
+	int (*partition_id)(const uuid_t *uuid, u16 *dst_id);
+	int (*direct_req2)(u16 dst_id, const uuid_t *uuid, u64 *payload,
+			   unsigned int nr_payload, u64 resp_regs[3]);
+};
+
 #ifdef CONFIG_ACPI_FFH
 void acpi_init_ffh(void);
 extern int acpi_ffh_address_space_arch_setup(void *handler_ctxt,
@@ -1659,6 +1688,18 @@ extern int acpi_ffh_address_space_arch_handler(acpi_integer *value,
 static inline void acpi_init_ffh(void) { }
 #endif
 
+#if defined(CONFIG_ACPI_FFH) && defined(CONFIG_ARM64)
+int acpi_ffh_ffa_register(const struct acpi_ffh_ffa_ops *ops);
+void acpi_ffh_ffa_unregister(const struct acpi_ffh_ffa_ops *ops);
+#else
+static inline int acpi_ffh_ffa_register(const struct acpi_ffh_ffa_ops *ops)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void acpi_ffh_ffa_unregister(const struct acpi_ffh_ffa_ops *ops) { }
+#endif
+
 #ifdef CONFIG_ACPI
 extern void acpi_device_notify(struct device *dev);
 extern void acpi_device_notify_remove(struct device *dev);
-- 
2.43.0


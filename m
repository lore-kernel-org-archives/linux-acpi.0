Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011065.outbound.protection.outlook.com [52.101.52.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F98B4A2050;
	Tue,  1 Sep 2026 19:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290997; cv=fail; b=W3jigc4CxrnuUn1fRE2dnJ0iE9fAyTMDn2d0jDFmtGnORIOOsHGb1ul9ovkQiPZdesLziPBes2FgW8IrvOtR7aJLjTjYYm3yLWYKfGKknHm4QQr2Jup0xgA/hAeoekmBkyyFB4qq5+4v2O0hhTmRHa/hIX9TLz56n9GmtTTUN5U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290997; c=relaxed/simple;
	bh=0b3a6feinITLnwrW3IjPi8saqBFCARjvs+SjMAA/Rh0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekrqJxK+/lP4SOsywyw7YOtV4ZbvklYFM3AxDOKrV54LpJrkmztODomyYZa+E/cdwBdII7cHOHXM692ZnxJui1mNmmQAkc83MNY84neIZrDaQki6l5btdQl6inrq5hOIeqoS9ao2rkqlpBSuqUb0pBDYtSEwqG5EI2+qJxCeHPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ocdxzEjX; arc=fail smtp.client-ip=52.101.52.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ocdxzEjX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BYu3onTeUn8Qvhg5p1SKx747CV4yOT9uw8jWurPKS9wjBQ5QrkFSPYKDy4FtPJaswEo3YVZsU2Bg2bHgX2UBMn3+1mhxyIyz8JPx1XVxhbgtzJl3a4pA3kFIR1tdNnQSiCgLoAHvO7BqDeCPWKd1uDdq9Q5FvUVqE88nJE7+vNv9IpGI30TnYeQUZ06hOFmy6ReQ9s+Kuky3ahqNBRplKWJmFWNrwTGesB9E3suJGPTT/0Wbs/82jqDGuwViKk7Ce91/35uXq1dTMD8zNJea8knwkd2zcMOUm7cOuHct5cBXNJ/9Mm1pb3xZGExSx3lhfCzyOYIHHIjmC/kYY4gB+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzl1fegg651C+BGn+9BpVpBQrZWJ8dZP9YkF2EBwbPE=;
 b=ZkIDs3xj0jMIyFeFBJ8rjuhSfIzeGE8msaGlnNZ4gPhOa53yIhg/NLMBqGIn4oORcUnEvSnJ1zmHY9Kh/eGV61m75XPvI+EkpwcxhFVM8W0JdPRnF55wUEmFAMDZtdjX3hJ9Lz31ZmSEQ1TDqvhGnokk9MF0ss6pKBmJvy4GtQohfHKOI7YhWSiVCLOP1E0EZYM0q1sxSGD8xFRv6+1dnMmzLlqCLxu00ZLzHOG4j/bKvhYEM823xJON0Rf6E9UN/hekMJnpzvV6sQ6dTPlSg2eBqQjoRyDAwv7tHbDGiQCNwCxpfzxIuRx6cO63vrQujnV6I5H3pA5Wfyb6XwddNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzl1fegg651C+BGn+9BpVpBQrZWJ8dZP9YkF2EBwbPE=;
 b=ocdxzEjXSU9E6E7FuXfPxqjLvu/FEanrVc9aDEOvuQs82jDu1r2qLsJiCAxgf7PgdCuiSDtQKSAMvo4lEAD1cyycmMnBpSkM59Rn0Tg78OfBcQOP5l3EDIU/Eiu+RKvPimISpxeiDJkrg5XAiCxFPYZjoWBpwopBlHqIqCoXfZ7n9QyIpfvLMyDp49lj187wED8/MPFdOaP5K6pdW71xCBxCvKExUOg/V0yPWr1WLs7LOReeduoopjX8tVaa6PAnVCGCyd9sRjQ6HR29F9x7eHF8cQS5Swg1bktlda5l93vmaxyrf0U9t+qHpX4+AycVaR7r0sw7DIgxB24nd/2uNQ==
Received: from PH7P221CA0006.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:32a::19)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 19:29:47 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:510:32a:cafe::8c) by PH7P221CA0006.outlook.office365.com
 (2603:10b6:510:32a::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Tue, 1
 Sep 2026 19:29:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Tue, 1 Sep 2026 19:29:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 12:29:15 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 1 Sep
 2026 12:29:14 -0700
Received: from dgx-1v-42.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46 via Frontend
 Transport; Tue, 1 Sep 2026 12:29:14 -0700
From: Jamie Nguyen <jamien@nvidia.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo
	<guohanjun@huawei.com>, Sudeep Holla <sudeep.holla@kernel.org>, "Catalin
 Marinas" <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, "Rafael J
 . Wysocki" <rafael@kernel.org>
CC: Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	<linux-acpi@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, Jamie Nguyen <jamien@nvidia.com>
Subject: [PATCH v2 2/3] ACPI: arm64: Add support for the FF-A FFH Operation Region (offset 2)
Date: Tue, 1 Sep 2026 12:29:05 -0700
Message-ID: <20260901192906.133670-3-jamien@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: 753f2201-0060-4578-cadc-08df085f60de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|23010399003|36860700016|6133799003|3023799007|10067099003|56012099006|5023799004|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	/3I9U2+X8Lf0hDwPGBZgexHP9JEckmUYjUSk8PjZXcllS+ugoRNHq2KLyQbX4nAi7fHlt87I/mlQcidnfwXI29FpLJwJDHrCoiIcu2oF0RA+S53W1h6B2uhcGRoiIDgReM8X2+lRDKwTa03C/6bJUFcsT4qgrItD0lUMSRN734T8Oi57E/8pIa/MS1koQ2a0Ri9ulj4EomP5j9RmkmJSj1rKJT+WNOiq1byIlcJhFIEYe6WRV8i3AU96MZgdEmiMj6SEB5IBm+UTxSatevB2CtQq89S7VjiRR7MrubmS0sCq7tUhdoKSNAMYg4/wSwru2SvMM/Vez9jzHSGTB9AYHrM5nWM158ii7y7WRoQGb305As8Cfh6Vidlr9LuiFcOsj110Vv3uHgNOnEfg0Sq2hyfg+PiXqMjmlSZqvMkk5sxyWm3VHAydmp7/xBynr7UFKImKVOWaxZfF4vXPq0uRZU6vDEdpzGN9RensmAZaGiXIC0ZbXbA41VMmtByxqMYNJrDOA73vS7XyE8AhjZK3GQpDpfXHcN7d5GgkGEX/YcsuV9uxfY8b0lmHAekvUoSrRt6pM/Tb3/P2Ss3RF2eyECOxSlu3wbjvF7b21eGjByAN2qyBZqO+jaVkosplnFX+VaLyESFtFzumqCeaF4gwdcG7EzhWu0mx+TJQP0FVIZLK3tjVKpTv7WwGijSdzS9TcPT/1po++19xYOLmMGLR1A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(23010399003)(36860700016)(6133799003)(3023799007)(10067099003)(56012099006)(5023799004)(22082099003)(18002099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	CQgNuzdlX+/g5G157tlbHjBEG3kEWfAr56PmohFMxQtr5LNaHYajlGGgB4hwRe5/o6SnJBqetHvQ8KHImqe1DHI93ZVWBT1OJmxRAtn/uvTM6ErZ8JnsvV3IyIm0SqhItu5n5/1Nfoovsg1OKZq4ASRdhPe7xm45dcWq5i331qkLBpMr4mzGzWCOVPGCMbPDefqqdfi6813JGXlijvLLYbYazMzPt5ZMrrx4Nuo5Ujfc9DDfGvWTglMS8xvIZbeLxintDIXUH8DD84911O+EvXF0/7zedmq7EGMGYdTdRyJ34nbo0Z68m77CPlt7ahwoHKhRK/PbGHwsKJO8ahD1tHR7xlAYpTXuDRTLpvtTQhM6ZExNiOdT3owQIGHhz7eqsgIuBOc/o3T1yGTAZRiR8vuP14gh1eOPkp55zmsnwAsoZYhFzGhogzAljrUDl39J
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 19:29:44.9306
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 753f2201-0060-4578-cadc-08df085f60de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

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

Assisted-by: Claude:claude-opus-5
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


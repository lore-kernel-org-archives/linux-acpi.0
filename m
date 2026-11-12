Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482070;
	b=3UNItUUoGCI8dNsMDY2omdJhHss8bSAlZtwZJq6hOgQRJIEdiNtNl616KGDsB/1UoJid
	 mhT6/VpiaF/HOijZUGWblU67hA/jjqv49DRfOImSsUutqpGxm1Bnm5WxZ1UZa3lPv9zrl
	 YFTaodipArQXBfGLvJmhYu7J+yUVoRfQln6grTg8HH4iWuJxS9oJXKViJp8AnySeLhlpW
	 IFR9rgkmFRZ7vJmpAGfYJgocCdT4YJ3xAM1GPNkkiiWvPUyIRBJHM73Sg6SzH2WLLxyBD
	 zpPcAG7LKoh/yiDX3xhX18uid9zawlgSRr4Rjd0jb381Ncx265QXOjuKsJpL2EEfWYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482070;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=oHLESe3h+Hl0fvYPNJEst+wVARKEJnOl/p9IddcU5sU=;
	b=olhucGn9zCt4tApboZKa8F6cPLYwuQGigupRHRpTo/PlNpxhsc/cfusvLnXqEs+ptis+
	 hcIjA28A/Jix3uytqBLKkYTLMtRZ8vak2QnezCfCz9Pe9R3mGRI/oP144dv4/x3MgyCSh
	 jDVCr7js9m/212H+2xtzZN/HubxiMJsyvJsuTYaNOFfH1NijGeZH7b3wJKBgcFGYPat4m
	 deqKPA7yNw12PWj6pwrxQEpMgVNdLxEm9MgHiI0qRmZ1ecOkoBU28fKv6OPHLQa+scPYI
	 L5gl3lRtY/QLyrUt+kGwiawIhr/dc3CFWNCIBKW7cxV7Ec6IsqB9tgVmD6RoFGAGeNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="e/HFL7qs";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65322606A321
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 11:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e/HFL7qs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEE041F00A07;
	Thu, 12 Nov 2026 11:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482070;
	bh=oHLESe3h+Hl0fvYPNJEst+wVARKEJnOl/p9IddcU5sU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e/HFL7qsI2hY8ATut6Sat24X4iqrDFOYNRDjmti84zjG8PQClxYYlxvNEJrwFqYil
	 b8T7lnQF9FPukcY1tDcO0KOTBjGV2B+0Jk7lTyWr3+0oOOXfgLJ5K/qw5NshEwbLVT
	 kW6Yx2YhK2+iQ+G9h63GAD1gylKS1cAbVFVrxT6rzFvihky3J0NX0tYxOyOX0RS8gv
	 Aj18h6S5olpdOuveh4HMUBAR8gxfWUBf4Jnz2ECvrZxq7hYak1QUSWAQ1/mPfhuVTA
	 KOCdTSKa+iKNbMko63aYBcW4GGhF855e4iL9LLv2h74pwI/DZPazR8zxeJbVKV4bHV
	 mockRzc5hw54g==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Thu, 12 Nov 2026 11:14:07 +0000
Subject: [PATCH v2 2/3] ACPI: FFH: Support FF-A direct request 2 calls
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-acpi_ffh_ffa-v2-2-575a9dbed22b@kernel.org>
References: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
In-Reply-To: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dat Mach <dmach@nvidia.com>
X-Mailer: b4 0.16.0

Arm Functional Fixed Hardware specification v1.3 defines FFH
OperationRegion offset 2 for issuing FFA_MSG_SEND_DIRECT_REQ2 calls.
The arm64 FFH handler currently supports only generic 32-bit and 64-bit
SMCCC calls, so it cannot implement this standardized interface.

Add a standalone FF-A path using the existing SMCCC conduit. Negotiate
FF-A v1.2, discover the sender endpoint with FFA_ID_GET, and use either
the receiver supplied by firmware or resolve a unique receiver from the
service UUID with FFA_PARTITION_INFO_GET_REGS.

Convert the ACPI ToUUID representation to the FF-A register encoding,
construct the direct request, resume interrupted or yielded calls with
FFA_RUN, and return the defined FFH status codes to AML.

Register-based partition discovery avoids RX/TX buffer ownership and
keeps the FFH implementation independent of the Arm FF-A transport
driver.

Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/acpi/arm64/ffh.c | 223 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/drivers/acpi/arm64/ffh.c b/drivers/acpi/arm64/ffh.c
index 04380bab193d..7f13a6d2473a 100644
--- a/drivers/acpi/arm64/ffh.c
+++ b/drivers/acpi/arm64/ffh.c
@@ -1,7 +1,23 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/acpi.h>
+#include <linux/arm_ffa.h>
 #include <linux/arm-smccc.h>
+#include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#define FFH_FFA_CALL_FAILED		1
+#define FFH_FFA_SUCCESS			0
+#define FFH_FFA_NOT_SUPPORTED		-1
+#define FFH_FFA_INVALID_PARAMETERS	-2
+#define FFH_FFA_OUT_OF_MEMORY		-3
+#define FFH_FFA_UNSPECIFIED_ERROR	-4
+
+#define FFH_FFA_MIN_LEN			(5 * sizeof(u64))
+#define FFH_FFA_MAX_LEN			(18 * sizeof(u64))
+#define FFH_FFA_UUID_OFFSET		(2 * sizeof(u64))
 
 /*
  * Implements ARM64 specific callbacks to support ACPI FFH Operation Region as
@@ -19,6 +35,211 @@ struct acpi_ffh_data {
 				struct arm_smccc_1_2_regs *res);
 };
 
+static DEFINE_MUTEX(acpi_ffh_ffa_lock);
+static bool acpi_ffh_ffa_initialized, acpi_ffh_ffa_partition_info_regs;
+static u16 acpi_ffh_ffa_sender_id;
+
+static void acpi_ffh_ffa_invoke(struct acpi_ffh_data *ffh_ctxt,
+				const struct arm_smccc_1_2_regs *args,
+				struct arm_smccc_1_2_regs *res)
+{
+	ffh_ctxt->invoke_ffh64_fn(args, res);
+}
+
+static int acpi_ffh_ffa_features(struct acpi_ffh_data *ffh_ctxt, u32 fid)
+{
+	struct arm_smccc_1_2_regs args = {
+		.a0 = FFA_FEATURES,
+		.a1 = fid,
+	};
+	struct arm_smccc_1_2_regs res;
+
+	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
+	if (res.a0 == FFA_ERROR) {
+		if ((s32)res.a2 == FFA_RET_NOT_SUPPORTED)
+			return -EOPNOTSUPP;
+		return -EINVAL;
+	}
+
+	return res.a0 == FFA_SUCCESS ? 0 : -EIO;
+}
+
+static int acpi_ffh_ffa_init(struct acpi_ffh_data *ffh_ctxt)
+{
+	struct arm_smccc_1_2_regs args = { }, res;
+	u32 version;
+	int ret = 0;
+
+	guard(mutex)(&acpi_ffh_ffa_lock);
+	if (acpi_ffh_ffa_initialized)
+		return 0;
+
+	args.a0 = FFA_VERSION;
+	args.a1 = FFA_VERSION_1_2;
+	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
+	version = res.a0;
+	if ((s32)version == SMCCC_RET_NOT_SUPPORTED ||
+	    FFA_MAJOR_VERSION(version) != 1 || version < FFA_VERSION_1_2) {
+		ret = -EOPNOTSUPP;
+		return ret;
+	}
+
+	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_MSG_SEND_DIRECT_REQ2);
+	if (ret)
+		return ret;
+
+	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_MSG_SEND_DIRECT_RESP2);
+	if (ret)
+		return ret;
+
+	acpi_ffh_ffa_partition_info_regs =
+		!acpi_ffh_ffa_features(ffh_ctxt, FFA_PARTITION_INFO_GET_REGS);
+
+	args = (struct arm_smccc_1_2_regs) { .a0 = FFA_ID_GET };
+	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
+	if (res.a0 == FFA_ERROR) {
+		ret = (s32)res.a2 == FFA_RET_NOT_SUPPORTED ? -EOPNOTSUPP : -EIO;
+		return ret;
+	}
+	if (res.a0 != FFA_SUCCESS) {
+		ret = -EIO;
+		return ret;
+	}
+
+	acpi_ffh_ffa_sender_id = (u16)res.a2;
+	acpi_ffh_ffa_initialized = true;
+	return ret;
+}
+
+static void acpi_ffh_ffa_uuid_convert(const u8 *guid, u8 *uuid)
+{
+	/* ACPI ToUUID uses GUID byte order while FF-A uses UUID byte order. */
+	uuid[0] = guid[3];
+	uuid[1] = guid[2];
+	uuid[2] = guid[1];
+	uuid[3] = guid[0];
+	uuid[4] = guid[5];
+	uuid[5] = guid[4];
+	uuid[6] = guid[7];
+	uuid[7] = guid[6];
+	memcpy(uuid + 8, guid + 8, UUID_SIZE - 8);
+}
+
+static int acpi_ffh_ffa_receiver_id(struct acpi_ffh_data *ffh_ctxt,
+				    u64 uuid_lo, u64 uuid_hi, u16 *receiver_id)
+{
+	struct arm_smccc_1_2_regs args = {
+		.a0 = FFA_PARTITION_INFO_GET_REGS,
+		.a1 = uuid_lo,
+		.a2 = uuid_hi,
+	};
+	struct arm_smccc_1_2_regs res;
+	u32 properties;
+
+	if (!acpi_ffh_ffa_partition_info_regs)
+		return -EOPNOTSUPP;
+
+	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
+	if (res.a0 != FFA_FN64_SUCCESS)
+		return -EINVAL;
+
+	if (FIELD_GET(FFA_PART_INFO_LAST_IDX_MASK, res.a2) ||
+	    FIELD_GET(FFA_PART_INFO_CUR_IDX_MASK, res.a2) ||
+	    FIELD_GET(FFA_PART_INFO_DESC_SIZE_MASK, res.a2) <
+		    FFA_PART_INFO_MIN_DESC_SIZE)
+		return -EINVAL;
+
+	properties = FIELD_GET(FFA_PART_INFO_PROPS_MASK, res.a3);
+	if (!(properties & FFA_PARTITION_DIRECT_REQ2_RECV))
+		return -EINVAL;
+
+	*receiver_id = FIELD_GET(FFA_PART_INFO_ID_MASK, res.a3);
+	return 0;
+}
+
+static int acpi_ffh_ffa_status(int error)
+{
+	switch (error) {
+	case -EOPNOTSUPP:
+		return FFH_FFA_NOT_SUPPORTED;
+	case -EINVAL:
+		return FFH_FFA_INVALID_PARAMETERS;
+	case -ENOMEM:
+		return FFH_FFA_OUT_OF_MEMORY;
+	default:
+		return FFH_FFA_UNSPECIFIED_ERROR;
+	}
+}
+
+static int acpi_ffh_ffa_direct_req2(acpi_integer *value,
+				    struct acpi_ffh_data *ffh_ctxt)
+{
+	struct arm_smccc_1_2_regs args = { }, res;
+	u64 *buf = (u64 *)value;
+	u64 uuid_lo, uuid_hi;
+	u16 receiver_id = (u16)buf[1];
+	uuid_t uuid;
+	size_t len = ffh_ctxt->info.length;
+	int ret;
+
+	if (len < FFH_FFA_MIN_LEN || len > FFH_FFA_MAX_LEN ||
+	    !IS_ALIGNED(len - 4 * sizeof(u64), sizeof(u64))) {
+		buf[0] = FFH_FFA_INVALID_PARAMETERS;
+		return AE_OK;
+	}
+
+	acpi_ffh_ffa_uuid_convert((u8 *)value + FFH_FFA_UUID_OFFSET, uuid.b);
+	if (uuid_is_null(&uuid)) {
+		buf[0] = FFH_FFA_INVALID_PARAMETERS;
+		return AE_OK;
+	}
+
+	ret = acpi_ffh_ffa_init(ffh_ctxt);
+	if (ret) {
+		buf[0] = acpi_ffh_ffa_status(ret);
+		return AE_OK;
+	}
+
+	uuid_lo = get_unaligned_le64(uuid.b);
+	uuid_hi = get_unaligned_le64(uuid.b + sizeof(uuid_lo));
+	if (!receiver_id) {
+		ret = acpi_ffh_ffa_receiver_id(ffh_ctxt, uuid_lo, uuid_hi,
+					       &receiver_id);
+		if (ret) {
+			buf[0] = FFH_FFA_INVALID_PARAMETERS;
+			return AE_OK;
+		}
+	}
+
+	args.a0 = FFA_MSG_SEND_DIRECT_REQ2;
+	args.a1 = ffa_pack_target_info(acpi_ffh_ffa_sender_id, receiver_id);
+	args.a2 = uuid_lo;
+	args.a3 = uuid_hi;
+	memcpy((void *)&args + offsetof(struct arm_smccc_1_2_regs, a4),
+	       &buf[4], len - 4 * sizeof(u64));
+
+	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
+	while (res.a0 == FFA_INTERRUPT || res.a0 == FFA_YIELD) {
+		if (res.a0 == FFA_YIELD)
+			fsleep(1000);
+
+		args = (struct arm_smccc_1_2_regs) {
+			.a0 = FFA_RUN,
+			.a1 = res.a1,
+		};
+		acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
+	}
+
+	memcpy(buf, &res, len);
+	if (res.a0 == FFA_MSG_SEND_DIRECT_RESP2 || res.a0 == FFA_SUCCESS ||
+	    res.a0 == FFA_FN64_SUCCESS)
+		buf[0] = FFH_FFA_SUCCESS;
+	else
+		buf[0] = FFH_FFA_CALL_FAILED;
+
+	return AE_OK;
+}
+
 int acpi_ffh_address_space_arch_setup(void *handler_ctxt, void **region_ctxt)
 {
 	enum arm_smccc_conduit conduit;
@@ -99,6 +320,8 @@ int acpi_ffh_address_space_arch_handler(acpi_integer *value, void *region_contex
 			ffh_ctxt->invoke_ffh64_fn(r, r);
 			memcpy(value, r, ffh_ctxt->info.length);
 		}
+	} else if (ffh_ctxt->info.offset == 2) {
+		ret = acpi_ffh_ffa_direct_req2(value, ffh_ctxt);
 	} else {
 		ret = AE_ERROR;
 	}

-- 
2.43.0


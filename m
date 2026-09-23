Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3A5372CB;
	Wed, 23 Sep 2026 13:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790170715; cv=none; b=V/GGSx6OF2fYC0iYWOn1E5BKCOKxQRwuRTHRpry+XVTTN3axaEiiFkY2sr/AkTRB5wn0k6SbGa/5w56sm026teGiXZ/WA4kG/CEw9RWyos/CMalegG6rcpI35Rmq4aq78eCLH+s+Pc9YRmnO+fbHJF5TMrLg4rpmuEc2on7vuUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790170715; c=relaxed/simple;
	bh=B6TPetXpKIA1bPnjsnIYvTQzYODjevTRgdmD3p7TBoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G8EZ024KKyfiboRnnBw/Xm1+v/ghRrf+vS7b+va4xftozi6hSv6forXTg+af9x7DgsndoZI5+zE8nP6nrkUO/pMBmA1D5biem/Y+U1FN1Ggormnr3oD9kLieBa+VjJpBoH0/EmpbxlVt+QK9+If8VLMA0KJrQePq0DLECfJHMnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDfWgxmG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDfWgxmG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC3341F000FF;
	Wed, 23 Sep 2026 13:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790170712;
	bh=2eBWzI7VPUFs8yCmGHFvajc1MZpzWqlyBbNSEn1wc6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LDfWgxmG08NMk6mX+TnuTugD//AmOv1glMGqxruf93nW0Xv2UXrCdLuxwx4KoiqiO
	 6AMspdlE7IMzk0XBa4Rfk9Pv7myPX5i+xLsdUwvZuka78K7fYbbzZ2i3sFeoXlEYuA
	 LNsq60AErGypaRJmgP+VUt7tPfNFORr7qAtwmGJPZVTpGlQaCudXNvT6U1GALLaact
	 Vv0x2mukYzj2MEIPSbY0CUMQQE4wcGPzFKLdsaDdF3h7bm4UTYE7asUTKSdKel3d4A
	 N8URosKILYHl0DcftPfF5PTKr0fZqbjTnD9yGI0naHNj2NM+Hbww+oKPUCVFnRY49t
	 1jm4OLg8vkN7w==
Date: Wed, 23 Sep 2026 14:38:28 +0100
From: Sudeep Holla <sudeep.holla@kernel.org>
To: Jamie Nguyen <jamien@nvidia.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Dat Mach <dmach@nvidia.com>,
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] ACPI: arm64: FFH Operation Region support for
 FF-A (offset 2)
Message-ID: <20260923-lurking-pony-of-fascination-ac6c49@sudeepholla>
References: <20260901192906.133670-1-jamien@nvidia.com>
 <20260922-purring-fennec-of-exercise-bbce5e@sudeepholla>
 <20260922155211.676134-1-jamien@nvidia.com>
 <20260922-exuberant-earwig-of-opportunity-4fecff@sudeepholla>
 <20260923124050.3270801-1-jamien@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923124050.3270801-1-jamien@nvidia.com>

On Wed, Sep 23, 2026 at 05:40:50AM -0700, Jamie Nguyen wrote:
> On Tue, Sep 22, 2026 at 07:06:02PM +0100, Sudeep Holla wrote:
> > Equally ugly. FF-A spec doesn't talk about ACPI FFH, so it doesn't
> > belong in FF-A driver.
> 
> Okay -- I'll move the ACPI-specific handling into ffh.c.
> 
> > So if on a platform, ASL has FFH with offset 2, we fail if FF-A driver
> > fails to initialise ? What if this FFH offset 2 is used in some other
> > device methods that need to be executed before FF-A module is inserted ?
> > We pull that device down as well ? Is that acceptable ?
> 
> You're right. With the current registration, offset 2 may be unavailable
> during initial enumeration or before module load. That's not suitable for
> AML.
> 
> > There is no state management with simple FFA_MSG_SEND_DIRECT_REQ2, it is
> > synchronous send request if you look at it along wih offset 0/1 and
> > without FF-A driver knowledge.
> 
> The request itself is synchronous and register-only. But the whole operation
> still shares FF-A state: version negotiation must be coordinated with other
> FF-A use, and X1 == 0 needs UUID lookup. It looks like
> FFA_PARTITION_INFO_GET_REGS is optional at the Non-secure physical instance
> according to DEN0077A Table 13.1. As such, I believe a portable
> implementation would need the shared RX/TX buffers. For example, if X1 is
> zero and that ABI is unavailable, UUID lookup would need to fall back to
> FFA_PARTITION_INFO_GET, whose results are returned through the caller's RX
> buffer.

I did try to come up something simpler and independent last evening and
this morning, far from completion and I am also thinking of 2 main changes
to it yet:
1. Maintain hash for receiver ID list
2. Drop the whole FFA_VERSION fuss as it must be dealt with in UEFI and
   that should be sufficient.

Of course not tested yet and even not sure this version is compile tested.
Also more checks needs to added like INFO_GET_REGS is used without check.

Regards,
Sudeep

-->8

From a78e71fe5a759687fbc205b817033f1a381b8c5e Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Wed, 23 Sep 2026 13:18:37 +0100
Subject: [PATCH 1/2] firmware: arm_ffa: Share FF-A register field definitions

ACPI FFH and the FF-A transport driver will be interpreting the same
PARTITION_INFO_GET_REGS metadata and pack endpoint IDs using the same
bit fields. Define these fields once in arm_ffa.h instead of keeping
private copies.

Use the shared masks in the transport driver and check descriptor
lengths against the same minimum used by ACPI FFH. This keeps the ABI
encoding consistent between the two users.

Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 48 +++++++++++--------------------
 include/linux/arm_ffa.h           | 19 ++++++++++++
 2 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
index 69d5f754dce4..05306ea484df 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -55,13 +55,6 @@
 #define FFA_MIN_VERSION		FFA_VERSION_1_0
 #define FFA_PLATFORM_NAME	"arm-ffa"
 
-#define SENDER_ID_MASK		GENMASK(31, 16)
-#define RECEIVER_ID_MASK	GENMASK(15, 0)
-#define SENDER_ID(x)		((u16)(FIELD_GET(SENDER_ID_MASK, (x))))
-#define RECEIVER_ID(x)		((u16)(FIELD_GET(RECEIVER_ID_MASK, (x))))
-#define PACK_TARGET_INFO(s, r)		\
-	(FIELD_PREP(SENDER_ID_MASK, (s)) | FIELD_PREP(RECEIVER_ID_MASK, (r)))
-
 #define RXTX_MAP_MIN_BUFSZ_MASK	GENMASK(1, 0)
 #define RXTX_MAP_MAX_BUFSZ_MASK	GENMASK(31, 16)
 #define RXTX_MAP_MIN_BUFSZ(x)	(FIELD_GET(RXTX_MAP_MIN_BUFSZ_MASK, (x)))
@@ -328,24 +321,16 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 	return count;
 }
 
-#define LAST_INDEX_MASK		GENMASK(15, 0)
-#define CURRENT_INDEX_MASK	GENMASK(31, 16)
-#define UUID_INFO_TAG_MASK	GENMASK(47, 32)
-#define PARTITION_INFO_SZ_MASK	GENMASK(63, 48)
-#define PARTITION_COUNT(x)	((u16)(FIELD_GET(LAST_INDEX_MASK, (x))) + 1)
-#define CURRENT_INDEX(x)	((u16)(FIELD_GET(CURRENT_INDEX_MASK, (x))))
-#define UUID_INFO_TAG(x)	((u16)(FIELD_GET(UUID_INFO_TAG_MASK, (x))))
-#define PARTITION_INFO_SZ(x)	((u16)(FIELD_GET(PARTITION_INFO_SZ_MASK, (x))))
-#define PART_INFO_ID_MASK	GENMASK(15, 0)
-#define PART_INFO_EXEC_CXT_MASK	GENMASK(31, 16)
-#define PART_INFO_PROPS_MASK	GENMASK(63, 32)
+#define PARTITION_COUNT(x)	((u16)(FIELD_GET(FFA_PART_INFO_LAST_IDX_MASK, (x))) + 1)
+#define CURRENT_INDEX(x)	((u16)(FIELD_GET(FFA_PART_INFO_CUR_IDX_MASK, (x))))
+#define UUID_INFO_TAG(x)	((u16)(FIELD_GET(FFA_PART_INFO_UUID_TAG_MASK, (x))))
+#define PARTITION_INFO_SZ(x)	((u16)(FIELD_GET(FFA_PART_INFO_DESC_SIZE_MASK, (x))))
 #define FFA_PART_INFO_GET_REGS_FIRST_REG	3
-#define FFA_PART_INFO_GET_REGS_MIN_REGS_PER_DESC	3
 #define FFA_PART_INFO_GET_REGS_NUM_REGS \
 	(sizeof(ffa_value_t) / sizeof_field(ffa_value_t, a0))
-#define PART_INFO_ID(x)		((u16)(FIELD_GET(PART_INFO_ID_MASK, (x))))
-#define PART_INFO_EXEC_CXT(x)	((u16)(FIELD_GET(PART_INFO_EXEC_CXT_MASK, (x))))
-#define PART_INFO_PROPERTIES(x)	((u32)(FIELD_GET(PART_INFO_PROPS_MASK, (x))))
+#define PART_INFO_ID(x)		((u16)(FIELD_GET(FFA_PART_INFO_ID_MASK, (x))))
+#define PART_INFO_EXEC_CXT(x)	((u16)(FIELD_GET(FFA_PART_INFO_EXEC_CXT_MASK, (x))))
+#define PART_INFO_PROPERTIES(x)	((u32)(FIELD_GET(FFA_PART_INFO_PROPS_MASK, (x))))
 static int
 __ffa_partition_info_get_regs(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 			      struct ffa_partition_info *buffer, int num_parts)
@@ -383,9 +368,9 @@ __ffa_partition_info_get_regs(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 		if (buf_sz % sizeof(*regs))
 			return -EINVAL;
 
-		regs_per_desc = buf_sz / sizeof(*regs);
-		if (regs_per_desc < FFA_PART_INFO_GET_REGS_MIN_REGS_PER_DESC)
+		if (buf_sz < FFA_PART_INFO_MIN_DESC_SIZE)
 			return -EINVAL;
+		regs_per_desc = buf_sz / sizeof(*regs);
 
 		nr_desc = cur_idx - start_idx + 1;
 		max_desc = (FFA_PART_INFO_GET_REGS_NUM_REGS -
@@ -501,7 +486,7 @@ static inline void ffa_msg_send_wait_for_completion(ffa_value_t *ret)
 static int ffa_msg_send_direct_req(u16 src_id, u16 dst_id, bool mode_32bit,
 				   struct ffa_send_direct_data *data)
 {
-	u32 req_id, resp_id, src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
+	u32 req_id, resp_id, src_dst_ids = ffa_pack_target_info(src_id, dst_id);
 	ffa_value_t ret;
 
 	if (mode_32bit) {
@@ -537,7 +522,7 @@ static int ffa_msg_send_direct_req(u16 src_id, u16 dst_id, bool mode_32bit,
 
 static int ffa_msg_send2(struct ffa_device *dev, u16 src_id, void *buf, size_t sz)
 {
-	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dev->vm_id);
+	u32 src_dst_ids = ffa_pack_target_info(src_id, dev->vm_id);
 	struct ffa_indirect_msg_hdr *msg;
 	ffa_value_t ret;
 	int retval = 0;
@@ -571,7 +556,7 @@ static int ffa_msg_send2(struct ffa_device *dev, u16 src_id, void *buf, size_t s
 static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 				    struct ffa_send_direct_data2 *data)
 {
-	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
+	u32 src_dst_ids = ffa_pack_target_info(src_id, dst_id);
 	union {
 		uuid_t uuid;
 		__le64 regs[2];
@@ -897,7 +882,7 @@ enum notify_type {
 #define RECEIVER_VCPU_MASK		GENMASK(31, 16)
 #define PACK_NOTIFICATION_GET_RECEIVER_INFO(vcpu_r, r) \
 	(FIELD_PREP(RECEIVER_VCPU_MASK, (vcpu_r)) | \
-	 FIELD_PREP(RECEIVER_ID_MASK, (r)))
+	 FIELD_PREP(FFA_TARGET_INFO_RECEIVER_MASK, (r)))
 
 #define NOTIFICATION_INFO_GET_MORE_PEND_MASK	BIT(0)
 #define NOTIFICATION_INFO_GET_ID_COUNT		GENMASK(11, 7)
@@ -928,7 +913,7 @@ static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
 {
 	ffa_value_t ret;
-	u32 func, src_dst_ids = PACK_TARGET_INFO(dst_id, drv_info->vm_id);
+	u32 func, src_dst_ids = ffa_pack_target_info(dst_id, drv_info->vm_id);
 
 	func = is_bind ? FFA_NOTIFICATION_BIND : FFA_NOTIFICATION_UNBIND;
 
@@ -950,7 +935,7 @@ static
 int ffa_notification_set(u16 src_id, u16 dst_id, u32 flags, u64 bitmap)
 {
 	ffa_value_t ret;
-	u32 src_dst_ids = PACK_TARGET_INFO(dst_id, src_id);
+	u32 src_dst_ids = ffa_pack_target_info(dst_id, src_id);
 
 	invoke_ffa_fn((ffa_value_t) {
 		  .a0 = FFA_NOTIFICATION_SET, .a1 = src_dst_ids, .a2 = flags,
@@ -1567,7 +1552,8 @@ static void handle_fwk_notif_callbacks(u32 bitmap)
 			return;
 		}
 
-		target = SENDER_ID(msg->send_recv_id);
+		target = FIELD_GET(FFA_TARGET_INFO_SENDER_MASK,
+				   msg->send_recv_id);
 		if (offset >= sizeof(*msg))
 			uuid_copy(&uuid, &msg->uuid);
 		else
diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
index e71d83ee0aef..3831fbe244c1 100644
--- a/include/linux/arm_ffa.h
+++ b/include/linux/arm_ffa.h
@@ -130,6 +130,15 @@
 #define FFA_FEAT_RXTX_MIN_SZ_16K	2
 #define FFA_FEAT_RXTX_MIN_SZ_MASK	GENMASK(1, 0)
 
+#define FFA_TARGET_INFO_SENDER_MASK	GENMASK(31, 16)
+#define FFA_TARGET_INFO_RECEIVER_MASK	GENMASK(15, 0)
+
+static inline u32 ffa_pack_target_info(u16 sender, u16 receiver)
+{
+	return FIELD_PREP(FFA_TARGET_INFO_SENDER_MASK, sender) |
+	       FIELD_PREP(FFA_TARGET_INFO_RECEIVER_MASK, receiver);
+}
+
 /* FFA Bus/Device/Driver related */
 struct ffa_device {
 	u32 id;
@@ -228,6 +237,16 @@ extern const struct bus_type ffa_bus_type;
 /* The FF-A 1.0 partition structure lacks the uuid[4] */
 #define FFA_1_0_PARTITON_INFO_SZ	(8)
 
+/* FFA_PARTITION_INFO_GET_REGS response fields */
+#define FFA_PART_INFO_LAST_IDX_MASK	GENMASK_ULL(15, 0)
+#define FFA_PART_INFO_CUR_IDX_MASK	GENMASK_ULL(31, 16)
+#define FFA_PART_INFO_UUID_TAG_MASK	GENMASK_ULL(47, 32)
+#define FFA_PART_INFO_DESC_SIZE_MASK	GENMASK_ULL(63, 48)
+#define FFA_PART_INFO_MIN_DESC_SIZE	24
+#define FFA_PART_INFO_ID_MASK		GENMASK_ULL(15, 0)
+#define FFA_PART_INFO_EXEC_CXT_MASK	GENMASK_ULL(31, 16)
+#define FFA_PART_INFO_PROPS_MASK		GENMASK_ULL(63, 32)
+
 /* FFA transport related */
 struct ffa_partition_info {
 	u16 id;
-- 
2.43.0


From 47807754d0d21003a37a6d30022317d8696e0daa Mon Sep 17 00:00:00 2001
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Tue, 22 Sep 2026 14:36:24 +0100
Subject: [PATCH 2/2][WIP] ACPI: FFH: Support FF-A direct request 2 calls

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
 drivers/acpi/arm64/ffh.c | 223 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 223 insertions(+)

diff --git a/drivers/acpi/arm64/ffh.c b/drivers/acpi/arm64/ffh.c
index 04380bab193d..6975f236b9b4 100644
--- a/drivers/acpi/arm64/ffh.c
+++ b/drivers/acpi/arm64/ffh.c
@@ -1,7 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/acpi.h>
+#include <linux/arm_ffa.h>
 #include <linux/arm-smccc.h>
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
@@ -19,6 +34,212 @@ struct acpi_ffh_data {
 				struct arm_smccc_1_2_regs *res);
 };
 
+static DEFINE_MUTEX(acpi_ffh_ffa_lock);
+static bool acpi_ffh_ffa_version_negotiated;
+static bool acpi_ffh_ffa_initialized;
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
+	mutex_lock(&acpi_ffh_ffa_lock);
+	if (acpi_ffh_ffa_initialized)
+		goto out;
+
+	if (!acpi_ffh_ffa_version_negotiated) {
+		args.a0 = FFA_VERSION;
+		args.a1 = FFA_VERSION_1_2;
+		acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
+		version = res.a0;
+		if ((s32)version == SMCCC_RET_NOT_SUPPORTED ||
+		    FFA_MAJOR_VERSION(version) != 1 ||
+		    version < FFA_VERSION_1_2) {
+			ret = -EOPNOTSUPP;
+			goto out;
+		}
+		acpi_ffh_ffa_version_negotiated = true;
+	}
+
+	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_MSG_SEND_DIRECT_REQ2);
+	if (ret)
+		goto out;
+
+	ret = acpi_ffh_ffa_features(ffh_ctxt, FFA_MSG_SEND_DIRECT_RESP2);
+	if (ret)
+		goto out;
+
+	args = (struct arm_smccc_1_2_regs) { .a0 = FFA_ID_GET };
+	acpi_ffh_ffa_invoke(ffh_ctxt, &args, &res);
+	if (res.a0 == FFA_ERROR) {
+		ret = (s32)res.a2 == FFA_RET_NOT_SUPPORTED ?
+		      -EOPNOTSUPP : -EIO;
+		goto out;
+	}
+	if (res.a0 != FFA_SUCCESS) {
+		ret = -EIO;
+		goto out;
+	}
+
+	acpi_ffh_ffa_sender_id = (u16)res.a2;
+	acpi_ffh_ffa_initialized = true;
+out:
+	mutex_unlock(&acpi_ffh_ffa_lock);
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
+	memcpy(&args.a4, &buf[4], len - 4 * sizeof(u64));
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


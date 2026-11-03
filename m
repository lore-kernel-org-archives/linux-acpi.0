Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793727561;
	b=pGB/WpEOSw1cyYHR6ZWTuHfrwyUE7vFvMs3C2TJ63T5uoJ8luSy1FQCeEmZY2nTQqIE0
	 za1/FP2LtlBOP8zwnpJUMrhmb0f8MGlho0QCylhrusKz++mqam95WrUv2Zyx25YqfwFY+
	 3Xq5UTLjEVnVDPYvNDtQ4CpiW4ZXuCuiKKsDgVLnhY86ZgP7CCX6ZaT/Qoy1iNzm+uWwt
	 OTexFPLpYnTumwmD63R9r5fej5+j1NN+HXGmn8YhqgP168k2+gxTGqeo02F/OIPZcLEG8
	 Uf46qDNLJ3wVgDT1OPHkQRb4v/0QBNN7ssFJsLSlZiGg1RUjc+I0tsqLLiGpVlVyT3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793727561;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WczHqXUJBDQkZnx7jmS64w/SIgD/rxh/pcaReuBDRzc=;
	b=BhQk+AA5grIyu7upjYcIFeynzZ+O4RPaCGhRNCtViUV5h14rEpBmDEE61SPtHuiO4Irv
	 2dvwUS237sl6jJLWdksclwI6nlqioLhjFRa3Y64y75XJ9qUgR7YR/4WUpvbC6zvpmsuXs
	 XtQJxgo+TaBjLT1xuR7sh8D7fZ63cCyPc4RuFj2JnlLN1K4sDx/4Q3tqOHvM90aOdI2op
	 YHXVdkFmd5VvewfGjg6WxZq277IvSV1LtHQy3CcDB/7ovrgDVyDuekPgZgFISapbwsijY
	 SPktUJhCnZzhIO0dXfXa2FnvgBBrJcEJQVz2PFniukaw7StwH/RLfYNxvjVUiby9Arg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFCBFM6U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF5B6606A33A
	for <linux-acpi@vger.kernel.org>; Tue,  3 Nov 2026 17:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KFCBFM6U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D14001F00A16;
	Tue,  3 Nov 2026 17:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793727560;
	bh=WczHqXUJBDQkZnx7jmS64w/SIgD/rxh/pcaReuBDRzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KFCBFM6UhOeoYoWIudd1p3yLoRUDhAwaLeyIoLQszPZYwv2wo6rNZAFv9fA6Jv/ct
	 A90k05Od6LzVOhhu+ltLnTdsH61+I0PhC/M683aVdC3rO1Iamj6yWF+UCDLQodZU4S
	 ZonXFqovlG/uuk5U6lotG0Heqfp6oJpAlHyZ45Yd3zDggF2brsRGJnMCVf7xckAs4S
	 Fq0jGGYd4U1mqQeJR+2NGtsvbWhJOsS3nJn8Szq0gpV5vLyHjBTbsPKCWhzcMibivL
	 iCZOj/VO28FQ54HUMaRT+5a7fPz1ZgdPQeCj3YVX14AixGOmQrGV0sGjB/L6N0kLbZ
	 RET83U73rdd9A==
From: Sudeep Holla <sudeep.holla@kernel.org>
To: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Jamie Nguyen <jamien@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Dat Mach <dmach@nvidia.com>
Subject: [PATCH 1/2] firmware: arm_ffa: Share FF-A register field definitions
Date: Tue,  3 Nov 2026 17:39:06 +0000
Message-ID: <20261103173907.1996118-2-sudeep.holla@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261103173907.1996118-1-sudeep.holla@kernel.org>
References: <20261103173907.1996118-1-sudeep.holla@kernel.org>
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

ACPI FFH and the FF-A transport driver interpret the same
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
index 28abc808fd32..babc5d62bdd2 100644
--- a/drivers/firmware/arm_ffa/driver.c
+++ b/drivers/firmware/arm_ffa/driver.c
@@ -52,13 +52,6 @@
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
@@ -320,24 +313,16 @@ __ffa_partition_info_get(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
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
@@ -375,9 +360,9 @@ __ffa_partition_info_get_regs(u32 uuid0, u32 uuid1, u32 uuid2, u32 uuid3,
 		if (buf_sz % sizeof(*regs))
 			return -EINVAL;
 
-		regs_per_desc = buf_sz / sizeof(*regs);
-		if (regs_per_desc < FFA_PART_INFO_GET_REGS_MIN_REGS_PER_DESC)
+		if (buf_sz < FFA_PART_INFO_MIN_DESC_SIZE)
 			return -EINVAL;
+		regs_per_desc = buf_sz / sizeof(*regs);
 
 		nr_desc = cur_idx - start_idx + 1;
 		max_desc = (FFA_PART_INFO_GET_REGS_NUM_REGS -
@@ -493,7 +478,7 @@ static inline void ffa_msg_send_wait_for_completion(ffa_value_t *ret)
 static int ffa_msg_send_direct_req(u16 src_id, u16 dst_id, bool mode_32bit,
 				   struct ffa_send_direct_data *data)
 {
-	u32 req_id, resp_id, src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
+	u32 req_id, resp_id, src_dst_ids = ffa_pack_target_info(src_id, dst_id);
 	ffa_value_t ret;
 
 	if (mode_32bit) {
@@ -529,7 +514,7 @@ static int ffa_msg_send_direct_req(u16 src_id, u16 dst_id, bool mode_32bit,
 
 static int ffa_msg_send2(struct ffa_device *dev, u16 src_id, void *buf, size_t sz)
 {
-	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dev->vm_id);
+	u32 src_dst_ids = ffa_pack_target_info(src_id, dev->vm_id);
 	struct ffa_indirect_msg_hdr *msg;
 	ffa_value_t ret;
 	int retval = 0;
@@ -563,7 +548,7 @@ static int ffa_msg_send2(struct ffa_device *dev, u16 src_id, void *buf, size_t s
 static int ffa_msg_send_direct_req2(u16 src_id, u16 dst_id, const uuid_t *uuid,
 				    struct ffa_send_direct_data2 *data)
 {
-	u32 src_dst_ids = PACK_TARGET_INFO(src_id, dst_id);
+	u32 src_dst_ids = ffa_pack_target_info(src_id, dst_id);
 	union {
 		uuid_t uuid;
 		__le64 regs[2];
@@ -889,7 +874,7 @@ enum notify_type {
 #define RECEIVER_VCPU_MASK		GENMASK(31, 16)
 #define PACK_NOTIFICATION_GET_RECEIVER_INFO(vcpu_r, r) \
 	(FIELD_PREP(RECEIVER_VCPU_MASK, (vcpu_r)) | \
-	 FIELD_PREP(RECEIVER_ID_MASK, (r)))
+	 FIELD_PREP(FFA_TARGET_INFO_RECEIVER_MASK, (r)))
 
 #define NOTIFICATION_INFO_GET_MORE_PEND_MASK	BIT(0)
 #define NOTIFICATION_INFO_GET_ID_COUNT		GENMASK(11, 7)
@@ -920,7 +905,7 @@ static int ffa_notification_bind_common(u16 dst_id, u64 bitmap,
 					u32 flags, bool is_bind)
 {
 	ffa_value_t ret;
-	u32 func, src_dst_ids = PACK_TARGET_INFO(dst_id, drv_info->vm_id);
+	u32 func, src_dst_ids = ffa_pack_target_info(dst_id, drv_info->vm_id);
 
 	func = is_bind ? FFA_NOTIFICATION_BIND : FFA_NOTIFICATION_UNBIND;
 
@@ -942,7 +927,7 @@ static
 int ffa_notification_set(u16 src_id, u16 dst_id, u32 flags, u64 bitmap)
 {
 	ffa_value_t ret;
-	u32 src_dst_ids = PACK_TARGET_INFO(dst_id, src_id);
+	u32 src_dst_ids = ffa_pack_target_info(dst_id, src_id);
 
 	invoke_ffa_fn((ffa_value_t) {
 		  .a0 = FFA_NOTIFICATION_SET, .a1 = src_dst_ids, .a2 = flags,
@@ -1542,7 +1527,8 @@ static void handle_fwk_notif_callbacks(u32 bitmap)
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


Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794482068;
	b=K0HU64cdRd2J4UVcWUJJabH/J3XIoi/ycCNj/qPI2KoiWYJ3RtFPhfI7QOg/51TDCSuL
	 84D9XweY0bqVJrQ9o9rPS74AsAKxGvwtmBVXVh0jNbGIxNfiZBgdF7nzWbn3zDxVlimvk
	 6zRcp+4Uemqmeezr8P8iPvjNzG5QEwRDFJNLusrJbzb5oNru3PJbsvKvFtLXs4C1FaigJ
	 dq5rbDTv7xRhgqW4fofBMiti7xgYNp7wtX+L1GmGWoJglLw2jEeL4BbuEKtGi/dSZ08pR
	 1YC0ZNaqFGrq0cjpIlDTIgtb6yTko7S/RPbNKVbPzQBQTK6NpLu+M26mx0CyZ6rBpgg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794482068;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=mFoIVQS/Xs1X1aU3Mq9zc6W40bj/X8sUP71p/Bn5zTI=;
	b=THOq9kIlVJlSu6fdoHjgu2QOCWvHMMN2PHpOg/6xPYNYlWW7zYoy2igFAfo3HOdi592f
	 CpCBCOUBI10CGXZqK43VQVFEdZIe+GdF3xeyIj4M1S3O04o75xY9aCjcn9Zt+/833ENOc
	 yAFTVFOwk9j255rwJqvaUWqYnlio+LOV8ureCknYiq+smY9aqMgzLupreDLOiDqYArOrC
	 moixl4d+C3O8rUzizEXdgc+dXFLwcZZXVsKHkXZFKNNlp8JFrU8w8Tx1U4JITCq1XXK3Z
	 ZTKwsaO+f/UYcj+l4zo+bqyj5UPbbAbd/whdXh58Jd1JfI+4DgzHqatoIfhFXCQ+4xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKAMbx0d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87BB606A323
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mKAMbx0d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D65C1F00A05;
	Thu, 12 Nov 2026 11:14:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794482068;
	bh=mFoIVQS/Xs1X1aU3Mq9zc6W40bj/X8sUP71p/Bn5zTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mKAMbx0dminjKbm/QElXvrXKoq1Qv0MQPL789DjhTIwA0TgVAG26Htu9YAHXpLuCe
	 ce5YsktNrLi9idvW6EV6NTQxpej4zjhM80HNDbynlkc40yKfrdGpNQGKDOMuTuIRcZ
	 iMW2bxePjqgOTUqHV2Y+vZJKbyYtNbsZriROhtVUHpRBLie8wG6za0n675W0+uHLvA
	 OzEara9217kAt0yMz9TOYtylevA7nYL667/NcVzMSCQt02nlvm8rDfh0lSCFOsEM4c
	 HWE23m0CuDu6gZOmsOuFvbzIeHGDJXISxr6ENlhJ61yp1lmXDiltDnmzVqkWLrhVpT
	 cJb3ycKBZPcJw==
From: Sudeep Holla <sudeep.holla@kernel.org>
Date: Thu, 12 Nov 2026 11:14:06 +0000
Subject: [PATCH v2 1/3] firmware: arm_ffa: Share FF-A register field
 definitions
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
Message-Id: <20261112-acpi_ffh_ffa-v2-1-575a9dbed22b@kernel.org>
References: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
In-Reply-To: <20261112-acpi_ffh_ffa-v2-0-575a9dbed22b@kernel.org>
To: linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Sudeep Holla <sudeep.holla@kernel.org>, 
 Jamie Nguyen <jamien@nvidia.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Hanjun Guo <guohanjun@huawei.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Dat Mach <dmach@nvidia.com>
X-Mailer: b4 0.16.0

ACPI FFH and the FF-A transport driver interpret the same
PARTITION_INFO_GET_REGS metadata and pack endpoint IDs using the same
bit fields. Define these fields once in arm_ffa.h instead of keeping
private copies.

Use the shared masks in the transport driver and check descriptor
lengths against the same minimum used by ACPI FFH. This keeps the ABI
encoding consistent between the two users.

Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
---
 drivers/firmware/arm_ffa/driver.c | 48 ++++++++++++++-------------------------
 include/linux/arm_ffa.h           | 19 ++++++++++++++++
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


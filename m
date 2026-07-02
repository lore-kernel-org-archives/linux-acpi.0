Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41503417359;
	Thu,  2 Jul 2026 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009420; cv=none; b=fcF2yjdcVbW5CpPAIbXtIl62LA07NT6+31q3fROTM60UpDeanU1Ar01R4MO7BggXOb0EGh+DdKGU83zygvYzspQgG+qi+2TqX3sy+ZweyHUAiUPGUUqOVyIlSRaLlU3tEvOu9Gg9WOEpEWJ6Y6fAE1hhhLr6lau6KyGW+BR00Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009420; c=relaxed/simple;
	bh=UDAWA7nbp2h8U0/KMznIvV6N2+N2gpmnFwibOfMICq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rlzDZZm66uRCHXio+yzYTH6beUkvTjM4vJEfcVD6X3XC1UB40l6LfFpr+q63bFynVFWLGrTBTyaKIGKSb2S/0YfYfefG624q9usq91RHD7WUAwj0YHX4U27MpVXluCQw+2RctbxDF61qPcErkfp+sXBNcvMku63kye9BuuZ3kkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lbtnuMUS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lbtnuMUS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 27C391570;
	Thu,  2 Jul 2026 09:23:29 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C3AD93F673;
	Thu,  2 Jul 2026 09:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009413; bh=UDAWA7nbp2h8U0/KMznIvV6N2+N2gpmnFwibOfMICq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbtnuMUS05JuaeGKKeMHCtFMh26jZQl9MO56SYzuXp6w1Xx8Do+kmDKGUDRcns1tC
	 EJ3hgAvwW4yKfWJq3VG8M3Jh8OKcTaR1b5WPmVCd0r/QDgOLrP/lEHMrKZzyG3L/+j
	 3c0X/DXMb0HNFGDwkdfkQiFEM5nquUh9XTXmf+40=
From: Andre Przywara <andre.przywara@arm.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	James Morse <james.morse@arm.com>,
	Ben Horgan <ben.horgan@arm.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Fenghua Yu <fenghuay@nvidia.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Srivathsa L Rao <srivathsa.rao@oss.qualcomm.com>,
	Ganapatrao Kulkarni <ganapatrao.kulkarni@oss.qualcomm.com>,
	Trilok Soni <tsoni@quicinc.com>,
	Srinivas Ramana <sramana@qti.qualcomm.com>,
	Niyas Sait <niyas.sait@arm.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 13/15] arm_mpam: add MPAM-Fb MSC firmware access support
Date: Thu,  2 Jul 2026 18:22:27 +0200
Message-ID: <20260702162229.4008659-14-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702162229.4008659-1-andre.przywara@arm.com>
References: <20260702162229.4008659-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm MPAM Firmware-backed (Fb) Profile document[1] describes an
alternative way of accessing the "Memory System Components" (MSC) in an
MPAM enabled system.
Normally the MSCs are MMIO mapped, but in some implementations this
might not be possible (MSC located outside of the local socket, MSC
mapped secure-only) or desirable (direct MMIO access too slow or needs
to be mediated through a control processor). MPAM-fb standardises a
protocol to abstract MSC accesses, building on the SCMI protocol.

Add functions that do an MSC read or write access by redirecting the
request through a firmware interface. For now this done via an ACPI
PCC shared memory and mailbox combination.

Since the protocol used is only a small subset of the full SCMI spec,
and the SCMI protocol has no full ACPI support anyway, open-code the
SCMI message generation and handshake, for just the fields we need.

[1] https://developer.arm.com/documentation/den0144/latest

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/Makefile        |   2 +-
 drivers/resctrl/mpam_devices.c  |  27 +++++--
 drivers/resctrl/mpam_fb.c       | 137 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_fb.h       |  17 ++++
 drivers/resctrl/mpam_internal.h |  12 +++
 include/linux/arm_mpam.h        |   2 +-
 6 files changed, 190 insertions(+), 7 deletions(-)
 create mode 100644 drivers/resctrl/mpam_fb.c
 create mode 100644 drivers/resctrl/mpam_fb.h

diff --git a/drivers/resctrl/Makefile b/drivers/resctrl/Makefile
index 4f6d0e81f9b8..097c036724e9 100644
--- a/drivers/resctrl/Makefile
+++ b/drivers/resctrl/Makefile
@@ -1,5 +1,5 @@
 obj-$(CONFIG_ARM64_MPAM_DRIVER)			+= mpam.o
-mpam-y						+= mpam_devices.o
+mpam-y						+= mpam_devices.o mpam_fb.o
 mpam-$(CONFIG_ARM64_MPAM_RESCTRL_FS)		+= mpam_resctrl.o
 
 ccflags-$(CONFIG_ARM64_MPAM_DRIVER_DEBUG)	+= -DDEBUG
diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 824bc6c97851..b858ff389bff 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -28,6 +28,7 @@
 #include <linux/workqueue.h>
 
 #include "mpam_internal.h"
+#include "mpam_fb.h"
 
 /* Values for the T241 errata workaround */
 #define T241_CHIPS_MAX			4
@@ -181,6 +182,9 @@ static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
 {
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
+	if (msc->iface == MPAM_IFACE_PCC)
+		return mpam_fb_send_read_request(msc, reg, res);
+
 	*res = readl_relaxed(msc->mapped_hwpage + reg);
 
 	return 0;
@@ -197,9 +201,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
 
 static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
 {
-	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
+	if (msc->iface == MPAM_IFACE_PCC)
+		return mpam_fb_send_write_request(msc, reg, val);
+
+	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
 	writel_relaxed(val, msc->mapped_hwpage + reg);
 
 	return 0;
@@ -1127,7 +1134,8 @@ static u64 mpam_msc_read_mbwu_l(struct mpam_msc *msc)
 
 	mpam_mon_sel_lock_held(msc);
 
-	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
+	if (msc->iface == MPAM_IFACE_MMIO)
+		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
 	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
@@ -1475,9 +1483,15 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 					 srcu_read_lock_held(&mpam_srcu)) {
 			arg->ris = ris;
 
-			err = smp_call_function_any(&msc->accessibility,
-						    __ris_msmon_read, arg,
-						    true);
+			if (msc->iface == MPAM_IFACE_MMIO) {
+				err = smp_call_function_any(&msc->accessibility,
+							    __ris_msmon_read,
+							    arg, true);
+			} else {
+				__ris_msmon_read(arg);
+				err = 0;
+			}
+
 			if (!err && arg->err)
 				err = arg->err;
 
@@ -1913,6 +1927,9 @@ static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
 
 static int mpam_touch_msc(struct mpam_msc *msc, int (*fn)(void *a), void *arg)
 {
+	if (msc->iface != MPAM_IFACE_MMIO)
+		return fn(arg);
+
 	lockdep_assert_irqs_enabled();
 	lockdep_assert_cpus_held();
 	WARN_ON_ONCE(!srcu_read_lock_held((&mpam_srcu)));
diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
new file mode 100644
index 000000000000..687be6f8a152
--- /dev/null
+++ b/drivers/resctrl/mpam_fb.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Arm Ltd.
+
+#include <linux/arm_mpam.h>
+#include <linux/cleanup.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/gfp.h>
+#include <linux/list.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_platform.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/processor.h>
+#include <linux/slab.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+#include <acpi/pcc.h>
+
+#include <asm/mpam.h>
+
+#include "mpam_fb.h"
+
+#define MPAM_FB_PROTOCOL_ID	0x1a
+#define MPAM_MSC_ATTRIBUTES_CMD	0x3
+#define MPAM_MSC_READ_CMD	0x4
+#define MPAM_MSC_WRITE_CMD	0x5
+
+#define MPAM_MSC_PROT_ID_MASK	GENMASK(17, 10)
+#define MPAM_MSC_TOKEN_MASK	GENMASK(27, 18)
+
+#define PCC_CHAN_FLAGS_IRQ	BIT(0)
+#define MPAM_READ_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 3 * sizeof(u32))
+#define MPAM_WRITE_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
+
+static atomic_t mpam_fb_token = ATOMIC_INIT(0);
+
+static int mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
+				      void __iomem *msg_buf)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;
+	void __iomem *payload_ofs = msg_buf + sizeof(*pcc_shmem);
+
+	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
+	writel_relaxed(MPAM_READ_MSG_SIZE, &pcc_shmem->length);
+	writel_relaxed(MPAM_MSC_READ_CMD |
+		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
+		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
+		       &pcc_shmem->command);
+
+	writel_relaxed(cpu_to_le32(msc_id), payload_ofs + 0x0);
+	writel_relaxed(0, payload_ofs + 0x4);
+	writel_relaxed(cpu_to_le32(reg), payload_ofs + 0x8);
+
+	return MPAM_READ_MSG_SIZE;
+}
+
+static int mpam_fb_build_write_message(int msc_id, int reg, u32 val,
+				       unsigned int token,
+				       void __iomem *msg_buf)
+{
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem = msg_buf;
+	void __iomem *payload_ofs = msg_buf + sizeof(*pcc_shmem);
+
+	writel_relaxed(MPAM_WRITE_MSG_SIZE, &pcc_shmem->length);
+	writel_relaxed(MPAM_MSC_WRITE_CMD |
+		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
+		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
+		       &pcc_shmem->command);
+
+	writel_relaxed(cpu_to_le32(msc_id), payload_ofs + 0x0);
+	writel_relaxed(0, payload_ofs + 0x4);
+	writel_relaxed(cpu_to_le32(reg), payload_ofs + 0x8);
+	writel_relaxed(cpu_to_le32(val), payload_ofs + 0xc);
+
+	return MPAM_WRITE_MSG_SIZE;
+}
+
+static int mpam_fb_send_request(struct mpam_msc *msc, u16 reg, u32 *result,
+				bool is_write)
+{
+	unsigned int token = atomic_inc_return(&mpam_fb_token);
+	struct acpi_pcct_ext_pcc_shared_memory *pcc_shmem;
+	struct mpam_pcc_chan *pcc_chan = msc->pcc_chan;
+	struct pcc_mbox_chan *chan;
+	void __iomem *payload_ofs;
+	u32 status;
+	int ret;
+
+	if (!pcc_chan)
+		return -ENODEV;
+
+	chan = pcc_chan->pcc_chan;
+
+	guard(mutex)(&pcc_chan->pcc_chan_lock);
+
+	if (is_write)
+		ret = mpam_fb_build_write_message(msc->mpam_fb_msc_id, reg,
+						  *result, token, chan->shmem);
+	else
+		ret = mpam_fb_build_read_message(msc->mpam_fb_msc_id, reg,
+						 token, chan->shmem);
+	if (ret < 0)
+		return ret;
+
+	ret = mbox_send_message(chan->mchan, NULL);
+	if (ret < 0)
+		return ret;
+
+	pcc_shmem = chan->shmem;
+	payload_ofs = chan->shmem + sizeof(*pcc_shmem);
+	status = readl(&pcc_shmem->command);
+	if (FIELD_GET(MPAM_MSC_TOKEN_MASK, status) != token)
+		return -ETIMEDOUT;
+
+	ret = readl(payload_ofs + 0x0);
+	if (ret < 0)
+		return ret;
+
+	if (!is_write)
+		*result = readl(payload_ofs + 0x4);
+
+	return 0;
+}
+
+int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
+{
+	return mpam_fb_send_request(msc, reg, result, false);
+}
+
+int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
+{
+	return mpam_fb_send_request(msc, reg, &value, true);
+}
diff --git a/drivers/resctrl/mpam_fb.h b/drivers/resctrl/mpam_fb.h
new file mode 100644
index 000000000000..45cd572a28ad
--- /dev/null
+++ b/drivers/resctrl/mpam_fb.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (C) 2024-2025 Arm Ltd.
+
+#ifndef MPAM_FB_H_
+#define MPAM_FB_H_
+
+#include <linux/types.h>
+#include "mpam_internal.h"
+
+#define PCC_TYPE3_MSG_PAYLOAD_OFS	0x10
+#define MPAM_WRITE_MSG_SIZE	(PCC_TYPE3_MSG_PAYLOAD_OFS + 4 * sizeof(u32))
+#define MPAM_FB_MAX_MSG_SIZE	MPAM_WRITE_MSG_SIZE
+
+int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
+int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
+
+#endif
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 4616f1283f1a..9e7778534143 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -11,6 +11,7 @@
 #include <linux/io.h>
 #include <linux/jump_label.h>
 #include <linux/llist.h>
+#include <linux/mailbox_client.h>
 #include <linux/mutex.h>
 #include <linux/resctrl.h>
 #include <linux/spinlock.h>
@@ -57,6 +58,15 @@ struct mpam_garbage {
 	struct platform_device	*pdev;
 };
 
+struct mpam_pcc_chan {
+	struct list_head	pcc_chans;
+	struct mbox_client	pcc_cl;
+	struct pcc_mbox_chan	*pcc_chan;
+	struct mutex		pcc_chan_lock; /* only one message at a time */
+	int			subspace_id;
+	int			refcount;
+};
+
 struct mpam_msc {
 	/* member of mpam_all_msc */
 	struct list_head	all_msc_list;
@@ -66,6 +76,8 @@ struct mpam_msc {
 
 	/* Not modified after mpam_is_enabled() becomes true */
 	enum mpam_msc_iface	iface;
+	struct mpam_pcc_chan	*pcc_chan;
+	int			mpam_fb_msc_id;	/* in its own name space */
 	u32			nrdy_usec;
 	cpumask_t		accessibility;
 	bool			has_extd_esr;
diff --git a/include/linux/arm_mpam.h b/include/linux/arm_mpam.h
index f92a36187a52..002f56e15362 100644
--- a/include/linux/arm_mpam.h
+++ b/include/linux/arm_mpam.h
@@ -12,7 +12,7 @@ struct mpam_msc;
 
 enum mpam_msc_iface {
 	MPAM_IFACE_MMIO,	/* a real MPAM MSC */
-	MPAM_IFACE_PCC,		/* a fake MPAM MSC */
+	MPAM_IFACE_PCC,		/* using the MPAM-Fb firmware redirection */
 };
 
 enum mpam_class_types {
-- 
2.43.0


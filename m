Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CB64D90BB;
	Thu, 23 Jul 2026 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822133; cv=none; b=XIU5k6QD0X1DLvg67Si8vKRq1NuEQfa92i8CjbC8EAGGn0SAAsJeAw6x0EY9ADItSjsOjF8ynuFqlEoqFRWNTbrxeOH3fciAsJZ6v6zQbqtmFkf8I0P17o2/wc/UjRa91RTgTEPQHTvCNnzD91rLdk9BdnCcYClzFTFAx4K52gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822133; c=relaxed/simple;
	bh=Cl7AHxRPWn8epyM1zP1G23+G0RzWuiGZgw43nZneJW8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPYMuIqGmVpaGc49JJf85TZ3YUeLpCTs2Ou51igFC+Mu3r64rC0hnYfq69YVaoDdcnlktYK6hXKMd5FmBRPfaWGeUmBsX1RNx83tHV/+ylCP0IzmGWXKUijyZ9xTwRch6Lk3bcBVElIKFQtA1VTUT59k07Gzu5gBgx4bC+iWprc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CA3+Sd93; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CA3+Sd93"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3ED23176A;
	Thu, 23 Jul 2026 08:55:26 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 05CD43FA7A;
	Thu, 23 Jul 2026 08:55:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784822130; bh=Cl7AHxRPWn8epyM1zP1G23+G0RzWuiGZgw43nZneJW8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CA3+Sd934EaA9D5zGWkqthCNKBMn4yDW0jv4aCJSpj10KVCBVnZNQCaPq9evbYRD0
	 KN/ih7HjtWrqKTcAlS5EsMn0xoOUGKy2REEgwNSn37kai6Kroowt/Nyw/hhM6PrQtY
	 PQlG+jfgWoSagnDtVfHosg/GADsEybscgxi9NUok=
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
	Lee Trager <lee@trager.us>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/10] arm_mpam: add MPAM-Fb MSC firmware access support
Date: Thu, 23 Jul 2026 17:54:52 +0200
Message-ID: <20260723155454.1760823-9-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723155454.1760823-1-andre.przywara@arm.com>
References: <20260723155454.1760823-1-andre.przywara@arm.com>
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
(simple) SCMI message generation, for just the fields we need.

[1] https://developer.arm.com/documentation/den0144/latest

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/Makefile        |   2 +-
 drivers/resctrl/mpam_devices.c  |  27 ++++-
 drivers/resctrl/mpam_fb.c       | 197 ++++++++++++++++++++++++++++++++
 drivers/resctrl/mpam_internal.h |  20 ++++
 include/linux/arm_mpam.h        |   2 +-
 5 files changed, 240 insertions(+), 8 deletions(-)
 create mode 100644 drivers/resctrl/mpam_fb.c

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
index e2cb884eacf4..b8108ed4b32c 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -181,6 +181,9 @@ static int __mpam_read_reg(struct mpam_msc *msc, u16 reg, u32 *res)
 {
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
+	if (msc->iface == MPAM_IFACE_PCC)
+		return mpam_fb_send_read_request(msc, reg, res);
+
 	*res = readl_relaxed(msc->mapped_hwpage + reg);
 
 	return 0;
@@ -197,9 +200,12 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
 
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
@@ -1136,7 +1142,8 @@ static int mpam_msc_read_mbwu_l(struct mpam_msc *msc, u64 *res)
 
 	mpam_mon_sel_lock_held(msc);
 
-	WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
+	if (msc->iface == MPAM_IFACE_MMIO)
+		WARN_ON_ONCE((MSMON_MBWU_L + sizeof(u64)) > msc->mapped_hwpage_sz);
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
 	ret = __mpam_read_reg(msc, MSMON_MBWU_L + 4, &mbwu_l_high2);
@@ -1485,11 +1492,16 @@ static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
 					 srcu_read_lock_held(&mpam_srcu)) {
 			arg->ris = ris;
 
-			err = smp_call_function_any(&msc->accessibility,
-						    __ris_msmon_read, arg,
-						    true);
-			if (!err && arg->err)
+			if (msc->iface == MPAM_IFACE_MMIO) {
+				err = smp_call_function_any(&msc->accessibility,
+							    __ris_msmon_read,
+							    arg, true);
+				if (!err)
+					err = arg->err;
+			} else {
+				__ris_msmon_read(arg);
 				err = arg->err;
+			}
 
 			/*
 			 * Save one error to be returned to the caller, but
@@ -1916,6 +1928,9 @@ static int mpam_get_msc_preferred_cpu(struct mpam_msc *msc)
 
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
index 000000000000..ec4bf0dd9182
--- /dev/null
+++ b/drivers/resctrl/mpam_fb.c
@@ -0,0 +1,197 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (C) 2024 Arm Ltd.
+
+#include <linux/arm_mpam.h>
+#include <linux/cleanup.h>
+#include <linux/errno.h>
+#include <linux/mailbox_client.h>
+#include <linux/mutex.h>
+#include <linux/types.h>
+
+#include <acpi/pcc.h>
+#include <asm/mpam.h>
+
+#include "mpam_internal.h"
+
+#define MPAM_FB_PROTOCOL_ID	0x1a
+#define MPAM_PROTOCOL_VERSION	0x0
+#define MPAM_MSC_ATTRIBUTES_CMD	0x3
+#define MPAM_MSC_READ_CMD	0x4
+#define MPAM_MSC_WRITE_CMD	0x5
+
+#define MPAM_FB_ERR_SUCCESS		 0
+#define MPAM_FB_ERR_NOT_SUPPORTED	-1
+#define MPAM_FB_ERR_INVALID_PARAMETERS	-2
+#define MPAM_FB_ERR_DENIED		-3
+#define MPAM_FB_ERR_NOT_FOUND		-4
+#define MPAM_FB_ERR_OUT_OF_RANGE	-5
+#define MPAM_FB_ERR_BUSY		-6
+#define MPAM_FB_ERR_COMMS_ERROR		-7
+#define MPAM_FB_ERR_GENERIC_ERROR	-8
+#define MPAM_FB_ERR_HW_ERROR		-9
+#define MPAM_FB_ERR_PROTOCOL_ERROR	-10
+#define MPAM_FB_ERR_IN_USE		-11
+
+#define MPAM_MSC_PROT_ID_MASK	GENMASK(17, 10)
+#define MPAM_MSC_TOKEN_MASK	GENMASK(27, 18)
+
+struct mpam_fb_read_payload {
+	u32 msc_id;
+	u32 flags;
+	u32 reg_offset;
+} __packed;
+
+struct mpam_fb_write_payload {
+	u32 msc_id;
+	u32 flags;
+	u32 reg_offset;
+	u32 value;
+} __packed;
+
+#define PCC_CHAN_FLAGS_IRQ	BIT(0)
+
+static atomic_t mpam_fb_token = ATOMIC_INIT(0);
+
+static void mpam_fb_build_version_message(unsigned int token,
+					  void __iomem *msg_buf)
+{
+	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
+
+	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
+	writel_relaxed(MPAM_FB_PROT_HEADER_LEN, &pcc_shmem->length);
+	writel_relaxed(MPAM_PROTOCOL_VERSION |
+		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
+		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
+		       &pcc_shmem->command);
+}
+
+static void mpam_fb_build_read_message(int msc_id, int reg, unsigned int token,
+				       void __iomem *msg_buf)
+{
+	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
+	struct mpam_fb_read_payload __iomem *payload = msg_buf + sizeof(*pcc_shmem);
+	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
+
+	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
+	writel_relaxed(msg_size, &pcc_shmem->length);
+	writel_relaxed(MPAM_MSC_READ_CMD |
+		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
+		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
+		       &pcc_shmem->command);
+
+	writel_relaxed(msc_id, &payload->msc_id);
+	writel_relaxed(0, &payload->flags);
+	writel_relaxed(reg, &payload->reg_offset);
+}
+
+static void mpam_fb_build_write_message(int msc_id, int reg, u32 val,
+					unsigned int token,
+					void __iomem *msg_buf)
+{
+	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem = msg_buf;
+	struct mpam_fb_write_payload __iomem *payload = msg_buf + sizeof(*pcc_shmem);
+	int msg_size = MPAM_FB_PROT_HEADER_LEN + sizeof(*payload);
+
+	writel_relaxed(PCC_CHAN_FLAGS_IRQ, &pcc_shmem->flags);
+	writel_relaxed(msg_size, &pcc_shmem->length);
+	writel_relaxed(MPAM_MSC_WRITE_CMD |
+		       FIELD_PREP(MPAM_MSC_TOKEN_MASK, token) |
+		       FIELD_PREP(MPAM_MSC_PROT_ID_MASK, MPAM_FB_PROTOCOL_ID),
+		       &pcc_shmem->command);
+
+	writel_relaxed(msc_id, &payload->msc_id);
+	writel_relaxed(0, &payload->flags);
+	writel_relaxed(reg, &payload->reg_offset);
+	writel_relaxed(val, &payload->value);
+}
+
+static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
+				u16 reg, u32 *result, int mpam_fb_command)
+{
+	unsigned int token = atomic_inc_return(&mpam_fb_token);
+	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
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
+	/* prune token to fit into the 10 bits inside the command register */
+	token = FIELD_GET(MPAM_MSC_TOKEN_MASK,
+			  FIELD_PREP(MPAM_MSC_TOKEN_MASK, token));
+
+	guard(mutex)(&pcc_chan->pcc_chan_lock);
+
+	switch (mpam_fb_command) {
+	case MPAM_MSC_WRITE_CMD:
+		mpam_fb_build_write_message(msc_id, reg, *result,
+					    token, chan->shmem);
+		break;
+	case MPAM_MSC_READ_CMD:
+		mpam_fb_build_read_message(msc_id, reg, token, chan->shmem);
+		break;
+	case MPAM_PROTOCOL_VERSION:
+		mpam_fb_build_version_message(token, chan->shmem);
+		break;
+	}
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
+	if (ret < 0) {
+		switch (ret) {
+		case MPAM_FB_ERR_NOT_SUPPORTED:
+			return -EOPNOTSUPP;
+		case MPAM_FB_ERR_INVALID_PARAMETERS:
+			return -EINVAL;
+		case MPAM_FB_ERR_NOT_FOUND:
+			return -ENOENT;
+		case MPAM_FB_ERR_OUT_OF_RANGE:
+			return -ERANGE;
+		default:
+			return -EINVAL;
+		}
+	}
+
+	if (mpam_fb_command != MPAM_MSC_WRITE_CMD)
+		*result = readl(payload_ofs + 0x4);
+
+	return 0;
+}
+
+int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
+{
+	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
+				    reg, result, MPAM_MSC_READ_CMD);
+}
+
+int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
+{
+	return mpam_fb_send_request(msc->pcc_chan, msc->mpam_fb_msc_id,
+				    reg, &value, MPAM_MSC_WRITE_CMD);
+}
+
+int mpam_fb_get_protocol_version(struct mpam_msc *msc)
+{
+	u32 version;
+	int ret;
+
+	ret = mpam_fb_send_request(msc->pcc_chan, 0,
+				   0, &version, MPAM_PROTOCOL_VERSION);
+	if (ret)
+		return ret;
+
+	return version;
+}
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index b3a6ed9ed175..e4686ff0ba2e 100644
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
+	struct kref		refcount;
+	int			subspace_id;
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
@@ -511,6 +523,14 @@ static inline void mpam_resctrl_offline_cpu(unsigned int cpu) { }
 static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
 #endif /* CONFIG_RESCTRL_FS */
 
+/* MPAM-Fb Firmware-backed protocol wrappers */
+int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
+int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
+int mpam_fb_get_protocol_version(struct mpam_msc *msc);
+
+#define MPAM_FB_PROT_HEADER_LEN	sizeof(u32)
+#define MPAM_FB_MAX_MSG_SIZE	(MPAM_FB_PROT_HEADER_LEN + 4 * sizeof(u32))
+
 /*
  * MPAM MSCs have the following register layout. See:
  * Arm Memory System Resource Partitioning and Monitoring (MPAM) System
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


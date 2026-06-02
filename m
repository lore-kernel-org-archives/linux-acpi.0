Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CF73AE185;
	Tue,  2 Jun 2026 07:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780384589; cv=none; b=MF7lI+AApllbP1q/dW3XgLd0tICQ0Pbi+ytyEVofWUbDBaJ1pYSkIzphULbBP5iFMZpnOBhHlPPZLF4Z78R+usj8sGNg/OTuQXopaGJrYAhTDM/qZ59dR7jvAo0nUZ2xs25a+rG127zcu1J8ZbEeRp3VHeYjcNzj8iX48d3qx7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780384589; c=relaxed/simple;
	bh=2PI49NUohaY7BwfcbdNXp4IWNPZLW/2G+3Zan7DuxUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j+nAZR3/YvYX342I8rQZqbtQvIaujV7W0Xkr2ec660XmFdFWQBkUiKGIActAP1JOmJ8OQM6YOh1RqSwFzDknof0s8DMARM/+48FdpCPlKWCs7lBrPY+jmO9EG1B707yyYHsx41RwibQakfEA7gt6WbIsVjLTBfSClZjuFx3Bp0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RvvbGDer; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RvvbGDer"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1780384579; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4nbxh71Fq5dsKcDIguU1IiPKLaoUTyNChJcaP+bZc5E=;
	b=RvvbGDerCmP28ymjLvFcJZDbJCRZny8/7NbOINME31aFyP48zmsbKRD3p+bkCXeELZS3+aK4wOHWmwOqiJpK+Uq3esjb8lSGt1Jb8kEYHzUnEAs9nhVDiFGVUOTGjBbKxW5JM+qMNkNp+lK8N+SBn5l/sZFMY4PQVhwgT4NV//M=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R391e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=tianruidong@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0X43R2h-_1780384576;
Received: from t50a05405.sqa.eu95.tbsite.net(mailfrom:tianruidong@linux.alibaba.com fp:SMTPD_---0X43R2h-_1780384576 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 02 Jun 2026 15:16:17 +0800
From: Ruidong Tian <tianruidong@linux.alibaba.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Tony Luck <tony.luck@intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Umang Chheda <umang.chheda@oss.qualcomm.com>
Cc: linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	zhuo.song@linux.alibaba.com,
	oliver.yang@linux.alibaba.com,
	Ruidong Tian <tianruidong@linux.alibaba.com>
Subject: [PATCH v7 15/16] arm64: ras: Introduce ras error storm mitigation
Date: Tue,  2 Jun 2026 15:15:38 +0800
Message-ID: <20260602071540.3711528-16-tianruidong@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
References: <20260602071540.3711528-1-tianruidong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Corrected errors can occasionally be reported at a very high rate
(known on x86 as a "CMCI storm"), consuming a substantial share of
CPU time and disturbing the running workload. The RAS driver needs
to throttle this so that error reporting itself does not become a
denial of service.

Adopt a hybrid per-record / per-node strategy:

  - Each record tracks its own CE history in a sliding window.
    By default a record enters storm mode once it accumulates more
    than 5 corrected errors within roughly one minute, at which
    point its FHI/CFI is masked via ERR<n>_CTLR and the record is
    added to a node-wide poll set. It leaves storm mode after
    ~30 s without any further error, at which point the interrupt
    is unmasked again. The thresholds and the poll interval are
    exposed via debugfs so operators can retune the algorithm at
    runtime without rebuilding the kernel.

  - The node owns a single timer that drains every stormy
    record. The first record entering storm starts the timer; the
    last one leaving stops it.

  - The poll interval is adaptive: halved on each tick that
    still finds errors, doubled on each tick that does not, capped
    at 300 s. This way the driver tracks the actual storm intensity
    instead of paying a fixed polling cost.

  -

  - ERI / UI (uncorrectable reporting) is intentionally excluded:
    uncorrected errors must remain synchronous and never be
    rate-limited.

The result bounds CPU spent on RAS under fault floods while
preserving full fidelity for correctness-critical paths.

Signed-off-by: Ruidong Tian <tianruidong@linux.alibaba.com>
---
 drivers/ras/arm64/Makefile     |   1 +
 drivers/ras/arm64/ras-cmn.c    |  10 ++
 drivers/ras/arm64/ras-core.c   |  45 +++++++-
 drivers/ras/arm64/ras-inject.c |   3 +
 drivers/ras/arm64/ras-storm.c  | 198 +++++++++++++++++++++++++++++++++
 drivers/ras/arm64/ras-sysfs.c  | 107 ++++++++++++++++++
 drivers/ras/arm64/ras.h        |  37 ++++++
 7 files changed, 397 insertions(+), 4 deletions(-)
 create mode 100644 drivers/ras/arm64/ras-storm.c

diff --git a/drivers/ras/arm64/Makefile b/drivers/ras/arm64/Makefile
index 0e4c7421c131..6897798f7314 100644
--- a/drivers/ras/arm64/Makefile
+++ b/drivers/ras/arm64/Makefile
@@ -6,3 +6,4 @@ arm64_ras-y		:= ras-core.o
 arm64_ras-y		+= ras-sysfs.o
 arm64_ras-y		+= ras-inject.o
 arm64_ras-y		+= ras-cmn.o
+arm64_ras-y		+= ras-storm.o
diff --git a/drivers/ras/arm64/ras-cmn.c b/drivers/ras/arm64/ras-cmn.c
index 109cdc46a717..489bbe38de5f 100644
--- a/drivers/ras/arm64/ras-cmn.c
+++ b/drivers/ras/arm64/ras-cmn.c
@@ -452,6 +452,16 @@ static int cmn_probe(struct platform_device *pdev)
 	platform_set_drvdata(pdev, nodes);
 
 	for (int i = 0; i < cmn_config->dev_num; i++) {
+
+		if (!nodes[i].name)
+			continue;
+
+		ret = arm64_ras_storm_init(&nodes[i]);
+		if (ret) {
+			ras_node_err(&nodes[i], "init storm mitigation failed\n");
+			return ret;
+		}
+
 		ras_online_node(&nodes[i]);
 		ras_node_init_debugfs(&nodes[i]);
 	}
diff --git a/drivers/ras/arm64/ras-core.c b/drivers/ras/arm64/ras-core.c
index 2fb645659694..82e8bb10870f 100644
--- a/drivers/ras/arm64/ras-core.c
+++ b/drivers/ras/arm64/ras-core.c
@@ -207,6 +207,9 @@ void ras_proc_record(struct ras_record *record, void *data, bool fake)
 	u64 ue;
 
 	regs.err_status = record_read(record, ERXSTATUS);
+
+	arm64_ras_storm_track_record(record, regs.err_status);
+
 	if (!(regs.err_status & ERR_STATUS_V))
 		return;
 
@@ -265,9 +268,8 @@ void ras_proc_record(struct ras_record *record, void *data, bool fake)
 	record_write(record, ERXSTATUS, regs.err_status);
 }
 
-static void ras_node_foreach_record(void (*func)(struct ras_record *, void *, bool),
-				    struct ras_node *node, void *data,
-				    unsigned long *bitmap)
+void ras_node_foreach_record(void (*func)(struct ras_record *, void *, bool),
+			     struct ras_node *node, void *data, unsigned long *bitmap)
 {
 	int i;
 
@@ -410,7 +412,7 @@ static int ras_register_irq(struct ras_node *node)
 	return ret;
 }
 
-static void ras_enable_irq(struct ras_record *record)
+void ras_enable_irq(struct ras_record *record)
 {
 	struct ras_node *node = record->node;
 	u64 err_ctlr;
@@ -425,6 +427,15 @@ static void ras_enable_irq(struct ras_record *record)
 	record_write(record, ERXCTLR, err_ctlr);
 }
 
+void ras_disable_irq(struct ras_record *record)
+{
+	u64 err_ctlr;
+
+	err_ctlr = record_read(record, ERXCTLR);
+	err_ctlr &= ~(ERR_CTLR_FI | ERR_CTLR_CFI);
+	record_write(record, ERXCTLR, err_ctlr);
+}
+
 static int ras_get_ce_threshold(struct ras_record *record)
 {
 	u64 err_fr, err_fr_cec, err_fr_rp;
@@ -533,6 +544,11 @@ static void ras_online_record(struct ras_record *record, void *data, bool __unus
 	ras_enable_irq(record);
 }
 
+static void ras_offline_record(struct ras_record *record, void *data, bool __unused)
+{
+	ras_disable_irq(record);
+}
+
 void ras_online_node(struct ras_node *node)
 {
 	int count = 0;
@@ -547,10 +563,23 @@ void ras_online_node(struct ras_node *node)
 
 	ras_config_irq(node);
 
+	arm64_ras_storm_init(node);
+
 	ras_node_foreach_record(ras_online_record, node, NULL,
 				node->record_implemented);
 }
 
+static void ras_offline_node(struct ras_node *node)
+{
+	if (!node->name)
+		return;
+
+	arm64_ras_storm_reset_node(node);
+
+	ras_node_foreach_record(ras_offline_record, node, NULL,
+				node->record_implemented);
+}
+
 static void ras_online_oncore_dev(void *data)
 {
 	int fhi_irq, eri_irq;
@@ -571,6 +600,8 @@ static void ras_offline_oncore_dev(void *data)
 	int fhi_irq, eri_irq;
 	struct ras_node *node = this_cpu_ptr(data);
 
+	ras_offline_node(node);
+
 	fhi_irq = node->irq[ACPI_AEST_NODE_FAULT_HANDLING];
 	if (fhi_irq > 0)
 		disable_percpu_irq(fhi_irq);
@@ -937,6 +968,12 @@ static int arm64_ras_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	ret = arm64_ras_storm_init(node);
+	if (ret) {
+		ras_node_err(node, "init storm mitigation failed\n");
+		return ret;
+	}
+
 	if (ras_node_is_oncore(node))
 		ret = cpuhp_setup_state(CPUHP_AP_ARM_RAS_STARTING,
 					"drivers/ras/arm64/ras:starting",
diff --git a/drivers/ras/arm64/ras-inject.c b/drivers/ras/arm64/ras-inject.c
index 7fb522a845e7..5e4b22806756 100644
--- a/drivers/ras/arm64/ras-inject.c
+++ b/drivers/ras/arm64/ras-inject.c
@@ -82,6 +82,9 @@ static int soft_inject_store(void *data, u64 val)
 
 	ras_proc_record(&record_inj, &count, true);
 
+	memcpy(&record->count, &record_inj.count, sizeof(record->count));
+	memcpy(&record->storm, &record_inj.storm, sizeof(record->storm));
+
 	if (count != 1)
 		return -EIO;
 
diff --git a/drivers/ras/arm64/ras-storm.c b/drivers/ras/arm64/ras-storm.c
new file mode 100644
index 000000000000..6ec95a34809b
--- /dev/null
+++ b/drivers/ras/arm64/ras-storm.c
@@ -0,0 +1,198 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * arm64 RAS error storm mitigation.
+ *
+ * This file plumbs the architecture-independent storm tracker
+ * (drivers/ras/storm.c) into the arm64 RAS driver. Storm tracking is
+ * per-record while the mitigation is mixed:
+ *
+ *   - When a record enters storm mode its FHI (fault handling) and CFI
+ *     (corrected fault) interrupts are masked via ERR<n>_CTLR.
+ *   - The first record entering storm starts the node's poll timer
+ *     which drains all currently stormy records.
+ *   - When a record leaves storm mode its interrupts are re-enabled and
+ *     it is removed from the poll. The timer stops once no
+ *     record remains in storm.
+ *
+ * Note that ERI / UI (uncorrected error reporting) is intentionally
+ * left untouched: uncorrected errors must continue to be delivered
+ * synchronously and never participate in storm suppression.
+ */
+#include <linux/bitmap.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/jiffies.h>
+#include <linux/percpu.h>
+#include <linux/printk.h>
+#include <linux/timer.h>
+
+#include "ras.h"
+
+#define INITIAL_CHECK_INTERVAL	(5 * 60) /* 5 minutes */
+
+#define NUM_HISTORY_BITS (sizeof(u64) * BITS_PER_BYTE)
+
+/* How many errors within the history buffer mark the start of a storm. */
+#define STORM_BEGIN_THRESHOLD	5
+
+/*
+ * How many polls of machine check bank without an error before declaring
+ * the storm is over. Since it is tracked by the bitmasks in the history
+ * field of struct storm_bank the mask is 30 bits [0 ... 29].
+ */
+#define STORM_END_POLL_THRESHOLD	29
+
+static void arm64_ras_storm_timer_fn(struct timer_list *t)
+{
+	struct ras_node *node = timer_container_of(node, t, storm_timer);
+	unsigned long iv = msecs_to_jiffies(node->timer_interval);
+	int count = 0;
+
+	ras_node_dbg(node, "Stormy bitmap %*pb\n", node->record_count, node->storm_bitmap);
+	ras_node_foreach_record(ras_proc_record, node, &count, node->storm_bitmap);
+
+	if (count)
+		iv = max(iv / 2, (unsigned long) HZ/100);
+	else
+		iv = min(iv * 2, INITIAL_CHECK_INTERVAL * HZ);
+
+
+	node->timer_interval = jiffies_to_msecs(iv);
+
+	if (atomic_read(&node->stormy_count)) {
+		ras_node_dbg(node, "next poll at %d ms\n", node->timer_interval);
+		mod_timer(&node->storm_timer, jiffies + iv);
+	}
+}
+
+static void
+arm64_ras_storm_reset_record(struct ras_record *record, void *__unused0, bool __unused1)
+{
+	struct ras_storm_unit *unit = &record->storm;
+
+	unit->in_storm_mode = false;
+	unit->history = 0;
+	unit->timestamp = 0;
+}
+
+void arm64_ras_storm_reset_node(void *data)
+{
+	struct ras_node *node = data;
+
+	node->begin_threshold = STORM_BEGIN_THRESHOLD;
+	node->end_poll_threshold = STORM_END_POLL_THRESHOLD;
+	node->timer_interval = INITIAL_CHECK_INTERVAL * MSEC_PER_SEC;
+
+	timer_delete_sync(&node->storm_timer);
+	bitmap_set(node->storm_bitmap, 0, node->record_count);
+
+	ras_node_foreach_record(arm64_ras_storm_reset_record, node, NULL, node->record_implemented);
+}
+
+static int arm64_ras_storm_do_init(struct ras_node *node)
+{
+	node->storm_bitmap = devm_bitmap_zalloc(node->dev,
+						node->record_count, GFP_KERNEL);
+	if (!node->storm_bitmap)
+		return -ENOMEM;
+
+	timer_setup(&node->storm_timer, arm64_ras_storm_timer_fn, 0);
+
+	return devm_add_action_or_reset(node->dev,
+					arm64_ras_storm_reset_node, node);
+}
+
+int arm64_ras_storm_init(struct ras_node *node)
+{
+	int ret = 0;
+
+	if (!node->record_count)
+		return ret;
+
+	/*
+	 * Per-CPU (oncore) nodes re-enter this path on every CPU
+	 * online transition, so the bitmap is allocated only on the
+	 * first call and reused on subsequent re-inits.
+	 */
+	if (!node->storm_bitmap) {
+		ret = arm64_ras_storm_do_init(node);
+		if (ret)
+			return ret;
+	}
+
+	arm64_ras_storm_reset_node(node);
+	return ret;
+}
+
+/**
+ * The function maintains the unit's history bitmap and decides whether
+ * the unit should enter or leave storm mode.
+ */
+static void ras_track_storm(struct ras_storm_unit *unit, bool corrected)
+{
+	unsigned long now = jiffies, delta;
+	unsigned int shift = 1;
+	u64 history = 0;
+
+	/*
+	 * Check how long it has been since this bank was last checked,
+	 * and adjust the amount of "shift" to apply to history.
+	 */
+	delta = now - unit->timestamp;
+	shift = (delta + HZ) / HZ;
+
+	/* If it has been a long time since the last poll, clear history. */
+	if (shift < NUM_HISTORY_BITS)
+		history = unit->history << shift;
+
+	unit->timestamp = now;
+
+	/* History keeps track of corrected errors. VAL=1 && UC=0 */
+	if (corrected)
+		history |= 1;
+
+	unit->history = history;
+}
+
+void arm64_ras_storm_track_record(struct ras_record *record, u64 err_status)
+{
+	struct ras_storm_unit *u = &record->storm;
+	struct ras_node *node = record->node;
+
+	ras_track_storm(u, err_status & ERR_STATUS_CE);
+
+	if (u->in_storm_mode) {
+		/*
+		 * Storm ends when no corrected error has been seen for
+		 * STORM_END_POLL_THRESHOLD + 1 consecutive polls.
+		 */
+		if (u->history & GENMASK_ULL(node->end_poll_threshold, 0))
+			return;
+
+		u->in_storm_mode = false;
+		u->history = 0;
+		set_bit(record->index, node->storm_bitmap);
+
+		ras_node_info(node, "%s: exited storm mode\n", record->name);
+		ras_enable_irq(record);
+
+		if (atomic_dec_and_test(&record->node->stormy_count))
+			timer_delete(&node->storm_timer);
+	} else {
+		if (hweight64(u->history) < node->begin_threshold)
+			return;
+
+		u->in_storm_mode = true;
+		clear_bit(record->index, node->storm_bitmap);
+
+		ras_node_info(node, "%s: entered storm mode\n", record->name);
+		ras_disable_irq(record);
+		/*
+		 * If this is the first record on this node to enter storm mode
+		 * start polling.
+		 */
+		if (atomic_inc_return(&record->node->stormy_count) == 1)
+			mod_timer(&node->storm_timer,
+				  jiffies + msecs_to_jiffies(node->timer_interval));
+	}
+}
diff --git a/drivers/ras/arm64/ras-sysfs.c b/drivers/ras/arm64/ras-sysfs.c
index d8b351ee9aef..9bf83d92d420 100644
--- a/drivers/ras/arm64/ras-sysfs.c
+++ b/drivers/ras/arm64/ras-sysfs.c
@@ -122,6 +122,109 @@ static int node_ce_threshold_set(void *data, u64 val)
 DEFINE_DEBUGFS_ATTRIBUTE(node_ce_threshold_ops, NULL,
 			 node_ce_threshold_set, "%llu\n");
 
+/* Storm debugfs entries */
+
+static int storm_stormy_count_get(void *data, u64 *val)
+{
+	struct ras_node *node = data;
+
+	*val = atomic_read(&node->stormy_count);
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(storm_stormy_count_ops, storm_stormy_count_get,
+			 NULL, "%llu\n");
+
+static int storm_begin_threshold_get(void *data, u64 *val)
+{
+	struct ras_node *node = data;
+
+	*val = node->begin_threshold;
+	return 0;
+}
+
+static int storm_begin_threshold_set(void *data, u64 val)
+{
+	struct ras_node *node = data;
+
+	if (val < 1 || val > BITS_PER_LONG)
+		return -EINVAL;
+
+	node->begin_threshold = val;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(storm_begin_threshold_ops, storm_begin_threshold_get,
+			 storm_begin_threshold_set, "%llu\n");
+
+static int storm_end_poll_threshold_get(void *data, u64 *val)
+{
+	struct ras_node *node = data;
+
+	*val = node->end_poll_threshold;
+	return 0;
+}
+
+static int storm_end_poll_threshold_set(void *data, u64 val)
+{
+	struct ras_node *node = data;
+
+	if (val >= BITS_PER_LONG)
+		return -EINVAL;
+
+	node->end_poll_threshold = val;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(storm_end_poll_threshold_ops,
+			 storm_end_poll_threshold_get,
+			 storm_end_poll_threshold_set, "%llu\n");
+
+static int storm_interval_ms_get(void *data, u64 *val)
+{
+	struct ras_node *node = data;
+
+	*val = node->timer_interval;
+	return 0;
+}
+
+static int storm_interval_ms_set(void *data, u64 val)
+{
+	struct ras_node *node = data;
+
+	node->timer_interval = val;
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(storm_interval_ms_ops,
+			 storm_interval_ms_get,
+			 storm_interval_ms_set, "%llu\n");
+
+static int record_in_storm_get(void *data, u64 *val)
+{
+	struct ras_record *record = data;
+
+	*val = atomic_read(&record->node->stormy_count);
+	return 0;
+}
+DEFINE_DEBUGFS_ATTRIBUTE(record_in_storm_ops, record_in_storm_get,
+			 NULL, "%llu\n");
+
+static void ras_storm_init_debugfs(struct ras_node *node)
+{
+	struct dentry *storm_dir;
+
+	if (!node->record_count)
+		return;
+
+	storm_dir = debugfs_create_dir("storm", node->debugfs);
+
+	debugfs_create_file("stormy_count", 0400, storm_dir,
+			    node, &storm_stormy_count_ops);
+	debugfs_create_file("begin_threshold", 0600, storm_dir,
+			    node, &storm_begin_threshold_ops);
+	debugfs_create_file("end_poll_threshold", 0600, storm_dir,
+			    node, &storm_end_poll_threshold_ops);
+	debugfs_create_file("check_interval_ms", 0600, storm_dir,
+			    node, &storm_interval_ms_ops);
+}
+
 static int ras_record_err_count_show(struct seq_file *m, void *data)
 {
 	struct ras_record *record = m->private;
@@ -151,6 +254,8 @@ static void ras_record_init_debugfs(struct ras_record *record)
 			    record, &ras_record_err_count_fops);
 	debugfs_create_file("ce_threshold", 0600, record->debugfs,
 			    record, &record_ce_threshold_ops);
+	debugfs_create_file("in_storm", 0400, record->debugfs,
+			    record, &record_in_storm_ops);
 	ras_inject_init_debugfs(record);
 }
 
@@ -186,6 +291,7 @@ static void ras_oncore_node_init_debugfs(struct ras_node *node)
 				    percpu_node, &ras_node_err_count_fops);
 		debugfs_create_file("ce_threshold", 0200, percpu_node->debugfs,
 				    percpu_node, &node_ce_threshold_ops);
+		ras_storm_init_debugfs(percpu_node);
 		ras_init_records_debugfs(percpu_node);
 	}
 }
@@ -208,5 +314,6 @@ void ras_node_init_debugfs(struct ras_node *node)
 			    node, &ras_node_err_count_fops);
 	debugfs_create_file("ce_threshold", 0200, node->debugfs,
 			    node, &node_ce_threshold_ops);
+	ras_storm_init_debugfs(node);
 	ras_init_records_debugfs(node);
 }
diff --git a/drivers/ras/arm64/ras.h b/drivers/ras/arm64/ras.h
index 75aa4ac83a41..e54082e2c3b9 100644
--- a/drivers/ras/arm64/ras.h
+++ b/drivers/ras/arm64/ras.h
@@ -12,6 +12,7 @@
 #include <linux/interrupt.h>
 #include <asm/ras.h>
 #include <linux/debugfs.h>
+#include <linux/timer.h>
 
 #define DEFAULT_CE_THRESHOLD 1
 
@@ -93,6 +94,19 @@ struct record_count {
 	u64 ueu;
 };
 
+/*
+ * history:		Bitmask tracking errors occurrence. Each set bit
+ *			represents an error seen.
+ *
+ * timestamp:		Last time (in jiffies) that the bank was polled.
+ * in_storm_mode:	Is this bank in storm mode?
+ */
+struct ras_storm_unit {
+	u64 history;
+	u64 timestamp;
+	bool in_storm_mode;
+};
+
 struct ras_record {
 	char *name;
 	void __iomem *regs_base;
@@ -105,6 +119,7 @@ struct ras_record {
 	struct ce_threshold ce;
 	enum ras_ce_threshold threshold_type;
 	struct record_count count;
+	struct ras_storm_unit storm;
 
 	int index;
 	/*
@@ -193,6 +208,9 @@ struct ras_node {
 	 */
 	int (*errgsr_mapping)(int errgsr_bit);
 	struct ras_record *records;
+	unsigned long			*storm_bitmap;
+
+	struct timer_list storm_timer;
 
 	u32 specific_data_size;
 	u32 record_count;
@@ -206,6 +224,15 @@ struct ras_node {
 	u8 group_format;
 	u32 irq[AEST_MAX_INTERRUPT_PER_NODE];
 	u32 gsi[AEST_MAX_INTERRUPT_PER_NODE];
+
+	/*
+	 * @stormy_count: Updated concurrently from hardirq and
+	 * timer softirqs.
+	 */
+	atomic_t			stormy_count;
+	unsigned int			begin_threshold;
+	unsigned int			end_poll_threshold;
+	unsigned int			timer_interval;
 };
 
 #define CASE_READ(res, x)                           \
@@ -334,4 +361,14 @@ irqreturn_t ras_irq_func(int irq, void *input);
 void ras_online_node(struct ras_node *node);
 int ras_cmn700_probe(struct platform_device *pdev);
 
+void ras_disable_irq(struct ras_record *record);
+void ras_enable_irq(struct ras_record *record);
+void ras_node_foreach_record(void (*func)(struct ras_record *, void *, bool),
+			     struct ras_node *node, void *data, unsigned long *bitmap);
+
+/* ras-storm.c */
+int  arm64_ras_storm_init(struct ras_node *node);
+void arm64_ras_storm_track_record(struct ras_record *record, u64 err_status);
+void arm64_ras_storm_reset_node(void *data);
+
 #endif /* _DRIVERS_RAS_ARM64_RAS_H_ */
-- 
2.51.2.612.gdc70283dfc


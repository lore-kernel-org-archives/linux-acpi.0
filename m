Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2609745199A;
	Tue,  4 Aug 2026 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785838058; cv=none; b=uN3PeKg+PSasJtYVrju11vXWiL0m5/r2udu/qfgBgn84py3CQlcXKnhBXWQuvhEisYfmqd3uuf0tXk8+TcHfr6Qsot3zt1/YENsPaIXa2q+uvzRiIUkRMGZ0dYmj6Tm03S0VkDvdLTJ2iLXpznPGeCHYM0TUz4KVpgUS+LqsL7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785838058; c=relaxed/simple;
	bh=/dykouqF0RUydoGbvMlOXk/hXe6B5OyVaox4xUQ6Cs0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SjZa8EUFUhOtZQeGYs5IVUCNNEYJxCcJ0GPKi1YlaX54rV/MmgD4PjlAhBKXQDfH633NmC7jhjZoBpdtlcS1ROMN2InDKvbL+QUqqebPoJJtIAKA2QM3/m0OyVtcZBE8ZhBMtIiGA8YORtuMI6CHSChUyMVZKtltQLPk45qZ09I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fvwqOp/Y; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fvwqOp/Y"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D6F1168F;
	Tue,  4 Aug 2026 03:07:32 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 22E033F86F;
	Tue,  4 Aug 2026 03:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785838056; bh=/dykouqF0RUydoGbvMlOXk/hXe6B5OyVaox4xUQ6Cs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvwqOp/YKmVUA6+Q4Lp+Ysm026sffb41su59Dvfyi4dGY0yMyUoH6pJGg4B/1LAtn
	 h7xxypwVkxBgdjU3cnZXoy6lWWVAjgdoi5dSnqQwEN8ehpKxMU6diQfdymkjTX6SE2
	 V0Uv1FHhjrUAkFr+xx0VIApQdQi1k4pqNXvb+/5U=
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
	Ritwick Sharma <ritwick.sharma@arm.com>,
	Gavin Shan <gshan@redhat.com>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 11/11] arm_mpam: detect and enable MPAM-Fb PCC support
Date: Tue,  4 Aug 2026 12:06:27 +0200
Message-ID: <20260804100627.3217149-12-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804100627.3217149-1-andre.przywara@arm.com>
References: <20260804100627.3217149-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Arm MPAM-Fb specification [1] describes a protocol to access MSC
registers through a firmware interface. This requires a shared memory
region to hold the message, and a mailbox to trigger the access.
For ACPI this is wrapped as a PCC channel, described using existing
ACPI abstractions.

Add code to parse those PCC table descriptions associated with an MSC,
and store the parsed information in the MSC struct.
There can be multiple PCC channels, and each channel can serve multiple
MSCs, so we need to keep track of the channel usage, using a list and
a refcount.

This will be used by the MPAM-Fb access wrapper code.

[1] https://developer.arm.com/documentation/den0144/latest

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Tested-by: Ritwick Sharma <ritwick.sharma@arm.com> # on Arm AGI CPU
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/resctrl/mpam_devices.c  | 113 +++++++++++++++++++++++++++++++-
 drivers/resctrl/mpam_fb.c       |  41 ++++++++++++
 drivers/resctrl/mpam_internal.h |   2 +
 3 files changed, 154 insertions(+), 2 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 3c686903def3..666ebf6234db 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -19,14 +19,19 @@
 #include <linux/irqdesc.h>
 #include <linux/list.h>
 #include <linux/lockdep.h>
+#include <linux/mailbox_client.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/printk.h>
+#include <linux/property.h>
 #include <linux/srcu.h>
 #include <linux/spinlock.h>
 #include <linux/types.h>
 #include <linux/workqueue.h>
 
+#include <acpi/pcc.h>
+#include <acpi/acpi_io.h>
+
 #include "mpam_internal.h"
 
 /* Values for the T241 errata workaround */
@@ -49,6 +54,88 @@ static LIST_HEAD(mpam_all_msc);
 
 struct srcu_struct mpam_srcu;
 
+/* PCC channels might be serving multiple MSCs, so keep a refcounted list. */
+static DEFINE_MUTEX(pcc_chan_list_lock);
+static LIST_HEAD(pcc_chan_list);
+
+static void mpam_pcc_chan_release(struct kref *ref)
+{
+	struct mpam_pcc_chan *cur = container_of(ref, struct mpam_pcc_chan,
+						 refcount);
+
+	pcc_mbox_free_channel(cur->pcc_chan);
+	list_del(&cur->pcc_chans);
+	mutex_destroy(&cur->pcc_chan_lock);
+	kfree(cur);
+}
+
+static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
+					       int subspace_id)
+{
+	struct mpam_pcc_chan *cur;
+
+	guard(mutex)(&pcc_chan_list_lock);
+
+	list_for_each_entry(cur, &pcc_chan_list, pcc_chans) {
+		if (cur->subspace_id == subspace_id) {
+			kref_get(&cur->refcount);
+
+			return cur;
+		}
+	}
+
+	cur = kzalloc_obj(*cur);
+	if (!cur)
+		return ERR_PTR(-ENOMEM);
+
+	cur->pcc_cl.dev = dev;
+	cur->pcc_cl.tx_block = true;
+
+	cur->pcc_chan = pcc_mbox_request_channel(&cur->pcc_cl, subspace_id);
+	if (IS_ERR(cur->pcc_chan)) {
+		long err = PTR_ERR(cur->pcc_chan);
+
+		kfree(cur);
+		return ERR_PTR(err);
+	}
+
+	/*
+	 * Timeout based on the "nominal latency" in us, from the
+	 * PCC ACPI table. tx_tout is in ms.
+	 * Add some margin here to be on the safe side.
+	 */
+	cur->pcc_cl.tx_tout = DIV_ROUND_UP(cur->pcc_chan->latency * 5, 1000);
+
+	mutex_init(&cur->pcc_chan_lock);
+
+	cur->subspace_id = subspace_id;
+	kref_init(&cur->refcount);
+
+	list_add_tail(&cur->pcc_chans, &pcc_chan_list);
+
+	return cur;
+}
+
+static int mpam_pcc_chan_put(struct mpam_pcc_chan *pcc_chan)
+{
+	struct mpam_pcc_chan *cur, *tmp;
+
+	if (!pcc_chan)
+		return 0;
+
+	guard(mutex)(&pcc_chan_list_lock);
+
+	list_for_each_entry_safe(cur, tmp, &pcc_chan_list, pcc_chans) {
+		if (cur == pcc_chan) {
+			kref_put(&cur->refcount, mpam_pcc_chan_release);
+
+			return 0;
+		}
+	}
+
+	return -ENOENT;
+}
+
 /*
  * Number of MSCs that have been probed. Once all MSCs have been probed MPAM
  * can be enabled.
@@ -2275,6 +2362,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
 {
 	struct mpam_msc *msc = platform_get_drvdata(pdev);
 
+	mpam_pcc_chan_put(msc->pcc_chan);
+
 	mutex_lock(&mpam_list_lock);
 	mpam_msc_destroy(msc);
 	mutex_unlock(&mpam_list_lock);
@@ -2285,7 +2374,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
 static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 {
 	int err;
-	u32 tmp;
+	u32 pcc_subspace_id;
 	struct mpam_msc *msc;
 	struct resource *msc_res;
 	struct device *dev = &pdev->dev;
@@ -2329,7 +2418,7 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 	if (err)
 		return ERR_PTR(err);
 
-	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
+	if (device_property_read_u32(dev, "pcc-channel", &pcc_subspace_id))
 		msc->iface = MPAM_IFACE_MMIO;
 	else
 		msc->iface = MPAM_IFACE_PCC;
@@ -2350,6 +2439,26 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 		}
 		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
 		msc->mapped_hwpage = io;
+	} else if (msc->iface == MPAM_IFACE_PCC) {
+		msc->pcc_chan = mpam_pcc_chan_get(dev, pcc_subspace_id);
+		if (IS_ERR(msc->pcc_chan)) {
+			pr_err("Failed to request MSC PCC channel\n");
+			return ERR_CAST(msc->pcc_chan);
+		}
+
+		err = mpam_fb_check_shared_buffer_size(msc);
+		if (err) {
+			mpam_pcc_chan_put(msc->pcc_chan);
+
+			return ERR_PTR(err);
+		}
+
+		err = mpam_fb_check_protocol_version(msc);
+		if (err) {
+			mpam_pcc_chan_put(msc->pcc_chan);
+
+			return ERR_PTR(err);
+		}
 	} else {
 		return ERR_PTR(-EINVAL);
 	}
diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
index bb743ee460a2..73cc1b09f676 100644
--- a/drivers/resctrl/mpam_fb.c
+++ b/drivers/resctrl/mpam_fb.c
@@ -20,10 +20,15 @@
 #define MPAM_FB_PROTOCOL_ID		0x1a
 
 #define MPAM_PROTOCOL_VERSION_CMD	0x0
+#define MPAM_FB_VERSION_MAJOR_MASK		GENMASK_U32(31, 16)
+#define MPAM_FB_VERSION_MINOR_MASK		GENMASK_U32(15, 0)
+
 #define MPAM_MSC_READ_CMD		0x4
 #define MPAM_MSC_WRITE_CMD		0x5
 
 #define MPAM_FB_PROT_HEADER_LEN		sizeof(u32)
+/* The longest message is MPAM_MSC_WRITE, with 4 parameters. */
+#define MPAM_FB_MAX_MSG_SIZE		(4 * sizeof(u32))
 
 #define MPAM_FB_SUCCESS		 0
 #define MPAM_FB_ERR_NOT_SUPPORTED	-1
@@ -209,3 +214,39 @@ int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
 	return mpam_fb_send_request(msc, msc->id, reg, &value,
 				    MPAM_MSC_WRITE_CMD);
 }
+
+/* We only support MPAM-Fb protocol version 1.x */
+int mpam_fb_check_protocol_version(struct mpam_msc *msc)
+{
+	u32 version;
+	int ret;
+
+	ret = mpam_fb_send_request(msc, 0, 0, &version,
+				   MPAM_PROTOCOL_VERSION_CMD);
+	if (ret)
+		return ret;
+
+	if (FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, version) != 1) {
+		pr_err("Incompatible MPAM-Fb protocol version %d.%d\n",
+		       FIELD_GET(MPAM_FB_VERSION_MAJOR_MASK, version),
+		       FIELD_GET(MPAM_FB_VERSION_MINOR_MASK, version));
+
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int mpam_fb_check_shared_buffer_size(struct mpam_msc *msc)
+{
+	int min_buffer_size = MPAM_FB_MAX_MSG_SIZE +
+			      sizeof(struct acpi_pcct_ext_pcc_shared_memory);
+
+	if (msc->pcc_chan->pcc_chan->shmem_size < min_buffer_size) {
+		pr_err("MPAM-Fb PCC channel size too small.\n");
+
+		return -ENOMEM;
+	}
+
+	return 0;
+}
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index f13a79a84c58..8859189088f3 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -528,6 +528,8 @@ static inline void mpam_resctrl_teardown_class(struct mpam_class *class) { }
 /* MPAM-Fb Firmware-backed protocol wrappers */
 int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result);
 int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value);
+int mpam_fb_check_protocol_version(struct mpam_msc *msc);
+int mpam_fb_check_shared_buffer_size(struct mpam_msc *msc);
 
 /*
  * MPAM MSCs have the following register layout. See:
-- 
2.43.0


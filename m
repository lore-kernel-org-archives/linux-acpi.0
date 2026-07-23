Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC4B4DB569;
	Thu, 23 Jul 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822140; cv=none; b=bWfBAwL6J0iGDcheN8UCAqpIQg7CiOKvro3D7dCqtGmdXSRuzfgqeu0iRUL0ulGcAR31n+sqRuP3dYWLe51yuATdD4J4guElbt2fOgeG70W/VB9J0MYI70rNpMJcU09RZM/AOxB09/LUGzcIVCLOdgZHAlulEDpaGl3cs4OVQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822140; c=relaxed/simple;
	bh=puaj69qRzbjRL3t0MWqCptnRjoA/ON3kxaK9k+GBkkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgktPIIIjqq+D6o0yABVgwzWgtTQlSZ/1o1yufdltnZw/NHx4EuqM3Fwe+mgT6cjLQQp5iMDfHWiyHai9sLfR8kJ0HMw2647NFvqUJEU2TjCZ7EgOsPmfzT4tx1Q4pm+ic8yTa1GkuJUn5QHjjrX/4XFeWZvf7LWfX76QZj6+HE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=pUP7XKFR; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="pUP7XKFR"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B73F8176B;
	Thu, 23 Jul 2026 08:55:33 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 835033F66F;
	Thu, 23 Jul 2026 08:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784822137; bh=puaj69qRzbjRL3t0MWqCptnRjoA/ON3kxaK9k+GBkkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pUP7XKFRrLDn8C8dPk9DCU40gz879qwLoGCmizOxxvW6YtGOLeuteHtRQcFSSgqrB
	 ND1Y6yf4Un9h4f43NB/B+BNt1N6OREtQMkA95z+EftjBDaAAA+uAu3803qtaMXWhex
	 oBVVAMMw/gYf4vqz8diu7A9nNjdQO5+MHK3IgY3A=
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
Subject: [PATCH v4 10/10] arm_mpam: detect and enable MPAM-Fb PCC support
Date: Thu, 23 Jul 2026 17:54:54 +0200
Message-ID: <20260723155454.1760823-11-andre.przywara@arm.com>
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
---
 drivers/acpi/arm64/mpam.c      |   6 +-
 drivers/resctrl/mpam_devices.c | 127 ++++++++++++++++++++++++++++++++-
 2 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
index 84963a20c3e7..ca9b8754ae5f 100644
--- a/drivers/acpi/arm64/mpam.c
+++ b/drivers/acpi/arm64/mpam.c
@@ -220,8 +220,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
 	struct platform_device *pdev __free(platform_device_put) =
 		platform_device_alloc("mpam_msc", tbl_msc->identifier);
 	int next_res = 0, next_prop = 0, err;
-	/* pcc, nrdy, affinity and a sentinel */
-	struct property_entry props[4] = { 0 };
+	/* pcc, msc-id, nrdy, affinity and a sentinel */
+	struct property_entry props[5] = { 0 };
 	/* mmio, 2xirq, no sentinel. */
 	struct resource res[3] = { 0 };
 	struct acpi_device *companion;
@@ -256,6 +256,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
 	} else if (iface == MPAM_IFACE_PCC) {
 		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
 							tbl_msc->base_address);
+		props[next_prop++] = PROPERTY_ENTRY_U32("msc-id",
+							tbl_msc->identifier);
 	}
 
 	acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index fea3161ffbe9..fc4b5f87fbe9 100644
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
@@ -49,6 +54,86 @@ static LIST_HEAD(mpam_all_msc);
 
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
+	kfree(cur);
+}
+
+static struct mpam_pcc_chan *mpam_pcc_chan_get(struct device *dev,
+					       int subspace_id)
+{
+	struct mpam_pcc_chan *cur;
+	int ret;
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
+	/* Timeout based on the "nominal latency" from the PCC ACPI table. */
+	cur->pcc_cl.tx_tout = cur->pcc_chan->latency * 5;
+
+	ret = devm_mutex_init(dev, &cur->pcc_chan_lock);
+	if (ret)
+		return ERR_PTR(ret);
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
@@ -2201,6 +2286,8 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
 {
 	struct mpam_msc *msc = platform_get_drvdata(pdev);
 
+	mpam_pcc_chan_put(msc->pcc_chan);
+
 	mutex_lock(&mpam_list_lock);
 	mpam_msc_destroy(msc);
 	mutex_unlock(&mpam_list_lock);
@@ -2211,7 +2298,7 @@ static void mpam_msc_drv_remove(struct platform_device *pdev)
 static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 {
 	int err;
-	u32 tmp;
+	u32 pcc_subspace_id;
 	struct mpam_msc *msc;
 	struct resource *msc_res;
 	struct device *dev = &pdev->dev;
@@ -2259,7 +2346,8 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 	if (err)
 		return ERR_PTR(err);
 
-	if (device_property_read_u32(&pdev->dev, "pcc-channel", &tmp))
+	if (device_property_read_u32(&pdev->dev, "pcc-channel",
+				     &pcc_subspace_id))
 		msc->iface = MPAM_IFACE_MMIO;
 	else
 		msc->iface = MPAM_IFACE_PCC;
@@ -2275,6 +2363,41 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 		}
 		msc->mapped_hwpage_sz = msc_res->end - msc_res->start;
 		msc->mapped_hwpage = io;
+	} else if (msc->iface == MPAM_IFACE_PCC) {
+		u32 msc_id;
+		int ret;
+
+		if (device_property_read_u32(&pdev->dev, "msc-id", &msc_id)) {
+			pr_err("missing MPAM-Fb MSC identifier\n");
+			return ERR_PTR(-EINVAL);
+		}
+		msc->mpam_fb_msc_id = msc_id;
+
+		msc->pcc_chan = mpam_pcc_chan_get(&pdev->dev, pcc_subspace_id);
+		if (IS_ERR(msc->pcc_chan)) {
+			pr_err("Failed to request MSC PCC channel\n");
+			return ERR_CAST(msc->pcc_chan);
+		}
+
+		if (msc->pcc_chan->pcc_chan->shmem_size < MPAM_FB_MAX_MSG_SIZE) {
+			pr_err("MPAM-Fb PCC channel size too small.\n");
+			mpam_pcc_chan_put(msc->pcc_chan);
+			return ERR_PTR(-ENOMEM);
+		}
+		ret = mpam_fb_get_protocol_version(msc);
+		if (ret < 0) {
+			pr_err("Cannot query MPAM-Fb protocol version.\n");
+			mpam_pcc_chan_put(msc->pcc_chan);
+
+			/* ret is an MPAM-Fb error code, return a Linux one. */
+			return ERR_PTR(-EIO);
+		}
+		if ((ret >> 16) != 1) {
+			pr_err("Incompatible MPAM-Fb protocol version %d.%d\n",
+			       ret >> 16, ret & 0xffff);
+			mpam_pcc_chan_put(msc->pcc_chan);
+			return ERR_PTR(-EINVAL);
+		}
 	} else {
 		return ERR_PTR(-EINVAL);
 	}
-- 
2.43.0


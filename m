Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43C23BBFBA;
	Mon,  3 Aug 2026 17:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785776711; cv=none; b=o4IyE0H5Jm1NfiqlZoEDtyuRJ8noQfuTBKOUD9OR9XUgO0Ww9ztoASWCHqhcjSoDmAQcfjBoucVYdFM1qJo1fkeXUgb1k/wCp0mVOp6tK0XnFVWYrN+LNtuCCYzHmvgn34GNLr2TU3FyMlyBOafX6w8MrBxBYcMY2xxT9d9pUTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785776711; c=relaxed/simple;
	bh=8ylZj4mCSSNDkUIDMUbdM6OiX2Xn4Kwb5/xvgqqQr5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk/hfZRDWSa9IjKUqXvfSe0nZa+qdObprO1dx0TqBuRpUO6IzFOfx9ObRCt8nyDdfUXDIJW0SprHUl/PA+2+qPWm/4wbomOzOTQC1PIWsS36Ev/NJQUi8Ph8DphcPKMnv4GxpyaWcjpxlVcYEcx0WGDQOSKznDWh7I9LyaYIzB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=spKlICXV; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="spKlICXV"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 805F21476;
	Mon,  3 Aug 2026 10:05:04 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 72A9A3F632;
	Mon,  3 Aug 2026 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785776708; bh=8ylZj4mCSSNDkUIDMUbdM6OiX2Xn4Kwb5/xvgqqQr5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=spKlICXVnziC366fHmXzRD1CHs7aF0l8ZStMuynkfx2uSHGO3pX2tJpqmLC5TJm96
	 azLtJD9DNHhTrVSdylvlp7+c3SpmPSRhtjF99H9L7JgS4dGaAuTKYH9SOw3yIXq6Cl
	 gfuXZlScO+YZevJgurf+ed9zxrpqwy4Zv0uAeaw4=
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
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] FIX: avoid using mailbox client dev pointer for error prints
Date: Mon,  3 Aug 2026 19:04:58 +0200
Message-ID: <20260803170458.3135976-1-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731170324.2927758-12-andre.przywara@arm.com>
References: <20260731170324.2927758-12-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a PCC channel is shared among several MSCs, all use the same
mailbox client struct, which contains the device pointer of the very
first MSC created. If that MSC goes away, the dev pointer becomes stale.
We use that pointer only for error printing, so drop that usage. We can
use the dev pointer from the MSC instead, which the callers of
mpam_fb_send_request() know.
The mailbox client code also seems to use this pointer only for error
prints, and only during initialisation, so it becoming stale afterwards
does not cause problems.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
Hi,

so this is the fix for the issue that Srivathsa described. This applies
on top of the v7 series posted. I put up a branch with the patch
squashed here:
https://gitlab.arm.com/linux-arm/linux-ap/-/commits/mpam-fb-v7-fixed?ref_type=heads
If I shall post a v8, please let me know.

Cheers,
Andre

 drivers/resctrl/mpam_fb.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/resctrl/mpam_fb.c b/drivers/resctrl/mpam_fb.c
index 7a7fb6d067ba..79e0229b77c1 100644
--- a/drivers/resctrl/mpam_fb.c
+++ b/drivers/resctrl/mpam_fb.c
@@ -6,6 +6,7 @@
 #include <linux/errno.h>
 #include <linux/mailbox_client.h>
 #include <linux/mutex.h>
+#include <linux/platform_device.h>
 #include <linux/types.h>
 
 #include <acpi/pcc.h>
@@ -128,17 +129,19 @@ static int mpam_fb_translate_error_code(int mpam_fb_code)
 	}
 }
 
-static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
+static int mpam_fb_send_request(struct mpam_msc *msc, u32 msc_id,
 				u16 reg, u32 *result, int mpam_fb_command)
 {
 	unsigned int token = atomic_inc_return(&mpam_fb_token);
 	struct acpi_pcct_ext_pcc_shared_memory __iomem *pcc_shmem;
+	struct mpam_pcc_chan *pcc_chan;
 	struct pcc_mbox_chan *chan;
 	void __iomem *payload_ofs;
 	int mpam_fb_err = 0;
 	u32 status;
 	int ret;
 
+	pcc_chan = msc->pcc_chan;
 	if (!pcc_chan)
 		return -ENODEV;
 
@@ -162,7 +165,7 @@ static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
 		mpam_fb_build_version_message(token, chan->shmem);
 		break;
 	default:
-		dev_err(pcc_chan->pcc_cl.dev, "unsupported MPAM-Fb command %d\n",
+		dev_err(&msc->pdev->dev, "unsupported MPAM-Fb command %d\n",
 			mpam_fb_command);
 		ret = -EINVAL;
 		goto out_err;
@@ -203,13 +206,13 @@ static int mpam_fb_send_request(struct mpam_pcc_chan *pcc_chan, u32 msc_id,
 
 int mpam_fb_send_read_request(struct mpam_msc *msc, u16 reg, u32 *result)
 {
-	return mpam_fb_send_request(msc->pcc_chan, msc->id, reg, result,
+	return mpam_fb_send_request(msc, msc->id, reg, result,
 				    MPAM_MSC_READ_CMD);
 }
 
 int mpam_fb_send_write_request(struct mpam_msc *msc, u16 reg, u32 value)
 {
-	return mpam_fb_send_request(msc->pcc_chan, msc->id, reg, &value,
+	return mpam_fb_send_request(msc, msc->id, reg, &value,
 				    MPAM_MSC_WRITE_CMD);
 }
 
@@ -219,7 +222,7 @@ int mpam_fb_check_protocol_version(struct mpam_msc *msc)
 	u32 version;
 	int ret;
 
-	ret = mpam_fb_send_request(msc->pcc_chan, 0,
+	ret = mpam_fb_send_request(msc, 0,
 				   0, &version, MPAM_PROTOCOL_VERSION_CMD);
 	if (ret)
 		return ret;
-- 
2.43.0


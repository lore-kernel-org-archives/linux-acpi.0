Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0450242E00B;
	Fri, 10 Jul 2026 14:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694763; cv=none; b=g/Jf+3gjDAoeaPNdnaTsub1drafI2k0609wiVC8xGkssXmaXEOwTXY29rf633a+TkbrH5jYoo5gGn7DpOtpfqFlq9hMJr464mRkT725Ys8fbC0yPY4CmxeEQGQq8zZtu+FQtfwp+op6HB06f0i1QIp/H2BZrAwd4CuG26u20Buc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694763; c=relaxed/simple;
	bh=LtzgxM6qOWpziK1YO1CIa7BsMHy549pWpqPWc8ykDbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rzDSIMoPYCWLezbSUdoWuzPwW3TTlct3dXHsaZOdIpuafofPIyKAwE86WP3zDW0C3jv7QlRNZKkNYS2Gel62V/+I/oeLECEHriK7hnoy3P+1W1Wv5/KJwxzoJHErAtGemR+NpDVDj0Ef73tmt8GB9a2CLubgnf+C90lsFav/dds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=BCzW7xgs; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="BCzW7xgs"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 035571E7D;
	Fri, 10 Jul 2026 07:45:52 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5A57A3F7B4;
	Fri, 10 Jul 2026 07:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694756; bh=LtzgxM6qOWpziK1YO1CIa7BsMHy549pWpqPWc8ykDbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCzW7xgswr7TO5SXyFGV8R5x6zC6Q8mWHK9UpTDCmU1+aD70CWYDzA6eiKV9hMHDt
	 P7N3ec9IKfuqZSd6BGOPJokMFoAgUvBj7ZAxxyvurQmnfNpWd2IgkRlL4nAf12Z22q
	 +ZaIrK/xEB6BgMHLmC+LQ2+xJ5lxARfAzKkPFkQU=
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
Subject: [PATCH v3 06/16] arm_mpam: propagate MSC read errors for __ris_msmon_read()
Date: Fri, 10 Jul 2026 16:45:10 +0200
Message-ID: <20260710144520.917375-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710144520.917375-1-andre.przywara@arm.com>
References: <20260710144520.917375-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the function for RIS accesses to return an error, and propagate
read errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 041fca018e68..84a8715464be 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1297,6 +1297,10 @@ static u64 mpam_msmon_overflow_val(enum mpam_device_features type,
 	return overflow_val;
 }
 
+/*
+ * This function might be called via smp_call_function_any(), so propagate
+ * errors inside the arg struct.
+ */
 static void __ris_msmon_read(void *arg)
 {
 	u64 now;
@@ -1339,7 +1343,9 @@ static void __ris_msmon_read(void *arg)
 	 * Read the existing configuration to avoid re-writing the same values.
 	 * This saves waiting for 'nrdy' on subsequent reads.
 	 */
-	read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
+	ret = read_msmon_ctl_flt_vals(m, &cur_ctl, &cur_flt);
+	if (ret)
+		goto out_unlock;
 
 	if (mpam_feat_msmon_mbwu_31counter == m->type)
 		overflow = cur_ctl & MSMON_CFG_x_CTL_OFLOW_STATUS;
@@ -1364,7 +1370,9 @@ static void __ris_msmon_read(void *arg)
 
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
-		mpam_read_monsel_reg(msc, CSU, &now32);
+		ret = mpam_read_monsel_reg(msc, CSU, &now32);
+		if (ret)
+			goto out_unlock;
 		nrdy = now32 & MSMON___NRDY;
 		now = FIELD_GET(MSMON___VALUE, now32);
 
@@ -1385,7 +1393,9 @@ static void __ris_msmon_read(void *arg)
 			else
 				now = FIELD_GET(MSMON___L_VALUE, now);
 		} else {
-			mpam_read_monsel_reg(msc, MBWU, &now32);
+			ret = mpam_read_monsel_reg(msc, MBWU, &now32);
+			if (ret)
+				goto out_unlock;
 			nrdy = now32 & MSMON___NRDY;
 			now = FIELD_GET(MSMON___VALUE, now32);
 		}
@@ -1748,6 +1758,7 @@ static int mpam_restore_mbwu_state(void *_ris)
 {
 	int i;
 	u64 val;
+	int ret = 0;
 	struct mon_read mwbu_arg;
 	struct mpam_msc_ris *ris = _ris;
 	struct mpam_class *class = ris->vmsc->comp->class;
@@ -1760,10 +1771,14 @@ static int mpam_restore_mbwu_state(void *_ris)
 			mwbu_arg.val = &val;
 
 			__ris_msmon_read(&mwbu_arg);
+			if (mwbu_arg.err) {
+				ret = mwbu_arg.err;
+				break;
+			}
 		}
 	}
 
-	return 0;
+	return ret;
 }
 
 /* Call with MSC cfg_lock held */
-- 
2.43.0


Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74142E8FD;
	Fri, 10 Jul 2026 14:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694766; cv=none; b=rkpBpgbzmWrjd+T4d7RH+Es6Z7wQTGFp4DWT8gbYinkffWldtkCfo/C7KLATGDxoSHdt+P1NGgkx9mtma6drCIiW9Q7KVs3hwdL/Z1XbzvW3GG4AQR2QL6DrX+pY3I+GsXN6kSyiA/EfpEsF/IJKvZ9wBMLNxz6wW0qdbcqXz4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694766; c=relaxed/simple;
	bh=y4YshKpJKf9hQH4Dk+4ONKPsAibk4pSYAqjEPmvDFlw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fpLbEuJtcW9/EBVGoeRoITWYdAoDdTNHmF6ym+j0TBbKyPhaSZvHLiXujnNcHT2XJM/XMiojGEqoc4fdIfS9eOym6L+up5AhYmXKx+pfl+Duj0Rie+pcp9V4nHQan+jL+zfZbB/OG7dWbSbbS+XxbKaDQO1TuF029cFB8aRKM0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=H7OVNtLW; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="H7OVNtLW"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 538681F60;
	Fri, 10 Jul 2026 07:45:56 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACCA43F7B4;
	Fri, 10 Jul 2026 07:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694760; bh=y4YshKpJKf9hQH4Dk+4ONKPsAibk4pSYAqjEPmvDFlw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H7OVNtLWAmLa4Rvo6npjkySOAERsLGzTVlxkRKMcVJwSycGjqd3Vi6TaFt47/nQgG
	 0e24pdaQylZwbl3Prles1bLRVZhgZcOOuzvkhN0SeD0uWpIR1WMbAzsmX4JP5O1dvA
	 YMwqhvVIYaXcWUXJQQeTxkkv+Lffnwj2p51NzmGg=
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
Subject: [PATCH v3 07/16] arm_mpam: __ris_msmon_read(): get rid of nrdy special handling
Date: Fri, 10 Jul 2026 16:45:11 +0200
Message-ID: <20260710144520.917375-8-andre.przywara@arm.com>
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

Although so far MSC accesses couldn't fail, there is one special
condition that would create an error: when the MBWU counter wouldn't be
able to read a stable value, we were setting bit 63 to mark this value
as unstable, and return this as an error later.
Now since the functions can return a proper error value, we can get rid of
this kludge and use the return value directly.

Remove the "nrdy" error flag variable, and assign -EBUSY to "ret" to handle
this case.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 38 +++++++++++++++-------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 84a8715464be..530ac0fe97b5 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1306,7 +1306,6 @@ static void __ris_msmon_read(void *arg)
 	u64 now;
 	int ret;
 	u32 now32;
-	bool nrdy = false;
 	bool config_mismatch;
 	bool overflow = false;
 	struct mon_read *m = arg;
@@ -1371,14 +1370,18 @@ static void __ris_msmon_read(void *arg)
 	switch (m->type) {
 	case mpam_feat_msmon_csu:
 		ret = mpam_read_monsel_reg(msc, CSU, &now32);
+		if (!ret) {
+			if ((now32 & MSMON___NRDY))
+				ret = -EBUSY;
+
+			if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) &&
+			    m->waited_timeout)
+				ret = 0;
+		}
 		if (ret)
 			goto out_unlock;
-		nrdy = now32 & MSMON___NRDY;
-		now = FIELD_GET(MSMON___VALUE, now32);
-
-		if (mpam_has_quirk(IGNORE_CSU_NRDY, msc) && m->waited_timeout)
-			nrdy = false;
 
+		now = FIELD_GET(MSMON___VALUE, now32);
 		break;
 	case mpam_feat_msmon_mbwu_31counter:
 	case mpam_feat_msmon_mbwu_44counter:
@@ -1394,9 +1397,11 @@ static void __ris_msmon_read(void *arg)
 				now = FIELD_GET(MSMON___L_VALUE, now);
 		} else {
 			ret = mpam_read_monsel_reg(msc, MBWU, &now32);
+			if (!ret && (now32 & MSMON___NRDY))
+				ret = -EBUSY;
 			if (ret)
 				goto out_unlock;
-			nrdy = now32 & MSMON___NRDY;
+
 			now = FIELD_GET(MSMON___VALUE, now32);
 		}
 
@@ -1404,9 +1409,6 @@ static void __ris_msmon_read(void *arg)
 		    m->type != mpam_feat_msmon_mbwu_63counter)
 			now *= 64;
 
-		if (nrdy)
-			break;
-
 		mbwu_state = &ris->mbwu_state[ctx->mon];
 
 		if (overflow)
@@ -1419,22 +1421,16 @@ static void __ris_msmon_read(void *arg)
 		now += mbwu_state->correction;
 		break;
 	default:
-		m->err = -EINVAL;
+		ret = -EINVAL;
 	}
-	mpam_mon_sel_unlock(msc);
-
-	if (nrdy)
-		m->err = -EBUSY;
-
-	if (!m->err)
-		*m->val += now;
-
-	return;
 
 out_unlock:
 	mpam_mon_sel_unlock(msc);
 
-	m->err = ret;
+	if (ret)
+		m->err = ret;
+	else
+		*m->val += now;
 }
 
 static int _msmon_read(struct mpam_component *comp, struct mon_read *arg)
-- 
2.43.0


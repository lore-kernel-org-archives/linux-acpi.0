Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EF52430792;
	Fri, 10 Jul 2026 14:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694771; cv=none; b=dH8WiZ0MUETNDHViyvz+IJPdx/4vGo5OyI5otnwM80q64EvqexePmPJ0EZRvB4NFjrKiMGJzP+0fpzh/x2aVjJnj1QJbotiWGblLOJ1kkp/1ClHSvT1SpjO/pTeq0kt8oO8KbDNlKETMdNbc93cR9db5EZvJkwHigr+e4QdUZZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694771; c=relaxed/simple;
	bh=zG916CSOag+6bdGmf8ocN9C8ja+Ns+Zo3Yu0tdFYbbc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k9JfnHAD3JaKARITvGDv3PYmMjIOu0Lom0mS37UCzci3VPPPqslDnyIyzQvTaAEv5XjNey7HDCvVRJ25pcXRpHS8PZ/p2O+Jgp8JP2DtG6fUj29OPodfdXw0w7nI7RERwsXP/Rhdw+8I8fMIk40C6Ed4wOhrxHkwlzZexH2kIE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=fLekdet2; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="fLekdet2"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 078B02308;
	Fri, 10 Jul 2026 07:46:05 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DA013F7B4;
	Fri, 10 Jul 2026 07:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694769; bh=zG916CSOag+6bdGmf8ocN9C8ja+Ns+Zo3Yu0tdFYbbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fLekdet2zS/dSBydNcU2ITDWBc96c7Za8WFrZEIw8ghtBdrGBBJFwKo1ceBbyEK4Q
	 GLasTVIQlNlq4UF3ReWh+DjvVAvo7sEiflr2pORm7v81V/gsTtPs0LL1JjmXM6U1Cn
	 IneqeWuqA1/bSqCVVrSaPddGwyJq21hMbKY5XMgk=
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
Subject: [PATCH v3 09/16] arm_mpam: let low level MSC write accessors return an error
Date: Fri, 10 Jul 2026 16:45:13 +0200
Message-ID: <20260710144520.917375-10-andre.przywara@arm.com>
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

The upcoming MPAM-Fb support does not use MMIO primitives to access an
MSC, but employs a shared-memory/doorbell based firmware protocol.
Its complexity means that is must be able to handle errors, whereas we
always assume an MSC access succeeds today.

Change the __mpam_write_reg() low level accessor function to return an
error code. At the moment this is always 0, but this will change with
alternative MSC access methods.

Also change some low level wrappers to propagate the error.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_devices.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index b2ecaba29fcc..f1e40ce24f5a 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -195,18 +195,20 @@ static inline int _mpam_read_partsel_reg(struct mpam_msc *msc, u16 reg,
 
 #define mpam_read_partsel_reg(msc, reg, res) _mpam_read_partsel_reg(msc, MPAMF_##reg, res)
 
-static void __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
+static int __mpam_write_reg(struct mpam_msc *msc, u16 reg, u32 val)
 {
 	WARN_ON_ONCE(reg + sizeof(u32) > msc->mapped_hwpage_sz);
 	WARN_ON_ONCE(!cpumask_test_cpu(smp_processor_id(), &msc->accessibility));
 
 	writel_relaxed(val, msc->mapped_hwpage + reg);
+
+	return 0;
 }
 
-static inline void _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
+static inline int _mpam_write_partsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
 {
 	lockdep_assert_held_once(&msc->part_sel_lock);
-	__mpam_write_reg(msc, reg, val);
+	return __mpam_write_reg(msc, reg, val);
 }
 
 #define mpam_write_partsel_reg(msc, reg, val)  _mpam_write_partsel_reg(msc, MPAMCFG_##reg, val)
@@ -220,10 +222,10 @@ static inline int _mpam_read_monsel_reg(struct mpam_msc *msc, u16 reg,
 
 #define mpam_read_monsel_reg(msc, reg, res) _mpam_read_monsel_reg(msc, MSMON_##reg, res)
 
-static inline void _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
+static inline int _mpam_write_monsel_reg(struct mpam_msc *msc, u16 reg, u32 val)
 {
 	mpam_mon_sel_lock_held(msc);
-	__mpam_write_reg(msc, reg, val);
+	return __mpam_write_reg(msc, reg, val);
 }
 
 #define mpam_write_monsel_reg(msc, reg, val)   _mpam_write_monsel_reg(msc, MSMON_##reg, val)
-- 
2.43.0


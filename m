Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE023A0E8A;
	Thu,  2 Jul 2026 16:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783009400; cv=none; b=sAL/kg/oeLPYVdqSM2Z+97fg/XdXAEsoJNSnz0uJ16AXbsptnWSIb3mBN0ig5gkuCJf4/K27Uv2DDnmRrTj3CqvxFAFU3zaAXRk/UotcL5rRvu6sBwwznThVDbi53J8/4hbBUr3tgwpsUv6ZxX5cZVDLvXkzO0QeMCWhpxHf15g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783009400; c=relaxed/simple;
	bh=StaJVar/MFIJDg7zd2ZfnqLePqmUuN9KdghK7iL1+YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ji9gt0KtvLAcncop2i0y2bIP/tBQ6CJJxdZowCp4SXN58my36jv2B+q9rbbXpMLP+K753/glBYdL4Y0ccVyPKgL/ZGkWIkGxmRWBmzNdAPL7oj1jfHWoF3ImVHBm/oGlnSOOguoVX+fprx/NZTUAOcU4CQKbc7fk5u+bwXY3M4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=PzmHFrPk; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="PzmHFrPk"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D10D35C7;
	Thu,  2 Jul 2026 09:23:08 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC6333F673;
	Thu,  2 Jul 2026 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783009392; bh=StaJVar/MFIJDg7zd2ZfnqLePqmUuN9KdghK7iL1+YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PzmHFrPk9uPqB7UUnfiAMxTkKxcZU1XlJQ2T+ZOjAu103bzBgImlcmqayqMwt2QFO
	 ZKsRB1i148kNXsuRziWqCjRElsQVWomXmsNolTxieurST2xDlH8Se+Hj/8Tq1wy29T
	 HiBeRQbKy9efF/n4vwQv9B63wQaKcrJR68p4wPZk=
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
Subject: [PATCH v2 08/15] arm_mpam: let low level MSC write accessors return an error
Date: Thu,  2 Jul 2026 18:22:22 +0200
Message-ID: <20260702162229.4008659-9-andre.przywara@arm.com>
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
index c50ca0e4f426..a7adc75a079c 100644
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


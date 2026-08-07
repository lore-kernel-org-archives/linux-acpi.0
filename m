Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1BC431A23;
	Fri,  7 Aug 2026 10:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786100145; cv=none; b=QenoR6YZgWee+ERG8b4N50ud5PmUIwAsfinwG2ZwgqSIt9/Yp6amxLcAUQOT0G69SuUd60JSAcoK/jvlDP3Uj6OuVteCSElG4yQZ7wjvBim4f7lOvJ/q5WoOYz+271YNivq6re/PWwVIqB/yjdbbpX6DnDR8ebeaf4yi3sdhva8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786100145; c=relaxed/simple;
	bh=wDkYmkx6x2Gn5xpCYCOLTVpZ0Id3kkAQWmh+PhrfvZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZAXAAYO6JdTpiauKAsb6cpUQJuY1eVxv5BPFuwmyYCq0PLIOR3OUg77qLT1FNiHw5iPdqkiNhtbKIHdqWYPmulx4adH3FPSQ3WeY/hLdPxsVh1e80Mbs+8tRcOwB3cGAkZaHy7/ZmN1sGqLbO3AdTGflxhY1stH15U5ytIVkO90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=S8W7CW/+; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="S8W7CW/+"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 571CC1BCA;
	Fri,  7 Aug 2026 03:55:37 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B02CE3F9A2;
	Fri,  7 Aug 2026 03:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786100141; bh=wDkYmkx6x2Gn5xpCYCOLTVpZ0Id3kkAQWmh+PhrfvZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S8W7CW/+Wzr4o0sGwKcI85qC5tJACYstT6YCbTA91wvRfD+L3kdeCfDj61JxK16Id
	 4WeYEOWuyX6gDyrbBfsvGyjUcn8qxNEqSEZZN1AQy7OqlJqimtD3Sq6EbPX9OJ7IwX
	 xaLpUks9u/jh3BtQjDaQO0nyIit2aCviHA4Ml+d0=
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
Subject: [PATCH v9 09/12] arm_mpam: prepare mon_sel locking for MPAM-Fb
Date: Fri,  7 Aug 2026 12:54:48 +0200
Message-ID: <20260807105451.3728284-10-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807105451.3728284-1-andre.przywara@arm.com>
References: <20260807105451.3728284-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MSC MON_SEL register needs to be accessed from hardirq for the overflow
interrupt, and when taking an IPI to access these registers on platforms
where MSCs are not accesible from every CPU. This makes an irqsave
spinlock the obvious lock to protect these registers. On systems with
MPAM-Fb mailbox MSC access it must be able to sleep, meaning a mutex must
be used. So MPAM-Fb platforms cannot support an overflow interrupt easily.
Clearly these two methods can't exist for one MSC at the same time.

Change the mon_sel locking wrapper function to only use a spinlock when
the MSC is accessed directly via MMIO. In case of MPAM-Fb, we use a
mutex, but only if we are in a sleepable context. If that's not the
case, we return an error. This should not happen, as MPAM-Fb by design
does not require an MSC access to happen from a specific CPU, so there
is no need for any IPIs or preemption disabling to satisfy CPU
constraints. And since overflow interrupts are not supported at the moment
anyway, we also wouldn't meet the other case.
Bailing out early is already happening in rare occasions today.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
Reviewed-by: Gavin Shan <gshan@redhat.com>
Tested-by: Gavin Shan <gshan@redhat.com> # on NVIDIA Grace Hopper
---
 drivers/resctrl/mpam_devices.c  |  6 +++++-
 drivers/resctrl/mpam_internal.h | 38 +++++++++++++++++++++++++++------
 2 files changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index 1b07f7765f96..99c91c604dea 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -2281,7 +2281,6 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 	if (err)
 		return ERR_PTR(err);
 
-	mpam_mon_sel_lock_init(msc);
 	msc->id = pdev->id;
 	msc->pdev = pdev;
 	INIT_LIST_HEAD_RCU(&msc->all_msc_list);
@@ -2302,6 +2301,11 @@ static struct mpam_msc *do_mpam_msc_drv_probe(struct platform_device *pdev)
 	else
 		msc->iface = MPAM_IFACE_PCC;
 
+	/* Lock type depends on MSC interface used */
+	err = mpam_mon_sel_lock_init(dev, msc);
+	if (err)
+		return ERR_PTR(err);
+
 	if (msc->iface == MPAM_IFACE_MMIO) {
 		void __iomem *io;
 
diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 57f2b3dbf7d0..6121cd126510 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -126,6 +126,7 @@ struct mpam_msc {
 	 */
 	raw_spinlock_t		_mon_sel_lock;
 	unsigned long		_mon_sel_flags;
+	struct mutex		mon_sel_mutex;
 
 	void __iomem		*mapped_hwpage;
 	size_t			mapped_hwpage_sz;
@@ -139,27 +140,50 @@ struct mpam_msc {
 /* Returning false here means accesses to mon_sel must fail and report an error. */
 static inline bool __must_check mpam_mon_sel_lock(struct mpam_msc *msc)
 {
-	/* Locking will require updating to support a firmware backed interface */
-	if (WARN_ON_ONCE(msc->iface != MPAM_IFACE_MMIO))
+	if (msc->iface == MPAM_IFACE_MMIO) {
+		raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
+
+		return true;
+	}
+
+	if (!preemptible())
 		return false;
 
-	raw_spin_lock_irqsave(&msc->_mon_sel_lock, msc->_mon_sel_flags);
+	mutex_lock(&msc->mon_sel_mutex);
+
 	return true;
 }
 
 static inline void mpam_mon_sel_unlock(struct mpam_msc *msc)
 {
-	raw_spin_unlock_irqrestore(&msc->_mon_sel_lock, msc->_mon_sel_flags);
+	if (msc->iface == MPAM_IFACE_MMIO) {
+		raw_spin_unlock_irqrestore(&msc->_mon_sel_lock,
+					   msc->_mon_sel_flags);
+
+		return;
+	}
+
+	mutex_unlock(&msc->mon_sel_mutex);
 }
 
 static inline void mpam_mon_sel_lock_held(struct mpam_msc *msc)
 {
-	lockdep_assert_held_once(&msc->_mon_sel_lock);
+	if (msc->iface == MPAM_IFACE_MMIO)
+		lockdep_assert_held_once(&msc->_mon_sel_lock);
+	else
+		lockdep_assert_held_once(&msc->mon_sel_mutex);
 }
 
-static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
+static inline int mpam_mon_sel_lock_init(struct device *dev,
+					 struct mpam_msc *msc)
 {
-	raw_spin_lock_init(&msc->_mon_sel_lock);
+	if (msc->iface == MPAM_IFACE_MMIO) {
+		raw_spin_lock_init(&msc->_mon_sel_lock);
+
+		return 0;
+	}
+
+	return devm_mutex_init(dev, &msc->mon_sel_mutex);
 }
 
 DEFINE_GUARD(mon_sel, struct mpam_msc *,
-- 
2.43.0


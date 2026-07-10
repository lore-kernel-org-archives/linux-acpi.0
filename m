Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4216C434418;
	Fri, 10 Jul 2026 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694788; cv=none; b=p3ppuKsxc9B/EWgdQjBGkwWyy4OeTgDd/+eGVhUYXy/+Lc9vZ+tAdE//e2l0gt3NshIOYlXV2Yaf73W+dz2x2mFYxkORHgorZ/zCNrt7AkZ6pekS4QiMW710lnKlaA/Mdqae47WjtBlZJsazsNlwrQUgfOFT+uGZMamPZSC5C4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694788; c=relaxed/simple;
	bh=9nyWinbuoPyugAl/Ma176q7b/W3ugsTwHcJ4M6XsbZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KPTjAK+SqOPrs+Y15p60zQEBQRL4w21686xcSlukJJ/CpHF0WW3MiG/tYMp0zpL29TUGtwwT09nKahBLgmMC8XQ2xXK+VopwEDEhlRv4WpjLUEYKynOSYzeYyO92rGUwQjgDhAYqY9haL9yc0ur7d/upvXWXurAvEKUUOVjtC6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sBLVEQyG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sBLVEQyG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 617F31E7D;
	Fri, 10 Jul 2026 07:46:22 -0700 (PDT)
Received: from e142021.munich.arm.com (e142021.arm.com [10.41.150.148])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA5693F7B4;
	Fri, 10 Jul 2026 07:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1783694786; bh=9nyWinbuoPyugAl/Ma176q7b/W3ugsTwHcJ4M6XsbZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sBLVEQyGOyTjy3HGvsITwudjT7y/1YFK/Zeqy3XZtahs1uqXN+66C9QGmbFL58IaR
	 kUSI6K9v0nzHSgo6D6b4C3jHpgk6gd4q3ua25zzwa3g4eFo6TClKrwTkfUWLhugI0a
	 MJXOOoV3BsZtJGUk3VbP8hDiOGReatddN6ld1JZk=
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
Subject: [PATCH v3 13/16] arm_mpam: prepare mon_sel locking for MPAM-Fb
Date: Fri, 10 Jul 2026 16:45:17 +0200
Message-ID: <20260710144520.917375-14-andre.przywara@arm.com>
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

The MSC MON_SEL register needs to be accessed from hardirq for the overflow
interrupt, and when taking an IPI to access these registers on platforms
where MSC are not accesible from every CPU. This makes an irqsave
spinlock the obvious lock to protect these registers. On systems with SCMI
mailboxes it must be able to sleep, meaning a mutex must be used. The
SCMI platforms can't support an overflow interrupt.
Clearly these two can't exist for one MSC at the same time.

Change the mon_sel locking wrapper function to only use a spinlock when
the MSC is accessed directly via MMIO. In case of MPAM-Fb, we use a
mutex, but only if we are in a sleepable context. If that's not the
case, we return an error. This should not happen, as MPAM-Fb by design
does not require an MSC access to happen from a specific CPU, so there
is no need for any IPIs or preemption disabling to satisfy CPU
constraints. And since overflow interrupts are not supported at the moment
anyway, we also wouldn't meet the other case.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/resctrl/mpam_internal.h | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/resctrl/mpam_internal.h b/drivers/resctrl/mpam_internal.h
index 04d1a59f02af..7b6e0df904f8 100644
--- a/drivers/resctrl/mpam_internal.h
+++ b/drivers/resctrl/mpam_internal.h
@@ -126,6 +126,7 @@ struct mpam_msc {
 	 */
 	raw_spinlock_t		_mon_sel_lock;
 	unsigned long		_mon_sel_flags;
+	struct mutex		mon_sel_mutex;
 
 	void __iomem		*mapped_hwpage;
 	size_t			mapped_hwpage_sz;
@@ -139,27 +140,44 @@ struct mpam_msc {
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
 
 static inline void mpam_mon_sel_lock_init(struct mpam_msc *msc)
 {
 	raw_spin_lock_init(&msc->_mon_sel_lock);
+	mutex_init(&msc->mon_sel_mutex);
 }
 
 /* Bits for mpam features bitmaps */
-- 
2.43.0


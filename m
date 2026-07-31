Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32FD0451071;
	Fri, 31 Jul 2026 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785517442; cv=none; b=l5UDR1mMvzcGlPh9VZgcTzaO3vHOGOFzaoScXtgufDKe4oaDSGguqWvJ8ramqVCrD15LpCtd4dPf2x09OMh6BbIxfhtr3wpLJEAjH6ZnJzjySevxrrfNKjaiVdFrYky2stQszPy+L/AMMgRws0AE6iDSJGwlB8qapu/S+UxL9wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785517442; c=relaxed/simple;
	bh=gx2sJjkF0UHE+KRG16kTE2Zuv4r4Qdh+PeWJ6EjL7JA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bz+wMtp5vsyMcNYXDeY0YpZlWIZqbGcKvdm6CkXh8cu74LemMZOSzl3mzJpNOmdfNaohHi2+3WR5324D4hAHAfaj5gj51EaYI8/NfpfIH33UGsT2UDGgmP3tYBUDsNPCHXet126Ob0VWot+JHR+IMp0kJCM8ipVFSDt50Kkws7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=lRa/cNqa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="lRa/cNqa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 67DC1204C;
	Fri, 31 Jul 2026 10:03:56 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E80E93F66F;
	Fri, 31 Jul 2026 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785517440; bh=gx2sJjkF0UHE+KRG16kTE2Zuv4r4Qdh+PeWJ6EjL7JA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lRa/cNqa+c77MRtEjdjdS73Wjq6gRDeZgvT84OdEfV13EPU7MbJYUBGuTtcasE/UE
	 k4BkRNlmYEoPmQ9QMvQiw6r9A01ZCiLT5CDRJ+kAp00XcGRROZrB47HOCPjpdQa4Qg
	 y8g+nV3NobvKRv2qu+KYxObRaMdDeekAImG8h7HI=
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
Subject: [PATCH v7 06/11] arm_mpam: propagate MSC access errors for state saving function
Date: Fri, 31 Jul 2026 19:03:19 +0200
Message-ID: <20260731170324.2927758-7-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731170324.2927758-1-andre.przywara@arm.com>
References: <20260731170324.2927758-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow the mpam_save_mbwu_state() function to return an error, and
propagate read and write errors from the lower level up.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Reviewed-by: Ben Horgan <ben.horgan@arm.com>
---
 drivers/resctrl/mpam_devices.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/resctrl/mpam_devices.c b/drivers/resctrl/mpam_devices.c
index fa8ed20a6740..38450c55e45e 100644
--- a/drivers/resctrl/mpam_devices.c
+++ b/drivers/resctrl/mpam_devices.c
@@ -1838,22 +1838,37 @@ static int mpam_save_mbwu_state(void *arg)
 
 		mon_sel = FIELD_PREP(MSMON_CFG_MON_SEL_MON_SEL, i) |
 			  FIELD_PREP(MSMON_CFG_MON_SEL_RIS, ris->ris_idx);
-		mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
-		mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
-		mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
-		mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
+		ret = mpam_write_monsel_reg(msc, CFG_MON_SEL, mon_sel);
+		if (ret)
+			return ret;
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_FLT, &cur_flt);
+		if (ret)
+			return ret;
+		ret = mpam_read_monsel_reg(msc, CFG_MBWU_CTL, &cur_ctl);
+		if (ret)
+			return ret;
+		ret = mpam_write_monsel_reg(msc, CFG_MBWU_CTL, 0);
+		if (ret)
+			return ret;
 
 		if (mpam_ris_has_mbwu_long_counter(ris)) {
 			ret = mpam_msc_read_mbwu_l(msc, &val);
 			if (ret)
 				return ret;
-			mpam_msc_zero_mbwu_l(msc);
+			ret = mpam_msc_zero_mbwu_l(msc);
+			if (ret)
+				return ret;
 		} else {
 			u32 val32;
 
-			mpam_read_monsel_reg(msc, MBWU, &val32);
+			ret = mpam_read_monsel_reg(msc, MBWU, &val32);
+			if (ret)
+				return ret;
+
 			val = val32;
-			mpam_write_monsel_reg(msc, MBWU, 0);
+			ret = mpam_write_monsel_reg(msc, MBWU, 0);
+			if (ret)
+				return ret;
 		}
 
 		cfg->mon = i;
-- 
2.43.0


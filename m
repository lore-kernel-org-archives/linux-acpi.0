Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623284746B6;
	Fri, 11 Sep 2026 11:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789126205; cv=none; b=FklkudEQQXktVLt/0hM8XOA3MwAMihJ8rGvHAWdCUQ8qkmSoi7zlhy2yd+CJyybY1J1I9dVaP56ZTy/p4nL6QlyA1PE7cN7FvNPSL8glZTWwNGsApiham+O3HukWWen9ZLyx/fS6WRFxd9+mgwn5kmdoI4RvDUyVhiY4fNpXSck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789126205; c=relaxed/simple;
	bh=fkL8LlJoJEuOsNOgQpjEIgSES2ACtwI8J5F9ENE5/mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9MSKMsuj2djKvDcPssjyPXgVaNG+yRm2j2evB5S25zC9xJfwqFzReiEboKvAmUpq+5+WuXXtVn3+Qwn1TkBgEgMirgPKynoIfpZ2BoDdl4ttz2Mr4Lf0ZH7LRd8KvzinppN1+Z2TCjaGMvB4EKssZdrsyDWgiQuGkTJSqLnjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=QPQLI48T; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="QPQLI48T"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ED1E928AC;
	Fri, 11 Sep 2026 04:29:45 -0700 (PDT)
Received: from e142021.arm.com (unknown [10.57.6.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 590A63F59E;
	Fri, 11 Sep 2026 04:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789126189; bh=fkL8LlJoJEuOsNOgQpjEIgSES2ACtwI8J5F9ENE5/mc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QPQLI48Tv7aVl/KMQIa5nGZKb/28bsV2o1bsBlil+2taoJkUgnD5hK2zVTJhgDj0l
	 tJYTRlah3TzzHS57vL87g+mEPAQ+TgxPYON0yvQfaFf78OQoJ+H+LknwfIS+cNsnHd
	 LItyNAANxoOq3xsjDQZkcO4k01clPwlx47gW5wsw=
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
Subject: [RFC PATCH v10 14/14] acpi: arm64: use MPAM-Fb offset field from ACPI table
Date: Fri, 11 Sep 2026 13:28:35 +0200
Message-ID: <20260911112835.714162-15-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911112835.714162-1-andre.przywara@arm.com>
References: <20260911112835.714162-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The newly introduced mpam_fb_offset field in the MSC node ACPI table holds
the difference between the system-wide MSC ID, as held in the
"Identifier" field, and the ID to be used on the MPAM-Fb protocol level.

Subtract that value from the MSC ID and store that in the mpam_fb_msc_id
property, so that the MPAM-Fb code can correctly address the MSCs.
Previously this field was marked as "must-be-zero", so there would be no
change when using older tables.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/acpi/arm64/mpam.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/arm64/mpam.c b/drivers/acpi/arm64/mpam.c
index 8c87b4a663439..ee9be310c2184 100644
--- a/drivers/acpi/arm64/mpam.c
+++ b/drivers/acpi/arm64/mpam.c
@@ -257,7 +257,8 @@ static struct platform_device * __init acpi_mpam_parse_msc(struct acpi_mpam_msc_
 		props[next_prop++] = PROPERTY_ENTRY_U32("pcc-channel",
 							tbl_msc->base_address);
 		props[next_prop++] = PROPERTY_ENTRY_U32("mpam-fb-msc-id",
-							tbl_msc->identifier);
+							tbl_msc->identifier -
+							tbl_msc->mpam_fb_offset);
 	}
 
 	acpi_mpam_parse_irqs(pdev, tbl_msc, res, &next_res);
-- 
2.43.0


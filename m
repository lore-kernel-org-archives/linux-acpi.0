Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF3F43DEA2;
	Thu,  8 Oct 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494951; cv=none; b=KbgvAltS2D3PrpWRgHdD7A8tWQuREhBy2Qtn1TiAptw6e6VU1KWHjZ08PfT5eEuQSPIGSl1ibJm7xELl5SDZSLSTpqjpYi48Z4JDesX5ySsrWJCnZpPMCs/wiUxgV0ShvBgcbs/l79z/mRkpRd8L1AL5go0/ldmT6UYp8BuchSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494951; c=relaxed/simple;
	bh=CgKD3MtDE1Q86Ohgi+DZhWSgQ31h5N+rd/8QiAIURJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cKWu/o4NiSi8RILOmCFGzbCvysfrwWRYrKnE6Oy3876w0vfe1DH4c3Oh9TuWqRzYDBwcPDkrwXsOpCYrkgzIP3AplYHo+R9VatKnqGKJukqRz3VXSHQZivkmmv2ot7PKtqa/d2ZJ8hsNwy+F5qlENzPVyAmUsE/S/is9mbuTwWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=q/51aEMM; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="q/51aEMM"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2FF41477;
	Thu,  8 Oct 2026 14:29:04 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.87.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 955DA3F763;
	Thu,  8 Oct 2026 14:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791494948; bh=CgKD3MtDE1Q86Ohgi+DZhWSgQ31h5N+rd/8QiAIURJk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q/51aEMM92pvNqWw/ZaswA1vjgpK3GZaWf5rt0cFuQXvmOhNQ1aASAD7/BTFnSXlM
	 oTR/S3MXW2uZfu0VN7zG3palrPPKsKuhnUePgc+OuejgmJ44FEeg58fdJI2A2qOL/v
	 Qd9vZ/ojKBlZhfjLNDwbdibGJgSs4bJ6W2kM8utE=
From: Christian Loehle <christian.loehle@arm.com>
To: rafael@kernel.org
Cc: zhenglifeng1@huawei.com,
	zhongqiu.han@oss.qualcomm.com,
	viresh.kumar@linaro.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Huang Rui <ray.huang@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Vanshidhar Konda <vanshikonda@os.amperecomputing.com>,
	Shubhang Kaushik <sh@gentwo.org>,
	Pierre Gondois <pierre.gondois@arm.com>,
	Beata Michalska <beata.michalska@arm.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Ionela Voinescu <ionela.voinescu@arm.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lukasz Luba <lukasz.luba@arm.com>,
	Jeremy Linton <jeremy.linton@arm.com>,
	jonathanh@nvidia.com,
	zhanjie9@hisilicon.com,
	Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH 2/2] MAINTAINERS: ACPI: Add a separate CPPC entry
Date: Thu,  8 Oct 2026 22:28:32 +0100
Message-Id: <20261008212832.354382-3-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261008212832.354382-1-christian.loehle@arm.com>
References: <20261008212832.354382-1-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CPPC is a distinct part of ACPI, with its own CPU performance control
semantics and register access mechanisms. Add a dedicated MAINTAINERS
entry to help direct changes to maintainers familiar with those details
and the various platforms implementing CPPC.

List Rafael and myself as maintainers for the implementation, public
header and sysfs documentation.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 MAINTAINERS | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 3064942ef05c..88e3bcfeedb9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -327,6 +327,17 @@ F:	drivers/acpi/acpica/
 F:	include/acpi/
 F:	tools/power/acpi/
 
+ACPI CPPC
+M:	"Rafael J. Wysocki" <rafael@kernel.org>
+M:	Christian Loehle <christian.loehle@arm.com>
+L:	linux-acpi@vger.kernel.org
+L:	linux-pm@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm
+F:	Documentation/admin-guide/acpi/cppc_sysfs.rst
+F:	drivers/acpi/cppc_acpi.c
+F:	include/acpi/cppc_acpi.h
+
 ACPI FOR ARM64 (ACPI/arm64)
 M:	Lorenzo Pieralisi <lpieralisi@kernel.org>
 M:	Hanjun Guo <guohanjun@huawei.com>

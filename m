Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185473B14BE;
	Thu,  8 Oct 2026 21:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494944; cv=none; b=G+uMWuaHp5uHC2KIOl87N8xsKSl/RV6VEQStRAIbvXWtjDoiD+G7Uyd5UOTpXSVdPd6M0YjQQL3KpHnPxZQ05Q7YW8g56/r0EHDqzMAljCSnDeZ5oh2Py9GlPQ4icX6iZwijVSj4h2Eqt69CcguFO2CtrIY9yWzu2jZmA/es9vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494944; c=relaxed/simple;
	bh=HSK1pjVm9ehxmlooMYhWq3cd6qmvmv5av3882DG5p+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rfh8VlzS8/PNYK3gGX9QoSphGc2F1cQy/vCY76c9rr0/dYiz+/4Ocyuqt3iOoBv6Pgnqf7fEaMz8ZcC+2W0ba1yh+WLpfMjHAM7Xrz9zK19EC2UukU8+iCI+URycPsO4VSDZPyadlt3R0RM55UE0ao1dAaRBpgDGtvo3pAsT1fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WVtS6XoP; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WVtS6XoP"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02FA51595;
	Thu,  8 Oct 2026 14:28:59 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.87.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 13BD63F763;
	Thu,  8 Oct 2026 14:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791494942; bh=HSK1pjVm9ehxmlooMYhWq3cd6qmvmv5av3882DG5p+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WVtS6XoPTlc6ehGJgMPUQGYfT9yGQM/L72Qy8L7R61KWMkezxJHb47n4u/wS+Ci/u
	 L/SmOLhKjO+Jor9ai0YuPDg+ersouu9gCUye0R/m+PJMZk95p64yYYQ+Ybo8L7CiQM
	 UIyL8yRdBAxKl2fTYlROGJUvMHUnQEtX/FjWtU38=
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
Subject: [PATCH 1/2] MAINTAINERS: cpufreq: Replace CPPC reviewer
Date: Thu,  8 Oct 2026 22:28:31 +0100
Message-Id: <20261008212832.354382-2-christian.loehle@arm.com>
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

Take over CPPC cpufreq review duties from Pierre Gondois. Thanks to
Pierre for his reviews and contributions to the driver.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65e8a4b5c90b..3064942ef05c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6765,7 +6765,7 @@ M:	"Rafael J. Wysocki" <rafael@kernel.org>
 M:	Viresh Kumar <viresh.kumar@linaro.org>
 R:	Jie Zhan <zhanjie9@hisilicon.com>
 R:	Lifeng Zheng <zhenglifeng1@huawei.com>
-R:	Pierre Gondois <pierre.gondois@arm.com>
+R:	Christian Loehle <christian.loehle@arm.com>
 R:	Sumit Gupta <sumitg@nvidia.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained

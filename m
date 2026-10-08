Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08613B14BE;
	Thu,  8 Oct 2026 21:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791494937; cv=none; b=fk7Jd+ccLnQhjnktDdLRPngt3QDWp62kNqkCAGGTEZZ06F739J25GoNN7yLj6DEdmPnDTjTjsd1weis3Z9I/qu8tuLn8sdsD2u4OLVILB9WSKh0xZut16PBMlJrAxkbS3+fFMmgusoH8k5JITGjrvF+g1OR1NTjb5EpjluPJtwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791494937; c=relaxed/simple;
	bh=DRL3fpOafRSkxxllvLGIoUiKklaEafR6458OmgjKk88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQ8TUr5WYDi+9+4hCmxPDFm4SP+HTvqSzFzCz70OoOJSe1BBK7jp57yIvot+sZQNsdqHS+3ud1tnxMlwBqO8OkkVY5DbZCkCxfR6RhD19friqM9CnV6WWbM441P+fwkLbyiXw1TAu2PNtFgoMHkPqdrBLUrHwylAbcPNYNHzoqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=T+vRViT8; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="T+vRViT8"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D57B1477;
	Thu,  8 Oct 2026 14:28:50 -0700 (PDT)
Received: from e127648.arm.com (unknown [10.57.87.21])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 973403F763;
	Thu,  8 Oct 2026 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1791494933; bh=DRL3fpOafRSkxxllvLGIoUiKklaEafR6458OmgjKk88=;
	h=From:To:Cc:Subject:Date:From;
	b=T+vRViT8zVrpxXP2flAbT8UDGmMuWjnRQLBXijj9tJbOMaRa5Ulwwur/YZq3K8xc5
	 GDaMD7s5/+5WQIm0rVctB2i5V3Emx4ndYxAvnJ25du6RPvkQEJ+Cr8MFaDv5sAoMim
	 5SqERzB9S5T23key9FycNsTwNH/QJ52hTYkNjkFU=
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
Subject: [PATCH 0/2] MAINTAINERS: Update CPPC responsibilities
Date: Thu,  8 Oct 2026 22:28:30 +0100
Message-Id: <20261008212832.354382-1-christian.loehle@arm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Rafael,

This series replaces Pierre with me as a reviewer for cppc_cpufreq and
adds a dedicated ACPI CPPC entry with you and me as maintainers.

The separate entry should help direct CPPC changes to people familiar
with its performance control semantics, register access mechanisms and
the platforms implementing it.

Thanks to Pierre for his work on CPPC.

Thanks,
Christian

Christian Loehle (2):
  MAINTAINERS: cpufreq: Replace CPPC reviewer
  MAINTAINERS: ACPI: Add a separate CPPC entry

 MAINTAINERS | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)


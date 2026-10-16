Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2FB4CCDE9;
	Fri, 16 Oct 2026 14:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160044; cv=none; b=NAH4pdTvGmviVrCGeissEFDZ1dfY0KTdkORX7xHnVXw/BNzzgeK6D93Xj2mR6li8ZVtByTZFuquYxfU3dKg8Hy+l416WF5mJGpMYQ72WcUDLob3x0v6Iy/ehObDOsXYruJhWKbmWVfNJ6G9mN0yUYGcag+R9NXxW+gZmN4ySnhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160044; c=relaxed/simple;
	bh=cuIUdCDlnghdcT2tzMioGyVqrSMpG1HcVthYZoFEfOc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=djxUqbKdDwluuCni3i2oI7jzF9q9H3zcVxHecUUlsh/x1e5QVivKNnkDbCEPwI21R8RYbn7YiBvE3Q65p+P5kSNDJZOw7KYP2eRPTfQT6xl10BZoF07A2wOmvOBuZHJc9ytfCEvn8G/1UTNAgr2bzUABjkhaDTxsvWo98ksnUes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bIhFq+yS; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bIhFq+yS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vG
	PKAAvIykdWCb82ySAm6qx8CUU1UNqtkq4LYigUlmA=; b=bIhFq+yS1ZnQ0HXWh2
	VK9Psy7NSuLafi5WOCzWr7bcmhQ4tToKeszhjag9Yqz/ClxnnfNLhbApzeExAP24
	LQTcHHxLCnX8FiT93YvpDgH8EWh0OdcPFFzlxi4ar0BjVITCv317uTPmcV1zSOaL
	yxQ0kqaMne4UgQTpNRlORapbY=
Received: from pc.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgCX5Hj5MNJqeorFAA--.36405S2;
	Fri, 16 Oct 2026 22:13:14 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/2] RISC-V: validate ACPI MADT entries before use
Date: Fri, 16 Oct 2026 22:12:46 +0800
Message-Id: <20261016141249.2791819-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgCX5Hj5MNJqeorFAA--.36405S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7XFy8Cw17Ww1fGrWxZF1kXwb_yoW3AFg_ur
	ykKr9rGr1DC3Z7tF10krsIvrWfGayDJr1UA39IyayfJFZ5trn0vrs5tFy8ZFy09an5twn5
	Jr9xZr43Zr129jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUUNVy5UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzRqZ02rSMPqtzwAA3N

RISC-V ACPI initialization passes generic MADT subtable headers to
RINTC, PLIC, and APLIC parsers.  These parsers currently access fields
from the fixed-size records before establishing that firmware supplied
the complete structure.  A truncated MADT entry can therefore cause an
out-of-bounds read during early interrupt and CPU setup.

Validate each typed record before its first field access.  The first
patch fixes the CPU RINTC parser and the second covers the PLIC and APLIC
interrupt-controller parsers.

Jiale Yao (2):
  riscv: validate RINTC entries before use
  ACPI: riscv: validate interrupt controller MADT entries

 arch/riscv/kernel/smpboot.c | 6 +++---
 drivers/acpi/riscv/irq.c    | 6 ++++++
 2 files changed, 9 insertions(+), 3 deletions(-)

-- 
2.34.1


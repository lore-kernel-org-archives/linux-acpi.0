Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6476835C690;
	Thu, 13 Aug 2026 16:01:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786636888; cv=none; b=s+9EboQX4Zgtv9KCGv+9RhtHxItug01dFTT5xZjZIokOnl5z6QavAN/WiWLUKq7h9M8DgyN4UK7glh5IQ2jLK9TPWOGo2BEDqU5glZlhF51lVs2zQ/k8J2Hm1bFRph8nOjjIHeuj5aD4QlHQIEKLOf7/4+bmRoceWbVSGTWyOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786636888; c=relaxed/simple;
	bh=XUt+o01YLmfcPT9SkT8Bkk/g6xOQkyEafwqf2WDdO30=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uUBB5x0RVDTQ8guK0uL7QBoFwpiLfsSSiW7Cteg6HgZDEZPIs4seesysW1pungo822a4dShFq0ukfwfpMNj+8p0QKeayRRd86kF8DOVFv4B3jggHrk6MAhv0ktaLT73+kzjyxxHpwGaEkRjgPsox3FhBuA8ZxUvyy11Dyqc/rnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAAX6+5O6n1qPxp7BQ--.64333S2;
	Fri, 14 Aug 2026 00:01:18 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Hanjun Guo <guohanjun@huawei.com>
Cc: Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Joerg Roedel <jroedel@suse.de>,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2 0/2] ACPI: IORT: validate node and RMR extents
Date: Fri, 14 Aug 2026 00:01:18 +0800
Message-ID: <20260813160118.69153-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAX6+5O6n1qPxp7BQ--.64333S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr15ZFWfuFyrJr4rtF17Awb_yoW8WF18pa
	yYqay5tr95JF1fKw4ft3W5GF1rG3yrJw47Xrn3J3sFvrn8tr1UA3WIkr12qFZIgrySgrW2
	vF40vFnrCFyY93DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26r1j6r4UM28EF7xvwVC2z280aVCY1x0267AKxVW8JV
	W8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_JF0_Jw1lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUoq2MUUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

The original patch combined the generic IORT node walk with the
IOMMU-specific RMR descriptor and ID-mapping arrays.  This version
separates those contracts as requested.

Patch 1 validates the root node area, complete node headers and advertised
node lengths in each generic walker.  Patch 2, built only with
CONFIG_IOMMU_API, validates the fixed RMR payload and both arrays before
walking them.

Changes since v1:
https://lore.kernel.org/all/20260706094300.82618-1-pengpeng@iscas.ac.cn/
- split generic traversal from RMR array validation
- validate root node_offset and node_count before pointer construction
- scope RMR helpers with their CONFIG_IOMMU_API users
- document why a zero-count array needs no offset validation

Testing used Linux 3d6d817622b0 plus this series, GCC 13.3 and QEMU
8.2.2 with a Cortex-A57 arm64 CPU model.  A temporary KUnit harness in
iort.c called the actual static validation helpers; the harness is not
part of this series.  The acpi_iort_bounds suite passed both tests,
covering invalid root offsets, truncated node and RMR payload extents,
and out-of-bounds RMR descriptor and ID-mapping arrays.

This did not exercise a platform-provided IORT table through the complete
boot-time discovery path.

Pengpeng Hou (2):
  ACPI: IORT: validate table and node extents before traversal
  ACPI: IORT: validate RMR node array extents

 drivers/acpi/arm64/iort.c | 117 +++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 8 deletions(-)


base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.50.1 (Apple Git-155)


Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A980B2E7376;
	Tue, 16 Jun 2026 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781617908; cv=none; b=HPjIkwrh45rpWjTqxwQ95Gf2wpCbIuvNilxq7YDRH8uoH66zIVtiFE8HoNyoY/q0CRFeTKWJggY4JCfrE4rq/mmLHS3WERwuxkg/EnWtYJnYR99g/PDxD1WUFRQ7HCaFhOfK3UtGS/+pRzn/N8f6xaGRXwl9raFLxKqfODC2YC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781617908; c=relaxed/simple;
	bh=3Wz1PCliwYcCTRIvD8S86PCDArvvozT9rug80vxUBCw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=iLLU3AKv+z9rLFN8KtI8PvZG2z409O84Dy5mWf2ioLEH42fnXLDmH3orTerpM9FscR4XukKr6GfZLk/o24oJkORXokuHTx17H2jZ4/fIWjdzEdbT9S3XavmN/+Jts32c/mI5+EmTTcPSXRQPzB11fzFL0ieEcbUt+MsFEMin1j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [127.0.0.2] (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowAA3VdzjVDFqj0rvFA--.12812S2;
	Tue, 16 Jun 2026 21:51:31 +0800 (CST)
From: Vivian Wang <wangruikang@iscas.ac.cn>
Subject: [PATCH 0/2] riscv: acpi: Enable ARCH_HAS_ACPI_TABLE_UPGRADE
Date: Tue, 16 Jun 2026 21:51:30 +0800
Message-Id: <20260616-riscv-acpi-table-upgrade-v1-0-45902d2dedf9@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOJUMWoC/y2N3QqCQBBGX0XmuglXcCNfJQx2x9Em8m92lUB89
 7bs8sD5zrdBYBUOUGUbKK8SZBwSmFMG9HBDxyhNYijywubWWFQJtKKjSTA6/2Jcpk5dw9j6ku2
 VSt9aC2k+Kbfy/qVv9cFh8U+m+O39DeV5SZ/x0MC7wEhj30ussvVyNqhk7tsO9b5/AF6pKbCrA
 AAA
X-Change-ID: 20260616-riscv-acpi-table-upgrade-fb5e69c5bf66
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-riscv@lists.infradead.org, Vivian Wang <wangruikang@iscas.ac.cn>
X-Mailer: b4 0.15.2
X-CM-TRANSID:rQCowAA3VdzjVDFqj0rvFA--.12812S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUY27AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E
	6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28Cjx
	kF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8I
	cVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aV
	CY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAq
	x4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeV
	CFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1l
	42xK82IYc2Ij64vIr41l4c8EcI0Ec7CjxVAaw2AFwI0_Jw0_GFyl4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxh
	VjvjDU0xZFpf9x0JjbTmhUUUUU=
X-CM-SenderInfo: pzdqw2pxlnt03j6l2u1dvotugofq/

I did end up using this for something, so this is probably also useful
for others.

---
Vivian Wang (2):
      ACPI: tables: Add missing #include <asm/fixmap.h>
      riscv: acpi: Enable ARCH_HAS_ACPI_TABLE_UPGRADE

 arch/riscv/Kconfig            | 1 +
 arch/riscv/include/asm/acpi.h | 2 ++
 arch/riscv/kernel/acpi.c      | 5 +++++
 arch/riscv/kernel/setup.c     | 2 ++
 drivers/acpi/tables.c         | 1 +
 5 files changed, 11 insertions(+)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260616-riscv-acpi-table-upgrade-fb5e69c5bf66

Best regards,
--  
Vivian "dramforever" Wang


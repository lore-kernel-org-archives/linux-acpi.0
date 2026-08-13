Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630FA360EC0;
	Thu, 13 Aug 2026 15:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635978; cv=none; b=GjsRII9oSALcnvgYYB5S13eKsdrK4LB3JffQJPgs4sMa/90nsJYPBgPMEVWmK2xEkt5XbnzMbDOhKzxISsTwPYyTWjsM/YndN4FXGd8kSyhv1G74+THi9pCKeXJTyzmQvZLLYB8vzB6dQTJcO42WpPkXeisHkotHPp9flj1NhqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635978; c=relaxed/simple;
	bh=zaRtDVfHdl/j4RxmaKM0k7Xac20g5ZKPP3BYD0dRVbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oDTFYB+hZCn8FovfU09AB5TsTwCtulq5S+IE0PcIW+601mInFzdjdGtN5M51RGEETCDcSXAZEUD3YBdIyUJHZNyY46JqmX/ErWjKdUHrsRoX0bKvwTULoGFdNBN//VwfSa6xR31S5+ZLxUZBfnU5Q5/vE9iWtzJV88MV+uVmq6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowAAHofS55n1qSnx6BQ--.20274S2;
	Thu, 13 Aug 2026 23:46:01 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Sunil V L <sunilvl@ventanamicro.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	linux-acpi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v2 0/3] ACPI: RHCT: validate nested node references
Date: Thu, 13 Aug 2026 23:46:00 +0800
Message-ID: <20260813154600.58861-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowAAHofS55n1qSnx6BQ--.20274S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF4kZry8Jw1kuF4xXF1DZFb_yoW8Zr15pr
	W5ua43trykJF4Ikr4ayw4j9a4fuw4fJr4aqr93Ja4xZF90yFZrA3W0yr18uF47uF93t347
	Xr4jvFsrua45u37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9F14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbo5l5UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

RHCT consumers walk the firmware-provided node area and follow hart-info
offsets without proving the corresponding extents.  ISA and CMO consumers
then read the referenced type-specific payloads directly.

Split the checks into independently reviewable layers.  Patch 1 validates
the table and node envelopes.  Patch 2 validates each hart-info offset
array and requires references to identify exact non-hart node boundaries.
Patch 3 validates the ISA string and CMO payload before use and publishes
CMO values only after a complete successful walk.

Changes since v1:
https://lore.kernel.org/all/20260706094619.83121-1-pengpeng@iscas.ac.cn/
- split root, reference and type-specific payload validation
- bound iteration by node_count
- require references to exact non-hart node starts
- enforce the RHCT rule that isa_length includes a trailing NUL
- avoid publishing partial CMO output after a later malformed node

Testing used Linux 3d6d817622b0 plus this series, GCC 13.3 and QEMU
8.2.2 for riscv64.  A temporary KUnit harness in rhct.c called the
actual static validation helpers; the harness is not part of this
series.  The acpi_rhct_bounds suite passed all three tests, covering
truncated table and node extents, invalid hart offset arrays, interior
node references, invalid ISA strings, and all-or-nothing publication of
CMO values after a later malformed reference.

This did not exercise a platform-provided RHCT table through the complete
boot-time discovery path.

Pengpeng Hou (3):
  ACPI: RHCT: validate table and node extents before traversal
  ACPI: RHCT: validate hart-info offsets and node references
  ACPI: RHCT: validate ISA and CMO node payloads

 drivers/acpi/riscv/rhct.c | 251 ++++++++++++++++++++++++++++++++------
 1 file changed, 213 insertions(+), 38 deletions(-)


base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.50.1 (Apple Git-155)


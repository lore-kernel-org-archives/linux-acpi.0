Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD4233B6CC;
	Thu, 13 Aug 2026 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786635548; cv=none; b=nMDh/SgqrBYRMxxX9v/u1UOY3S8ngPG//0qWvO49oJgVs4kO4l4IoryLsehT5z9B5kIddBKGzZqhbtQvSTvCVlNw/vSJClzf3U95BM/AXzQ2ru5qaRdJUvbRfneFC0wbDrSolyK8D5DbaNWQeZ6Stru2rtLbh1CSJWpqjG33ze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786635548; c=relaxed/simple;
	bh=r/x9uThJPGjk++cJkpNSwa0t9Kv5f0zaqzEeeLxby9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uiBhIgjgFaYcGfyP9sgDAi2a31e1zHlj9HBrfi0T/duDju3eb8KHbPKBLC8aHfrU7eOQi7CSfAK+de/1k0qiEqsMwCp0cb9ttvYohOH5wG5kwoORBY1W1s9+eQheOpzUCO8aZT6MvzCxk+AU4QPql4q+p4D0gED0X7ftYxwtyRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowADnvPAL5X1q+Sh6BQ--.15943S2;
	Thu, 13 Aug 2026 23:38:51 +0800 (CST)
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
Subject: [PATCH v2 0/3] ACPI: RIMT: validate nested firmware extents
Date: Thu, 13 Aug 2026 23:38:51 +0800
Message-ID: <20260813153851.47947-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowADnvPAL5X1q+Sh6BQ--.15943S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr17XF1xKrWUCw4kWFWUXFb_yoW8Cw4kpr
	WfWFW5try8Jw4fK3yftw4jkF15urn3Jr47AF9xtwn7ZFn0qF4jkrWIk34IqanxGrn3Gw13
	Zr4FqFsruFy3CaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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

RIMT consumers trust three separate layers of firmware data: the root
node area, the payload and arrays contained in each node, and cross-node
ID mappings.  Validating only the outer table does not establish the
bounds of either nested layer.

Split the validation by contract.  Patch 1 validates the root and node
envelopes while preserving unknown-node traversal.  Patch 2 validates
supported node payloads, arrays and the platform-device string.  Patch 3
validates exact destination-node references, mapping depth and ID
arithmetic.

Changes since v1:
https://lore.kernel.org/all/20260706094414.82794-1-pengpeng@iscas.ac.cn/
- split root, node-data and mapping-reference validation
- preserve unknown-node traversal compatibility
- require destination offsets to match exact node boundaries
- treat num_ids as a count, as specified by the RIMT definition
- keep the existing unchanged-ID result on mapping failure

Testing used Linux 3d6d817622b0 plus this series, GCC 13.3 and QEMU
8.2.2 for riscv64.  A temporary KUnit harness in rimt.c called the
actual static validation helpers; the harness is not part of this
series.  The acpi_rimt_bounds suite passed all three tests, covering
truncated table and node extents, invalid payload and array extents,
unterminated device names, interior node references, ID range and
addition errors, and a cyclic mapping chain.

This did not exercise a platform-provided RIMT table through the complete
boot-time discovery path.

Pengpeng Hou (3):
  ACPI: RIMT: validate table and node extents before traversal
  ACPI: RIMT: validate node payload and array extents
  ACPI: RIMT: validate mapping references and ID arithmetic

 drivers/acpi/riscv/rimt.c | 239 ++++++++++++++++++++++++++++++++++----
 1 file changed, 219 insertions(+), 20 deletions(-)


base-commit: 3d6d817622b0a9721e3cc404df3469171582be13
-- 
2.50.1 (Apple Git-155)


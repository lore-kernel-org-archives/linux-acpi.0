Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE2745C6E0;
	Fri, 16 Oct 2026 14:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792160090; cv=none; b=kWbIRUn9HBOTCCfqjHhkIWldsHJECGKflhGXf9OvfQ1SUO5ZgQaKDT7UTIP1L5TE273l9SVw+a8jLhTe+RZthAlAOsud2koOR/fHuawe0gz+oRrgbBhBOHmi7YYnSHSboVrs+cjy5ruVI+/dfBc+S5ezYxXU45aNiqtlUkqq/BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792160090; c=relaxed/simple;
	bh=I+zSJlIdE2k5NxbzeBxOS6NlE+TBlqTGfDfoEYjBbQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=utOqJrqXV02XDiFDJTtZlW/25htwbHETO/efpEK3klpaJ7WGV91ebbDGVTBfMltegcczvqGaWy+HJdogWPbl0RDcLctKtXAQj/LrAdbNbnS2xygeH8uFGI1anF8uTv1RQxR7oLtlCrQj6Js9LRU0fmKzUwaRn05Z1S3P87vDf38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bcc0nMwB; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bcc0nMwB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/6
	zuCbaILpwUGXgd0XBseygKBWeHr1yHI3Nb4KQaoMM=; b=bcc0nMwByKWkH11LrI
	rQg4xGkU1ykMA+TGeGtNCzXXjTGOkqZjgC/B7ukDaVS4Oa8Bg64nj1obof/ITsIt
	avXba/WCq7gXi8xidK1U/ZnN3wL1CkeXMuXqqsiWl3UbwZiU6GnJqC8fRMVgY7ns
	j6TpHorIaN8c/x3JOkLte05qo=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3NysnMdJq1dUUAg--.27711S2;
	Fri, 16 Oct 2026 22:14:00 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH 0/6] irqchip: validate ACPI MADT entries before use
Date: Fri, 16 Oct 2026 22:13:51 +0800
Message-Id: <20261016141357.2793046-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3NysnMdJq1dUUAg--.27711S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ar15ZFykXw4DJw45Cw4xXrb_yoW8JFWrpF
	W5Za4rtr1SkFW7CrnxAw4UXF98JFn5trW7ta93t3W3Xrn5KF1DX3W7trZ0qF4fAw17GwnF
	9r4FqF4xuFyUAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUzpB-UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzgil32rSMSgcFAAA3V

IRQ chip ACPI probing receives MADT records supplied by firmware.  The
common probe path does not currently verify that the complete declared
entry is contained in the table, and several callbacks access
fixed-size records without checking their minimum size.  Malformed
entries can therefore cause out-of-bounds reads during early boot.

Add the common declared-range check first, then validate the concrete
ITS, GIC, LIO-PIC, and BIO-PIC records in their respective callbacks.
Each patch remains independently buildable and limits its changes to one
parser implementation.

Jiale Yao (6):
  ACPI: irqchip: validate MADT entry bounds before probing
  irqchip/gic-v3-its: validate MADT ITS entries
  irqchip/gic-v3: validate MADT records before use
  irqchip/gic-v5-its: validate MADT translate frames
  irqchip/loongarch-cpu: validate MADT LIO-PIC entries
  irqchip/loongson-eiointc: validate MADT BIO-PIC entries

 drivers/acpi/scan.c                    |  7 +++++++
 drivers/irqchip/irq-gic-v3-its.c       |  3 +++
 drivers/irqchip/irq-gic-v3.c           | 18 ++++++++++++++++++
 drivers/irqchip/irq-gic-v5-its.c       |  3 +++
 drivers/irqchip/irq-loongarch-cpu.c    |  3 +++
 drivers/irqchip/irq-loongson-eiointc.c | 10 ++++++++--
 6 files changed, 42 insertions(+), 2 deletions(-)

-- 
2.34.1


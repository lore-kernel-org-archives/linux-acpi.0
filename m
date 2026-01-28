Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACF6376BEB;
	Wed, 28 Jan 2026 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632089; cv=none; b=p/Ho6zOXXh6Xq5Y8wUWVAPxVIhFRWwuLU6SZdqD9exYqnf+JkLdGpV4vXm7N+wrc7mw92BrubjgKzBS0HgaOgaXs6nNjoOh44ackp5j9wxf0bTTzGwtPRS9NJRW/zDpZWLo22t5orzJiaFSPfEB4wZhi30YjRUojnCdeNRvNS4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632089; c=relaxed/simple;
	bh=LLcYCf8E3m+c3NEGM6PLVB/b2aK0eRa7uHCxUc0B8eM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ogBTlN9kexJ5SDbD1VYLNipahNRHtnW1LEMwbMtMCvm0nacvaDnWemSAwfWZqe02CW2bfepD9/TKagP78MPkmtENJoBbhyePziggOqSh4ECUZo1GQH6fS5O0/K3lvHaSC2B34817cEniNaXAR/XPy6oiRErku3MImpCjQdHjp+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EhM4N6sp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EhM4N6sp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1AE3C4CEF1;
	Wed, 28 Jan 2026 20:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632089;
	bh=LLcYCf8E3m+c3NEGM6PLVB/b2aK0eRa7uHCxUc0B8eM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EhM4N6spWcTX8jUod7ooTwW2pQzTpXLDJHyiIXyOkD4SL+5HdLWkoDHTxDO7bi2Hi
	 nouUOXfo+YKMR401HXpQSubprm0j+3PBDaR6rPU7CLq6N7v0pZkPlzfXq2fhLHMnOe
	 2nyqkGoGBP4KBgvwQXVesod7EY73IMRZUoLVoYqtQlDKfdjDitDmElP82Sw1S3zryh
	 RdVtHPb0WPhPgT/+zPf7M1d6g0xF+bI2y8YsHzjwx/u8N+nstX++843GTr3WvoxfHf
	 d/aSBkVnT630pDlsxsfh8Ih3yaDVL+YbSQc9iCLbkosVJKqLpH4YXCwiaBX6lyjneb
	 RiLqcyeDSUL9Q==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:32 -0800
Subject: [PATCH RFC v2 11/17] RISC-V: QoS: add to build when
 CONFIG_RISCV_ISA_SSQOSID set
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-11-dca586b091b9@kernel.org>
References: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
In-Reply-To: <20260128-ssqosid-cbqri-v2-0-dca586b091b9@kernel.org>
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 =?utf-8?q?Radim_Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 Adrien Ricciardi <aricciardi@baylibre.com>, 
 Nicolas Pitre <npitre@baylibre.com>, 
 =?utf-8?q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>, 
 Atish Patra <atish.patra@linux.dev>, 
 Atish Kumar Patra <atishp@rivosinc.com>, 
 Vasudevan Srinivasan <vasu@rivosinc.com>, Ved Shanbhogue <ved@rivosinc.com>, 
 yunhui cui <cuiyunhui@bytedance.com>, Chen Pei <cp0613@linux.alibaba.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, Weiwei Li <liwei1518@gmail.com>, 
 guo.wenjia23@zte.com.cn, liu.qingtao2@zte.com.cn, 
 Reinette Chatre <reinette.chatre@intel.com>, 
 Tony Luck <tony.luck@intel.com>, Babu Moger <babu.moger@amd.com>, 
 Peter Newman <peternewman@google.com>, Fenghua Yu <fenghua.yu@intel.com>, 
 James Morse <james.morse@arm.com>, Ben Horgan <ben.horgan@arm.com>, 
 Dave Martin <Dave.Martin@arm.com>, Drew Fustini <fustini@kernel.org>, 
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
 x86@kernel.org, Rob Herring <robh@kernel.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
 Robert Moore <robert.moore@intel.com>, Sunil V L <sunilvl@ventanamicro.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, linux-acpi@vger.kernel.org, 
 acpica-devel@lists.linux.dev, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=738; i=fustini@kernel.org;
 h=from:subject:message-id; bh=LLcYCf8E3m+c3NEGM6PLVB/b2aK0eRa7uHCxUc0B8eM=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQbe/6ucKK+kJ+cks0JsRXbcirMiy68l1xwRNT3K1
 tBlwZPaUcrCIMbFICumyLLpQ96FJV6hXxfMf7ENZg4rE8gQBi5OAZjICwZGhmnTpT/+/Va91WWC
 CqNftv68qEeHueqaIlfyP5G4lTNr40NGhi1/sgQKKrgPf/3cVD3btpDnqvjKisscpzaViUdPjUt
 +zgsA
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Add the srmcfg CSR handling and the resctrl interface to the build when
CONFIG_RISCV_ISA_SSQOSID is set.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/kernel/qos/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/qos/Makefile b/arch/riscv/kernel/qos/Makefile
index 9f996263a86d..9ed0c13a854d 100644
--- a/arch/riscv/kernel/qos/Makefile
+++ b/arch/riscv/kernel/qos/Makefile
@@ -1,2 +1,2 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o
+obj-$(CONFIG_RISCV_ISA_SSQOSID) += qos.o qos_resctrl.o

-- 
2.43.0


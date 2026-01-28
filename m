Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87B50374751;
	Wed, 28 Jan 2026 20:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632088; cv=none; b=Xh5l0rZgrpBMhUrJ8f8UdeAKTJdlAy4AsXRQTGce7npHF00OeTi+aoLArfZ2xZYKjqWBuFwtwxldeOF9S3TUaHtjQL+dGmKQx0aMtajhM6uKdnpaVGVza1WFf7PnQrkdc+wo0H5iVFbY/4tEozFmIrLCWPj/RKneDDLcbmy412M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632088; c=relaxed/simple;
	bh=SXrtFbN0ix7KxT0GqeIs7HkzT3FdlhgaF3gCwM+F2Mc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QEIqcjJgHjlS69A23i9ievgkuQkvpgD5WIYv/mNzvTBnh/k7O2QaCinlNZaqTWv+BB3/FWsolIhBUz3NHVN3T5NCDpgpESoOz+53Nrtn/53wi6MbAcdaHQvFBaM2kurFVNO++3uq7iOwRg0OepHc+dFU1zjLqA8RsDo28HMeyUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SXHGNinc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SXHGNinc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DC3C2BCB7;
	Wed, 28 Jan 2026 20:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632088;
	bh=SXrtFbN0ix7KxT0GqeIs7HkzT3FdlhgaF3gCwM+F2Mc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SXHGNincT1DeoGx7ssYkSIxdzYD3fa107Q47yezQ1LeJwiV7ONy7LToOgvXkr0ZTw
	 S68V839gLSVlHktb33pZevH0NgFjRlLb4uTsqB7lP/nwom+MUzF2srHxzBO7UqKjRL
	 A+YHYevDMB7kT5OadaQGqqUXK9iRjrOUEOokLC1pkS8QncUhifRrAoqrk+7C95SCzE
	 9rOkjDAeI5KTOmJxYrovOZp38l5w2ERAycGoY5PFVGIE5zdt0qE7N9RobXeDDGXkS6
	 bGzEeD+ksB8JeVfeg38UGEthfHxRDTSwoZ5sgumdZ5MpcHNwBamciSNHc2ZiF7Wl8w
	 /E+is7bA4XZpA==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:30 -0800
Subject: [PATCH RFC v2 09/17] RISC-V: QoS: expose implementation to resctrl
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260128-ssqosid-cbqri-v2-9-dca586b091b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1087; i=fustini@kernel.org;
 h=from:subject:message-id; bh=SXrtFbN0ix7KxT0GqeIs7HkzT3FdlhgaF3gCwM+F2Mc=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFQZwVWzgevGUQymt74rxZA9L+66yIPZaRfbY6W7uB
 Q61/bc6SlkYxLgYZMUUWTZ9yLuwxCv064L5L7bBzGFlAhnCwMUpABOZMp/hn0qHm5PoJqH/af9y
 TM9v48sSELjomZSU/fxiS2xaiuC+R4wMp8/OnJf36OwJtsRDBaFS9//EPXecIMawUeqn1DmzpWx
 eTAA=
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

The generic resctrl header include/linux/resctrl.h includes
linux/riscv_qos.h when CONFIG_ARCH_HAS_CPU_RESCTRL is set.

Co-developed-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Adrien Ricciardi <aricciardi@baylibre.com>
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 MAINTAINERS                      | 1 +
 arch/riscv/include/asm/resctrl.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 31e536304972..96ead357a634 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22510,6 +22510,7 @@ M:	Drew Fustini <fustini@kernel.org>
 L:	linux-riscv@lists.infradead.org
 S:	Supported
 F:	arch/riscv/include/asm/qos.h
+F:	arch/riscv/include/asm/resctrl.h
 F:	arch/riscv/kernel/qos/
 F:	include/linux/riscv_qos.h
 
diff --git a/arch/riscv/include/asm/resctrl.h b/arch/riscv/include/asm/resctrl.h
new file mode 100644
index 000000000000..7d247d87dab9
--- /dev/null
+++ b/arch/riscv/include/asm/resctrl.h
@@ -0,0 +1,2 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#include <linux/riscv_qos.h>

-- 
2.43.0


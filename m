Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82B336ECA;
	Wed, 28 Jan 2026 20:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769632084; cv=none; b=fWjYunNCJjlDzqWR4PZalwJU2HnpVCpQqLE2iNasqgxM2uC5Wi9qIsD16SuS8f7ROmCoN05BQBKewkulIkftCOX1AWFbut8IWCF1WySwsNK+tmXzPs1874Zlh+7Y0TweX3tD/N56WbkxmvcNAaETkQRyjifrbwIYZbcw3hrRVUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769632084; c=relaxed/simple;
	bh=fj8k7O5ZHAbvxYPSXABfgdwCx96nHjY6bA9gTqNje0o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GkgShrBr5j0eS5ylCkLICGCQi9mQiWoZbeYXM4LrHujKKCOEzReewyR1Y7e7CjIpao2Btk6Uo7ktcUlmRgRSqQc94ByziNU4lOTbke5fPy9tzzAtSafhD/Ct1bmetGfVu0+Nz3dz3D3rDwDBATOe/boFC/DmQqTxEgLHg+CcCt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnEr3FIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnEr3FIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AE4BC4CEF7;
	Wed, 28 Jan 2026 20:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769632084;
	bh=fj8k7O5ZHAbvxYPSXABfgdwCx96nHjY6bA9gTqNje0o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lnEr3FIfCsXlF/AQZanvEtVWCn/JltE3MGIvF9w4D4ayIgdylOAJhvTtuvl1r1IOB
	 CdyhNLl88Girdfnj8BXm+NdMj0JPjYlXE6ocKtxhT0Hx+L7zfz0zRGyWi80zX6gbz4
	 OgmsOZIyMFTBYWi8TBTV18am6n2i77N7/fvZnMmoPzhIf7Z6o8hR2wvYORIFj6je/I
	 myCicl/CY+6IKLZOWpOQ2HlBJ9WJQS8l1NRyVqqcsEQpi6qCXQx4+5ogUY8gGbrzsb
	 L0Rozibjfll3jBe4vQq+vImqDRbzfkYQOQHe6+sAc6wcTdyyO7fuW+TnwSOTm2Ixub
	 hSEzvjmQ9jBTA==
From: Drew Fustini <fustini@kernel.org>
Date: Wed, 28 Jan 2026 12:27:23 -0800
Subject: [PATCH RFC v2 02/17] RISC-V: Detect the Ssqosid extension
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260128-ssqosid-cbqri-v2-2-dca586b091b9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1618; i=fustini@kernel.org;
 h=from:subject:message-id; bh=fj8k7O5ZHAbvxYPSXABfgdwCx96nHjY6bA9gTqNje0o=;
 b=owGbwMvMwCV2+43O4ZsaG3kYT6slMWRWFfobF4qs9Wp5vWb6ury3XytXTFYXU1Wo2C3hnDqzY
 am63YaVHaUsDGJcDLJiiiybPuRdWOIV+nXB/BfbYOawMoEMYeDiFICJxK9g+B/N/WVx2Je9++5/
 WsS0Vmez1XzV4xMTbjRtSGSqkmVr2/uZkeFxsmrwLb+j0f+PTpqiwF/yd31fX6vOQYXj3Hrv2zM
 FlzEAAA==
X-Developer-Key: i=fustini@kernel.org; a=openpgp;
 fpr=1B6F948213EA489734F3997035D5CD577C1E6010

Ssqosid is the RISC-V Quality-of-Service (QoS) Identifiers specification
which defines the Supervisor Resource Management Configuration (srmcfg)
register.

Link: https://github.com/riscv/riscv-ssqosid/releases/tag/v1.0
Signed-off-by: Kornel Dulęba <mindal@semihalf.com>
[fustini: rebase on current upstream]
Signed-off-by: Drew Fustini <fustini@kernel.org>
---
 arch/riscv/include/asm/hwcap.h | 1 +
 arch/riscv/kernel/cpufeature.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/riscv/include/asm/hwcap.h b/arch/riscv/include/asm/hwcap.h
index 4369a2338541..28dff8233b34 100644
--- a/arch/riscv/include/asm/hwcap.h
+++ b/arch/riscv/include/asm/hwcap.h
@@ -110,6 +110,7 @@
 #define RISCV_ISA_EXT_ZALASR		101
 #define RISCV_ISA_EXT_ZILSD		102
 #define RISCV_ISA_EXT_ZCLSD		103
+#define RISCV_ISA_EXT_SSQOSID		104
 
 #define RISCV_ISA_EXT_XLINUXENVCFG	127
 
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c05b11596c19..bf704b48679c 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -558,6 +558,7 @@ const struct riscv_isa_ext_data riscv_isa_ext[] = {
 	__RISCV_ISA_EXT_DATA(ssaia, RISCV_ISA_EXT_SSAIA),
 	__RISCV_ISA_EXT_DATA(sscofpmf, RISCV_ISA_EXT_SSCOFPMF),
 	__RISCV_ISA_EXT_SUPERSET(ssnpm, RISCV_ISA_EXT_SSNPM, riscv_xlinuxenvcfg_exts),
+	__RISCV_ISA_EXT_DATA(ssqosid, RISCV_ISA_EXT_SSQOSID),
 	__RISCV_ISA_EXT_DATA(sstc, RISCV_ISA_EXT_SSTC),
 	__RISCV_ISA_EXT_DATA(svade, RISCV_ISA_EXT_SVADE),
 	__RISCV_ISA_EXT_DATA_VALIDATE(svadu, RISCV_ISA_EXT_SVADU, riscv_ext_svadu_validate),

-- 
2.43.0


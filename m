Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793883167;
	b=Gl5l1gTaM1g1unn/4kveghNQrCNuE/r8ZjapF9WivNSTOqz7h+BtANYlNshUivgyhEY8
	 eaqLWou6Ral0dJzuS5ZcF5dJr68p2qeyZium195l94DiaSASqktA4ynGDTpdv4WxX22iW
	 GrUXefTNgN2MYZbCm0VNAoWkMpKkiTn6TqadtkV2ZuwJYPcmzUliH68qXpYlAtFez0qP9
	 f35ImR6ML4a+PPOHKY3zSaLVJEu5nQEeJdOCOqMrG1sywaiVxFV3Gn7aj+o1spJqsQH64
	 UxLuxFw2Gnd8OASJis+Urd+7NvCIexPYFa+TKSFjNj1UzOFQXKh32hktL2fyfd5BtWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793883167;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Message-Id:
	 X-Lms-Return-Path:Content-Language:Received:References:Content-Type:
	 To:Mime-Version:User-Agent:Cc:In-Reply-To:Date:
	 Content-Transfer-Encoding:X-Original-From;
	bh=Fz6oVrX7/NbNBKe7D52bmdwjWluMA6P4LkwzqUDU7u8=;
	b=mGCZ2VNj6e1QY+7tpF7M6u46yZw6B3IjAMBo63Oq6ioPJd9MAWMYgQx2/WE8RN4hh7m3
	 tzthgvSBf7EVd11RIz0jMB4Yd5pARINmyWCQc+/KMVUwk71IPUQ19IuDvLFdYkQwl9ZIe
	 Wk0IfeD371DwliNGSetvj9jt+V8VJprHQTxN6Uiv6vrVlOSkY5pSgFFQI7iQHKHvE2hud
	 JrqogPA1PNkVVpLGgAyW/FAwLhKVgVjayD7nSHI1DFEGQXf7qt6ha4mlszKkTRLN1yEBi
	 aKiV76mF7fmKdzCFO5kW+rOXkzZCKlMbw2SU3iZ9jFwP+/jbOX5CQLYCmW0ohakR7Zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=picoheart.com;
	spf=pass smtp.mailfrom=picoheart.com;
	dkim=pass header.d=picoheart.com header.i=@picoheart.com header.a=rsa-sha256 header.s=feishu2604151535 header.b=IYsXm2P5;
	arc=none smtp.remote-ip=209.127.231.42
Received: from va-2-42.ptr.blmpb.com (va-2-42.ptr.blmpb.com [209.127.231.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F89C606A32E
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 12:52:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F89C606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=picoheart.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=picoheart.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=picoheart.com header.i=@picoheart.com header.a=rsa-sha256 header.s=feishu2604151535 header.b=IYsXm2P5
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1793883161; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=Fz6oVrX7/NbNBKe7D52bmdwjWluMA6P4LkwzqUDU7u8=;
 b=IYsXm2P5Q3lFFL99BDPxLFTKSU2lnKSXO+VMiLPDpBq+fqhCbAjtoXAgTc2yIBvoNaMnqS
 khonTVnSlJuGD1+Xuw2AInBhyo7l5xmHV+gF7Ju2V9yfvbkwkwld0lupL7c14Srq0kXnLc
 MliKsyaA2scfEz+bqmpc15GNvcpwYFBE24690vZN/ur0kTaytRpbk0qMRW2FrPw3kEp2BR
 a7oYIXMNqsM9U/wWrSOsyKz7AXD/fe39THCkzaBjIWmpuLU1LALaGC/zQHJlLstWg0pVFY
 8woCdnb2uAJBkasp7frTFhbCxn9mJqkfyun17YoeG0sGSp0CGEQoKoGbr6H2qg==
From: "Yicong Yang" <yang.yicong@picoheart.com>
Subject: Re: [PATCH v7 1/1] RISC-V: Add common csr_read_num() and csr_write_num() functions
Message-Id: <51cb0e88-356e-4980-95a2-e4a46695ee9d@picoheart.com>
X-Lms-Return-Path: <lba+26aec7c17+cfdd0b+vger.kernel.org+yang.yicong@picoheart.com>
Content-Language: en-US
Received: from [100.86.223.207] ([58.250.106.114]) by smtp.feishu.cn with ESMTPS; Thu, 05 Nov 2026 20:52:38 +0800
References: <20261104161512.883885-1-anup.patel@oss.qualcomm.com> <20261104161512.883885-2-anup.patel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
To: "Anup Patel" <anup.patel@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: "Sunil V L" <sunilvl@oss.qualcomm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, <yang.yicong@picoheart.com>, 
	"Palmer Dabbelt" <palmer@dabbelt.com>, 
	"Paul Walmsley" <paul.walmsley@sifive.com>, 
	"Alexandre Ghiti" <alex@ghiti.fr>, "Len Brown" <lenb@kernel.org>, 
	"Atish Patra" <atish.patra@linux.dev>, 
	"Anup Patel" <anup@brainfault.org>, "Will Deacon" <will@kernel.org>, 
	"Mark Rutland" <mark.rutland@arm.com>, <linux-acpi@vger.kernel.org>, 
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>, 
	"Anup Patel" <apatel@ventanamicro.com>, 
	"Sunil V L" <sunilvl@ventanamicro.com>, 
	"Andrew Jones" <ajones@ventanamicro.com>, 
	"Atish Patra" <atishp@rivosinc.com>, "Nutty Liu" <nutty.liu@hotmail.com>
In-Reply-To: <20261104161512.883885-2-anup.patel@oss.qualcomm.com>
Date: Thu, 5 Nov 2026 20:52:36 +0800
Content-Transfer-Encoding: 7bit
X-Original-From: Yicong Yang <yang.yicong@picoheart.com>

On 11/5/26 12:15 AM, Anup Patel wrote:
> From: Anup Patel <apatel@ventanamicro.com>
> 
> In RISC-V, there is no CSR read/write instruction which takes CSR
> number via register so add common csr_read_num() and csr_write_num()
> functions which allow accessing certain CSRs by passing CSR number
> as parameter. These common functions will be first used by the
> ACPI CPPC driver and RISC-V PMU driver.
> 
> Also, the RISC-V ACPI FFH specification allows arbitrary CSR number
> as CPPC register and the RISC-V SBI specification allows arbitrary
> CSR number as PMU hardware counter. This means ACPI CPPC driver and
> RISC-V PMU driver no longer need to do sanity checks on CSR number
> which are now done by the common csr_read_num() and csr_write_num()
> functions.
> 
> Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> Reviewed-by: Atish Patra <atishp@rivosinc.com>
> Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> ---
>  arch/riscv/include/asm/csr.h |   3 +
>  arch/riscv/kernel/Makefile   |   1 +
>  arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
>  drivers/acpi/riscv/cppc.c    |  17 ++--
>  drivers/perf/riscv_pmu.c     |  54 ++----------
>  5 files changed, 184 insertions(+), 56 deletions(-)
>  create mode 100644 arch/riscv/kernel/csr.c
> 
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 621f84d1898f..ebd82043430b 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
> @@ -672,6 +672,9 @@
>  			      : "memory");			\
>  })
>  
> +unsigned long csr_read_num(unsigned long csr_num, int *out_err);
> +void csr_write_num(unsigned long csr_num, unsigned long val, int *out_err);
> +
>  #endif /* __ASSEMBLER__ */
>  
>  #endif /* _ASM_RISCV_CSR_H */
> diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
> index f54c336bf547..7f52ae724225 100644
> --- a/arch/riscv/kernel/Makefile
> +++ b/arch/riscv/kernel/Makefile
> @@ -51,6 +51,7 @@ obj-y	+= soc.o
>  obj-y	+= alternative.o
>  obj-y	+= cpu.o
>  obj-y	+= cpufeature.o
> +obj-y	+= csr.o
>  obj-y	+= entry.o
>  obj-y	+= irq.o
>  obj-y	+= process.o
> diff --git a/arch/riscv/kernel/csr.c b/arch/riscv/kernel/csr.c
> new file mode 100644
> index 000000000000..e96b129c1a99
> --- /dev/null
> +++ b/arch/riscv/kernel/csr.c
> @@ -0,0 +1,165 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2025 Ventana Micro Systems Inc.
> + */
should update to 2026?

Now read of CPPC FFH counter succeed on my platform.

Tested-by: Yicong Yang <yang.yicong@picoheart.com>

Thanks.

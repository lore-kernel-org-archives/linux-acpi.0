Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794388532;
	b=QCj+bhIR7ml+CRASjd0qFYLX2KUfwsMnVQk6eW2FJNdzN0bicRWyPicgBbgAo6yc25zT
	 rZZMC6EI3q3ZhPiAE5tLeK1d1m9cVmKq0JEZWU1VA0a2uUDXcY7FhXZx+sZF5slPBOZAT
	 40dt5PKnhM3CSwsonuhiRi05m5781EE97077X0Xtl8R6nttu7vXdFIMgG4hZ75JYWFJyX
	 sSHxKvlXcOhlWgq4Pb/SEs4RnURxOSM8RObBOjzl3IwpILS2rLTfU8k+FtrsTZhJVTwlH
	 Uc/XTlCX5EbkBm+oDQdr9CHKVLBgRbCD8w4whzJrwUvi+dF6NG1x7aua1bnWI6epGfA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794388532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Original-From:In-Reply-To:User-Agent:References:Mime-Version:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=5QBZ8GiNGrJnUI6N35dRz2cDj8jF0y9M+l9Eb/FSxrI=;
	b=JaevXwanCChOQZha7IhgTb/FhqAdn8Qp2NVlBlF8TMsIEx/vnwtnpq/5Cy9KLYJtj32V
	 pmYmLVzllors4r3KD+InEPz1zk3XZLiZNomMhpiQDZzHXxMqcB2ua/wiitvBAZPe4Dyem
	 R4n6I6BrP28vAipagpuVtpaVcJIl74rTj4c/PctHStzmBIa/N2xen1EETvoGvTzUI+rXQ
	 249hQfxvWM00t+1DsIfpbsZ6WOkL/KlYgBwSbzwLBjSkHF8L1ho+H5hl/2AZXNumxJVVM
	 7NKAJqqG7eagCJ58WPIB7050GS5sLVe/JWJk2JYSluX685ARNzABd1UIQyxVPuOPeIw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HzNtIOeW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.173
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9503606A32A
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 09:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9503606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=HzNtIOeW
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8b31fc13124so23190187b3.3
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 01:15:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794388530; cv=none;
        d=google.com; s=arc-20260327;
        b=nyBnOGRhUeq0PdTjCHDpkiqSqJXlFLOiZaDnE6Ono+p5mDcNXS6ZhP5TjGFE3Xo0aJ
         fQ0MjYDw5Xj8hZ20YmzKIymZ3xtSL7sYgKX+0hAjh0DZ+JWBma9KGQsdtEqEgaQrnvuL
         EjzyAFnoqrFKAIEYpUpXsrv7m1dVhflzIQBDPenWxHhLGR38sE7aGKIOmJs7tASBkLy4
         UBsgHmH9kdHaG+lYmGFySlIiL8v99W8p8ESf5FRNKBF9Zd8AuPA1FQcWko3zXHIpLTaG
         +V9uLEJIuZyeFyLUh2yaYL8xMEYtnyxqBOihiP8yrvW6/0F1VJsW8jmmfW2Hjs7X1xQs
         7Y9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:user-agent
         :in-reply-to:from:dkim-signature;
        bh=5QBZ8GiNGrJnUI6N35dRz2cDj8jF0y9M+l9Eb/FSxrI=;
        fh=Y2b3LBh5+Nr57w8h9H+oNbdG7NrMoGv0lpwz68Y5r5Q=;
        b=WqX11fyivogJJ9/5OvlJP1Cz3DYrY13h+HO8/A+k4ePwjxWeU1wemOGp4fsBGECL6w
         VMvn/G24L5GIgXvLcube/zDriJ4YcR42xQvzrjK4HJjKK45VtrxCTTTNCcqEpd7+0sfa
         ETxgS7kc8oI6RGOjhnMelTtUhWUaPDeBiKLy4Wc6ipbrdRUJ8crtHfWI1b02iqO3fdne
         js+oUakaZhBcnOvXjfYN98FZ8lKODHaOZojdXwzfrwvj2La0DA2KjNNcWPGQ4WPC4J82
         MR0cZM8pYP7Sz4QZJJY12MT6TpUEpzFJR7y1WuNgfTlCh9kqx4zPenI82AsYtLMLFwpF
         YPAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794388530; x=1794993330; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :user-agent:in-reply-to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5QBZ8GiNGrJnUI6N35dRz2cDj8jF0y9M+l9Eb/FSxrI=;
        b=HzNtIOeWviucvigYcA46hEnjuXrW/gc3E10595qDDFPFeCLhBappFbDB9jS6CtsKKt
         MkenEp+0fCDizDhWi3ULEjpMx5fEkM9evaaYQ1+b72DHc64YOnTcdZAS0zLdy08kLVAf
         tX0XYpx3jbeju02S7Tlez1urW4fP5FXcKqkZZJsMdSBPkOb3fVUmHLo/P1UXs4ts1OQ1
         jwTZ6WaaWll3BlCgs4iQGaEvcn5eX/8xI7GObzD0LLpQjLBFelv+09SRI+mrIzyWTZ71
         /Z6/cffgmQ1/8eGqUWiO53+b05sd2lOG1WINxJBprjj9Wc51N2/HWWtN7MaS4gYKnw9d
         f4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794388530; x=1794993330;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :user-agent:in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=5QBZ8GiNGrJnUI6N35dRz2cDj8jF0y9M+l9Eb/FSxrI=;
        b=Eox1Nlwl6ywlQzSJovFeN26VZq+EXmU1hjeMm8QsTV+4O9xSoxidglHaFo1KU2VqMg
         z/xFR4M+k2zpzpUfdx/SC3D/C4OLOZD/2lAxaDHo3RL36DUsmkc7uowPrELz7kbVlSTS
         0Rr2wTtPGOnRhaZb2eZwnVd49jgME34lLTvwUO+lJFB3FN4A364t4HBC0A8epk1dZ7Z5
         Qg+TVuVN8cbb25h0Pnnf9pXA9TjwHTNtett9sfkmVJ8DSMFy3wpSZgceNUFHR40cvIQT
         dSciyGKfOwF0XgQ0EbMFNbTSP1nZquvDage1WX1ZIH6ROdyDuo6zzVhTlo/aZMD3M/Cl
         6SUA==
X-Forwarded-Encrypted: i=1; AL+hErGh1u0t6iDCyDOczRWYY99OWpvzAPXN4Wc9VGuTY1/G7fvrm3WadSRE5wxLYal7LVwvA7Z4sSO+qvPG@vger.kernel.org
X-Gm-Message-State: APuU4Z9qB98fPA34lMOt+Gq+aslDxUYoTN7jxtxJot2mucPwcS1N1YD3
	DYAxylPHw8fc+HYCF72z2z88egfiFuPowH04HCGWHZFnxqtIyUUbhC5qCaWPCntyGkDUKBL2Rxj
	hOTdTZLfVPma0UyjLhsZmvof5PEjYxREaCKzyA6FszA==
X-Gm-Gg: AYBFou2o7M68EmWUlYugBGiWHMlq2qe8T9f1OpzID7ud9/fHTq9KvnxovNtYwdciT2B
	n+jtJeXwAGkg5DTEUjgMnmxcAPqotwogmIL7Dm1e4SBhJDQWvdAMU8qZ0/Cms4e/1xkr4kdbW8/
	QNfBbNR8khdm+9PJIMYGINJTfthq1G1He5ZZHs6DAevAaSCBI8ihcsclc76RQB/HKbSLSq0lzQO
	8xlCKcFbU8osiP8rqdHWvlhY0kYQ3QJC1eEJKZjstLSVFAjgueXDYRhWyPC0hPR1v6sex+8rm8Z
	EGKEH5Epgm8czprijLijrAvaimrkE6yR1CKUw2yVgXT4WdyzJKnQ86/Cqgo0wGIsQoAvuACLRi9
	BGcHRi0ih7BrPV2w9Nsjf7ugVxhb0B+HoxwMQKQ==
X-Received: by 2002:a05:690c:e3cc:b0:8b3:47fd:a020 with SMTP id
 00721157ae682-8b3a81b0dd7mr18772977b3.35.1794388530362; Wed, 11 Nov 2026
 01:15:30 -0800 (PST)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 11 Nov 2026 03:15:29 -0600
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
In-Reply-To: <20261104161512.883885-2-anup.patel@oss.qualcomm.com>
User-Agent: Mozilla Thunderbird
References: <20261104161512.883885-1-anup.patel@oss.qualcomm.com> <20261104161512.883885-2-anup.patel@oss.qualcomm.com>
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Date: Wed, 11 Nov 2026 03:15:29 -0600
X-Gm-Features: AclHuK9OnoLWMiiTkLADqyRKwVWpH6udmKoKB5NUgD5BSW6Guh7fRvex4qoZ3-g
Message-ID: <CACnXVnfFWF8h+o0=nSb9JESOxYsdVMO+BJKMT7t=K=XVgVwx2g@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Anup Patel <anup.patel@oss.qualcomm.com>, Sunil V L <sunilvl@oss.qualcomm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>
Cc: Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, Atish Patra <atish.patra@linux.dev>, 
	Anup Patel <anup@brainfault.org>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atishp@rivosinc.com>, 
	Nutty Liu <nutty.liu@hotmail.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Yuanzhu <yuanzhu@bytedance.com>, Yicong Yang <yang.yicong@picoheart.com>
Content-Type: text/plain; charset="UTF-8"

Hi Anup,

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
>   arch/riscv/include/asm/csr.h |   3 +
>   arch/riscv/kernel/Makefile   |   1 +
>   arch/riscv/kernel/csr.c      | 165 +++++++++++++++++++++++++++++++++++
>   drivers/acpi/riscv/cppc.c    |  17 ++--
>   drivers/perf/riscv_pmu.c     |  54 ++----------
>   5 files changed, 184 insertions(+), 56 deletions(-)
>   create mode 100644 arch/riscv/kernel/csr.c
>
> diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.h
> index 621f84d1898f..ebd82043430b 100644
> --- a/arch/riscv/include/asm/csr.h
> +++ b/arch/riscv/include/asm/csr.h
>
> [...]
>   /*
>    * Read the CSR of a corresponding counter.
>    */
>   unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
>   {
> -	if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
> -	   (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {


Could we keep the existing CSR range check in riscv_pmu_ctr_read_csr()
when switching it to csr_read_num()?

The SBI PMU driver still assumes the architectural counter layout. For
example, if SBI assigns an event to a custom counter at CSR 0x800,
pmu_sbi_csr_index() truncates 0x800 - CSR_CYCLE to zero. The perf mmap
page then advertises index 1, so userspace reads cycle while the kernel
reads 0x800. The same index is used to set and clear scounteren.

Non-snapshot overflow handling and RV32 high-half reads also assume the
architectural layout. Could we keep the PMU conversion
behavior-preserving and handle custom counters separately?

> [...]
Thanks,
Zhanpeng

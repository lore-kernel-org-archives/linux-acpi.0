Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794731257;
	b=n17rjHlsyfO9FEMpjT44tkO+u7/IT6WbYzwb5o4TTGhOrsxpijYe0esPYDbEkDeAOF4W
	 1nxRJtlRP3LWOw1EfVux1pvKJrCnVcKvVyXla79qhTsK0zN4PEl/JZsJTdbNGa/MoL9dX
	 fRR3yQPRlXYN9vaqkdzMSpsKgKs2z7sWH0dt3EpjVeUefbUxk5Si6zplESjpqVIYXr+OH
	 0BOne9CC6PcZ0koddCutiTDwyEabrmjYGpFAexH/pHa8+rGKcxnpwlBwdYdrZw/AN59j7
	 63tLwyy7ulpNFP3M8zegFaaz/fmS/3Fp6vnl8DlkxtJsPM1oZEs+IVhTp9KEuJhcc6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731257;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=aiSvnartFRsxRkzyDYAtms10TvAxc9fqqCfE0o7gA2A=;
	b=DfC/cMmvVyvvx8GdWGWsUNkmkM7R3GpIdrfFkGtCalI0aynJk1wFu1IqpHRZyg+hS9gL
	 7TeTsogBoy5zRz2Ma6DhQFjVrcNDWsWi2dQu/B32A1K138+al+JAcIaLk6ZkSEUOjad90
	 BRqJdmO5E7vzKxz3Y+ChH9QJhUhDYxv48VLoeHZgHjyNMWk2Baqv8rrQ5arW/fTuPcEL3
	 QPr/RjAD2RsllD37HTLD/fm0hn6ITq9YJlLOcBO6u7PMCVfq4dl5HF4AotrAVj5vCO1f4
	 22D6fZcgo/+Z7Fi/3xVEE7uXh/1dM4TSsVV4uG1SEOFTJGY6yhxFoRN0WC/sC84TV+w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=FF9b9NOG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEC606A88E
	for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2026 08:27:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66DEC606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=FF9b9NOG
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so1481005e9.3
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2026 00:27:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794731251; cv=none;
        d=google.com; s=arc-20260327;
        b=TBkQPzazWHMxQjBd9c3MYA+RuZBUosPsZNIubhRm3L4zbqNw3AJTNq77fYmNF+bTJX
         CJg6RbVBwJuu6FR2PDVIa3DJBEncflNkB3YEYwyxruNWkci2i1KQodbtoN1PcA8bLLzd
         c9BnMYyvrtm/M6Gdpfv/dpogKmc04ZgRRB9s4W2C1KWMPueJ1lR7kY1EZofdU5lZdTEA
         aSqWZ+SQKCY8WQ+7EBAhRxXWnoyR+lrggONvsq/4A1JTzVY8zH3Lk81lTKuMZ8aVgYpl
         a21t7+NTBkzzPZyUHzyP3Au4JK608rISeawlEvgq2zF5lYWhclhcv6TVKV8UeqcZNQ8e
         d7Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aiSvnartFRsxRkzyDYAtms10TvAxc9fqqCfE0o7gA2A=;
        fh=x3c4adJZbZ/jU2FSKVmv6bd2NwH4RPj/pMtwcoaN/5I=;
        b=MOjh4ENd1f9afgjhwOLmV7rq/eRINpyn37p/b0ZJ24YhGZKG5uYIo504VytPiCIn2A
         bTVpRUjQb48TJOvl/+QNoK7u2TdR7LzYM31g6+mjIHtpjOorvYFCsJfNLP32utW3DQH6
         YKWXIVfdMFyx741R5BI5XP3Ra5zARe657DPuTOvGNBj6qUtvWlkxIaaeFDzI1Cl1WMj6
         RWE8qKPeivw4dFyqeRbIIsicRRH+SEoakJ8Buu+WLXCYaKY5iuA7hNIguNPNdYVDNyHl
         j+EP5j+pWoH3kkQSYZZDRQEIyriUyRwJCS61ktbZotdEyQudo1agRSwplPQFeHHtqlhF
         Pg5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794731251; x=1795336051; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aiSvnartFRsxRkzyDYAtms10TvAxc9fqqCfE0o7gA2A=;
        b=FF9b9NOGyETaLASOYqSncg3Io0UaOS7xKD9piIRGEkDKWbkJQB4K0hCBB9eos32pb/
         Cy6o8nzSUMy9Z+kV+XFdhzfLtgs0HI47ArmYnnezpjdxHCIz9IFUP0K2cHJWWTxsD/sz
         1oKyBVd3TJCOnY32lZCU4TiFi31y+IzZ/q/aazzhUd27DJd+kwa7jRK9+MK8RjvucDDN
         IdDLCYgtiNYaiHOUWb7ylh11Bs7CAUn65L1uMtSVEbjTL6b905O7flTXR5nHqD2OuONs
         dBoAvQs4YwGWz62bsZzFoez3ERifZGRfEknwrEzcYi9UNYi7kXux+7H6nmkR9e8QJusK
         9ojA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794731251; x=1795336051;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aiSvnartFRsxRkzyDYAtms10TvAxc9fqqCfE0o7gA2A=;
        b=Cqm0fUVboRZE+AdTK/GWJNK8l+t4xd+d50w+W1JRvj4CTIl+EUK1lc4bUqGcPw3VQE
         ACYEE1EWR3e5cqhsRJcZuRy6WPX4UheeYDnEzlT+PfAEZI6/1YdrsJ/U+SHB77Sf2vJK
         jiwQq6RjVvqrMhCXtVz4Toe9dplmcaaDFvZyBXUkFh9lJolfcNRUgZMjA2mM5youVndU
         Ys4rNPNwGwHA14mden9L6WFSIx3SnbKT1mUZ4qoFb766De/c50w66ktXPHuZ2asz5wsy
         c7HzHXAgaGI+NUURAAspy8hy1Q3olecqsf3kxB1gfXzH+jll4yGXBSYu/k10zXhe7ifg
         nAAw==
X-Forwarded-Encrypted: i=1; AL+hErFVBAyZw7O4ZWrv/+USnzkALE8LbWtlpL9xEWWQV6ggLvy6ORQonyvppAn5iD7t+g3hre6LSZMhMvzl@vger.kernel.org
X-Gm-Message-State: APuU4Z+npi4y81gJtO2g6bB9mfBiinH2okcqe+kfYcYX6Xp7qUaCjuEn
	6vV/jFyWZIqWKEPrXju0GRHMkJ6cbOl//xw4raZUcqft1dq7k87L7YYg+19g0o0sNFpp3HJII9U
	SCiozP3qPcDj9FFrPTJDvcPX6mWP7w+7AiZPcY0ioQg==
X-Gm-Gg: AYBFou0iEbPRDhuveamj+wZVFFOLJwi0IOQlo82N4bECDOuEMjpwhBhQwUdNyNfmJ1i
	wFFaKr4Qfy9wT3cbLT47zg9cycSp17QKRioyptrP3hqibSYJZvHwMkLIEmY8K4SDERH07mwvgGt
	/rTOlWUorF/nQmsDSZic7Y7x80O8Kzt34cGpSXivifgT9PP4ZeWJJWMnHBSdSrF5oIrIRhMZLAZ
	rBhT86IQSYiv8Vofa6/aVSnfewKnoIhPfZflv4JSeVsXhNQ/1GiFnXE1oJTT3h0dV0VCYsHf7Kh
	Mt/7AhEYvIRcgRlWePU3kjm9YnL7D9NXSSA/bEuT40cVEi5MFN6+sfj4W1rv07rCwKEAiANqAhP
	71PCKBheiXbMeZHjx0NFWQzktMkLOlb6LFCugdzjYJzeLRU8gqkJkRTwJ8fYMSmn/i2mglTjZdD
	UJHWM0SQVp4PsPFzcg/Mfg3CIxg/m2vzoyPtRyZdvwKHJ3RNb76GwW
X-Received: by 2002:a05:600c:6208:b0:4a4:fc8c:cfd9 with SMTP id
 5b1f17b1804b1-4bb55a66467mr149044985e9.25.1794731250698; Sun, 15 Nov 2026
 00:27:30 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104161512.883885-1-anup.patel@oss.qualcomm.com>
 <20261104161512.883885-2-anup.patel@oss.qualcomm.com> <CACnXVnfokcEnSgQS_wLN=LZ=jztisuusft6nC8Z--+o+xCC1tA@mail.gmail.com>
In-Reply-To: <CACnXVnfokcEnSgQS_wLN=LZ=jztisuusft6nC8Z--+o+xCC1tA@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 15 Nov 2026 13:57:19 +0530
X-Gm-Features: AclHuK_i7RtARhSnEV4JaRu_cVL19f5fuKwJ5a_U31KgZmQUYeTFRxuQRxn9Ppk
Message-ID: <CAAhSdy0+bdkTutXEL-0FKa7meg51wEsJxB9M=kuNLUNEaCVaRA@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Sunil V L <sunilvl@oss.qualcomm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Alexandre Ghiti <alex@ghiti.fr>, Len Brown <lenb@kernel.org>, 
	Atish Patra <atish.patra@linux.dev>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, linux-acpi@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Anup Patel <apatel@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Andrew Jones <ajones@ventanamicro.com>, Nutty Liu <nutty.liu@hotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 5:16=E2=80=AFPM Zhanpeng Zhang
<zhangzhanpeng.jasper@bytedance.com> wrote:
>
> Hi Anup,
>
> On 11/5/26 12:15 AM, Anup Patel wrote:
> > From: Anup Patel <apatel@ventanamicro.com>
> >
> > In RISC-V, there is no CSR read/write instruction which takes CSR
> > number via register so add common csr_read_num() and csr_write_num()
> > functions which allow accessing certain CSRs by passing CSR number
> > as parameter. These common functions will be first used by the
> > ACPI CPPC driver and RISC-V PMU driver.
> >
> > Also, the RISC-V ACPI FFH specification allows arbitrary CSR number
> > as CPPC register and the RISC-V SBI specification allows arbitrary
> > CSR number as PMU hardware counter. This means ACPI CPPC driver and
> > RISC-V PMU driver no longer need to do sanity checks on CSR number
> > which are now done by the common csr_read_num() and csr_write_num()
> > functions.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > Reviewed-by: Sunil V L <sunilvl@ventanamicro.com>
> > Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
> > Reviewed-by: Atish Patra <atishp@rivosinc.com>
> > Reviewed-by: Nutty Liu <nutty.liu@hotmail.com>
> > ---
> >   arch/riscv/include/asm/csr.h |   3 +
> >   arch/riscv/kernel/Makefile   |   1 +
> >   arch/riscv/kernel/csr.c      | 165 ++++++++++++++++++++++++++++++++++=
+
> >   drivers/acpi/riscv/cppc.c    |  17 ++--
> >   drivers/perf/riscv_pmu.c     |  54 ++----------
> >   5 files changed, 184 insertions(+), 56 deletions(-)
> >   create mode 100644 arch/riscv/kernel/csr.c
> >
> > [...]
> > +     switch (csr_num) {
> > +     switchcase_csr_read_32(CSR_CYCLE);
> > +     switchcase_csr_read_32(CSR_CYCLEH);
>
> Could we guard the CYCLEH cases with CONFIG_32BIT? They're RV32-only.

Okay, I will add #if for CONFIG_32BIT.

Regards,
Anup

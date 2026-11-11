Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794397574;
	b=25M5UepHOQf1xxR00D2pKXwxWY9taSd1hxdRm/CjhaZ/fCc3n/CjCbinOKR3LKS3oYoH
	 VaAik7jMJQbfpHC9tGIg8ZHS1rRrJpORVuM5zpLbkm7XVQjxBnt+dXEDS9TLniab/xyQc
	 bE0kztJcqjKvx1d8oZit97PCKr8/U68xjlSMApZNyTYNfNrnlu1ZZvPEcpw6f+FThvT/Y
	 94oOBbeMFj1s8+VlXZBEsAw9zd4MvdJABCczGGtxoAcHiSAnUj+OAAYfy6Z4dSM8Wz0Sm
	 RFgLBLliImEWCabN8t3Uu9jw25u7JY61JgcO/NY/Cf/Ro/M8n5C4Pwe6RLI35Apdy2Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397574;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 In-Reply-To:X-Original-From:User-Agent:References:Mime-Version:From:
	 Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=sxD02/BBheMAurw06u7jeipcoPrAv0FPorNrk8HrBgA=;
	b=weyR4kCFLPqGJU+QXG5AgkZwBU311uoo2QNHLapQfipAI3jAjfu4co3TcFUN7qrMItz4
	 IZtDYFh6AfjAb79UjKxoyhV6nId7iWqeAq4RnkYyNWpQv7TuImchnuvaXiPLyPOaV5q20
	 uo7IqqOpP/TJjQ3z/Dw/YO68Y28GcNX00UJlnY3eh0Im0wQFmkgZBXW5LBC9g53aglHij
	 EgsE3eCdMk6Kn4yaQ7vgkVrpa9Qn5lZMDMKlnEKTcir7ponjzDeHmPs7l7oBemdR1dOru
	 kF2qY+suj6fp26woZJkcTBzNBVLUwh+tQtPvithx3n1vAmeNq7iojHu1EnoB5CSRlmg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kIwgcAUp;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D25606A326
	for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 11:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1D25606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=google header.b=kIwgcAUp
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b349d21fd1so23076587b3.2
        for <linux-acpi@vger.kernel.org>; Wed, 11 Nov 2026 03:46:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794397573; cv=none;
        d=google.com; s=arc-20260327;
        b=jpWXGDMqGWmgHgz0Jop3/2kC5QEZ1ETKzePnkwxX8cZ9ilUqOGe44+Bu76eNDLaGRs
         6GOWoDasUj6GNmZqZcxZqE0ivlzXQI8GjjBGL8XxLKKepFgDNbl4RTAZlEHLdRwxOKfC
         PfZau66iWrN+IJ5PP/1HQDXvAlQp5N0ZEcY9ltpj22neUfpG8YqF9sfdfDYCVxA4rPv/
         FxbsRzXUWAR2kfvv07zx/7W7UwGch7e1ZSplN2y7QfSfKkrQyAf3N2f/FEEsKstUeEp2
         P0IMvybxac8H2VGwMzYNqkzUUDMFSEVzecnXL7Tz11HFdPJjj2E5yhRYw7DUL8q8G06c
         xF3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:references
         :user-agent:in-reply-to:dkim-signature;
        bh=sxD02/BBheMAurw06u7jeipcoPrAv0FPorNrk8HrBgA=;
        fh=GZrY5GMi0pPaYQ/KtUDOr8VKf9ifmgGOng8RgzczSJE=;
        b=bcyZEl8psdfxhx6tS/FGMt1uZwS/MH/ORzIaDXE6NqwrH4o8aQt9w0ObN6tGhBjI0B
         jpgkC2jfkvfGRpp3eRRqOmILWHnAytSRrVqKdkPdPQcFzo/rughBlfY4lq0qYKDKozq6
         4aKOjBf2sCmW+sODVHjXkK+K78zVKWVukeeRPzzhvz6TgtdFVH56cTh2Gs19dlEeDtfY
         VqQZfoTy8umQY0ewZvCtNebw5clcVond6DQuNJkrzfPwUQYTP6XB0H8BSsDZeVwEdoLn
         FJ0VEpRgtUghN58DJZnw6v6juQoLgDLI1OFgvHuDRNQOnLCexCWdXg9y5vJLUrwojK/q
         NBgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1794397573; x=1795002373; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:user-agent:in-reply-to:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sxD02/BBheMAurw06u7jeipcoPrAv0FPorNrk8HrBgA=;
        b=kIwgcAUpQqL4lZ/PQ1kOjwgNqzoOlXy05fPuJt9K9jm8u2fhViAiqEaJI0y0Aw94YL
         DXSizoXh+EafTCTjjyCPNyBhoJZIted1KJfK/LiOjA/NTEMJwkRibmfOz97PHidSGuLM
         ZXLzzjNAPpA8Z+ZCu+WpbS0v02qSWC+1vybPmx4CSgEAHRIoLroc8RikaB7/oprNsBFl
         dp7rGnORJJOvfcgj6sWmeixgXtXQ/+N1BjTksPAZPE+MlTo1RSVxTmrPXOoXwkN8rATj
         Zzn97EboZnSduCdtbJQGI1TrCg9w+fF8zsRcpK3WJov+Cm9SZ5FEMyn88GgY4GVisyal
         vSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794397573; x=1795002373;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :references:user-agent:in-reply-to:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sxD02/BBheMAurw06u7jeipcoPrAv0FPorNrk8HrBgA=;
        b=l2oy4DGH/ZBEPXJ6fvm4zWU1SiOAyDOKLregH8GwqiKcc7HdveXlt0FrfLIR0Kibek
         RkpmXlUVe16ueIPIhWnXaGr3x6r117EEDgWvVkSXEI8oISwBOubAKcobYLMwkUi0tKEw
         OpHh/Cq49DoNcoK1I0ucYbfZqcxuPChZMAcmF8fElmylRpXd7kgAVzOtRnP0ObxU3SHu
         7jD94WGOXRh6AIKl7sUGB94S26YOAjqKrb7mGhq+TQcHjAwaVuo8Tr845two7BOHmtko
         Ks/BhH55eSbyVSJXtD0shGpODSI20zrU5L5CzFJ/85NaPW73XsfTE/ZXKmSTr+ZpZ1U5
         Epqw==
X-Forwarded-Encrypted: i=1; AL+hErFb6k4QeBhgpYHo5B3jXVaHg/fShum8Xrhkm8sYWS9npRUddUBnPJ8o3eRoGKmZkvFU0FzCw+mQoAA8@vger.kernel.org
X-Gm-Message-State: APuU4Z+aVKbgAArWgKh0mxxO4xwfmHIMqKa3CbLHeDLVMjpIJfOW8Zc+
	vOqqR49TynjzSNdLiCigPCISIMav4hGVarn+lurgng52KJn4bH/dhULEUqBDhjCignBC9JDFQ1o
	XUIM5zLZu18d+qu8v7azhYLgGpdHlVgi9vieSiBuKtQ==
X-Gm-Gg: AYBFou3BrtqW8Yjt6QJ0ClF9m5Ek0dpz8sOTi27XuNGNLO/iawFuZgRdmVjZk6kKA18
	bxqNWLZ0pNJy8s+hDwBFsrrV0cRb+TJCrvjDP2i0kYDRJ9aFi0cYxqGwxN3qbYg04q9Q/4DRH+7
	Ymnj/EC8OAQrpHQfHRBy7ktlqUSecGjXdm04tMUvjcvuJ76p8oKIiD5lZBSAzfNp8OAbFijzfK8
	TICSxoWPhh+ZynpwV7W59vzyvZeSVlftMOvELGdDjsE87Y99i0xXFbJJJ3S9gp1rK4sHRGoPDMk
	MaKK6cqoQXrfy46RXgVRq1PelVfYZfrNE8KN+xnO5ieLiGw2Kixzfa7Xoqyg6xRLgvC3mkMEJUO
	HzWJsfqrFx6bRNh/MN/UXbKfIUlPeBmKqHQU=
X-Received: by 2002:a05:690c:4:b0:8ab:2f89:32e0 with SMTP id
 00721157ae682-8b3a81199f4mr13471067b3.57.1794397572467; Wed, 11 Nov 2026
 03:46:12 -0800 (PST)
Received: from 44278815321 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 11 Nov 2026 05:46:11 -0600
In-Reply-To: <20261104161512.883885-2-anup.patel@oss.qualcomm.com>
X-Original-From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
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
From: Zhanpeng Zhang <zhangzhanpeng.jasper@bytedance.com>
Date: Wed, 11 Nov 2026 05:46:11 -0600
X-Gm-Features: AclHuK8VD5zdhvsTYmRtyJzXAXUoripQo7x0P6Es21hMYyxTa4lv3D3kijFwJg8
Message-ID: <CACnXVnfokcEnSgQS_wLN=LZ=jztisuusft6nC8Z--+o+xCC1tA@mail.gmail.com>
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
	Andrew Jones <ajones@ventanamicro.com>, Nutty Liu <nutty.liu@hotmail.com>
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
> [...]
> +	switch (csr_num) {
> +	switchcase_csr_read_32(CSR_CYCLE);
> +	switchcase_csr_read_32(CSR_CYCLEH);

Could we guard the CYCLEH cases with CONFIG_32BIT? They're RV32-only.

> [...]

Thanks,
Zhanpeng

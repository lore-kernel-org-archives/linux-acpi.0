Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794731107;
	b=wAXdujoq75IyrwJ/6Nmh2zpQqxWRTGwaEhK26Fq3z4413WRkRmAtP1J2MUefemw674c/
	 lUWmUWvGDyKk3HJWqAChAPp5aDhj5qCMXm54NxwE5/KNl/8Hjun1Y3UFxOT+doXvy9zTm
	 fGvEAN1Qtd9SCoRPmG9556FzXZNEO7pxxjXccX7larKOkAMfbRMXojCPnXaa+I/4J/r1D
	 sAeVORaCvBLQIJ/R7Z2eKLD8VKnQw7Z0g0fvNta+Gvbm1IUhYQYaI71F9OIgCd0BLGFIE
	 RY08WakG35Bz+QfpyqKzWqWM64EsrobzrXS/GLUb3J1u/inxigPZnV1udvRjU/mJymQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794731107;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=/Px0VIJUlGzeZ9LUedxi9YmXr5Pv4gH8RZcOXqIrVUQ=;
	b=DsXsAKSckgG2RrFi0WNs5JOqxmW8kVpmHnsyExNE5iL6LennWfFkEuEprzZ/YayWZX9c
	 tnk/gzXlZmyHvbuP3ERuhh8WzxCHsbe0HxEn1kNGQqGRDh/dEMIFeI9p8VP+VxXmAUI4j
	 Am652AeXNMA/49jHgSh++ou5J8qj6LcUVwKKqcMKKGRm0m+/Ug4xzRX4YRRi4N6J+sSYn
	 ea1G108omn1L5058UrA7+tVrlG6/hstKp31efBsz5bHVQRiZtDzJrqJyqVK+xmONx8umB
	 KFh9PX+vwvOczoK03p9EyAKWYTVqPBwGd6qOwgILBIpXY8fYwgd4c2PGxYTpz6pTbgA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=brainfault.org;
	spf=none smtp.mailfrom=brainfault.org;
	dkim=pass header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=IR9SQMXY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8401C606A31D
	for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2026 08:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8401C606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault.org header.i=@brainfault.org header.a=rsa-sha256 header.s=google header.b=IR9SQMXY
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-49134c8509fso2500459f8f.1
        for <linux-acpi@vger.kernel.org>; Sun, 15 Nov 2026 00:25:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794731105; cv=none;
        d=google.com; s=arc-20260327;
        b=VTw4A0lGT8v1q2VBTD9HQlZ4FyXGilvinSA7WY7PWLMqb4i9SPvh0qo46q3JpshgcL
         TUsSBan0W5U8/1L//Ljz0Qty54edTXcLEZODqkfSWitsZuafPMj/M4uzYOuHFbBE9ptB
         2HpMGuEBKleFBWg8LyETt4N9IhxiReCMMSu41n7kWL75l/dWq+gE7B3oOoJlnbooph3t
         LLQCJNwvLbo2kg2YTBIMCef5YP6Ggfe8OeW1mk6qAMJBAf8OkYCgEl0PyHyVx6P8DGNY
         Jk60T7NTY8SBc1a0kv/4+hW2kyjiIofamAIJgvG4vMgLyn6ztuBIPyJ9YTgCmkbbNmCh
         zYEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/Px0VIJUlGzeZ9LUedxi9YmXr5Pv4gH8RZcOXqIrVUQ=;
        fh=ZU1LrBF+LLHDb45Q7Q1+pSDzZTX+6v2htPYOq/ZeuaQ=;
        b=BbmklE/seD5dvYf3+kA54pM7psKW+dXgSYt0Xteq+zXP0cOE2SEdRtbEujDPKh7N6R
         lG/isDD4aHf6aHagz7HQ+IDChLftqUCH3/Y7doJPVWOh2ZOIhKtGc9K59FQGX1G1POaD
         mPZTlTwIYrXcCm3MzUFlnYeNhafnom6kyaEGvgozoqun2MJrKYlyZ7xNw7vpnXb22JSP
         7lTak3c08TONOnsaqh28j3UAtw9yll1YxfQeU3WBDLh0UPrceYiwGbU37j+xJdwioxdy
         NPx+PM9+8eNL6EQy3yqNjK/Ji6fgFDcbx0k66dyd0boGZvUVd/ECCm9Z2VUo1pvjv1LT
         RbBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault.org; s=google; t=1794731105; x=1795335905; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/Px0VIJUlGzeZ9LUedxi9YmXr5Pv4gH8RZcOXqIrVUQ=;
        b=IR9SQMXYvTknKh3oH4uGk+tMS8HRfie+6WGkmtvhQ58SaddqigIaRPAfgFPWZgwckj
         6mVw2khpAdNDCIwkrtwzW/8FuRrbL0Ox15exAuIB/LAHgHO0+JumrvxkzSXMX+245ZZ1
         hJhwnWSaw0mDuZPdig46uu87mMu2B8DW3tlFZ1kqB7B1hFS8SJbjh7K9YDbUWF2OkU+X
         X6r+gDMyILYji1zI04QLzoylvklkjdabLw53EqXEyL/koUeylsD34U47rY1IOl6LWe2d
         cBBnXTnlgrNd7wYcr4EsWuR9/FuGmdMoNY0u6QUKFsjv8OhKGuCEbiPskfVjf1KpUVos
         qekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794731105; x=1795335905;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/Px0VIJUlGzeZ9LUedxi9YmXr5Pv4gH8RZcOXqIrVUQ=;
        b=Grdp2RGXu/SCrUOIKEKXY39EGFX825b703QM7z8FzU4cf/RqgpUd8neUwWxmORHGmK
         4eTreTPt0OHxsgMZJnyibp0nHBOh1eYpWX7564KGutsFqZAZrPnZ9q7xuq0uiYsNs494
         PHgKVzZfkRwySa75zvQo7lt4GXK3Bf9gec5QtzJvTK3Vjj4Mqp6SylKkd76j6zVw3ZWa
         9jqtXph/mk/gVoO69GLxpkr7RtgbMbOxvjfHZO+TGntK+2iNUXvDDUtgIz2h6mb7+7X5
         emVgw1FbRDNlEtQuiDwBGCOxqbp0mecGO3e/ANrJdrLkZNegj2NYVVsojYtxGdWGeHhd
         Jjjg==
X-Forwarded-Encrypted: i=1; AL+hErFxTQfgwo4H1Or/QjPAlIxp7gnaJcVIbQ/09NWufJ4Iq9LVZVxU5X/WS7dSNUjOdru0BPb1rxO1NJjN@vger.kernel.org
X-Gm-Message-State: APuU4Z9VS17Ycl4YZ7i8L1Pk5zriw+3Jr1fTPHJiDe65hlH7qs5qJhIQ
	IC/8ekAl+kzi25qM7Ps0z5kTafeVBVSzothYL8VrawpSn3v4h6oB8YUoeJcWmMZ3B3IvVKS1422
	4d1sI0Xm3V7CbxWXZX7i9aYzCBCIZIRtUF1ObCOLCxEZaDmUsU1X8JIU=
X-Gm-Gg: AYBFou2+hEzPS/sixezNTW82OdMxMGN3tyBnMBKt4n1VwagBW1gb6MM/Ph8IaReVwmC
	8B3gxx5MTgBqUhWA7JGHcyl0SDDZ/1xYU3W+jQfXahZcmb4zHHEZKr9+2D7Khmopt97Akmn0zGu
	27XAM54sMrdTs26ZE9XRp0FpgrKdzYP2BzyKrHqy9D66/E9JrCtHQk+raZy/8gdOSBdq+X/PfZf
	hquGyMiUoarS5azy6vAQNtkvsvPqGINRRfutYuxGLhbXobpWy/82w8fiBQrnfBnAd9ct2wfPVTm
	JlUyn/PE12iVSAXEDiXcnyhaIHAuIC2Ii+OxjRitVH+BU3eBWpGcO10clNEWS6PJwo/GbhGQETM
	bUtZ650wRgoXeR0bRuZQodEhE7OrwvCb+ZZO/l+iTEh9t/oZOBuCYJGq1mVb4fdCtvaytkz8Tib
	jfLC6u1fMh2tBgZ56T5bsUnxqcKr/lIQG9d6lXJZ0xHP8Eg0RYXLgm
X-Received: by 2002:a05:6000:2012:b0:49c:9e8a:31a9 with SMTP id
 ffacd0b85a97d-49c9e8a3296mr14948320f8f.57.1794731104324; Sun, 15 Nov 2026
 00:25:04 -0800 (PST)
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
 <20261104161512.883885-2-anup.patel@oss.qualcomm.com> <CACnXVnfFWF8h+o0=nSb9JESOxYsdVMO+BJKMT7t=K=XVgVwx2g@mail.gmail.com>
In-Reply-To: <CACnXVnfFWF8h+o0=nSb9JESOxYsdVMO+BJKMT7t=K=XVgVwx2g@mail.gmail.com>
From: Anup Patel <anup@brainfault.org>
Date: Sun, 15 Nov 2026 13:54:53 +0530
X-Gm-Features: AclHuK-mOIV-pplZYU_DZWul_INV3rWFbYVSrvzZgzVjhgWpo6FzAMokpkZQVIs
Message-ID: <CAAhSdy0ec6MdgrXWAe_AZT2aHEZeL-muj1EpadjCfseZVBy3qQ@mail.gmail.com>
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
	Andrew Jones <ajones@ventanamicro.com>, Atish Patra <atishp@rivosinc.com>, 
	Nutty Liu <nutty.liu@hotmail.com>, Yunhui Cui <cuiyunhui@bytedance.com>, 
	Yuanzhu <yuanzhu@bytedance.com>, Yicong Yang <yang.yicong@picoheart.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 11, 2026 at 2:45=E2=80=AFPM Zhanpeng Zhang
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
> > diff --git a/arch/riscv/include/asm/csr.h b/arch/riscv/include/asm/csr.=
h
> > index 621f84d1898f..ebd82043430b 100644
> > --- a/arch/riscv/include/asm/csr.h
> > +++ b/arch/riscv/include/asm/csr.h
> >
> > [...]
> >   /*
> >    * Read the CSR of a corresponding counter.
> >    */
> >   unsigned long riscv_pmu_ctr_read_csr(unsigned long csr)
> >   {
> > -     if (csr < CSR_CYCLE || csr > CSR_HPMCOUNTER31H ||
> > -        (csr > CSR_HPMCOUNTER31 && csr < CSR_CYCLEH)) {
>
>
> Could we keep the existing CSR range check in riscv_pmu_ctr_read_csr()
> when switching it to csr_read_num()?
>
> The SBI PMU driver still assumes the architectural counter layout. For
> example, if SBI assigns an event to a custom counter at CSR 0x800,
> pmu_sbi_csr_index() truncates 0x800 - CSR_CYCLE to zero. The perf mmap
> page then advertises index 1, so userspace reads cycle while the kernel
> reads 0x800. The same index is used to set and clear scounteren.
>
> Non-snapshot overflow handling and RV32 high-half reads also assume the
> architectural layout. Could we keep the PMU conversion
> behavior-preserving and handle custom counters separately?
>

Okay, I will keep the CSR range check in riscv_pmu_ctr_read_csr().

Regards,
Anup

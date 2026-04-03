Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62E742048
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 16:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775234861; cv=pass; b=TwVeU/h48IsRmMFWHd4gwYbFpB7sXFM2QTVKLVpBL293S//emKq7Jfle4wjSwUfa4Zr8WIde1BjBZSzjy7nU5QYSVxx4yP1tBMktOaPfasoU1D3PYq++JyhHWImIFE9/SctAMBWkPUZXzNGbv+ST2XG/KiN4bUY5HwO4xKk2Nns=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775234861; c=relaxed/simple;
	bh=bOvgYL3sN+3HT6Ry7DE2UyR+exdHNE12LBkCxRWzVAI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xt7DMEXITK2TliPPFLbhN7X0gxTcw/X8giX8tlh1D51wTfGTsd2M2bk9IiokhIaEtn9uFJKKK5UKp6DkXL1fd4JRhbA2vpOgzxsKQ4zOcuUv5oXVbBeU4BRCZvzINRQ8a7BwSp4h4SdvM9XmYA6CQ/xfnylKtk9pwes80ElgEUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org; spf=none smtp.mailfrom=brainfault.org; dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b=Nv9xjQfK; arc=pass smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=brainfault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20251104.gappssmtp.com header.i=@brainfault-org.20251104.gappssmtp.com header.b="Nv9xjQfK"
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-67e09232daeso1281189eaf.2
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2026 09:47:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775234859; cv=none;
        d=google.com; s=arc-20240605;
        b=iu3pEOkkx6+Z5dhPMi48hUmlmunKR9IBhLBA4hOM9Ry3CTMaMzIGmlRBEJUNmB8iOQ
         gDEaZMMOHwkkZm5eqB3pKVX/aRHjkSRN0GTkoWXgj0smis8PF00k/DCXAlCPbHPdmA1W
         cjFksYaOZXNx2iTZLa6gJxVSAaTNET726luSBa0TwcSdIsj2x4qsQNtouzUxdEvutMMc
         vmelEVxihDOdfL2C+KljkE6xPomQ2sBIg7E08m7G8dTR1e+x4h4Xmb1sne2Ldo3JKTeM
         Hz3BfZeRxO4Uf4C2+tz8UijWLL8XpfR+FMwUcHhAmICNNCfZ/LxS+kofItOUuhrnX1qc
         M5ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yd/fcGpgiRLI6biLglbkJN32L6g92D+Cp9fisarR7TE=;
        fh=0dXELpQGMVkE9rw2cWU4AXhlcG/cw9RqO/mIcbeNmqs=;
        b=Hpif/9PtHjgRhEupCiTqkciIUux4H7V3xTFjLA2/V/1q8J9wiKAzko0Ikmu71dibxa
         VpKB3gqK+I3kaosNenQC3u+w1Yab0JX9ZWFkV6I1uZCfnJAozL1A4UF/ufi+CltWo9Zl
         pfJi0qYtA3Cpce9HM9YzlE8ZL6zI48qOHifSu/JUvbvJlr+SVFzcPvqrL2kGgXKBOVkn
         6DgPUSQeLZmIuCqY5EKZ3nOyVHVmHarn8JOX3TgS66PKAFRMjUX3NtPZOrkBRXnjZ+HV
         z+Dn4BxaydBBjHy8XLoOzto1VseJVZa16uM5bDCHV0fwzfI6OqnNheZTE2NmKCpfsdoW
         GWeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20251104.gappssmtp.com; s=20251104; t=1775234859; x=1775839659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yd/fcGpgiRLI6biLglbkJN32L6g92D+Cp9fisarR7TE=;
        b=Nv9xjQfKE5L1hhZ3sM5VNGA9GepnNCvt+e3SH2mCR7rOwpoyIA4tx7qHKLoVwiiw63
         LtVO4JdnEX3CISKKurClo3TUOj6x656jD51+dEfcPjpEHKAWoQYNHZ0HuCHZIgljosNT
         yF+JdKdlq8z9Id7YzalnpUzPqpiB+6sgX2yT40AGCDg6QTHJdy7rG6n6qwnDTlTQnytE
         9u10VR0ff1JTNbE4NSZRbRnro5UJ4hrTDAv0pSG6nJUwvaPZ9hI/1LX3hLi4s1Z1gbXS
         SgWczLQja8xrFzMiw4cN1TpFQJXAF9ZI34cStgpKXFkOCmuLV0E9muFI46Tj+WL5cuzv
         JEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775234859; x=1775839659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yd/fcGpgiRLI6biLglbkJN32L6g92D+Cp9fisarR7TE=;
        b=OZVomAs/o+sdLFdW030sOqwH5dXu2CH4R2yfxrdvLQVqmK7WcpJ4E0LrpwMVfqFV2K
         gSK5uZN9InwHLD/LhMryr9CzcqU+IwUlXgCqZVWUA1Jpf7c9wEoRby2xsgZwdxqvwVFR
         bvQC4hGt6u/bUrpe9i9dyx2PIU8CglfPZKyV4jD4oUCf/d/gkuPDx/h3gmYpc5oGxxld
         U8mylDmoH8n1VEZOiy+50KGTtp1VlE8tWzPfJci9i0vTCfn4CZ/QftMBwRaAMxSIaYCZ
         rKS45aa7VSVq2U6XDMIQ82jE/Xt60Jpsm+c8TCSMtfwi0+7lr5M9OrOv++IUcdB45dcM
         abHg==
X-Forwarded-Encrypted: i=1; AJvYcCXW2CXIGlmg1e82mbL4zr2bhyxbZMWzy5XqJCUhfhE140rz14W24vlog2nM3vGR2bqAnjP0YUE9EFd9@vger.kernel.org
X-Gm-Message-State: AOJu0YwMADgNsjgY/bDF9pS2NWw/W28vtOkA/SXffVZ+9WlRcazH+Q96
	CaBYLTC2e6ebhUeMfEIsBisRLE3x9Z7ha/qnvbP9Xnp9h5yDosz6hDclxeaCI/L2zovlghJgdzl
	XlgHJdt4WCkdJn/8IWCslT8tN0Em2soTOkWmPm6nF3A==
X-Gm-Gg: ATEYQzwzxEyfeWxBEYUreTwdx99s4P4/q11hzdIUEQS5DGt44XSM2T32yG2yCuoa+qC
	VKquNc/Dp4Ta2uR0LVN58D5jgwe6s6u5b+/TmbI1Bsklqhq9rdG9pn2vCg0fpCh3FztBYMTNqtA
	aFCiu1PKtZRoEYEdtz59sm1viGL2TpZlZ01qdX1OjRb3uxr5Nf8MDK7dQuW7UV11RaCChOZsIFp
	NBQmJNU52mJocpyOAF7TSpRLFNDOssmdlNy5w2fOvRF0C5+Q/BU38RE3I9w1x/rVEV8XdwnY+BA
	+uoqu54OwZ8CpRjPYeE/SLQ0ct0ACrvb5QfdxE1M+qSNVR+t+w6xW/1iailC45IsuNtczquZQSw
	ACq1wuYF9BGeC5efMBSYOPIBqqA==
X-Received: by 2002:a05:6820:1799:b0:67e:1dd2:4102 with SMTP id
 006d021491bc7-6821f67891fmr1943718eaf.32.1775234858557; Fri, 03 Apr 2026
 09:47:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204155309.763597-1-anup.patel@oss.qualcomm.com>
 <20260204155309.763597-2-anup.patel@oss.qualcomm.com> <603b0a16-4965-2689-d3ea-3f9db0cc49aa@kernel.org>
 <CAAhSdy28oPgzaaZj94F-MToTYT6WTWsiSVpuy0VzLkM_maSP0g@mail.gmail.com> <e8a5e3b7-b68a-8b92-192f-985a0559eb95@kernel.org>
In-Reply-To: <e8a5e3b7-b68a-8b92-192f-985a0559eb95@kernel.org>
From: Anup Patel <anup@brainfault.org>
Date: Fri, 3 Apr 2026 22:17:27 +0530
X-Gm-Features: AQROBzCgxdkNDQ3suqhKRRV9KCytYtmrrnUx1qrolNT_DoeDZPgRKtPsxGB4U-k
Message-ID: <CAAhSdy3DOsJrwgoBii5Un8iWU9SUS0k6xVw=FQVavhjHKMJDJg@mail.gmail.com>
Subject: Re: [PATCH v5 1/1] RISC-V: Add common csr_read_num() and
 csr_write_num() functions
To: Paul Walmsley <pjw@kernel.org>
Cc: Anup Patel <anup.patel@oss.qualcomm.com>, Sunil V L <sunilvl@oss.qualcomm.com>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Anup Patel <apatel@ventanamicro.com>, Alexandre Ghiti <alex@ghiti.fr>, 
	Atish Patra <atish.patra@linux.dev>, Atish Patra <atishp@rivosinc.com>, 
	linux-kernel@vger.kernel.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
	linux-acpi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Nutty Liu <nutty.liu@hotmail.com>, 
	linux-riscv@lists.infradead.org, Andrew Jones <ajones@ventanamicro.com>, 
	Will Deacon <will@kernel.org>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 3, 2026 at 9:26=E2=80=AFPM Paul Walmsley <pjw@kernel.org> wrote=
:
>
> On Fri, 3 Apr 2026, Anup Patel wrote:
>
> > On Fri, Apr 3, 2026 at 1:55=E2=80=AFPM Paul Walmsley <pjw@kernel.org> w=
rote:
> > >
> > > On Wed, 4 Feb 2026, Anup Patel wrote:
> > >
> > > > From: Anup Patel <apatel@ventanamicro.com>
> > > >
> > > > In RISC-V, there is no CSR read/write instruction which takes CSR
> > > > number via register so add common csr_read_num() and csr_write_num(=
)
> > > > functions which allow accessing certain CSRs by passing CSR number
> > > > as parameter. These common functions will be first used by the
> > > > ACPI CPPC driver and RISC-V PMU driver.
> > > >
> > > > Also, the RISC-V ACPI FFH specification allows arbitrary CSR number
> > > > as CPPC register and the RISC-V SBI specification allows arbitrary
> > > > CSR number as PMU hardware counter. This means ACPI CPPC driver and
> > > > RISC-V PMU driver no longer need to do sanity checks on CSR number
> > > > which are now done by the common csr_read_num() and csr_write_num()
> > > > functions.
> > >
> > > I recall that when we discussed this patch on a call a few months ago=
, it
> > > was brought up that it seemed useful to restrict which CSRs could be =
read
> > > or written at runtime, on a per-vendor basis.  That way, the FFH inte=
rface
> > > couldn't be used to read or write custom CSRs that had nothing to do =
with
> > > CPPC or PMU functions.
> > >
> > > Are you still planning to implement that change?
> >
> > The current csr_read_num() and csr_write_num() only allows
> > HPM counters and custom CSR space (as defined by the Priv
> > spec) to be accessible via ACPI FFH. The ACPI FFH interface
> > is very flexible and allows vendors to specify the CSR number
> > in the ACPI table itself so we don't need to compile kernel on
> > per-vendor basis.
> >
> > In other words, the current approach allows same Linux kernel
> > image for multiple vendor even if they use custom CSRs in their
> > ACPI FFH interface.
>
> I understand that part.  The part that I don't like is that with this
> patch, the FFH interface could also be used to read and write custom CSRs
> that have nothing to do with CPPC or PMU functions.  That doesn't seem
> like a good idea.  What I had in mind was to add a way to restrict the
> custom CSRs that the kernel would allow FFH to use, via a mechanism other
> than the ACPI table - e.g., sysfs, or the kernel command line, etc.
>

We can't use FFH interface to read and write custom CSRs
from any part of the kernel. This is because ACPI FFH encoding
is specific to a subsystem. Currently, RISC-V ACPI FFH encoding
is only defined for LPI states and CPPC registers. Out of these,
only CPPC FFH encoding allows specifying custom CSRs.

Regards,
Anup

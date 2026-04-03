Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C6F21FF21;
	Fri,  3 Apr 2026 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204715; cv=none; b=HMp33iJpMytb/Zlu7RRHJRiK/mEXwlMJ3pG68JOkjOUcOet8lbxrNLFulXxcU9IsD5SSjSz9Uo05jvyOu8pCeWs8dtTnew1Vm3zXeJ2cdk7C7vtyFznVm/gUeAmu1aOiJO1VuAFjS7pYP/JcSNBXscQqtgzQ4Ij0yJsmCzBfe+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204715; c=relaxed/simple;
	bh=2V7jZRmmYQJwcE2susZ5Qb8YVVyl3rnEKO+bynnd24w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oWTWu5Jfm6Ok6jJfGjmQaLQct859jMDPOn/01h2NBqxarFmZljZn1dqtsXIfA5zOVqna9SzIKVOjCxUvjOKwsylPONO8qCOkjMrwyz9rs/vAgEuZlTKuG/+XZP8bB123XB5SEG3THFq/c+NzPnUANmb/JU1Of8+k+tfb5r1Ip5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coj/wKPw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coj/wKPw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01EEC4CEF7;
	Fri,  3 Apr 2026 08:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775204714;
	bh=2V7jZRmmYQJwcE2susZ5Qb8YVVyl3rnEKO+bynnd24w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=coj/wKPwyyPQPWVkbZcyGi3QYwg0g6XHtikRG3kDONj6sXKTpKQX9NV/SG4B/AMPH
	 2hmXoMawVQE7pRQ25NS2StWXXAoiS15OwdQZaz8Ql+3Qz8DE8KdiCQMXKUryAshIDE
	 drpOp3VqmLevTnf9K2EmRFJ/D62Ui5tfXHPZN5MpPmEZFOjwNUpHvInWSesZwdcO1z
	 twGZjYlu5/BJohkDT8fos5MORF5hYsuddakC/CDsx3q74As/+QseSSQc8sP71qW9CU
	 MGY2dvypb3veVQsXVq+4fmIt0gA7i3AcmnTO/fZILDBLU6zHNT90lyFdTBE/0AnZ0L
	 bHF+TdRkjXMJQ==
Date: Fri, 3 Apr 2026 02:25:12 -0600 (MDT)
From: Paul Walmsley <pjw@kernel.org>
To: Anup Patel <anup.patel@oss.qualcomm.com>
cc: Sunil V L <sunilvl@oss.qualcomm.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, Anup Patel <apatel@ventanamicro.com>, 
    Alexandre Ghiti <alex@ghiti.fr>, Atish Patra <atish.patra@linux.dev>, 
    Anup Patel <anup@brainfault.org>, Atish Patra <atishp@rivosinc.com>, 
    linux-kernel@vger.kernel.org, Andrew Jones <andrew.jones@oss.qualcomm.com>, 
    linux-acpi@vger.kernel.org, Palmer Dabbelt <palmer@dabbelt.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    Nutty Liu <nutty.liu@hotmail.com>, linux-riscv@lists.infradead.org, 
    Andrew Jones <ajones@ventanamicro.com>, Will Deacon <will@kernel.org>, 
    Len Brown <lenb@kernel.org>
Subject: Re: [PATCH v5 1/1] RISC-V: Add common csr_read_num() and csr_write_num()
 functions
In-Reply-To: <20260204155309.763597-2-anup.patel@oss.qualcomm.com>
Message-ID: <603b0a16-4965-2689-d3ea-3f9db0cc49aa@kernel.org>
References: <20260204155309.763597-1-anup.patel@oss.qualcomm.com> <20260204155309.763597-2-anup.patel@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

Hi Anup,

On Wed, 4 Feb 2026, Anup Patel wrote:

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

I recall that when we discussed this patch on a call a few months ago, it 
was brought up that it seemed useful to restrict which CSRs could be read 
or written at runtime, on a per-vendor basis.  That way, the FFH interface 
couldn't be used to read or write custom CSRs that had nothing to do with 
CPPC or PMU functions. 

Are you still planning to implement that change?


- Paul

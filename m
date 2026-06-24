Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C432A1BF
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782307090; cv=none; b=nomF9LFVZRIWmXWJUnnWNXhPSjgMQkniFlZh2LbvS6I04EOzGwB0+dSgPsZCxqUK6ojaE0YzfCb7GHDSPTHzWTHnFQuaOCPMNe/EO869au9nzYSHpL9uZuFqufdnT3QYBVCkEMnkyOVuadUDgBnHmla1Ruvg3NhSTeMQ5juC9EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782307090; c=relaxed/simple;
	bh=WtUzF+kKa00RFVwSgcsiFZm79bWbkbrHEkU0/c/TpkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fGnNo7O1T/nYUJX2SVRWJ759p+dCY9gVzooMcrlDnSL89mUXOOT9nQ/UQD+meQOBWJYlbIGn2xRu1jDXpEYTtkx4rIbkpV9UPoY0PON9Mrlns7zvns60WVmwJEHZFHyhrXhW1iaQWzKtphCu50+cXz63EtCm21Tdy9KaE+33WaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aSRG5boF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aSRG5boF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C02291F00ADB
	for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2026 13:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782307089;
	bh=1rD5RzOkXDXTz9zhYe01XrnuO4Sm8PLmcsetrRyq0j8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=aSRG5boFF576nEz0BFVHWB/dOFlcQf9QVXwZa8b/TuCHY/GCsJg0oXEzamnf+M1jD
	 iWweLgCfIuv7+t92aGHdHzUEJodKOmEpyuFXD41pmEh3xQ74VYXezX7D84gARjfcCG
	 GPM9/RN0CtJrSBW489pyuaRBCRQg3kP8H3pMxcxtTekTrXuMlXogbZEo7GK4WNemGt
	 lPusITMN4VULnX3RKGVfC5y2+JndNWAMGdGgqPOTp+eBs3DiWpKo/GsQfLtajH/0oV
	 F1p0s26/BVXCw+9TTsdSp/RvuRmKWG6/fTR0CRFenFdxPOFRiqKcCDgE4RRKn+uQyU
	 qSgftL9j1CLVA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-39977ab0562so9383461fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 24 Jun 2026 06:18:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RropFtQCkIOsr62NIv+v3LCGwvsiujUNq9jweuKxOWQh5KLBgSLgfYuWPZFMzm7MAkyemxYFJyQ/2y2@vger.kernel.org
X-Gm-Message-State: AOJu0YwT6444dNZeA7XvVE1dOMaJeXa9XqJaCtm3w65ysB5VZWDH1lZf
	ARda1geIpsZzAPESWyasUB0O5FqW3gtcIVN3v5q/iAY4ULjkIDoGE0mqRSbELDZDqBKJbguQc8N
	q2rccxD28hA5SBtrM0cBawB8UaBdJx6A=
X-Received: by 2002:ac2:5981:0:b0:5aa:64cb:9594 with SMTP id
 2adb3069b0e04-5ae9d57862cmr636267e87.15.1782307088192; Wed, 24 Jun 2026
 06:18:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616072617.2272-1-lirongqing@baidu.com> <CAJZ5v0j3Wnn3exbji-6PzwjCnOCJDe_pUJU9R25Bhvh1ZE3E5A@mail.gmail.com>
 <731d81865e444be8a9bc07dd121975f3@baidu.com>
In-Reply-To: <731d81865e444be8a9bc07dd121975f3@baidu.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 24 Jun 2026 15:17:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gpdX-V9rwtE6AC9GiwVpjf=xexZCQEA+Z3CwevemUcWQ@mail.gmail.com>
X-Gm-Features: AVVi8CcGimQDx9OVfVo-peErRJmnfIUZDklsSTkoyAy4wC0g8y2nBYj2kxSLXJ8
Message-ID: <CAJZ5v0gpdX-V9rwtE6AC9GiwVpjf=xexZCQEA+Z3CwevemUcWQ@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IFvlpJbpg6jpgq7ku7ZdIFJlOiBbUEFUQ0hdW3YyXSBBQ1BJOiBwcm9jZXNzb3JfaQ==?=
	=?UTF-8?B?ZGxlOiBNYXJrIExQSSBlbnRlciBmdW5jdGlvbnMgYXMgX19jcHVpZGxl?=
To: "Li,Rongqing" <lirongqing@baidu.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Sunil V L <sunilvl@ventanamicro.com>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Sudeep Holla <Sudeep.Holla@arm.com>, 
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Huisong Li <lihuisong@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 3:51=E2=80=AFAM Li,Rongqing <lirongqing@baidu.com> =
wrote:
>
> > > The acpi_idle_lpi_enter() function is invoked within the cpuidle path
> > > after RCU has already been disabled for the current local CPU.
> > > Consequently, ftrace's function_trace_call() expects RCU to be
> > > actively watching before recording trace data, emitting a warning if
> > > it is not.
> > >
> > > Fix this by annotating acpi_idle_lpi_enter(), the generic __weak stub=
,
> > > and the RISC-V implementation of acpi_processor_ffh_lpi_enter() with
> > > __cpuidle. This moves these functions into the '.cpuidle.text'
> > > section, implicitly disabling ftrace instrumentation (notrace) along
> > > this sensitive path and preventing trace-induced RCU warnings during
> > > idle entry.
> > >
> > > Fixes: a36a7fecfe60 ("ACPI / processor_idle: Add support for Low Powe=
r
> > > Idle(LPI) states")
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > > ---
> > > Diff with v1: add __cpuidle to acpi_processor_ffh_lpi_enter
> > >
> > >  drivers/acpi/processor_idle.c | 4 ++--  drivers/acpi/riscv/cpuidle.c
> > > | 2 +-
> > >  2 files changed, 3 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/acpi/processor_idle.c
> > > b/drivers/acpi/processor_idle.c index 390ab5f..4482cf2 100644
> > > --- a/drivers/acpi/processor_idle.c
> > > +++ b/drivers/acpi/processor_idle.c
> > > @@ -1143,7 +1143,7 @@ static int acpi_processor_get_lpi_info(struct
> > acpi_processor *pr)
> > >         return 0;
> > >  }
> > >
> > > -int __weak acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> > > +int __weak __cpuidle acpi_processor_ffh_lpi_enter(struct
> > > +acpi_lpi_state *lpi)
> > >  {
> > >         return -ENODEV;
> > >  }
> > > @@ -1156,7 +1156,7 @@ int __weak acpi_processor_ffh_lpi_enter(struct
> > acpi_lpi_state *lpi)
> > >   *
> > >   * Return: 0 for success or negative value for error
> > >   */
> > > -static int acpi_idle_lpi_enter(struct cpuidle_device *dev,
> > > +static int __cpuidle acpi_idle_lpi_enter(struct cpuidle_device *dev,
> > >                                struct cpuidle_driver *drv, int index)
> > > {
> > >         struct acpi_processor *pr;
> > > diff --git a/drivers/acpi/riscv/cpuidle.c
> > > b/drivers/acpi/riscv/cpuidle.c index 624f9bb..c76dbab 100644
> > > --- a/drivers/acpi/riscv/cpuidle.c
> > > +++ b/drivers/acpi/riscv/cpuidle.c
> > > @@ -66,7 +66,7 @@ int acpi_processor_ffh_lpi_probe(unsigned int cpu)
> > >         return acpi_cpu_init_idle(cpu);  }
> > >
> > > -int acpi_processor_ffh_lpi_enter(struct acpi_lpi_state *lpi)
> > > +int __cpuidle acpi_processor_ffh_lpi_enter(struct acpi_lpi_state
> > > +*lpi)
> > >  {
> > >         u32 state =3D lpi->address;
> > >
> > > --
> >
> > Sashiko says that this change may not be sufficient to fully address th=
e issue
> >
> > https://sashiko.dev/#/patchset/20260616072617.2272-1-lirongqing%40baidu
> > .com
> >
> > and that appears to be a valid concern.
>
> Should this fix be placed in a separate patch? CPU_PM_CPU_IDLE_ENTER_PARA=
M
> is also invoked by sbi_cpuidle_enter_state, which is itself already annot=
ated with __cpuidle,
> so this appears to be a pre-existing issue in the RISC-V tree. It would b=
e more appropriate
> to have RISC-V experts to fix it independently.

OK, fair enough.

Applied as 7.2-rc material, thanks!

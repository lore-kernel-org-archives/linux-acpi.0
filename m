Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AEE3EF0BD;
	Tue,  9 Jun 2026 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780996748; cv=none; b=CrfhoMR902ZuW0OIcAjFZKHmkTxbDWeAZXaOLoJ7QGjq//oNTaCFZMksOy7h44b/xHjdtEav7xf8Z3PGWLGXS9k/AoAPS14TPblR2Eh5MvF4ambzDlL9c8C0HbdKKS64seTd/AilE3ewKhdbf80//PDSvUhS8U7EqBtEv7zEwFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780996748; c=relaxed/simple;
	bh=SOGEsiob5KgP55lb6jJSATvDTnAhJIKXVupn0hBMpkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jGp0KnysgQhQ/KI1qrkeWrFPXKV+QpF1eMyndNdRWf44I9umu/2ythuKbiu7AECIphkAWDRXNeE4pjAuqcJGfps80HvDjLMRnsgtzztLXaGXpb9k6RmE1s9wdFbrt4cZqe8hjul9jtACKvzRiHbJItUYxo5vZsvXEJQUYfM5MYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rf6WZ+J3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rf6WZ+J3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95D71F00893;
	Tue,  9 Jun 2026 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780996746;
	bh=UnLSIOIPLrsgN1aJrq7sJm6YQFhZ+kBm+237OZTgZtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Rf6WZ+J3P0F0wrd3ax1kk+wZcQgOIGh2lEH9DewE60K5vxhRKqNjVP5Fpb99QNYXB
	 iUWsONWJl7offoG7ybI8rLcdvEs4vqsw9d1ZxqF0LWd+dFvt9oaD99wwlVAEfHwbDe
	 +16ZDuTt2wUPOM1Bkg4Rq4EOdC+k69aJF/8QkKCwy5M1fsdyYEvZ6Kq+lE+x+bG3N1
	 9Wanm4yCdexYV9h7qjUzYjbQfIlh5gECJlpwbeIvMoggylNYxHdX/xRqBgftfbO3+a
	 zIOh6QowHakk3+HzJgIcX0IeA0Z0HjDtz/26TTyaZSVKUECFhkCGOg4KuvtfzikztN
	 0xv3dSD9sOu3w==
Date: Tue, 9 Jun 2026 11:19:00 +0200
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Sunil V L <sunilvl@oss.qualcomm.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	Sunil V L <sunilvl@ventanamicro.com>, Marc Zyngier <maz@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Anup Patel <anup@brainfault.org>, Hanjun Guo <guohanjun@huawei.com>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev
Subject: Re: [PATCH v2 1/6] ACPI: RISC-V: Fix riscv_acpi_irq_get_dep() loop
 termination
Message-ID: <aifahCtdj8GpHN/v@lpieralisi>
References: <20260603-gic-v5-acpi-iwb-probe-deferral-v2-0-23ffa16b6ebb@kernel.org>
 <20260603-gic-v5-acpi-iwb-probe-deferral-v2-1-23ffa16b6ebb@kernel.org>
 <CAB19ukFFwm3ehzkBFr+oXRjA7VK_4_=XHFSuqdEpbVqUz8Do4Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB19ukFFwm3ehzkBFr+oXRjA7VK_4_=XHFSuqdEpbVqUz8Do4Q@mail.gmail.com>

On Mon, Jun 08, 2026 at 09:54:28PM +0530, Sunil V L wrote:
> Hi Lorenzo,
> 
> On Wed, Jun 3, 2026 at 1:51 PM Lorenzo Pieralisi <lpieralisi@kernel.org> wrote:
> >
> > In riscv_acpi_add_irq_dep() the main loop condition would currently stop
> > the loop if an interrupt descriptor contains an interrupt for which the
> > respective GSI handle is NULL, which is not correct because subsequent
> > interrupts in the interrupt descriptor might still have a GSI dependency
> > that must not be skipped.
> >
> > Rework riscv_acpi_add_irq_dep() and the riscv_acpi_irq_get_dep() call chain
> > to fix it - by not forcing the loop to stop in order to guarantee
> > dependency detection for all the interrupt entries in the CRS descriptor.
> >
> > Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Sunil V L <sunilvl@ventanamicro.com>
> > ---
> >  drivers/acpi/riscv/irq.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/acpi/riscv/irq.c b/drivers/acpi/riscv/irq.c
> > index 9b88d0993e88..cd83c3035cf6 100644
> > --- a/drivers/acpi/riscv/irq.c
> > +++ b/drivers/acpi/riscv/irq.c
> > @@ -299,6 +299,7 @@ static acpi_status riscv_acpi_irq_get_parent(struct acpi_resource *ares, void *c
> >                         return AE_OK;
> >
> >                 ctx->handle = riscv_acpi_get_gsi_handle(eirq->interrupts[ctx->index]);
> > +               ctx->rc = 0;
> >                 return AE_CTRL_TERMINATE;
> >         }
> >
> > @@ -314,10 +315,8 @@ static int riscv_acpi_irq_get_dep(acpi_handle handle, unsigned int index, acpi_h
> >
> >         acpi_walk_resources(handle, METHOD_NAME__CRS, riscv_acpi_irq_get_parent, &ctx);
> >         *gsi_handle = ctx.handle;
> > -       if (*gsi_handle)
> > -               return 1;
> >
> > -       return 0;
> > +       return ctx.rc;
> >  }
> >
> >  static u32 riscv_acpi_add_prt_dep(acpi_handle handle)
> > @@ -381,8 +380,11 @@ static u32 riscv_acpi_add_irq_dep(acpi_handle handle)
> >         int i;
> >
> >         for (i = 0;
> > -            riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
> > +            !riscv_acpi_irq_get_dep(handle, i, &gsi_handle);
> >              i++) {
> > +               if (!gsi_handle)
> > +                       continue;
> > +
> >                 dep_devices.count = 1;
> >                 dep_devices.handles = kzalloc_objs(*dep_devices.handles, 1);
> >                 if (!dep_devices.handles) {
> >
> Do these fixes need the Fixes tag?

I can add a Fixes: tag but I wanted first some help testing them, it
is code perusal that got me there.

> Otherwise, LGTM.
> Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

Thanks,
Lorenzo

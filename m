Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CD334BA5B
	for <linux-acpi@vger.kernel.org>; Wed,  1 Jul 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782916785; cv=none; b=bbxsmaq8O0YWErGurnzvSl/dywZ8iHnZ18sW/YCdAOVv64BO+VY/JnZ+OD9/im/wqdUvkNLydkKyyoswgCTzoFyy0AdNqqB/XlMbWNeLVnE/4aw8U9oWj08O1KJ/j7CGAP/0VaEGgHOtZAXxMdXMdVRefUOReHZDVOMUvI18O8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782916785; c=relaxed/simple;
	bh=ZDATG7GU7GQJM6/CQV2vAKL7C2dz3SKM6yDRL5kkOnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N/aCjsMkHq+551GGUCSWwwSa6EGEuWfISng4VdcYl8zSLzKUeQKL+VElxG/uMNqpVxEXOei8ZpxW3k0ie3lOv2Q+456eqcWwH5dwabFBZGo+uuO3KNKzvKLFXNuD3/WOZr5wS0mCtxhswXcLpUpNHBod4XmQQ5AjPUz8Xsl2UDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmzioyS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmzioyS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2781F00ACA
	for <linux-acpi@vger.kernel.org>; Wed,  1 Jul 2026 14:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782916784;
	bh=s7GDv4Qeq43vga0eQ+4FLDcxAgod6j01lWFHsftaTvA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=VmzioyS0/nBLPX13eze/j+6WXBsF3QTGoRnd8wt/uaFiVbvt0djRkgaH77f0wUlKO
	 bAng3FfuDXhf/y1ihFlJo160EJzIAmDl3pE6GWjxlZlAd1QnOdZ6P3UWaeF1yawpXE
	 6TMi6gRyeO2ljCYVuSPFK7nmqo5bMjQ2wGqrX0cUkr7LGK2cQedJDZhRbgC/6nLg8E
	 n08Pf1M1TbmdE4w5patGgCfTbw61JSM1ASPAPsxZhp9XwZrX0EMhU4oO1UkaTkd6T9
	 Csx+AY07pmP1RHnDoLt1GfnoNuNFOa4vqYUrzxHEmNjZveK+fb3HfZzKfbiKk3omKv
	 odAULRoAkbwlA==
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-59d07df448bso292067e0c.0
        for <linux-acpi@vger.kernel.org>; Wed, 01 Jul 2026 07:39:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rq0AgkvJJ1sWwnmrhrasG5T+gmxkvny15sC2dvy4ZY6m7zUy05lnRjfsHhHigi7YUchwKhxPvV9udTe@vger.kernel.org
X-Gm-Message-State: AOJu0YxCppdgVpAKdOYEpbN4uyLX1Kw6OYvOHPwrg3W8uYsP2tayCPDb
	hRzQkpZ0bopJBqqS22DH4KF2514g7i2zhlFrb7dHsda+i+knVKY8Zol9hL+VKUuifDH1DhlrBRB
	T07/XFENr3SncLjMfflVvSWYboo0Nivc=
X-Received: by 2002:a05:6122:658b:b0:5bb:d0ab:5ed3 with SMTP id
 71dfb90a1353d-5bddf516f62mr879319e0c.1.1782916783791; Wed, 01 Jul 2026
 07:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-6-c1b7268d4fdc@kernel.org>
 <CAJZ5v0j5RtaadVjTLm7rghNiz_9b4_Rs4PPQZgAinud7tssgEA@mail.gmail.com>
 <20260630-thankful-organic-foxhound-a991a0@sudeepholla> <CAJZ5v0gt5OsgUHXDyt1D=090ZMoxWg_s+Cwjs-M5AkC8e806ig@mail.gmail.com>
 <20260701-hopeful-cuddly-bobcat-6a8cf6@sudeepholla> <20260701-predictable-dragon-of-emphasis-50e5dc@sudeepholla>
In-Reply-To: <20260701-predictable-dragon-of-emphasis-50e5dc@sudeepholla>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 1 Jul 2026 16:39:19 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h0kwgEXYudh=YwTcpfYzX+1wiF9sbeYzOjcbVEiV=mqQ@mail.gmail.com>
X-Gm-Features: AVVi8CecZlU3TW4lCD7KHvxtPmImj9zBrNFmxXUCEbWw0R6Y6XH-4SpV7G124hE
Message-ID: <CAJZ5v0h0kwgEXYudh=YwTcpfYzX+1wiF9sbeYzOjcbVEiV=mqQ@mail.gmail.com>
Subject: Re: [PATCH 6/6] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 4:13=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.or=
g> wrote:
>
> On Wed, Jul 01, 2026 at 02:34:10PM +0100, Sudeep Holla wrote:
> > On Wed, Jul 01, 2026 at 12:44:30PM +0200, Rafael J. Wysocki (Intel) wro=
te:
> > > On Tue, Jun 30, 2026 at 7:00=E2=80=AFPM Sudeep Holla <sudeep.holla@ke=
rnel.org> wrote:
> > > >
> > > > On Tue, Jun 30, 2026 at 02:33:08PM +0200, Rafael J. Wysocki (Intel)=
 wrote:
> > > > > On Sat, Jun 27, 2026 at 6:39=E2=80=AFPM Sudeep Holla <sudeep.holl=
a@kernel.org> wrote:
> > > > > >
> > > > > > ACPI defines a PCC OperationRegion as the shared memory fields =
that
> > > > > > follow the PCC signature. The OperationRegion length is likewis=
e the
> > > > > > total size of the fields that succeed the signature in shared m=
emory.
> > > > > >
> > > > > > ACPI 6.6 adds clarification that the PCC shared memory signatur=
e is
> > > > > > populated by the platform and verified by OSPM.
> > > > > >
> > > > > > The PCC address space handler currently copies the OperationReg=
ion
> > > > > > buffer to and from the start of the PCC shared memory region. T=
hat can
> > > > > > overwrite or expose the signature at byte offset 0, and it also=
 misses
> > > > > > the last 4 bytes of the actual PCC OperationRegion data.
> > > > > >
> > > > > > Offset OperationRegion copies by the size of the signature and =
reject
> > > > > > regions that do not fit in the shared memory after that signatu=
re.
> > > > > >
> > > > > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > > > > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion hand=
ler for the PCC Type 3 subtype")
> > > > > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > > >
> > > > > Does this depend on anything else in the series or is it independ=
ent?
> > > > >
> > > >
> > > > It is independent. This just fixes the issue of including the signa=
ture in
> > > > the opregion data. It can go independently as all other patches as =
well.
> > >
> > > So I've looked at Sashiko's feedback on this change:
> > >
> > > https://sashiko.dev/#/patchset/20260627-acpi_pcc_signature-v1-0-c1b72=
68d4fdc%40kernel.org
> > >
> > > and I'm a bit worried.
> > >
> > > Of course, the preexisting issues found by it will need to be
> > > addressed separately, but what about firmware released before the
> > > clarification in ACPI 6.6 and the possible misalignment issue
> > > mentioned by it?
> >
> > I haven't analysed all the report from Sashiko yet. But unlike other pa=
tches
> > in the series, this one is not strictly to validate the signature.
> >
> > Even before v6.6, the PCC Opregion didn't include the signature which i=
s
> > at offset 0. The code always started copying to/from offset 0 missing t=
he
> > last 32-bit field(word). Since v6.3 when PCC Opregion was added we have
> > this in the specification:
> >
> >   | <section> Declaring message fields within a PCC OperationRegion
> >   |
> >   | For all PCC subspace types, the PCC Operation Region pertains to th=
e
> >   | region of PCC subspace that succeeds the PCC signature.
> >
> > So, this patch addresses that issue of wrong starting offset used by th=
is
> > driver.
> >
> > Other patches I agree, it is more likely we just need to warn and not
> > reject absence of wrong PCC signatures.
> >
> > I will take a look at the other issues reported by Sashiko soon.
> >
>
> Forgot to add that let us wait at-least until I go through the report
> understand and conclude it is not fatal/critical before we can merge this=
.
> Indeed a quick read concerned as much that I would like to spend time
> analysing it carefully.

OK

I think that it would be good to update the changelog of the $subject
patch to clarify that the bug fixed by it is with respect to the
original definition in ACPI 6.3 and not with respect to the ACPI 6.6
clarification, so there is no legacy firmware that might be affected
by it.

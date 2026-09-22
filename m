Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9962F5372D4
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 11:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790077942; cv=none; b=rStFeByo1rGXe7Zd4Jwt8a7QVBi4mpwKNKvXUQirQcMR3SIytGL2JxtNav/wDTzkWsxNyct0fWaoiUxjjTaKhjQ0fNzx1Lo3UOXFuUVih5uZLfPhB88tqPLAA/iHZZy6tXAYFryBARK8udccIbRPeIWxiQRsjNnV6dtVILATkc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790077942; c=relaxed/simple;
	bh=tZSNk29erPo1ut1HXL5T/TOdFnETV8lEDFNO+DhX4zA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lCgbCSk+Lcxud8F70DgHDJwVoGACPPpZq0q2/CTNbnKNHAu7gqX+YbFC4PiX0cmXXInEm3IeZTOKPb6piNRLhbDbqmfUfjWt/X4YMVh/8eQ08Shc4sHR2dHYKugls3x7JuobgkOc7yq2GyUXQSWun0741MIVHYHOc02V4//AeW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UfZFLWWO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UfZFLWWO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47C0E1F000FF
	for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 11:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790077941;
	bh=U+XdmS7Wo+p7xecYNaHq/QnaJdgBC5+JYJOarRisQ6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UfZFLWWOOPtqdPKYx11/X42B3hBFqVEnAYSat+ebn6Q47e39ZC/sRcQSWIz62wV75
	 pW6CBoImpWxl31gQ4zCITnu+nx27CSVM0C+/XyiG2nytpfadpqATK8d9AefKrtTUyu
	 twDSsjYo5mzaFJZYIGny38kHqEJqcjlRWhtJ3/G70GqcsATwQ9fSa5Y3d7r03yuuSt
	 9bUsqfjnMfdNkH/2YQ0m5KuJ6YAhQj3wnTBlo/wLAg258tbVuHSMjQlp1UmwEVLBYl
	 5umPFf9U0qcjguSx6nm2Pgtj8YU6OQe8UjRSamyBjN8ctxoBcEkCuOOTMxvI2OP8k0
	 0fkbf/lCyspig==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff17443dso42277641fa.1
        for <linux-acpi@vger.kernel.org>; Tue, 22 Sep 2026 04:52:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxnVXauJRBxRXWU1OCjqe5z2NWr2HHJp0CWGegMnKi6GxvZpom06hTowQslngeGUpMqh+PtfA/jbhEK@vger.kernel.org
X-Gm-Message-State: AFuF++lKzA4X0Pzl6LlU/t+pczU8gcTmRtHC8OqmPkc9jIvedPuB7HLx
	IA5daunvcYrDijK7cioAWU9Rv4jkY6IqIm+U32U+0yWcStK7byWZi5hrov5HE/4oJVNM/7YbyCd
	lfGgTPu1/8klBw71GTVfb+ksYYhH2sgE=
X-Received: by 2002:a05:651c:509:b0:39c:624d:82b9 with SMTP id
 38308e7fff4ca-3a5fbe86acdmr30197701fa.4.1790077939620; Tue, 22 Sep 2026
 04:52:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722131553.2117835-1-sudeep.holla@kernel.org>
 <20260722131553.2117835-2-sudeep.holla@kernel.org> <CAJZ5v0hdxtuEbFQdwRe=T+Q2xRki+uN9PP7PPw7AdW4Obe3fqA@mail.gmail.com>
 <20260813-demonic-athletic-manul-e1d7bb@sudeepholla> <CAJZ5v0gMU1NjMKgEUMW6cmU7uquPyES2TejZVQqkwDH5C6FWvw@mail.gmail.com>
In-Reply-To: <CAJZ5v0gMU1NjMKgEUMW6cmU7uquPyES2TejZVQqkwDH5C6FWvw@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 22 Sep 2026 13:50:46 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gqo_n39PGnBkB-5ozE_dQyau4t=5OxvdnZxu4D+ivhHQ@mail.gmail.com>
X-Gm-Features: AcwNN1XPaifcY_RruxbhZfDplOPIZGg6XKR3TIQJNsiQWlI8PUzApyEt7nR_8c0
Message-ID: <CAJZ5v0gqo_n39PGnBkB-5ozE_dQyau4t=5OxvdnZxu4D+ivhHQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ACPICA: Fix PCC OperationRegion command offsets
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 11:13=E2=80=AFAM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Thu, Aug 13, 2026 at 5:00=E2=80=AFAM Sudeep Holla <sudeep.holla@kernel=
.org> wrote:
> >
> > On Wed, Aug 05, 2026 at 06:46:15PM +0200, Rafael J. Wysocki (Intel) wro=
te:
> > > On Wed, Jul 22, 2026 at 3:16=E2=80=AFPM Sudeep Holla <sudeep.holla@ke=
rnel.org> wrote:
> > > >
> > > > ACPI 6.3, section 5.5.2.4.7.3, states that the PCC Operation
> > > > Region is associated with the region of shared memory that follows =
the
> > > > PCC signature.
> > > >
> > > > The generic and extended PCC shared memory layouts include the 4-by=
te
> > > > signature at offset 0, so their raw shared memory COMMAND fields ar=
e at
> > > > offsets 4 and 12 respectively. Since AML field offsets for the PCC
> > > > OperationRegion are relative to the region after that signature, AC=
PICA
> > > > must look for those COMMAND fields at OperationRegion offsets 0 and=
 8.
> > > >
> > > > Adjust the generic and master subspace command checks to use those
> > > > OperationRegion-relative offsets. Otherwise writes to the COMMAND f=
ield
> > > > can fail to invoke the PCC address space handler at the offset desc=
ribed
> > > > by the PCC OperationRegion definition.
> > > >
> > > > Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region su=
pport for AML interpreter")
> > > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > > ---
> > > >  drivers/acpi/acpica/exfield.c | 11 ++++++-----
> > > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > > >
> > > > diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/ex=
field.c
> > > > index 9a55524ed8f4..a7fac63938b3 100644
> > > > --- a/drivers/acpi/acpica/exfield.c
> > > > +++ b/drivers/acpi/acpica/exfield.c
> > > > @@ -45,12 +45,13 @@ static const u8 acpi_protocol_lengths[] =3D {
> > > >
> > > >  /*
> > > >   * The following macros determine a given offset is a COMD field.
> > > > - * According to the specification, generic subspaces (types 0-2) c=
ontains a
> > > > - * 2-byte COMD field at offset 4 and master subspaces (type 3) con=
tains a 4-byte
> > > > - * COMD field starting at offset 12.
> > > > + * According to the specification, the PCC OperationRegion begins =
after
> > > > + * the PCC signature. The raw shared memory COMD offsets of 4 for =
generic
> > > > + * subspaces (types 0-2) and 12 for master subspaces (type 3) ther=
efore
> > > > + * appear at OperationRegion offsets 0 and 8.
> > > >   */
> > > > -#define GENERIC_SUBSPACE_COMMAND(a)     (4 =3D=3D a || a =3D=3D 5)
> > > > -#define MASTER_SUBSPACE_COMMAND(a)      (12 <=3D a && a <=3D 15)
> > > > +#define GENERIC_SUBSPACE_COMMAND(a)     ((a) < 2)
> > > > +#define MASTER_SUBSPACE_COMMAND(a)      (((a) - 8) < 4)
> > > >
> > > >  /*****************************************************************=
**************
> > > >   *
> > > > --
> > >
> > > Can you please see the corresponding upstream ACPICA pull request?
> > > There are concerns regarding it.
> > >
> >
> > Sorry for the delay in response, currently I am on vacation and don't
> > have all the setup to validate anything. I will follow up once I am bac=
k.
> > It is OK to miss v7.3
>
> OK, I'll wait then, thanks!

A new version of this has been applied upstream:

https://github.com/open-acpica/acpica/commit/57a2afa78dbe3580e19307aedd19f3=
2388512094

so can you please rebase and resend the series?

Thanks!

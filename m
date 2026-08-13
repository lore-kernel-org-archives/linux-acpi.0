Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66109353EDF
	for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 09:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786612436; cv=none; b=S/WW1CdVSxnbILrz6na4pwX/V/+tM8Em3Z4oyv6q5HIsuvRfQpHJ3tRr25nyG6xYrb9h9sMZhDs6Bqa83GI0r7VRmuS/Of8BLh/K7kVvnRjOpeCQdDFZ8ZLbOwvP7uaRup51GEDWet+0RwfBhU9NcZ7L04TVQUIteEnOK05Yvng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786612436; c=relaxed/simple;
	bh=wNa4yBoWyMmFnBuuKabMY31Qn9tIHXbMS3K/NGSymts=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bet7V5zhytfSB8qh1C3m7VjvonThRFiiNwZyL3+LJBpP7dvH/xhp77+0MhypTVU2H9qG7NO9lNc45vSWAxfo5wnhBKAVThnBEuwOro5spGOWcOiBN05QJaGmteTZTksNHOPJeD+4GyM/FrtvebwKPd1en4aYDNYhmNtCW6fCyz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P7eJV8qp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P7eJV8qp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 362011F00A3E
	for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 09:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786612435;
	bh=LhAi/xlxK8JP8cA81/58f93yko89uigQ5ipid3kk9jc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=P7eJV8qp0Y4xFMFZz8C76Wo5J6LDLJ+iTu2rUkDNY0UCtb7S1LxNEl0YwRWYI78+U
	 j/a0BIgv+3S/HztFYdZR/KJJG0enJr6uuLQk96h1Nc+420e/y3eWnrhAG/wQdS1E9r
	 U6oDlKHRUJlh2Ui41NVX488uyg2AA/tpD/Prg7wJQu0cHr27sAa6GPlLz9TZijNFQv
	 cv9U1Xtgx+vE8f6xQ/eNF6UBKzjU/0iIQGJxofh8EKMoR8NHk5k/h+vIHRL9yIbSWS
	 ScWda3cZDRsrjSfFYAa87AhP4WPfiHZBXBc0QFKqMdlVISKuhey1Eu8PbT+7U1TT8W
	 jRik7UZqYh5hA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b28c91fba5so1013295e87.1
        for <linux-acpi@vger.kernel.org>; Thu, 13 Aug 2026 02:13:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoB4obq9qEk41DzEfOly9Z6rMEUXzmAiENJEVNSVBLIoACXhQ+r1UN1gKZu9DMGqyQWWOcv+PRpCvQQ@vger.kernel.org
X-Gm-Message-State: AOJu0YwuICRczzxGCZo1HejeE4/VJ25XCG9Px5RditSzoLDRsxVDWhIR
	2GFNRZJ5HYsrJ38eP+QX1PFfdiywKSoS729CcoRB3WIVQht07/QTBBxprtV70cJqYuRsf3nMPfp
	mDpwlBCSgo9fEgIURK9EawRdNKyUTSOk=
X-Received: by 2002:a05:6512:1444:10b0:5b2:d6a3:4510 with SMTP id
 2adb3069b0e04-5b453ce1a08mr547819e87.20.1786612433602; Thu, 13 Aug 2026
 02:13:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260722131553.2117835-1-sudeep.holla@kernel.org>
 <20260722131553.2117835-2-sudeep.holla@kernel.org> <CAJZ5v0hdxtuEbFQdwRe=T+Q2xRki+uN9PP7PPw7AdW4Obe3fqA@mail.gmail.com>
 <20260813-demonic-athletic-manul-e1d7bb@sudeepholla>
In-Reply-To: <20260813-demonic-athletic-manul-e1d7bb@sudeepholla>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 13 Aug 2026 11:13:31 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMU1NjMKgEUMW6cmU7uquPyES2TejZVQqkwDH5C6FWvw@mail.gmail.com>
X-Gm-Features: AUfX_mzjj1YuUUhBThcPDaeHNnm_w4rMlGqwQtgg0Xsk2EYwg3QfFb4WXKHHeWU
Message-ID: <CAJZ5v0gMU1NjMKgEUMW6cmU7uquPyES2TejZVQqkwDH5C6FWvw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] ACPICA: Fix PCC OperationRegion command offsets
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 5:00=E2=80=AFAM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Wed, Aug 05, 2026 at 06:46:15PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Wed, Jul 22, 2026 at 3:16=E2=80=AFPM Sudeep Holla <sudeep.holla@kern=
el.org> wrote:
> > >
> > > ACPI 6.3, section 5.5.2.4.7.3, states that the PCC Operation
> > > Region is associated with the region of shared memory that follows th=
e
> > > PCC signature.
> > >
> > > The generic and extended PCC shared memory layouts include the 4-byte
> > > signature at offset 0, so their raw shared memory COMMAND fields are =
at
> > > offsets 4 and 12 respectively. Since AML field offsets for the PCC
> > > OperationRegion are relative to the region after that signature, ACPI=
CA
> > > must look for those COMMAND fields at OperationRegion offsets 0 and 8=
.
> > >
> > > Adjust the generic and master subspace command checks to use those
> > > OperationRegion-relative offsets. Otherwise writes to the COMMAND fie=
ld
> > > can fail to invoke the PCC address space handler at the offset descri=
bed
> > > by the PCC OperationRegion definition.
> > >
> > > Fixes: aa6ec56b574d ("ACPICA: ACPI 6.3: add PCC operation region supp=
ort for AML interpreter")
> > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > ---
> > >  drivers/acpi/acpica/exfield.c | 11 ++++++-----
> > >  1 file changed, 6 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/acpi/acpica/exfield.c b/drivers/acpi/acpica/exfi=
eld.c
> > > index 9a55524ed8f4..a7fac63938b3 100644
> > > --- a/drivers/acpi/acpica/exfield.c
> > > +++ b/drivers/acpi/acpica/exfield.c
> > > @@ -45,12 +45,13 @@ static const u8 acpi_protocol_lengths[] =3D {
> > >
> > >  /*
> > >   * The following macros determine a given offset is a COMD field.
> > > - * According to the specification, generic subspaces (types 0-2) con=
tains a
> > > - * 2-byte COMD field at offset 4 and master subspaces (type 3) conta=
ins a 4-byte
> > > - * COMD field starting at offset 12.
> > > + * According to the specification, the PCC OperationRegion begins af=
ter
> > > + * the PCC signature. The raw shared memory COMD offsets of 4 for ge=
neric
> > > + * subspaces (types 0-2) and 12 for master subspaces (type 3) theref=
ore
> > > + * appear at OperationRegion offsets 0 and 8.
> > >   */
> > > -#define GENERIC_SUBSPACE_COMMAND(a)     (4 =3D=3D a || a =3D=3D 5)
> > > -#define MASTER_SUBSPACE_COMMAND(a)      (12 <=3D a && a <=3D 15)
> > > +#define GENERIC_SUBSPACE_COMMAND(a)     ((a) < 2)
> > > +#define MASTER_SUBSPACE_COMMAND(a)      (((a) - 8) < 4)
> > >
> > >  /*******************************************************************=
************
> > >   *
> > > --
> >
> > Can you please see the corresponding upstream ACPICA pull request?
> > There are concerns regarding it.
> >
>
> Sorry for the delay in response, currently I am on vacation and don't
> have all the setup to validate anything. I will follow up once I am back.
> It is OK to miss v7.3

OK, I'll wait then, thanks!

Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8300546C4D9
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661630; cv=none; b=a3lgXV8JHHchtDQKZ1pDuioJJB3D4vWE8K9AtNQnDF3/Q2VfPHCw8u9gOXCRff5kXIqr2PXrWz8P09NXHXr6a7BsSlKyqLJVMQA9wvFwujLdctRoeU4SYdIZ8H/8Ogfnud1n6wBPIVrObLD6QlKP4XHqd0mgwTvlR1n9RF1YCps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661630; c=relaxed/simple;
	bh=/Tlq+AwXEl3Bn6dm5NQihs1DVIqNYoTX7gTKZup2T+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=McSynDGeETlc2+gaBq06TmFcttwsKwhkFXwjmPsHqCYcPYy9D+u8a6U0Jlt3UYIk8e+LMurHpKibE0BK5AFvD1YOJ9xPT1ZHbZcAOiGgbHBuk/KzcuyM9XHggxkbz+s41gqET1HehaZRp/uqv96z/I5Gt1jz4oEp6iZpfIX/IuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sa4QVvys; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sa4QVvys"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A86B1F00A3D
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661629;
	bh=/Tlq+AwXEl3Bn6dm5NQihs1DVIqNYoTX7gTKZup2T+I=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Sa4QVvysWnI78facCK72zv5aRdXQu60ZiQ8YYRfC0ucTqsWb5j/PwKPVzG0OYMvyG
	 yKbyPpHAYfYvV+jSp2Pny0qTI1ivSdwh7aroPJ6xR/nrPSf2fHOnLSIr8m3t8+JOxw
	 P8LZHHAToL+H14WtgVFSMDt+qGvS6k5tz/GR+m5pDFxp7ZgWkUV+SIuOWOpuJm7ycM
	 Lm3hg40viLJgpOGoMioLi40McwIH15lPMAtiKYngTq5yBFTC5XwjAleZIuRdqh0uoV
	 YgUkk5QlkObjdUTsjum+MUEtArQQnrUBbBvU5Ps+PxNuJ7JU2cKqccLSRo67doA4J7
	 c0uGp9B1/NtZg==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb8c19017so14328827e87.0
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:20:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrZjJwKXBLPs6RazPsGw/6pxCRVV7BKUXF5g/tFGdLUYQoBbsC9Zsliqn7sTqBNfhkyOnqGVDFe5P5X@vger.kernel.org
X-Gm-Message-State: AOJu0YzjdxWxXOqoN4vZsm9r6F+jyUvp/wwdhzsQaHKAfjp1tWNQF+td
	6o3P1TM7H1YhcJYNvP6MIjyHaesL5UujpVGZQ7GvihTdK+UpYrTiKGtgEuhpH9EBQIymp/ltrwy
	dtukv4Q3eUzBRJFg/BhVvpGXq+gr70sc=
X-Received: by 2002:ac2:43b6:0:b0:5b0:20b0:9589 with SMTP id
 2adb3069b0e04-5b28f9ac1c6mr3048489e87.38.1784661627798; Tue, 21 Jul 2026
 12:20:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717081005.470013-1-sudeep.holla@kernel.org>
 <20260717081005.470013-3-sudeep.holla@kernel.org> <b75fc80b-6d1c-44d9-986c-be2c0a6e7711@huawei.com>
 <20260721-honest-shiny-teal-da9d6d@sudeepholla>
In-Reply-To: <20260721-honest-shiny-teal-da9d6d@sudeepholla>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 21:20:15 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jAOA3iQB6htExJNAtLu5oVJB9nZGzh=0+uaerVwgHMxQ@mail.gmail.com>
X-Gm-Features: AUfX_mxSpC_xdcI5_twiMHwGPOC3zkvoOHY131Ph4xSSNKgBgXNYH6V65y553Ew
Message-ID: <CAJZ5v0jAOA3iQB6htExJNAtLu5oVJB9nZGzh=0+uaerVwgHMxQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "lihuisong (C)" <lihuisong@huawei.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Saket Dumbre <saket.dumbre@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 21, 2026 at 2:27=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Tue, Jul 21, 2026 at 07:43:53PM +0800, lihuisong (C) wrote:
> >
> > On 7/17/2026 4:10 PM, Sudeep Holla wrote:
> > > ACPI 6.3 introduced PCC OperationRegions. Section 5.5.2.4.7.3,
> > > "Declaring message fields within a PCC OperationRegion", states that,
> > > for all PCC subspace types, the PCC Operation Region pertains to the
> > > region of PCC subspace that succeeds the PCC signature.
> > >
> > > The PCC address space handler currently copies the OperationRegion
> > > buffer to and from the start of the PCC shared memory region. That ca=
n
> > > overwrite or expose the signature at byte offset 0, and it also misse=
s
> > > the last 4 bytes of the actual PCC OperationRegion data.
> > >
> > > Offset OperationRegion copies by the size of the signature and reject
> > > regions that do not fit in the shared memory after that signature. AM=
L
> > > that sizes the PCC OperationRegion to include the signature is not
> > > conforming to the PCC OperationRegion definition.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler fo=
r the PCC Type 3 subtype")
> > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> > > ---
> > The below commit description said the PCC operationRegion contains the
> > signature field.
> > "77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler for the PC=
C
> > Type 3 subtype")"
> > And I find that the definition of this OperationRegion in ACPI spec 6.3=
 is
> > the same with spec 6.5 and 6.6.
> > That is, the original implementation already didn't comply with ACPI sp=
ec.
> >
> > Patch 1/4 also requires the change of platform AML about PCC
> > OperationRegion.
> > These modification may lead to the existed PCC OperationRegion method i=
n
> > some drivers doesn't work.
> > Because the platform AML still contains signature field in PCC
> > OperationRegion method.
> > I don't know how many drivers in linux have used this method.
> > IMO, we at least need to reclarify this usage change and provide a new =
usage
> > example in the commit log like the original commit did.
> >
>
> Good point, I didn't realise I had wrong example in the original commit.
> I will add the example of correct usage in this change. Thanks for pointi=
ng
> it out.
>
> > Anyway, this patch also makes the driver more compliant with the
> > specifications.
> > So I agree.
> > Reviewed-by: Huisong Li <lihuisong@huawei.com>
> >
>
> Thanks again for all the review.

I gather that there will be a v2 then.

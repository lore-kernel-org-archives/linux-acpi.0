Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE094279E4
	for <linux-acpi@vger.kernel.org>; Wed,  1 Jul 2026 10:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782902685; cv=none; b=hbi7i2hK8WtzASOj/SGkcFRoKZslcYxHRhTcRzuWhRGsi2BkTokZ7mZ4uhcG7VyyImrKckCC2f3nprKj/popck2NIh+9wI5AqGI6PVC+/usSlXK0php9nIvgiC8wrM0ax5/gAC0sPkiAaypFmyV5ylq8ikxLhUJc14GDa076c3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782902685; c=relaxed/simple;
	bh=d8vOtDWf/G+A4CI0gplhbWylGOZ5jmHWGpd6A9V+58A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ds4ebSfEr0ZFoDEmMRGufCzF/NvTbc+Q0xXFUtOrmUew2BndLPRiEJupklfQ+7ECw2RaB40m5HbdG5wHCIrt8HNjxe9Db2yXEuBCwfYGnfWYJ4Tvy9tuu6Wy3aPbl9dJ+n3BNgY5eDuNNCo39wQAVhHeNMFXGCXhaaUYdEMyW/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZjcsozA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZjcsozA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F17BE1F00A3A
	for <linux-acpi@vger.kernel.org>; Wed,  1 Jul 2026 10:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782902684;
	bh=d8vOtDWf/G+A4CI0gplhbWylGOZ5jmHWGpd6A9V+58A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CZjcsozA1auu1cKLuU4vYLASY5XHfgufNGQqu22nUjiDnCFEBHU4ZWkSAsveY/ywe
	 jodz7shAIi9sf5/+dp8EykWoy5aimnC1XsOSEtfu5Ajh2+AbNi/W8e7VCX01bU3W8A
	 Wr/69eCcloSaX6F1ykBa5ZhBZre/UhKgWSE70xiT6DXPpY6J/fPyJpAmZxmuWrx3Qp
	 tsBB161FhCrPQCXU4RyPZJYy9PgHV8lPZ+2whAaACuzQhu4ec3nrOYRuWovg0jql2+
	 8+0zbuno2UKJsNWJrghVtHVPJ4+2fMb6d8JhF1UrSPlAT8s1qQVa42/2lJr3Ubuf3A
	 kMVPgHsIhk0xA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb18fe7ceso301435e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 01 Jul 2026 03:44:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoH38zH08gye89vS9BoFnnzmES8+QYCV8BT7tsCKtyFzsdyLecrcUf9mRTEl7EwV553Xc3yL4yVArQ7@vger.kernel.org
X-Gm-Message-State: AOJu0YyWp15uMemFu6J2sUy1uAWh6ZUnTy39hlmeeTBazwSUG/qzu1LH
	4izQiGfCOKEhs0wxkAIHNwCN/dLedcjW3FzdIAQl1L/t+68Oi85e3+h7kSrP6+k8h4jsJVjZDo+
	Sjz0GAs61kPLO6s84+e5DTzbjJHAOrgg=
X-Received: by 2002:a05:6512:611:20b0:5ad:518a:61dd with SMTP id
 2adb3069b0e04-5aec68b8313mr185765e87.46.1782902682481; Wed, 01 Jul 2026
 03:44:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260627-acpi_pcc_signature-v1-0-c1b7268d4fdc@kernel.org>
 <20260627-acpi_pcc_signature-v1-6-c1b7268d4fdc@kernel.org>
 <CAJZ5v0j5RtaadVjTLm7rghNiz_9b4_Rs4PPQZgAinud7tssgEA@mail.gmail.com> <20260630-thankful-organic-foxhound-a991a0@sudeepholla>
In-Reply-To: <20260630-thankful-organic-foxhound-a991a0@sudeepholla>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 1 Jul 2026 12:44:30 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gt5OsgUHXDyt1D=090ZMoxWg_s+Cwjs-M5AkC8e806ig@mail.gmail.com>
X-Gm-Features: AVVi8CfrEh6m4dza9S4j4yAOEy1WgZ-x_Sp0y1aLiD4zDZ8ZDFGYA9XtHT5lYpk
Message-ID: <CAJZ5v0gt5OsgUHXDyt1D=090ZMoxWg_s+Cwjs-M5AkC8e806ig@mail.gmail.com>
Subject: Re: [PATCH 6/6] ACPI: PCC: Preserve shared memory signature in
 OpRegion handler
To: Sudeep Holla <sudeep.holla@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 30, 2026 at 7:00=E2=80=AFPM Sudeep Holla <sudeep.holla@kernel.o=
rg> wrote:
>
> On Tue, Jun 30, 2026 at 02:33:08PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Sat, Jun 27, 2026 at 6:39=E2=80=AFPM Sudeep Holla <sudeep.holla@kern=
el.org> wrote:
> > >
> > > ACPI defines a PCC OperationRegion as the shared memory fields that
> > > follow the PCC signature. The OperationRegion length is likewise the
> > > total size of the fields that succeed the signature in shared memory.
> > >
> > > ACPI 6.6 adds clarification that the PCC shared memory signature is
> > > populated by the platform and verified by OSPM.
> > >
> > > The PCC address space handler currently copies the OperationRegion
> > > buffer to and from the start of the PCC shared memory region. That ca=
n
> > > overwrite or expose the signature at byte offset 0, and it also misse=
s
> > > the last 4 bytes of the actual PCC OperationRegion data.
> > >
> > > Offset OperationRegion copies by the size of the signature and reject
> > > regions that do not fit in the shared memory after that signature.
> > >
> > > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > > Fixes: 77e2a04745ff ("ACPI: PCC: Implement OperationRegion handler fo=
r the PCC Type 3 subtype")
> > > Signed-off-by: Sudeep Holla <sudeep.holla@kernel.org>
> >
> > Does this depend on anything else in the series or is it independent?
> >
>
> It is independent. This just fixes the issue of including the signature i=
n
> the opregion data. It can go independently as all other patches as well.

So I've looked at Sashiko's feedback on this change:

https://sashiko.dev/#/patchset/20260627-acpi_pcc_signature-v1-0-c1b7268d4fd=
c%40kernel.org

and I'm a bit worried.

Of course, the preexisting issues found by it will need to be
addressed separately, but what about firmware released before the
clarification in ACPI 6.6 and the possible misalignment issue
mentioned by it?

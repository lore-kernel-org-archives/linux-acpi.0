Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFB93D090E
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783080928; cv=none; b=nmQ9XgSMGnAWiZmFuuCfueZIIdq3kZCxkQ6gp2NyvCtetYeHrYRDIRYKZxyPqZ3/AKc0+giGKKXX4eAq2ZV+IIqxCkCFOt4in1QE53uYdoECYFOcsPw6OeLDC6rHziHiwLhugpWSgPlW5V6Qg7/OptC+FGH0XbF9BBVMUOOCfbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783080928; c=relaxed/simple;
	bh=esVxq2/OWGQEO5v/or2bpMCVebSBPE0Jx5cUfcfX+QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S/Bk0+cmLf/wUwVwJOnJ4Q82gpMI60N6WN/vDV49DOWqv1VldNVDMqEX+PEJdjl9oCPIbtW/E89jl6eZngO34JDOufqUeg9hKG/NdYLSNQ05wRafTnNT05g9MgCEdoHgJ8jO3+UNR+e+O6A3ruj+jvSGJbGVSWS+rD0PgT/kElA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNG22d/h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CNG22d/h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F4421F00ADE
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783080927;
	bh=esVxq2/OWGQEO5v/or2bpMCVebSBPE0Jx5cUfcfX+QA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=CNG22d/h7hJqhCM3iXYnMZVt/aUK0YaAZl8qrtB74WHSZMIeDc/xhrgcHiJc8HCwG
	 csQ7yTHluapAg35IcpfcsCEewH7q0H+ZQCbd+Ve+SmQ433UfE+OlyRM41Sb2eZPwQB
	 E6b0w3/U0fd7uAYtDQBUJkyfm3sqrb3Ppqc0ewKTYM3pfc5ZaskMC58l81LtbHtO0d
	 23BT1L3HeKt3KPWOcIwMHwpzHZD1ZYEZUFYPGzcv/+gPACNE1IQ3fExeDLqw22PER/
	 BMi9wAzBUWbn1Oiub+YJCRUl0oLwv+hNv554cz9S3OyEmY3uhvsuVan/b9wkGGCZyp
	 MStbOe2yz1DHg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aebf9a509eso541611e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 05:15:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqZBej4By5nJ69PatiEmS6t+pPGzemAJOTUg2Rd7WKTeBbSSQABYFqQD4Ua7oudegn88sjPElkp58Ir@vger.kernel.org
X-Gm-Message-State: AOJu0YwSAj1DGVsevJp+QxiHfDm2lwGP3zVLr4Wh639FZ5jA7gsjASOM
	MWeecCtrrRWRaUY2gPc9FP/NnDAzXRmWLPAG/dFKtRPAVn6hfRls+1coIzqz3RhicRtQvwxNjmy
	Z7mOsp9f+SuolNk/3QrLDk1NG1BPPovI=
X-Received: by 2002:a05:6512:154a:b0:5ae:b730:5235 with SMTP id
 2adb3069b0e04-5aec8025dd1mr1953613e87.18.1783080925532; Fri, 03 Jul 2026
 05:15:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5135166.31r3eYUQgx@rafael.j.wysocki> <akemrOqzWtcDVqey@ashevche-desk.local>
In-Reply-To: <akemrOqzWtcDVqey@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 3 Jul 2026 14:15:13 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0isEvOx_UWCb9bpV0FQac+Dg7rmrjEtoYUH9hLyBgSP_A@mail.gmail.com>
X-Gm-Features: AVVi8CcCyhZbaTM8aEfP_CDJwOvx85hepSQO51lwkon72qAjQwO3MM1G7tZy8pE
Message-ID: <CAJZ5v0isEvOx_UWCb9bpV0FQac+Dg7rmrjEtoYUH9hLyBgSP_A@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] platform/x86: Stop using acpi_device_name/class()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Denis Benato <denis.benato@linux.dev>, Jonathan Woithe <jwoithe@just42.net>, 
	Robert Gerlach <khnz@gmx.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Kenneth Chan <kenneth.t.chan@gmail.com>, 
	Mattia Dongili <malattia@linux.it>, Azael Avalos <coproscefalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 2:10=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 01:15:01PM +0200, Rafael J. Wysocki wrote:
> > Hi All,
> >
> > There are two fields in struct acpi_device_pnp, device_name and device_=
class,
> > that were supposed to be populated and used by device drivers, but they=
 have
> > never been used consistently and some drivers just populate them and do=
n't
> > access them later, and some drivers use them uninitialized.
> >
> > All of that is confusing and messy, so the drivers for core ACPI device=
s
> > have been updated to stop using those fields which are now slated for
> > removal, but they are still accessed in some places.
> >
> > This series updates platform x86 drivers accessing those fields to stop
> > doing that.
>
> In most of the patches you have double space in your name in From.

Do you mean the From header in the patch body or the From header in
the SMTP headers?

> Can we have some consistency here? Or is it deliberate (in which case I'm=
 wondering why)?

Not deliberate, probably an e-mail client mess-up.

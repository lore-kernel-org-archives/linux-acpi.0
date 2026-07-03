Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9303955D8
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082694; cv=none; b=txhTjIkvk90c0WjHte7NbuvH8+FV1UuJeZsquDS3KMslj7XtqebXWJUVD/yBqLE9aAKO26ggOKCctyfpxPg+RxBuPLemAdwm9/UqeYUmLmAtqgr7xcpEc0/tl/fjkHYLu6H472cgoMcqCyyBEzmhZH00AH2H2XopRjf+OHN5zr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082694; c=relaxed/simple;
	bh=RIigBZLdXVKJmfhMgPGx8pT9Xn+bY/rlKKJbg52AXKg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eEOsHsaU/HFITAkPqxaw61YwTZzTmbi2xyvJINiVcHyHkSyGbdifImB6os5qwZb3Zkg8hJxjgtY8kAS5z83aPgocsuWS8xuskVBZvyl5PMLqzb+X/3RbYPaTroWZodOak8VeML0hAl0SBj1DGGSoy8zp2AEYLiqlc5grjnY54Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBNrkhNd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBNrkhNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1180F1F000E9
	for <linux-acpi@vger.kernel.org>; Fri,  3 Jul 2026 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082693;
	bh=RIigBZLdXVKJmfhMgPGx8pT9Xn+bY/rlKKJbg52AXKg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=jBNrkhNd2XTinTTGCUtE0Fb5eLCw6CVSQnqkk4ztNmDYE/F9GONrX/ftA6yYAx+IQ
	 MMC9a2DojufW70Y5sUhpG61Teaq2lQmreeGJVTSDg0bXbhA9fy+LW028NyyVwGayQo
	 gBVGPsB2YwT24+Xlysgsd/Bjd18+nlDQq70hMtXYvK22DIRywySXHnA91fElKKKFJK
	 3PsFSW0tGoinkoIajmnEIdzKFom47CZxrr50zQTd6S9aksPcNuvqik4MsgyUrhDGgY
	 5hePvaLDeXj/0iKNfukT7jj+TrmUjKApLiMexkACUs8v5CmRESFNMgZ1HVMLbEwy9Q
	 qC+yIfcP4lutA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5aebfa21c62so645093e87.3
        for <linux-acpi@vger.kernel.org>; Fri, 03 Jul 2026 05:44:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrKyCoVov7qdQoxRMn3iOxgvaQ3SCz6ei32dtNr5waDPwsayrmxQblZDgOM7GXn0dOOgU3Ub3fgGzyS@vger.kernel.org
X-Gm-Message-State: AOJu0YwpV6k4gJcXs5nbHQY8dkjXz1UwIfuCqCRnKjKUJQTYXfXSjImR
	eUSVtjg0AKOI8U8Gbuv2cQ1alpoUOfbcV5zxQtcsYGurn9rnvELBZzFfwvhCCDmh1Cg9MTFvgTh
	bh+vtLA1OQgt+YcD7mlGwd2PT4J/O6Og=
X-Received: by 2002:ac2:51cd:0:b0:5ae:c926:fc11 with SMTP id
 2adb3069b0e04-5aec926fd83mr1755249e87.30.1783082691569; Fri, 03 Jul 2026
 05:44:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5135166.31r3eYUQgx@rafael.j.wysocki> <akemrOqzWtcDVqey@ashevche-desk.local>
 <CAJZ5v0isEvOx_UWCb9bpV0FQac+Dg7rmrjEtoYUH9hLyBgSP_A@mail.gmail.com> <aket5xHht1sMRIEz@ashevche-desk.local>
In-Reply-To: <aket5xHht1sMRIEz@ashevche-desk.local>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 3 Jul 2026 14:44:38 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMabGfAMSQ5UjLqvy-5uKFrdYCLwXdUi0Y3Oa7wum7EQ@mail.gmail.com>
X-Gm-Features: AVVi8CdTuku-Yl4Is8DW8X38c3ESvLQhmp-GGvRW1SWi9bLlAWb1Ay3N_xGf53o
Message-ID: <CAJZ5v0gMabGfAMSQ5UjLqvy-5uKFrdYCLwXdUi0Y3Oa7wum7EQ@mail.gmail.com>
Subject: Re: [PATCH v1 00/10] platform/x86: Stop using acpi_device_name/class()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Corentin Chary <corentin.chary@gmail.com>, "Luke D. Jones" <luke@ljones.dev>, 
	Denis Benato <denis.benato@linux.dev>, Jonathan Woithe <jwoithe@just42.net>, 
	Robert Gerlach <khnz@gmx.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Kenneth Chan <kenneth.t.chan@gmail.com>, 
	Mattia Dongili <malattia@linux.it>, Azael Avalos <coproscefalo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 3, 2026 at 2:41=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jul 03, 2026 at 02:15:13PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Fri, Jul 3, 2026 at 2:10=E2=80=AFPM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Fri, Jul 03, 2026 at 01:15:01PM +0200, Rafael J. Wysocki wrote:
> > > >
> > > > There are two fields in struct acpi_device_pnp, device_name and dev=
ice_class,
> > > > that were supposed to be populated and used by device drivers, but =
they have
> > > > never been used consistently and some drivers just populate them an=
d don't
> > > > access them later, and some drivers use them uninitialized.
> > > >
> > > > All of that is confusing and messy, so the drivers for core ACPI de=
vices
> > > > have been updated to stop using those fields which are now slated f=
or
> > > > removal, but they are still accessed in some places.
> > > >
> > > > This series updates platform x86 drivers accessing those fields to =
stop
> > > > doing that.
> > >
> > > In most of the patches you have double space in your name in From.
> >
> > Do you mean the From header in the patch body or the From header in
> > the SMTP headers?
>
> At least SMTP. TBH, I haven't paid attention to the From lines in the bod=
ies.

Well, those are the ones that matter though because git will use them
to override the SMTP From header (and so they need to match the S-o-b,
not the SMTP From).

Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792512156;
	b=Ifdm98B2923Hw4AgzPJf/bxqhW5uMBS9qyWBoKspbYExxw2H/rJ8dSdfPQJUoZJJ4MQo
	 Hizu2+EMwAv+KiBoETvCTGZfWT9KaEeyKS+DN5OEZh0Wm8dtVVepHCH574TrjDIdXnv/N
	 uPXvYirPeepc3AklIZIUq9sXKXDYiOx+EOpIWHPGR7P3io8hmLwJ+kZu+MH+lKkrj7KM6
	 KhGqwjf4MDjz7lBAc5AcbeTVsXnTqZg4PzkQTugV/DMiLLikxXn6wnWXeTUv8W8NNJV+M
	 nPbxVbTIsF/hwHyT47ddxHYM42Z87zpyiu8udYVc/VX7FxfJDlgPOdTl9uH/eHba4bQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792512156;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=T6Xn0GgbQ2LS6M/ihkwGknyXfBAZO+tMr2iX2I+xIjg=;
	b=giQEa23wJybReQMN6cKLoIhIn97cS0CfKn9etZ2x1+X75JIcsmh/mrRu5h6T8rHSKwTn
	 eN70veJ1BcGwm9mDbhkE6gLfbcSVjTfWMFEy4On94S/M6yiGM2alEG3wUgAeUtr58bocj
	 0QkBbKnOQfkwhGOrnq3JDbGIBt6GEzt5Z7piMc3oN/HETEk5mgL8ISskFnlkO5tvBfHyo
	 r+qyhlFc9BREi77QVm+/WYitx3LnAUb6q5xV5nvpX5KjS/HpiwtuynhMEO3F5eV7KNgL+
	 BlafN/dfv6V15+7ZttlshxRZfcxHOPgrBTuhNKxDmFt4Bghk5WSMKfHdsSUEmNZMWbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQXgQn4e;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9531D606A322
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 16:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hQXgQn4e
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D9D1F000C5
	for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 16:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792512156;
	bh=T6Xn0GgbQ2LS6M/ihkwGknyXfBAZO+tMr2iX2I+xIjg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hQXgQn4ewnepe4JFUB901d+7zgzryWjv+w0+AOTfu1bd07Pgtzi6EXfoZOm+PpXAc
	 4zL2826NeSBOuXr4JfS1En7Uij/H1mZWVZ4AL/Bl+mqSOOUZywoDIkdK8ByW0TxRw5
	 BicSp+BOkhokcLMBqEWgn+ctufzKk7J5szwnElWuWUeXZ4ZCJW/Hyo+KhUG1uFJ9Qn
	 h+DyOjO7QoePaM/bsER1mozCDfeXOOh5UkjvvG9YhOhfk3HTiKPzkDkra0QMZphTKu
	 Jkk072dp97G5TEFYTDWYCDGECVjnBnHXsMWfBl5SDze6aZEzW4+2QkRXL7hl3dPK4a
	 +wxVemH6t53jw==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5ba328513b9so3042317e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 20 Oct 2026 09:02:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwS9XsRYyRsKcJSnlc6+QBkHryrp+Y7czJ+U2RgL8vF4lKclkGCnHeWetjAKZFPtkXiMF1TuvVSvnMO@vger.kernel.org
X-Gm-Message-State: AFq9FYKn6zCLwYL94H3rxQrWtxdwm4MExu+lqZMgaYuUfSx9lP3QxqgY
	7gnHbmx0C7fDG1rJyDgeA6U/Fjbe8f/100joYwUF4+jNMlUu2LH1h+gc6GOmlvdr4DMPHyoGqhG
	yASTjC58Y5kuegjGhbaHpnvffil1mJRk=
X-Received: by 2002:a05:6512:3d8c:b0:5bc:d9d6:6a98 with SMTP id
 2adb3069b0e04-5be50a471cbmr3402594e87.10.1792512142493; Tue, 20 Oct 2026
 09:02:22 -0700 (PDT)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260925-acpi-static-table-irq-probe-defer-v1-2-2c62125d0085@kernel.org>
 <arZDwutoadki7tiZ@ashevche-desk.local> <arZNL9BnTGK0Klwc@red-moon>
 <arZS4vwxps01dGb7@ashevche-desk.local> <arqSqcoWAkhy-8do@red-moon>
 <d1720b63-65bf-4019-bc19-1852555f7993@arm.com> <asieTvinZ7c2QpQm@red-moon>
 <CAJZ5v0hVLSJs1j8J1TV3yJ8Psyaf=B_0UfHsYSMtM5xTup0B_Q@mail.gmail.com>
 <atXyIadz1TEKSodg@red-moon> <CAJZ5v0joJBZg==DWPsNviPfL7Jo=qupRhb6GinqOLoHXGnvevg@mail.gmail.com>
 <ateI-JcExDyfXKrs@red-moon>
In-Reply-To: <ateI-JcExDyfXKrs@red-moon>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 20 Oct 2026 18:00:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0h+S3z3YqpJYCwcZXpPNEawedSof1z4+ydWn=tZbL8L6g@mail.gmail.com>
X-Gm-Features: AclHuK8HDf2yPjcd4rawrCfnLbX27pb5S5MNqmvyCllH3hG9fIPbIUdmHBI-lNo
Message-ID: <CAJZ5v0h+S3z3YqpJYCwcZXpPNEawedSof1z4+ydWn=tZbL8L6g@mail.gmail.com>
Subject: Re: [PATCH RFC 02/11] ACPI: Introduce irq_get() for static fwnodes
To: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mark Rutland <mark.rutland@arm.com>, 
	Marc Zyngier <maz@kernel.org>, Daniel Lezcano <daniel.lezcano@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@kernel.org>, Wim Van Sebroeck <wim@linux-watchdog.org>, 
	Guenter Roeck <linux@roeck-us.net>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	driver-core@lists.linux.dev, linux-watchdog@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 5:30=E2=80=AFPM Lorenzo Pieralisi <lpieralisi@kerne=
l.org> wrote:
>
> On Mon, Oct 19, 2026 at 08:05:50PM +0200, Rafael J. Wysocki (Intel) wrote=
:
> > On Mon, Oct 19, 2026 at 12:34=E2=80=AFPM Lorenzo Pieralisi
> > <lpieralisi@kernel.org> wrote:
>
> [...]
>
> > Basically, yes, the idea is to defer the creation of the platform
> > device until the dependency is met.
> >
> > > till the dependencies are cleared but then, without a _CRS, where wil=
l
> > > the consumer driver find the platform device resources ?
> >
> > Well, good question.
> >
> > > There are multiple facets in this issue and possibly some of them hav=
e
> > > been already solved but I need to pull them together.
> > >
> > > > Note that the dependencies can be added to acpi_dep_list after
> > > > creating a struct acpi_device with acpi_add_single_object() and
> > > > acpi_scan_add_dep() is not really suitable for that, but it should =
be
> > > > doable if the dependencies can be found.
> > > >
> > > > > I need to have a deeper look into this next week but I wanted to =
ask first
> > > > > whether there was something I missed - most likely.
> > > >
> > > > Well, it is not really straightforward.
> > >
> > > Yes it is getting messy. This RFC, with all its flaws, does not trans=
parently
> > > prevents enumeration but rather relies on -EPROBE_DEFER to sort out
> > > dependencies - though it does so by adding more stuff into ACPI stati=
c fwnode
> > > that to be honest I'd rather see gone.
> >
> > I think what you need is a notification mechanism that will trigger
> > when a specific device (enumerated via the ACPI Namespace) becomes
> > operational.  It doesn't look like any of the existing ones (platform
> > device probe deferral or ACPI device dependencies tracking) is really
> > suitable for your use case.
>
> Yes. It might just be a notification from ACPI core to say "the driver fo=
r
> this ACPI device probed, go create platform devices that depends on it".

The ACPI core doesn't know about driver probing, so this notification
would need to come from the driver of that specific device.

In the regular _DEP dependencies case, the drivers that provide
dependencies generally need to call acpi_dev_clear_dependencies()
which triggers a dependency list walk.

I guess driver_bound() could do something like that in principle (it
does a similar thing already for deferred probing), but I'm not sure
how generic it needs to be for this particular use case.

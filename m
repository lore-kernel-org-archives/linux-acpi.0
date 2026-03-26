Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5449401A38
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 15:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540034; cv=none; b=XzuKH+/7ZUxTCJLoMAOwFkWOQTOgx6nkotaBAAFL/cgpuxMcaCiQSM0Fgk0zFztpssZA3g3HP/Smdfwt1DciGQMFs/lRy5pjQr/IXDBPT87S5LPXnJ4FZ081fc5kmVurj+f5PBmXAcnT7qM0pVL4zBFfOzfrW/O6XZpE0/2LH+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540034; c=relaxed/simple;
	bh=fWnV7rDU2XNvNnwbXNTOC3wtz4D4Ffj4sBhra5QKJMk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n6EuoMMUm6oZuy3VoHpmMsF7WCdH3XKignCn4KTWWI7CKDw8B5y1E9H+O0L006dpdiInwUxYMAfZqjFAIdUy6KkQdGULUM7nVQtdmf5j8uO4HUTD/JZ5DnaRY4CEr2A2LKDAGPfJ5JsgXhjIuhV6ck8JW0ORbLXKstGxS3FDxOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ftCKq5fD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ftCKq5fD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744DBC2BCB5
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 15:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774540034;
	bh=fWnV7rDU2XNvNnwbXNTOC3wtz4D4Ffj4sBhra5QKJMk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ftCKq5fDWXgoE6TB7zqzejmnwb7TwGh/Ef70cw2Erxvd5NtOawXMKGgki6mxHAQIb
	 AF+kGDCJtRVBWWmaG5oz7I77jgoblk9bjZ+27Kv8YbbqKo878ki9/dLGioJBz90NKh
	 ZDeqBBXDIznMeQkOuEhr45wg8adR0HxDNGZpSdtikDomDuK0cVo4rtgVem2oawOrxz
	 t4duiBxoKgen3oQtTvB+hf8f0vMgsinjirMu4mJWsvBkIKaK+oVvfe5CaSHbs7PVBU
	 OSYvC3WFoLCv/6a1w3jETjsdR2MecSs+XelNMuI5VHb+MvT1H3Lp3eOdxlgXlkhLpj
	 Ox0iIX7Rd98uA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38be5d7c27cso10372541fa.0
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:47:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUE1W9O22/WsjSq/wvcAWrSgpYCp8qZMPVwyarMToZrylQlpHljUqnKjUDoyNR/uQw6Q4OSF4ZGESYq@vger.kernel.org
X-Gm-Message-State: AOJu0YyM//B3kGEBs2bh3nI6cKEqTYCWyRr/VymZLC+X8aa5j4KV0ywO
	44o48cvY3xhnWSvclZiYN0/sODwrBQvqsq7APHfxocLmeLWK2ySw0JsNht9o9TB2gqxsZs1t0kB
	9wAJh/LG+d/8cJIaYs2xzO0TKGuPrqI1Ryu5I1zD1og==
X-Received: by 2002:a05:651c:2118:b0:38c:4b14:13ab with SMTP id
 38308e7fff4ca-38c4b148507mr26935061fa.33.1774540032962; Thu, 26 Mar 2026
 08:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acIV6xF8mY-8wd5e@google.com> <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com> <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
 <acTtzuGD-K5XvVir@ashevche-desk.local> <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
 <acTwqD8fXZSncMIS@ashevche-desk.local> <acTy8Wkfs8Sx84oZ@ashevche-desk.local>
In-Reply-To: <acTy8Wkfs8Sx84oZ@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 26 Mar 2026 16:47:00 +0100
X-Gmail-Original-Message-ID: <CAMRc=MdrxYRhB3MWnhTPM9FqzF-_P7Br5mRJ7kYOxQ2G3zjdow@mail.gmail.com>
X-Gm-Features: AQROBzDf3HYMGKXpGrLn5Y55f4GIrv8bJ8UmGCkyoSsx25x8l8K48Rl09M-Q0Ho
Message-ID: <CAMRc=MdrxYRhB3MWnhTPM9FqzF-_P7Br5mRJ7kYOxQ2G3zjdow@mail.gmail.com>
Subject: Re: [PATCH] software node: allow referencing software nodes by name
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 9:48=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 26, 2026 at 10:39:09AM +0200, Andy Shevchenko wrote:
> > On Thu, Mar 26, 2026 at 09:34:01AM +0100, Bartosz Golaszewski wrote:
> > > On Thu, Mar 26, 2026 at 9:27=E2=80=AFAM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Wed, Mar 25, 2026 at 05:32:06PM +0100, Bartosz Golaszewski wrote=
:
> > > > > On Tue, Mar 24, 2026 at 8:30=E2=80=AFPM Dmitry Torokhov
> > > > > <dmitry.torokhov@gmail.com> wrote:
> > > > > >
> > > > > > Please post the reworked version so we can review all the detai=
ls. My
> > > > > > concern was that it relies on notifier chains to notify when de=
vices
> > > > > > get registered and unregistered, and instead of matching node n=
ames you
> > > > > > now need to somehow match device instances and software node in=
stances,
> > > > > > which again likely is done based on some name. This just piles =
on
> > > > > > complexity where a simpler solution would be sufficient.
> > > > >
> > > > > I will post it. Hopefully before the end of the week. I want to c=
over
> > > > > both OF nodes with paz00 as well as ACPI with android tablets. Th=
e
> > > > > latter case will have to wait for devices because there's no way =
to
> > > > > look up an ACPI node by name that I could idenfity (correct me if=
 I'm
> > > > > wrong).
> > > >
> > > > What do you need from ACPI exactly? The ACPI namespace in the OS is=
 represented
> > > > by set of ACPI handles, each of which is the object pointing out to=
 some object
> > > > in it. Any object in ACPI has a unique path. At any time, after par=
sing the
> > > > ACPI table(s) into ACPI namespace we may get a handle based on the =
path.
> > >
> > > DT is unflattened very early into the boot sequence. Is this the case
> > > for ACPI tables as well? Knowing the name of the device (HID + index,
> > > eg.: "INT33FF:00"), can I check if there's a corresponding ACPI node
> > > (of_find_by_path/name() in DT parlance)?
> >
> > I believe so. See how we find a GPIO chip in the gpiolib-acpi-core.c.
> > In the similar way you can try finding any object in ACPI namespace.
> >
> > But note, ":00" is part of device instance name, it's not available
> > in ACPI namespace. There we have HID, UID, et cetera, ":00" is pure
> > Linux kernel thingy.
>
> We have acpi_dev_present(), but if you read its kernel-doc, it suggests
> to use acpi_get_devices() for the case of early checks (before device
> are actually being instantiated).
>

Ah, but I'm seeing that the firmware node handle of the acpi device is
part of struct acpi_device and is only initialized during the scanning
phase which happens at subsys_initcall() time? When using
acpi_get_devices() you have an abstract handle and no fwnode for which
to assign the secondary node yet, right?

It's not like with DT where there already is an instance of struct
device_node to which you can assign the secondary fwnode even if its
device doesn't exist yet.

Bart

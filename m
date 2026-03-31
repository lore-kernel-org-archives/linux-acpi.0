Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F79382F37
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774959502; cv=none; b=UGAwIALn/x9bXu3P+8q3A8Kjot+Iynpl32A/sD0r+/yk5i+D8fepGmNiS79u7QrM3fnET/E9T2FGNcg0HUhfOyXegTumU3afrosvbNlW7aWvqvEIkNBpb/hTe57wxplfGdLlkF6aCAvg1dTrEI3QgdN0g/5f3djaiwiALbZ5Oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774959502; c=relaxed/simple;
	bh=NrKb3Hx3cKJoOdTevgDagOXB1CFIHAEOMb1inHGc+cM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oNoODZMqNPQ0XGnk4sQZV3wZMCXO6ypkNiRx7ItI70ZpWOogqRVERfTCOYWrXGI45wusGn9UGmSo0cDNED+mKf9xOz0AH9GtoaxRS1ZPRW99MloV+Hd9ALL1rlt3kGVvmiTY4hryxmRrEgMDTa32TwaBcl/Z9TPGifY3+c0zy5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkuHisc7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkuHisc7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F7CC2BCB3
	for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 12:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774959501;
	bh=NrKb3Hx3cKJoOdTevgDagOXB1CFIHAEOMb1inHGc+cM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lkuHisc7NK3Db9kq6X82/ItrdEbbosaMVACrKLX2u4R1M9UgXSyIRENpBdu7QRlr0
	 YVmuIqe0pf4fWUQkd9i8za4eqS70H00zZjL9Zst20gJtbw0z88xFlmyx/MNcK5CXsA
	 RjNtoAP2UNzBVW3O5lZrfmlbqmDbPUf9mbBepds5b72HyQx9zj3+i6gJTtvg41MySX
	 5gyb+2GwKZe2zrsKH3SvKIS8LmLttc1VoBz+38bhixh3br8PUA1L035sDyBXyGhJaa
	 +31oZ7oFm6JkNcWQCKIBcmBPILpKScssebQPf3+GcO4nlQ8TqEPmgMLssbpHXGVDZI
	 jAVSXnzYvPr6A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-417571c6083so3041953fac.2
        for <linux-acpi@vger.kernel.org>; Tue, 31 Mar 2026 05:18:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUNrVgR1UWrKsh6l3xaETejPoOM0N/dQnPex2++eqL5zoYUhe5E5RoTtrfJTG4aC/JtYO18Sgoc6KL9@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9jRpLKAfh3Fnb/F924n9QRP4JkfIW0+uMOOXpm28QMzqhBqul
	DjuXGfA4MAs21R5TJgV6KIBIULA8KmnEusj1dZAiN9dxQWP0BNN+pjhNK/8GeOAMKm43PeGqOwt
	Bun0KN2psK2Dz8DEE2D6MJpNDOU6i0To=
X-Received: by 2002:a05:6870:bb0d:b0:409:b5a3:42bb with SMTP id
 586e51a60fabf-41cec33f322mr8024838fac.31.1774959500820; Tue, 31 Mar 2026
 05:18:20 -0700 (PDT)
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
 <CAMRc=MdrxYRhB3MWnhTPM9FqzF-_P7Br5mRJ7kYOxQ2G3zjdow@mail.gmail.com> <acWChJZK-xwpuTZM@ashevche-desk.local>
In-Reply-To: <acWChJZK-xwpuTZM@ashevche-desk.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 31 Mar 2026 14:18:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i-3eG_fGAfS7oAf3gBac-K0EUuBfgsUShu6+0=PMC7uA@mail.gmail.com>
X-Gm-Features: AQROBzBepqKiiMX5qG_ajp9HutWOQhTUXdB9zgxGE_X9kLiUvl9QoBSsUD3u5R8
Message-ID: <CAJZ5v0i-3eG_fGAfS7oAf3gBac-K0EUuBfgsUShu6+0=PMC7uA@mail.gmail.com>
Subject: Re: [PATCH] software node: allow referencing software nodes by name
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 8:01=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 26, 2026 at 04:47:00PM +0100, Bartosz Golaszewski wrote:
> > On Thu, Mar 26, 2026 at 9:48=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Thu, Mar 26, 2026 at 10:39:09AM +0200, Andy Shevchenko wrote:
> > > > On Thu, Mar 26, 2026 at 09:34:01AM +0100, Bartosz Golaszewski wrote=
:
>
> ...
>
> > > > I believe so. See how we find a GPIO chip in the gpiolib-acpi-core.=
c.
> > > > In the similar way you can try finding any object in ACPI namespace=
.
> > > >
> > > > But note, ":00" is part of device instance name, it's not available
> > > > in ACPI namespace. There we have HID, UID, et cetera, ":00" is pure
> > > > Linux kernel thingy.
> > >
> > > We have acpi_dev_present(), but if you read its kernel-doc, it sugges=
ts
> > > to use acpi_get_devices() for the case of early checks (before device
> > > are actually being instantiated).
> >
> > Ah, but I'm seeing that the firmware node handle of the acpi device is
> > part of struct acpi_device and is only initialized during the scanning
> > phase which happens at subsys_initcall() time?
>
> Sounds correct. With that you can just check the device presence in the t=
able
> and maybe evaluate the status (but I'm not sure about the latter).

Yes, you can.  _STA is available at that point.

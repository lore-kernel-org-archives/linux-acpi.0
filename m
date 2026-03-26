Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B905737646C
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514838; cv=none; b=Gc6rcOzxK+QJ01Qne4HjdILLC+I4zbvwCztMufh7/SmK7/ve9khkj5C2hPOgKSjxyx/5iUmB9uOW6lSSElduEW/YqAyxRtKNwC1R+egy0L5HTbayfeuBERT/ZJV1TeI0FpOeYcZeE5YH2gpuzVGQW8v9wjR6uZV4ZKBLOl44AXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514838; c=relaxed/simple;
	bh=ZXF2zvjfRk8rFjeCkAnCC+O+YGmofyJCt72d9PaUOU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J5kFQHTmUqL9Rp9/gP0Z61tVp3HHEpTcc8GzQMYaE/IlBiqB5jzkEEqt9IDvSTufi+Js5M/lhueXPai3aPitCJZIB7MyEfZc3T/1z37gqyQtCXFp2Y45WSBWviizTgChEfbAr87uoEMO6Te5bnwTFo92CNUENGk52PGdzaF+eXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZStVPRew; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZStVPRew"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7979FC2BCB3
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774514838;
	bh=ZXF2zvjfRk8rFjeCkAnCC+O+YGmofyJCt72d9PaUOU8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZStVPRewU2lD/XmMhdZ5HXmJ8y1dYONBK3rhy1NnJiv8q8bOxU9M93DVnzfEwmayz
	 yHN3KYFa0W+BIX/UEG2LpGn72/HtJbhAntIJDOuYXlKEtzhCTRrfCPfl/+wpyLdGoQ
	 gXEmq3dKv/0vN3CnRX5KcuEAniYvCqoLPPmYCraZvI0uxTDzcZ/wTNUGjEqjP2nNvt
	 2lkGJl57ZsXYHOf6i5kABCmmFPMCV2ST+nm132auGQP6vrydDbkyg8P/ubsnp4Tgl5
	 TRJ6z+GCnYLMxg7bOMrbWb5D6IKBfiFDzAb2gYxV4WwjQEaMHaTlOZtbyBM2Mbxyp9
	 tqyQWGWCJfBeg==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38bf47a6f02so5828761fa.3
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 01:47:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUW7AFSNtPi9APzWKWeHZFeuvrG+JliDDJkRUgd2Hj5e1hHPXHkMeBWMVyffcg4j/E+gT7zgkR41rR0@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk9Tkism3P1JlDoGYPJN5ndpEWATshDyS0H5xGn7Iy1S7Q2hFU
	PqdnC8JCqX3Iqz3TrYFiTPu2mFXG0jdG4fWRnt1SE69MOhd05kjK9AA3m4k65KWBwGeKdP2VATW
	yMSlJN8e251lr7sEYl2vwc9iQh/bRx0OOmaU4uFESIA==
X-Received: by 2002:a05:651c:888:b0:389:eed3:5685 with SMTP id
 38308e7fff4ca-38c430b53f5mr25715861fa.16.1774514837096; Thu, 26 Mar 2026
 01:47:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acIV6xF8mY-8wd5e@google.com> <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com> <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
 <acTtzuGD-K5XvVir@ashevche-desk.local> <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
 <acTwqD8fXZSncMIS@ashevche-desk.local>
In-Reply-To: <acTwqD8fXZSncMIS@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 26 Mar 2026 09:47:03 +0100
X-Gmail-Original-Message-ID: <CAMRc=McUD+M4oYOAyhU845nuSF6yve_JuaTDSNBWw3Ah3OVgrQ@mail.gmail.com>
X-Gm-Features: AQROBzDznfIV8odMjUNxsBoF1DFdTG7vinasxV7KOJ3Gh6QhL-yewdez10OZiPE
Message-ID: <CAMRc=McUD+M4oYOAyhU845nuSF6yve_JuaTDSNBWw3Ah3OVgrQ@mail.gmail.com>
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

On Thu, Mar 26, 2026 at 9:39=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Thu, Mar 26, 2026 at 09:34:01AM +0100, Bartosz Golaszewski wrote:
> > On Thu, Mar 26, 2026 at 9:27=E2=80=AFAM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > On Wed, Mar 25, 2026 at 05:32:06PM +0100, Bartosz Golaszewski wrote:
> > > > On Tue, Mar 24, 2026 at 8:30=E2=80=AFPM Dmitry Torokhov
> > > > <dmitry.torokhov@gmail.com> wrote:
> > > > >
> > > > > Please post the reworked version so we can review all the details=
. My
> > > > > concern was that it relies on notifier chains to notify when devi=
ces
> > > > > get registered and unregistered, and instead of matching node nam=
es you
> > > > > now need to somehow match device instances and software node inst=
ances,
> > > > > which again likely is done based on some name. This just piles on
> > > > > complexity where a simpler solution would be sufficient.
> > > >
> > > > I will post it. Hopefully before the end of the week. I want to cov=
er
> > > > both OF nodes with paz00 as well as ACPI with android tablets. The
> > > > latter case will have to wait for devices because there's no way to
> > > > look up an ACPI node by name that I could idenfity (correct me if I=
'm
> > > > wrong).
> > >
> > > What do you need from ACPI exactly? The ACPI namespace in the OS is r=
epresented
> > > by set of ACPI handles, each of which is the object pointing out to s=
ome object
> > > in it. Any object in ACPI has a unique path. At any time, after parsi=
ng the
> > > ACPI table(s) into ACPI namespace we may get a handle based on the pa=
th.
> >
> > DT is unflattened very early into the boot sequence. Is this the case
> > for ACPI tables as well? Knowing the name of the device (HID + index,
> > eg.: "INT33FF:00"), can I check if there's a corresponding ACPI node
> > (of_find_by_path/name() in DT parlance)?
>
> I believe so. See how we find a GPIO chip in the gpiolib-acpi-core.c.
> In the similar way you can try finding any object in ACPI namespace.
>
> But note, ":00" is part of device instance name, it's not available
> in ACPI namespace. There we have HID, UID, et cetera, ":00" is pure
> Linux kernel thingy.
>

And how would the four instances of the cherryview pin controller be
identified in ACPI? I've just created a dumy table with a single
device, I don't know ACPI very well. Could you post an example .dsl
here for testing?

Bartosz

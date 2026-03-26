Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CF53B6352
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774514055; cv=none; b=H4dRtM8mO6BkQWuUiwXSTBHu1k9kZXh9ZrakUJK17ISeGk/xWn0ZgleAheKqnrCN+j1xXcq265LQ2NSFVlMt7fKJXaSCNRhW8asHIepjIxny8U2vi31m/CEZhpYyC/noc4MsSToS9HQ11JJwbVuWvOL8fz314yGEguzU/pKo+xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774514055; c=relaxed/simple;
	bh=2GPPwrhAS/2I2dEVlIZY4TiBjyyp59j5dJ3UrXf8juw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tgv4RinK3fqBjYzNqPS2lzcbNrhPq3Vazb/dZolelRjVd/ZBTNAr+xlncQPjlqPmNQHcTNjEQ5f34pOzdWP7q9Zza/v5OO9W8Y+fZYpvW8aUkad2LcD2kVW7ZlUagaM5MbBhlhfeO463/q+yoSShnJPpPfqnFXoDcL2OvEykHQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qxDgz1A6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qxDgz1A6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA1DC2BCB3
	for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 08:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774514055;
	bh=2GPPwrhAS/2I2dEVlIZY4TiBjyyp59j5dJ3UrXf8juw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qxDgz1A6R+w/KzhI/4/WSFtxgpL8+9DDB4YndvC2jpcVypS9VEpAp13Xhpd1vhbGq
	 Mq+Rkzy2jmkE0tlm71h9RlYo1UNHfxn8T0ZX7Mkxv9JBxkE/SxLlD/mR1xK459/NZ3
	 SZq4zwpNZXcyZpYpdc0neo5PLlK5uPshoTPKnZOuDJZRUXT/OcLUGhH2Qr0EliKtPt
	 6tJi6T/3Xdbl3eqVTjd4RcQ7Qqw7uxQqYVCuKQRW1MIcv4szftUHHOxc/B8lm8+R9+
	 +Nh7g8fGjOo0QpRrzWuym66vnUMEume9wxIK2dGYy+jbePhFX5Eaf32sNJtj3bDn1L
	 tPoQZBJQT5k6Q==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-38704f70ea3so6625811fa.2
        for <linux-acpi@vger.kernel.org>; Thu, 26 Mar 2026 01:34:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXnlK1s8iWAqY0jcW0uV0MJIp7JnzSsY68W2cbHjJTY1MCY+YHUMrs9lJVCAkKOUUWf+8H+5rIXyRlg@vger.kernel.org
X-Gm-Message-State: AOJu0YzHJx9X1tyXOFMBqdbHnhXofmumHHEas7Xwb8pLOcoKleFWWJQe
	6PMN1+oi8T+28v/2k1X1eP4iMuSnpRRkmECwo3RqOR2FIiZwHjOn8VZ2Itt6X3Z37YungFC6ltu
	3mR/bD1kJ6v2j9env8U8XGsWj0hiJDnheIL8oSDfksQ==
X-Received: by 2002:a2e:a98b:0:b0:38c:4b3a:32f8 with SMTP id
 38308e7fff4ca-38c4b3aa48fmr20651991fa.5.1774514054310; Thu, 26 Mar 2026
 01:34:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acIV6xF8mY-8wd5e@google.com> <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com> <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
 <acTtzuGD-K5XvVir@ashevche-desk.local>
In-Reply-To: <acTtzuGD-K5XvVir@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 26 Mar 2026 09:34:01 +0100
X-Gmail-Original-Message-ID: <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
X-Gm-Features: AQROBzC-il97F7Nv94OXjqjdeAzVfHinFNT9M4SjDpdWPsPzXiV_3k7cYz_77i4
Message-ID: <CAMRc=MeEMx1w5HaXBUP6iAu8T8b7Ti1i7JVDDTwvpjaEOtDJuw@mail.gmail.com>
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

On Thu, Mar 26, 2026 at 9:27=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Mar 25, 2026 at 05:32:06PM +0100, Bartosz Golaszewski wrote:
> > On Tue, Mar 24, 2026 at 8:30=E2=80=AFPM Dmitry Torokhov
> > <dmitry.torokhov@gmail.com> wrote:
> > >
> > > Please post the reworked version so we can review all the details. My
> > > concern was that it relies on notifier chains to notify when devices
> > > get registered and unregistered, and instead of matching node names y=
ou
> > > now need to somehow match device instances and software node instance=
s,
> > > which again likely is done based on some name. This just piles on
> > > complexity where a simpler solution would be sufficient.
> >
> > I will post it. Hopefully before the end of the week. I want to cover
> > both OF nodes with paz00 as well as ACPI with android tablets. The
> > latter case will have to wait for devices because there's no way to
> > look up an ACPI node by name that I could idenfity (correct me if I'm
> > wrong).
>
> What do you need from ACPI exactly? The ACPI namespace in the OS is repre=
sented
> by set of ACPI handles, each of which is the object pointing out to some =
object
> in it. Any object in ACPI has a unique path. At any time, after parsing t=
he
> ACPI table(s) into ACPI namespace we may get a handle based on the path.
>

DT is unflattened very early into the boot sequence. Is this the case
for ACPI tables as well? Knowing the name of the device (HID + index,
eg.: "INT33FF:00"), can I check if there's a corresponding ACPI node
(of_find_by_path/name() in DT parlance)?

Bart

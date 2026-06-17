Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B8D390233
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 06:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781676859; cv=none; b=SG+o6sgmHvuYYVVbVj3vpadEy8ArGlP1T/h+8NVQ9WTiIeSBwsMeDOGsrdRBZnTicCU/YnrqGr45OjaELNPf48dKfEwKlBsiFGC1slKVswRRpCielfPgjIAGPN4Y3//p7xjHdQOImEs4ADFBJt9mEdjC7u4VxN/1MNod9zc0/jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781676859; c=relaxed/simple;
	bh=MRoLxQm4C/hKvJxLeAzrHxdKytkzuCHv4hSP4eNk2mA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HcZNgQ/PpOTC4CgO30STr9KJHV7r5uD+qbnHUIcMFLNgQiu0vT1v78vIk+tYfUZe/AtqGCZZQwD0LKqC9etokh49tWI3ApLEIQ/vGvcwt6IFUZLlWQBeERsf4KcpxdPmHVdvXSkW/Ta9XKHozz3Sqm2IUB5ZmYegF/Fh92Fjaws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=leVxuQVn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="leVxuQVn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D340E1F00A3A
	for <linux-acpi@vger.kernel.org>; Wed, 17 Jun 2026 06:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781676857;
	bh=MRoLxQm4C/hKvJxLeAzrHxdKytkzuCHv4hSP4eNk2mA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=leVxuQVnVgmbIpJ3IC61vXGoDtph1LyF33XiQD3pm9htibl9P7Wm/T6unhvp5bSrA
	 Rd2tPT8oA49BUBDM+m6GEP51ZkgFh1eXT2s6AhQvGW+ui6mwzvjqmpp6/bpTVTCHFr
	 1ZenIT+l1eLea27JizSMOx5JxzHv5J+QKJVtl/vsVE8+qdKxWTFjT+F+sLxoWb56Iu
	 sTROE164fxWqkUl0akkZm4boLjlfpF1rEpPCMzY/UdDbVyrS4kSIU5p+EK2S1btoYD
	 cQ8daTX1kmsuT6DRxfeEc4nc7uu+ojRonmcSFOsFhMur8/rFx4Tr92W8wrCeVH33we
	 dvC6UoPsCknyg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-39940cb1ba0so34012891fa.2
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2026 23:14:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+FGoMwl0agHBB67KuGeUuqVDKL3HBZZUDEGlJKe2eHXgYLO0XjHbbHV0zqEKWFZlZmFSO029jzlv6m@vger.kernel.org
X-Gm-Message-State: AOJu0YyQi4fudZCN7R/tbz8a+RouyO37Xw0cNKwTKlnLqkxEk+c0S2y3
	yF+VLT72flXsEcz+O9Be/BbP4/+smpUO+AaexY7OLOKHBuXQlJZHFpElrcbyVYYDxwT2C0avevS
	RIlusHRfkGsukfhM0d7GIkDiJOMbrFeHWfaPkVoc6YQ==
X-Received: by 2002:a05:651c:1473:b0:393:82e9:fb63 with SMTP id
 38308e7fff4ca-39969b151b4mr5047091fa.1.1781676856531; Tue, 16 Jun 2026
 23:14:16 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 01:14:15 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 17 Jun 2026 01:14:15 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260616114855.GD2990@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610154204.110379-1-scardracs@disroot.org>
 <20260612085257.GY2990@black.igk.intel.com> <CAMRc=Mcv7SWVYA6rNZo+-tYx_ohOdedkewLZOa=X1Eei=1fTzA@mail.gmail.com>
 <ajEkvstS6RgRTATK@ashevche-desk.local> <CAMRc=MeKdP46ohf=hJQRo=afe8WhTQ5yo+Zu3f34h-E4BiuSmQ@mail.gmail.com>
 <ajEzQDcuDAG_mHaS@ashevche-desk.local> <20260616114855.GD2990@black.igk.intel.com>
Date: Wed, 17 Jun 2026 01:14:15 -0500
X-Gmail-Original-Message-ID: <CAMRc=Md4OjbixE5a9YkOg3aNp36RZa3hZGgmX2rb2OuYUsNBYw@mail.gmail.com>
X-Gm-Features: AVVi8CfsbBnjBZ9tKWB2AULgkrPL2-mlbSKNf-rKa89AfGWtbqu7HhbzUUJavJo
Message-ID: <CAMRc=Md4OjbixE5a9YkOg3aNp36RZa3hZGgmX2rb2OuYUsNBYw@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] gpiolib: acpi: Add robust bounds-checking and safe
 address handling
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Mika Westerberg <westeri@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marco Scardovi <scardracs@disroot.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jun 2026 13:48:55 +0200, Mika Westerberg
<mika.westerberg@linux.intel.com> said:
> On Tue, Jun 16, 2026 at 02:28:00PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 16, 2026 at 06:42:34AM -0400, Bartosz Golaszewski wrote:
>> > On Tue, 16 Jun 2026 12:26:06 +0200, Andy Shevchenko
>> > <andriy.shevchenko@linux.intel.com> said:
>> > > On Tue, Jun 16, 2026 at 02:54:02AM -0700, Bartosz Golaszewski wrote:
>> > >> On Fri, 12 Jun 2026 10:52:57 +0200, Mika Westerberg
>> > >> <mika.westerberg@linux.intel.com> said:
>> > >> > On Wed, Jun 10, 2026 at 05:42:02PM +0200, Marco Scardovi wrote:
>> > >> >>
>> > >> >> The series adds explicit bounds checking for GPIO pin accesses and
>> > >> >> ensures safe handling of ACPI addresses in OperationRegion handlers,
>> > >> >> without referring to truncation or wrap-around behavior, which does
>> > >> >> not apply.
>> > >> >
>> > >> > I'm fine with these now.
>> > >> >
>> > >> > For both,
>> > >> >
>> > >> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>> > >>
>> > >> Andy, Mika: do you want me to queue these directly for v7.2?
>> > >
>> > > I believe there is no hurry, but I have no objections if you pull it in.
>> >
>> > Your call, if you thknk these should wait until v7.3, I'll leave them for now.
>>
>> For the full consensus we need Mika's opinion :-)
>
> If we can get these for v7.2-rc2+ or so that would be good enough IMHO.
>

Then let me just queue them now then.

Bart

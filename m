Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745B544238C
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788770566; cv=none; b=HaEfgnFY4a2IVN7FQmZKqFfriSATjoXmTgrJ+UgtMin3Tfa60NBxYRlG9K9gct8z/YsKK7Yi+raShvqtQ9ZGhVh6qzjCgOuBjAI2XYNXpz13rTH2Qjd5FOlqny9n+n237VOXA/0dUcScjOSv4qb+jK9S9UrRU0TtMvGz4GuxVRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788770566; c=relaxed/simple;
	bh=bvgnRIDupB6q+uAT7fNeLBNHD/lrtfXyh4a6Y69o1ew=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hMsRW8bYbHI50fh/EL0E648d5HDvLOyAHrlcjgwbndbf9VsBnAQKZvnZPV3rb5M1DACgS9XXMHwzeUrZk2Xc9yEUPwQ90LcucWVC2UDu9PBjjZV3KbVFkZxopf3NoCJS15GYu22fqLhNuIknjrMXX56GM3ciznxlfmox53I2vAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPGFXv9e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPGFXv9e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BB901F00A3F
	for <linux-acpi@vger.kernel.org>; Mon,  7 Sep 2026 08:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788770565;
	bh=FsL1JRBtjl14wKfbHM2QsZ2zNoKnZ1ubF74NM1A6Jzs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=nPGFXv9ebB9LWaJ4ZpwBlxuZi9KUW/dyOfZkOUMsGz3kJUpXXasI3Ki32vsrg+Tqh
	 VJMfCrM9GZD28QvyPaxqNPSe8KvY+jR7kX59lgynC/QpxlFaoEuQKZHDmK8160ETgv
	 l3Ji2FlItbsgAMnZOLpWtvoim2FOo3IXOYOv9IZhAzLKUC9idQGf8vmSGBCLuFtiDl
	 s+ApzFchXRZ1kye8xnkHXgmyc2kU09h9F6n2+K7GRc/9a5/GVjcBOmAs5LASnHPwcf
	 o1269GRHN4hqcsu6tiI4EK6h3r7sfUXHBEElE0wjbOmlkrywYTt8ATUsxZ0U1V3Ysu
	 iQOz01z1sYE4g==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3a2b4743936so25542951fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 07 Sep 2026 01:42:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy1X5Mnb+B+6PSH2xIswwmiPu+3Zs1kMEBTCfb5pE7xEssdb71/RL8JIMgb6qh7TwfJZ/9owymVJhIZ@vger.kernel.org
X-Gm-Message-State: AFuF++lrYOWG+78y6CbLgrhysIoBoeb7M097hvSPJxhW4yecd27vc/Rf
	XzCjPt4jTppCmcFLBlXThFi53JO4/dKMsxZi04B/7M9WZVzM3jMSrVmhAHKw5m4CTAHQmpM4e8v
	SkNQnrNesho6fdm2BCtwNRifYaLAyJBMgPExCoGhrbA==
X-Received: by 2002:a2e:b88f:0:b0:3a3:368:fb9f with SMTP id
 38308e7fff4ca-3a371f5630emr24940481fa.13.1788770563714; Mon, 07 Sep 2026
 01:42:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Sep 2026 01:42:42 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Sep 2026 01:42:41 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <0587c422-8279-491e-b377-af623e13366c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821070651.39763-1-vaknins33@gmail.com> <178827844334.39529.382963115769227795.b4-ty@oss.qualcomm.com>
 <aplfrNXzNvgbMJf1@ashevche-desk.local> <CAMRc=Mck+ft9wmWQLcq4uFTvH9u_rB_bFQ6tGtG7YkYdbowJaw@mail.gmail.com>
 <0587c422-8279-491e-b377-af623e13366c@kernel.org>
Date: Mon, 7 Sep 2026 01:42:41 -0700
X-Gmail-Original-Message-ID: <CAMRc=MeDKQCuh683UVm1mZLa7gMfi9_q6nia6WFT_sZAPu4GnQ@mail.gmail.com>
X-Gm-Features: AcwNN1WSwhJ1q6AAMkoDnQTqEurSzKK3a8rvISuNw7xwBUqiDTxxQZNMz_gWSlc
Message-ID: <CAMRc=MeDKQCuh683UVm1mZLa7gMfi9_q6nia6WFT_sZAPu4GnQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
To: Hans de Goede <hansg@kernel.org>
Cc: Mika Westerberg <westeri@kernel.org>, Kivan <vaknins33@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Mario Limonciello <mario.limonciello@amd.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sep 2026 09:56:58 +0200, Hans de Goede <hansg@kernel.org> said:
> Hi,
>
> On 3-Sep-26 14:42, Bartosz Golaszewski wrote:
>> On Thu, 3 Sep 2026 13:53:16 +0200, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> said:
>>> On Tue, Sep 01, 2026 at 06:00:46PM +0200, Bartosz Golaszewski wrote:
>>>>
>>>> On Fri, 21 Aug 2026 10:06:50 +0300, Kivan wrote:
>>>>> The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
>>>>> to stay suspended in s2idle (Modern Standby), prematurely waking
>>>>> after 1-3 seconds with 0% hardware sleep achieved.
>>>>>
>>>>> In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
>>>>> defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
>>>>> \_SB.PCI0.GPP3:
>>>
>>> [...]
>>>
>>>> Applied, thanks!
>>>>
>>>> [1/1] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
>>>>       https://git.kernel.org/brgl/c/1900b5a41493e7050c68c1e62780d6fb9a209457
>>>
>>> I thought I am going to pick this up via my tree...
>>> But okay, not a big deal, I don't expect any conflict in that area.
>>>
>>
>> Oops, sorry. If any conflict does occur let me know, I can revert it or we can
>> fix it in tree.
>
> Regardless of who's tree this goes through I would like to point out
> that a quirk like this really should go through a fixes branch
> for the current cycle (no idea if it already is on a fixes branch,
> the "applied" message does not make that clear).
>

It's queued for v7.4 alright.

Bart

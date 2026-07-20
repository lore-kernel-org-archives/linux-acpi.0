Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46F73A782B
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 07:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784531714; cv=none; b=UYY0CUqFmWHXDmON6WOJp6eK0STYWOtzR7zQQb6Di/VAjPBljlRCFEIDqB2u/cmVxv21dVv9d2cmjLEDle+wSCWH+yaAINbLBrsjHnZvJllLZtRiPlUPCFavaNuHrEwk51BXLW5LdtHjMDK3gmejUgYagnaMQx0Bq2Yh0Vu63OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784531714; c=relaxed/simple;
	bh=Qxe1wlOLxloaHegMhvAeO0dFL1jjuOsAo2Z3X8y6mtA=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UDOarhvEGOYtTvfyrQY2XNYrkovVeWcHlCe5rldOjV97T/U4L92Ft574JacO9jWUIevG1l7CqlQnYEm/XgsqjxjYC5gPlCtJUnnOWzCZfsTRxo/Wx6bXmvRIe59Ud1NG/hjMBXmjNbci4mVZyLC5b6op6sxO8yFt50PhA4I/9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ArMHZht+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ArMHZht+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1941F00AC4
	for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 07:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784531712;
	bh=o5mECv2KTe8SiKRGXZ+hZW/XufJFB3KGTqUxWEwdBTs=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ArMHZht+hO7T/pCuAl9EB9pgJK20+HaRYxMEhH9fwV2WpBMcOTgBy8mN9yiggBywK
	 681IEXBRHVlu2bDk826S4+wfHTj8tfKt3XTjrzAyxJ0vvPe3Y3dLZTaoorrA5bk1QB
	 0goZQV16P81CZGhRQgmn9PlXkk1a+9la7Y6a6KwfN39w+zCyoUnj4gnwRSOjalkmhB
	 DF/zcOs9aGS1nqyXObD+SjhCnVXCtFFVtlbYQ7C/QGCRsV2XmMDq5cS0sjoeaRF7gf
	 jnBRq76ibQ40cqUQWtMhDmP/8g6yLcFndZllsZHREh+I0vYbJIrxLdwhRj1CW4sO9w
	 9zZtaCTpi0VHA==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aeb5e85378so10503169e87.1
        for <linux-acpi@vger.kernel.org>; Mon, 20 Jul 2026 00:15:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RoGOXaDmfOPolAzq8TShnCM6pIHzsJyyz4VGjjr3P14iSh49TSnTtgdrYqmf2DNwPfFOjMBE0fYlFfc@vger.kernel.org
X-Gm-Message-State: AOJu0YxYSj2mvYeAwfxd7mX2VQXhZYLTb0HpR62uEr6yiYZcMxolUErB
	lLz+2kIdcd2sSUyeplbyYf8K5ju0ZYDKriCTu67dDG9UfYD1bzWKnPGD3zPef7yuJqPDq8vu8Yy
	RersR1YadXXo1cvI8ZgheKQ6FKBCoayENGFG3wGMFmg==
X-Received: by 2002:a05:6512:1503:20b0:5b0:13b4:6079 with SMTP id
 2adb3069b0e04-5b28f9ae65dmr1582849e87.53.1784531711252; Mon, 20 Jul 2026
 00:15:11 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 00:15:09 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 20 Jul 2026 00:15:09 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <DK0W7O5C7LYK.3BJOBTN337Q52@kernel.org>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713-swnode-fw-devlink-v4-0-d4f2dee27ad9@oss.qualcomm.com>
 <20260715212830.3077100-1-dakr@kernel.org> <DJZGR6NV2WK5.2ZRW7VZIRO3LD@kernel.org>
 <DK0W7O5C7LYK.3BJOBTN337Q52@kernel.org>
Date: Mon, 20 Jul 2026 00:15:09 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mdvhf69-vJx22+MuaWVJfn4ipFbQ0wc2U96F599uqrdVA@mail.gmail.com>
X-Gm-Features: AUfX_mzhVw0yY4ElBsp3RJ24-o-6M3TylIG-umxlyM5jDc9PiJ1qxEAwGhY8ScU
Message-ID: <CAMRc=Mdvhf69-vJx22+MuaWVJfn4ipFbQ0wc2U96F599uqrdVA@mail.gmail.com>
Subject: Re: (subset) [PATCH v4 0/5] software node: provide support for fw_devlink
To: Danilo Krummrich <dakr@kernel.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>, David Gow <david@davidgow.net>, 
	Rae Moar <raemoar63@gmail.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Bartosz Golaszewski <brgl@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kunit-dev@googlegroups.com, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-gpio@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 17 Jul 2026 15:49:55 +0200, Danilo Krummrich <dakr@kernel.org> said:
> On Wed Jul 15, 2026 at 11:30 PM CEST, Danilo Krummrich wrote:
>> On Wed Jul 15, 2026 at 11:28 PM CEST, Danilo Krummrich wrote:
>>> On Mon, 13 Jul 2026 13:14:43 +0200, Bartosz Golaszewski wrote:
>>>> [PATCH v4 0/5] software node: provide support for fw_devlink
>>>
>>> Applied, thanks!
>>>
>>>   Branch: topic/swnode
>>>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git
>>>
>>> [1/5] kunit: provide a set of fwnode-oriented helpers
>>>       commit: 9fdbdb528488
>>> [2/5] software node: add fw_devlink support
>>>       commit: 37e586675993
>>> [3/5] software node: add kunit tests for fw_devlink support
>>>       commit: eecba5978729
>>> [4/5] MAINTAINERS: add myself as reviewer of software node support
>>>       commit: 122630406245
>>>
>>> The patches are in the topic/swnode topic branch and will be merged into the
>>> corresponding target branch soon.
>>
>> I will provide a signed tag once I have the 0-day result.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/tag/?h=swnode-7.3-rc1
>
> The changes are also in driver-core-next now, thanks!
>

Pulled, thanks!

Bartosz

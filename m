Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0468F34EEF2
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 11:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774611206; cv=none; b=p+q31agXxgyBhF5asG1t0jIiBS997QZszw8HRtWXyB2Z4fWLCqmVyU2l4t2NMRyE6RloUYtcrGG1Ptqs1BVwBNTuSMwsp4lqvjEcAsLunVynY+CWTf/i0SNXZ9qLQwZ2yHD1rMZ7vYiZQd2mhs53OKB5KVHhC5le3RQ4GUgHQ+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774611206; c=relaxed/simple;
	bh=HYbsKtARQhYUUl8t77+jkNHhaDhPjZmFlmtYa7LM3Zc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HZTtLftHGF8lMEwDfmdcj5OmOYf03odPuN+mJyxhsNevS0HWkm/zvkb2c9YHC/IjMIFlNpl2Aw2u6Wdn1KixE6ZDfyiZ138xDCYednSJCpU5lhOGIdXiu8dMoBP7Kj+GHAKFhzxf1U/O+UnfyNKU2FV6WUixN3cZgp1kNrTPI/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G57RbAkd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G57RbAkd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4C7C2BCB0
	for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 11:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774611205;
	bh=HYbsKtARQhYUUl8t77+jkNHhaDhPjZmFlmtYa7LM3Zc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=G57RbAkdtmlu7TzcO8pL7FP7Qg+iVxoLblmbwKpPgjcqKOWcX/uCj92+YaqvPlQbR
	 psH3BYUCuMZvV5GM5SNH0becbCHAE9O9Y2BOit9B/veVcRrDd5QQbrSBsFrlZZWLCF
	 H3V1zHnagKWfbr+lv+O3I2qGwYXJmkAeWU4WSGbsqrytcWix9q2c7TKwEY277VWf4p
	 wt+Xzd2YkhtimuIWi9sSxsKgS2qnYtEglUkIPCAMxxR+1K3WoSHI8U5I27zZsrlBrR
	 Km0VLoWHU2C8OEy65hAUMo6mGLC1anrbvjEGp14IstZeKKn8FxUGOGCkLCMA3U5yU0
	 It45N2A6hxY2A==
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7d9d929e27aso1681108a34.2
        for <linux-acpi@vger.kernel.org>; Fri, 27 Mar 2026 04:33:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUwWu3HUmjPO/thG0rtjb2rcvAZhncAPhO6J0a7i2Z0+lpcSOavUYeAmr8WBu5BR0j2I6orfeOjI+3w@vger.kernel.org
X-Gm-Message-State: AOJu0Yylj/+tZOwUNHS2wswMVewkXoRsjQ3e/nmhPzACyupaHRlXieYF
	yDlB3w2yM819QL5EWcof+19IckYJX8eb6Q5BdgJ0D8auQ04Jb0EaNqRhT+1VR7o7GyOi4y4qBTN
	WTgHjI7QsQvJSJuUVNIMtJ2S65lsCb/8=
X-Received: by 2002:a4a:ee0c:0:b0:67d:e140:3443 with SMTP id
 006d021491bc7-67e185ee502mr1007013eaf.14.1774611205004; Fri, 27 Mar 2026
 04:33:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251125072933.3706006-1-lihuisong@huawei.com>
 <20251125072933.3706006-2-lihuisong@huawei.com> <CAJZ5v0j6HPW8thPNLSRRzZCjSSnr69DWBHn9BBR2+L4tOKD6Fw@mail.gmail.com>
 <11f9d333-4d18-463a-817f-d3f450d1624e@huawei.com> <2d2d2d40-c73a-4988-90fe-fad75e35c75b@huawei.com>
 <f2be1178-28f4-4412-adb7-1530944a76ed@huawei.com> <CAJZ5v0heJsOWA5z7CwrON4zvaebj8-C_HBe5ymYa+FAbfJgy1A@mail.gmail.com>
 <3948b6fe-2aa6-4e38-9d58-c0e25e48fe93@huawei.com>
In-Reply-To: <3948b6fe-2aa6-4e38-9d58-c0e25e48fe93@huawei.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 27 Mar 2026 12:33:12 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jPhW_spgjhfeig96G9pMEYb27_EKEYz17eZngrDLY7iA@mail.gmail.com>
X-Gm-Features: AQROBzDjihCAuBR-e9TBgLhPZt-L3pU-qARjU47jR5FkbNS3wDNBG8k800qqgi8
Message-ID: <CAJZ5v0jPhW_spgjhfeig96G9pMEYb27_EKEYz17eZngrDLY7iA@mail.gmail.com>
Subject: Re: [PATCH 1/3] cpuidle: Add enable_cpuidle() interface
To: "lihuisong (C)" <lihuisong@huawei.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sudeep.Holla@arm.com, linuxarm@huawei.com, 
	jonathan.cameron@huawei.com, zhanjie9@hisilicon.com, zhenglifeng1@huawei.com, 
	yubowen8@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 27, 2026 at 7:23=E2=80=AFAM lihuisong (C) <lihuisong@huawei.com=
> wrote:
>
>
> On 3/26/2026 9:39 PM, Rafael J. Wysocki wrote:
> > On Thu, Mar 26, 2026 at 1:17=E2=80=AFPM lihuisong (C) <lihuisong@huawei=
.com> wrote:
> >> Hi Rafael,
> >>
> >> On 1/30/2026 9:59 AM, lihuisong (C) wrote:
> >>> Hi Rafael,
> >>>
> >>> On 1/15/2026 8:18 PM, lihuisong (C) wrote:
> >>>> On 1/15/2026 3:18 AM, Rafael J. Wysocki wrote:
> >>>>> On Tue, Nov 25, 2025 at 8:29=E2=80=AFAM Huisong Li <lihuisong@huawe=
i.com>
> >>>>> wrote:
> >>>>>> The global switch of cpuidle can be turned back on in some case.
> >>>>>> So add enable_cpuidle().
> >>>>> No, this is not going to work.  The "off" switch only affects
> >>>>> initialization AFAICS.
> >>>> I think it would be work.
> >>>> The cpuidle_not_available() also see the "off" on do_idle().
> >>>> And cpuidle_idle_call() check this function first and then select
> >>>> idle state.
> >>>> Cpuidle doesn't select and enter idle state if this fuction return t=
rue.
> >>> I verified that disable_cpuidle() effectively prevents all CPUs from
> >>> entering any idle states and the cpuidle function is correctly
> >>> restored after calling enable_cpuidle().
> >>> What do you think?
> >> Could you pleasetake a look atmy reply?
> >> If not ok, I will drop this from my upstream list.
> > Sorry, can you please remind me what problem you wanted to address
> > with the help of this?
> Regarding the discussion in the link[1], if driver fail to get power
> info in power notify,
> the old idle states may no longer be reliable. Therefore, patch 2/3
> disables ACPI idle
> via the new interface introduced in patch 1/3.
>
> However, our discussion on whether this new interface can disable ACPI
> idle has not yet reached a conclusion.
> Could you please revisit this thread? It's quite brief, and I'd
> appreciate your further input.
>
> [1]
> https://lore.kernel.org/all/20251103084244.2654432-1-lihuisong@huawei.com

The "off" variable has been intended for disabling cpuidle via kernel
command line (note that the corresponding module param is read-only).

disable_cpuidle() is only used by Xen now and only at the setup/init stage.

I don't think that using it on idle state list change notifications is
a good idea.

Something like cpuidle_pause_and_lock() would be a better match I
think.  acpi_processor_hotplug() uses it already for a similar
purpose.

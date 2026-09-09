Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9F257982E
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788964125; cv=none; b=W+UvnxKk2YZW3GrjQ9lyykacNclMWgGH0angquYfT5xIQWT4pQGg50qLqlNxpghQBpG3FYmZ0/SzXhkMSgU9gDW5NFLdKqQd2Fy0kkIVV7Mf91BvGV2LFNn5Mgnhn3bytTMAxZsj66dTfbl9tCFDTWOl/7X/Lj8lQOrzaM9REIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788964125; c=relaxed/simple;
	bh=stadVtBCp6wk6pQ883aHgpti5/i/VdTdCNSizlaXdF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6AZZMk5Z8hy7zUFGdzWKMVxzRLZN09d85hIqL3rEg6+/cSKHjR3ceqnkjg8gx5R+gJZCOdMaChIAXjLPH0ITuz09kBGmaMpY6Nu17XhmM6EE0T3Mw+hCq3ktGUDyrmvkd4B9dSzuM+AGB2gZt89GVYGOD3UPRjFDmGUgc6r9Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ld4iCOtJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ld4iCOtJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C521F00A3A
	for <linux-acpi@vger.kernel.org>; Wed,  9 Sep 2026 14:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788964124;
	bh=stadVtBCp6wk6pQ883aHgpti5/i/VdTdCNSizlaXdF0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ld4iCOtJuGXAEhSM3K6eujG0sqPNWOp8/i4ICSZ0WmaFMo12ZOs4+jbFcNS0HVI7H
	 5q+dIOyrlVagh8R2nw7gwU34YJflAeToJ2NYiZ3AVcz6scxy8mKIBZZVHHYcQBvq9U
	 e4JrDKGN6iN5m5Pb3cjFJs4nIAsjeSksX5KLlhu5LJNag7ByX6DeoRVJgpk9NPNvCL
	 Qm42x+cWmHCvYE0CXuL1ai0XHBLooWB6jarVzG7Gqs21ySwi5AIlClqy4pJy9qjdWz
	 Wl9vLGdgU0JeZZx4SkhbD0YHIfIidwKaM2q9vqu2hbwhUub92nq48DJHmvNjtjtzgY
	 eEXe4XOvwfnwA==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff17443dso4097171fa.1
        for <linux-acpi@vger.kernel.org>; Wed, 09 Sep 2026 07:28:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzVTKvXtZYeyGkOuI6YJfmv0ENYDdj84xYdORHFdSGUNHzt9VvqkWWWSezUZ/uPx8m8Ffk0y6I3AWWe@vger.kernel.org
X-Gm-Message-State: AFuF++nJzTi6QAihjZZlZfWcP2Xnt+lcxnobCX3iNpsFbAK6tt+xe7pH
	YcD1LPJO5eoDzzBwLQaCC07+VkwBH1Tniw/dDAFbWyiGKzIkP1zFr8m0T93d65R/cQg+UygU9T/
	717auMXPaPl9X+jxBKpeuOahUqXhD8vU=
X-Received: by 2002:a2e:8a86:0:b0:3a3:52a7:39ee with SMTP id
 38308e7fff4ca-3a58d33e018mr4441811fa.1.1788964122291; Wed, 09 Sep 2026
 07:28:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806233817.622975-1-W_Armin@gmx.de> <f2f17b0d-22a1-4a57-895b-318bb50456f3@gmx.de>
 <CAJZ5v0j4EAZnrEA3Z7EKX5fdfhTWYbb=f0rOPnLsz5zaEMguGQ@mail.gmail.com> <dec5d721-8bc5-4be3-81cf-16b63829cbf0@gmx.de>
In-Reply-To: <dec5d721-8bc5-4be3-81cf-16b63829cbf0@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 9 Sep 2026 16:27:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0j67n7N-Eogik3njKV92E=FyW33bTvg6FnVfiT_AqwXug@mail.gmail.com>
X-Gm-Features: AcwNN1X4VP570iJuqr7naYH5b5DhHROwqgRYiMXybiki5ac9psZhgAOp68PshzE
Message-ID: <CAJZ5v0j67n7N-Eogik3njKV92E=FyW33bTvg6FnVfiT_AqwXug@mail.gmail.com>
Subject: Re: [PATCH] ACPI: battery: Fix bogus cycle count values on systems
 without _BIX
To: Armin Wolf <W_Armin@gmx.de>
Cc: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>, lenb@kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wse@tuxedocomputers.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 1, 2026 at 10:18=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 01.09.26 um 22:16 schrieb Rafael J. Wysocki (Intel):
>
> > On Tue, Sep 1, 2026 at 10:11=E2=80=AFPM Armin Wolf <W_Armin@gmx.de> wro=
te:
> >> Am 07.08.26 um 01:38 schrieb Armin Wolf:
> >>
> >>> Devices supporting only the legacy _BIF ACPI control method cannot
> >>> know the cycle count of the associated battery, so cycle_count always
> >>> remains 0. Claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT on
> >>> such devices can thus mislead userspace applications and prevents
> >>> power supply extensions from supplying correct cycle count values.
> >>>
> >>> Fix this by not claiming support for POWER_SUPPLY_PROP_CYCLE_COUNT
> >>> on devices without _BIX.
> >> Any thoughts on this? I tested it on my device, and so far everything =
seems
> >> to work flawlessly.
> > It looks good overall, but it is quite substantial, which is why it
> > didn't make it into 7.3-rc1.
> >
> > I'm planning to apply it for 7.4.
>
> Alright, that works for me.

And so applied.

Sashiko has a comment on the _BIX failing case:

https://sashiko.dev/#/patchset/20260806233817.622975-1-W_Armin%40gmx.de

but this can be addressed on top of the current patch IMV.

If you think that it's worth addressing, please send a follow-up one for th=
at.

Thanks!

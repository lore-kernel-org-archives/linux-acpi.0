Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1E4450410
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 13:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786541966; cv=none; b=BReizyLMmjt+TeINXBmoUTvQGcJE58UjsDDBuG80eDI+FgN6+gN8DUQYmW5QzbQmK7TTUFrvyBQbR9Iy3NmvGuG0r+ivXz62/XgepV4FZnWoxfL0488ZAxGYxzR/f4F28QxE8YnD1NMLwexTlMp17tTH7CzVpyLSGDlLi4eb1F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786541966; c=relaxed/simple;
	bh=RWE7pQb8i2JB14XwU4wJ+yXFy3Q4jS2VR+KW/a4+0Lw=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swPJYZmU9hNjo/kQLlAxLv9hjCFy/52QVEBDiefGv/e/UrM+g5kPxcvB7jbjqweHlBGSBVrPMVEr+XQRgz1OneJCtzTCE745oY1Ycl3wue4cPaT88FKZCtWQnOZrCR/HG2RrUVBmi/RHl7jzwvbUFmkzkayXArMU20tBHkPBaMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imABkov/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imABkov/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FDC1F000E9
	for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 13:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786541964;
	bh=RWE7pQb8i2JB14XwU4wJ+yXFy3Q4jS2VR+KW/a4+0Lw=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=imABkov/1V0w27uXhO5lV4FS5nkHrPG7rBt8tYoLX3y1JFEW/3TQe3RSd440Ja6AJ
	 YGA29br8xyG0cPZ1vs5d35V4Jtu+tmnWv+JPMqTZdzYV79II+Iaa+sggUZCdmJ+Mco
	 ioT+aPHt/cM0vcDUlctBo7/U0y/kF7zy53oHbMthN44gtP4SzHsyhWRSU5MqpCauew
	 1dX8SnwlMCqb+I3bYP90bXYFO2EOxCvl57Coj0yKspSnJ8QhT6hjJPskupQMOBzgs9
	 S+gPrt89TVNwRCzy8xOiiRBDMnumIEecuwIB2/gBLMX7Z9c1jlQYJtdjia4jMqFOBG
	 JYhy+KYYygNEA==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso842951e87.3
        for <linux-acpi@vger.kernel.org>; Wed, 12 Aug 2026 06:39:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp5QhFKLcV/CFmAJKG7KuEIm5Qb9gJo+dMPk3CJoM87YGm7hhRR3OCQMY0owUeli747HiKVvENS8j3K@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/wIafUmhMRPfkCMt2hOK7GT74kSyRArtuHhdDnz90I1RMb/1
	09VQ4iOHuiSTI/AxY1FIdsdL2H9G1+Z/ab6xQRj0eJbSFVcmh2gycd+LBW0ivSCoA9qJ7nCLcaN
	WwcPSUvoiwbziAzQKi0QkwyDvHqvHDPgGiCpZlPSZbA==
X-Received: by 2002:a05:6512:1053:b0:5b2:a339:b422 with SMTP id
 2adb3069b0e04-5b44e2e2690mr954360e87.14.1786541963208; Wed, 12 Aug 2026
 06:39:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 06:39:20 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 12 Aug 2026 06:39:20 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <anxyNPJfvkVaa8L-@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808155513.2221976-1-xnorigc@gmail.com> <aneGptJn8J7eF9tj@ashevche-desk.local>
 <CAD++jLkCYwTyK6C8LvZiYJ9fSc8bp3RPpb4d6EgQTRraJtJDzA@mail.gmail.com>
 <anmNf3rJGxso6nuc@ashevche-desk.local> <ans3pcNFEDVBYXXT@ashevche-desk.local>
 <CAMRc=MeDLc-LPwoCEA8yMw3+L9UcN-NgXpYpFPxtUNffAAffyw@mail.gmail.com>
 <anwxWXfqSt2bM8iy@ashevche-desk.local> <CAMRc=McGR_2V2mPJZwU6kBk8TzCV6iKu3-C9yF1bbWE0R73-cw@mail.gmail.com>
 <anxyNPJfvkVaa8L-@ashevche-desk.local>
Date: Wed, 12 Aug 2026 06:39:20 -0700
X-Gmail-Original-Message-ID: <CAMRc=Md=5gnKO9TzQR6bgSzNqj_qvRF=j9uVSTnA75A_ZPqT_g@mail.gmail.com>
X-Gm-Features: AUfX_myIFpzGsa8pkdvOuZXkp5lxzCJJOo3Vo6IeC0qxJJRVzTzdxOBgA_uQfpk
Message-ID: <CAMRc=Md=5gnKO9TzQR6bgSzNqj_qvRF=j9uVSTnA75A_ZPqT_g@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS TX Air FA401GM
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Yao Qi <xnorigc@gmail.com>, westeri@kernel.org, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Aug 2026 15:16:36 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Wed, Aug 12, 2026 at 06:54:30AM -0500, Bartosz Golaszewski wrote:
>> On Wed, 12 Aug 2026 10:39:53 +0200, Andy Shevchenko
>> <andriy.shevchenko@linux.intel.com> said:
>> > On Wed, Aug 12, 2026 at 01:23:53AM -0700, Bartosz Golaszewski wrote:
>> >> On Tue, 11 Aug 2026 16:54:29 +0200, Andy Shevchenko
>> >> <andriy.shevchenko@linux.intel.com> said:
>> >> > On Mon, Aug 10, 2026 at 11:36:19AM +0300, Andy Shevchenko wrote:
>> >> >> On Mon, Aug 10, 2026 at 12:17:06AM +0200, Linus Walleij wrote:
>> >> >> > On Sat, Aug 8, 2026 at 9:42=E2=80=AFPM Andy Shevchenko
>> >> >> > <andriy.shevchenko@linux.intel.com> wrote:
>> >> >> > > On Sat, Aug 08, 2026 at 03:55:13PM +0000, Yao Qi wrote:
>
> ...
>
>> >> >> > > If AMD people will be quick enough to tag this, I will include=
 in my PR to
>> >> >> > > Linus W. on next week.
>> >> >> >
>> >> >> > To Bartosz?
>> >> >> > It's gpiolib...
>> >> >>
>> >> >> Oh, true, I have also pin control stuff to send!
>> >> >
>> >> > Okay, I have checked if I have anything to Bart and it seems I mixe=
d that with
>> >> > pin control stuff. So, Bart, if you feel confident about this patch=
, you can
>> >> > take it directly. Here is my formal tag for that
>> >> >
>> >> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> >>
>> >> Is this a bugfix? I'll be OoO until the end of August starting on Fri=
day with
>> >> the exception of a single day to catch up on email. I'll be sending m=
y PRs for
>> >> v7.3 tomorrow. Not sure if I should take it for v7.3 or v7.2?
>> >
>> > On one hand there is no rocket science behind this patch (that's why I=
 gave my tag),
>> > but if you strictly want AMD to confirm, then postpone, so it's up to =
you to decide.
>>
>> If this is not an important bugfix, then let me postpone it until next c=
ycle.
>
> I believe a user may survive with this bug to be present for a bit longer=
.
> But not my call, at Intel I have no such hardware :-)
>

No worries, it can go upstream right after I'm back from vacations.

Bart

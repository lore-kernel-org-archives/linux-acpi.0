Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32724A8A1B
	for <linux-acpi@vger.kernel.org>; Thu,  3 Sep 2026 12:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439384; cv=none; b=pY1v6k+h+1YGwsvaRY71EwmtLkGdkqodhoHovDoyHXdjY0K/foL0kl1EW0D8mtCBeYkBTc4StjWpTCIYKc7P2QUw5tnoVWRfogNhnufp465d2MVXz3HIKxL7DYhZHg1fAzp7Cybl+6fpQHDOC46cC6LwgiWMYr5EiHup/V80sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439384; c=relaxed/simple;
	bh=kNU/k11BVa8SD18dvZpEVQtHVQvQQgOOZ50l+boBbK0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JEMdBupKpqxU9gLqn+LgonLU6U9OGGD5ql6m+naObXSUQzY+HTNuzOrF3ZIQcudWjcBabfhgcKN1CIBVSACEnywJ129P7afcvuT/2JpdIsZXuYCzlPYrHuXT33QQ9Phg6e34QFsKJP1pjTaDRCWHv+CjqcfRdqRF5/2fKuVANHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJu5++RJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJu5++RJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7095E1F00AC4
	for <linux-acpi@vger.kernel.org>; Thu,  3 Sep 2026 12:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788439382;
	bh=aR99XB3BjQrnv0W3ztdKLJH/R2+wXXStLVC5XuteylA=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=AJu5++RJGHcdv/OWtoTrrIm0RqfRdt1QHjy1go4yfHObJMiH5LV0EcBV6D2roLGuB
	 3YsrDhr2AZ7bOHUeT+S31K3T1lSD2z3BXUhNBtLw4EMEXpA05xTkxMX4ao9Dwzf9tp
	 QfWyqIsffjsFBZQlE51AhOjCyHJtESOd5nAOOFmapiuS69inhWFr3U3lM1rBnWlwsj
	 ZzyW/2g+8vbm7qpB7FtLd88MUNQHC4FOaD2WZu1zWzL/hEkfJ9lJqAkZ9LgFtqPz9+
	 4AY6qbrjs3CKOiHlKfkuJLpTwxUNgHzc1ia6xF9bXppf11neZwyx7dezkNv3FLdP3O
	 IBu2oGxbctYLA==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b4a95ab94fso1018733e87.0
        for <linux-acpi@vger.kernel.org>; Thu, 03 Sep 2026 05:43:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxPnVEcdFbqU+cgM13b2+zh7h15Y1UcuAGregw3eE9/zyKb7DXR//9HgvTuTDkDUggYZmDorPVXvZMQ@vger.kernel.org
X-Gm-Message-State: AFuF++lSgwgHeJHl6zToCDvqDm6Y/WBewbJkebqFOTY7IFEk4MhI5rAn
	8QpK9uRBSgZIqjcMlef0nUcOi0zBzgoqQBZjeuHLXa15f4UiIS8gkDBGQ9SvgbfID2RZZxmlWhG
	ecbdwVWdIFnGvm+Iyv8LJRhfdu+waKVClmi3DCcQ1CA==
X-Received: by 2002:a05:6512:3e07:b0:5b6:10bc:dc46 with SMTP id
 2adb3069b0e04-5b610bcdcefmr604327e87.29.1788439381082; Thu, 03 Sep 2026
 05:43:01 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 05:42:59 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 3 Sep 2026 05:42:58 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <aplfrNXzNvgbMJf1@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821070651.39763-1-vaknins33@gmail.com> <178827844334.39529.382963115769227795.b4-ty@oss.qualcomm.com>
 <aplfrNXzNvgbMJf1@ashevche-desk.local>
Date: Thu, 3 Sep 2026 05:42:58 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mck+ft9wmWQLcq4uFTvH9u_rB_bFQ6tGtG7YkYdbowJaw@mail.gmail.com>
X-Gm-Features: AcwNN1WJs57t_o6KckC2mhjZxrGSza3_cvZkypNljGQrIWUv_ioLQdYmRwBlG6E
Message-ID: <CAMRc=Mck+ft9wmWQLcq4uFTvH9u_rB_bFQ6tGtG7YkYdbowJaw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, Kivan <vaknins33@gmail.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Mario Limonciello <mario.limonciello@amd.com>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Hans de Goede <hansg@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 3 Sep 2026 13:53:16 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Tue, Sep 01, 2026 at 06:00:46PM +0200, Bartosz Golaszewski wrote:
>>
>> On Fri, 21 Aug 2026 10:06:50 +0300, Kivan wrote:
>> > The ASUS ZenBook UX425UA_UM425UA (with AMD Ryzen 7 5700U SoC) fails
>> > to stay suspended in s2idle (Modern Standby), prematurely waking
>> > after 1-3 seconds with 0% hardware sleep achieved.
>> >
>> > In the laptop's ACPI SSDT tables (SSDT15), GPIO Pin 24 (hex 0x18) is
>> > defined in _AEI as ExclusiveAndWake targeting the PCIe bridge device
>> > \_SB.PCI0.GPP3:
>
> [...]
>
>> Applied, thanks!
>>
>> [1/1] gpiolib: acpi: Add ignore_wake quirk for ASUS ZenBook UX425UA_UM425UA
>>       https://git.kernel.org/brgl/c/1900b5a41493e7050c68c1e62780d6fb9a209457
>
> I thought I am going to pick this up via my tree...
> But okay, not a big deal, I don't expect any conflict in that area.
>

Oops, sorry. If any conflict does occur let me know, I can revert it or we can
fix it in tree.

Bartosz

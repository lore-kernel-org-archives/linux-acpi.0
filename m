Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C10A45C70A
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141225; cv=none; b=uI8C5Liq/gdNSr50YaOkGBCmBFpzQ6lbu7ViJGhokH6UtOH+tyxKXYO+9jVxSTyWCgOa2N/m8VZH3FZff4QZfri5qJp31bia4N6rsl1hcku+88RnVkreX7qqHu37rj1AFY7h4xjI/mxdHlw3Lk33MBrmwMJMPNkTX9zepxTWNZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141225; c=relaxed/simple;
	bh=5pGWd8qCiqF0I4nI+EOmimC6BrkF2ULgfPT5HjdfE1w=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pj03BG7VrqE+6FtQZmdq3XF7oRFOb9WlKC191bqGctUM66qquI6DcjlX+3s0iWEzxLzUm0OxR3tAfN2r77lYJoPSQl60C4iSp5ORc1WrM3uKMWsKf2fVlS/uB5W0ySAfTbUVUo+i2QTu4Nk5v0THX5S82AX3sIBdwrjEahFUYjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8jOSXmx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8jOSXmx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D0921F000C8
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 09:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792141224;
	bh=5pGWd8qCiqF0I4nI+EOmimC6BrkF2ULgfPT5HjdfE1w=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=i8jOSXmx+Cn8Aj0D+6I+bwpijN6ojTaZnmdpdmpPSyYa5CHM9Zcd8GY9Oaw7nIpWY
	 ufrHsxcSbQVYVUsvE5ERXBTPQPNxyarTGiLvxp2k+HzdqrW5xqj+sHtQ8hi+AQljtW
	 7IMRqj6eeIgd11nMEUTEjuasYu6sb/Ad1fPPfLkVPybHO2EBNe24iDXxo+bod/mxS9
	 7WdfJZGE9bmvBosU2qjA5ao05eFEDfpYgcBAKYVGp6N93Iar6cIBh3GSSA2NC0OE+9
	 PQ2Uy9fHhE0z9CdopNHK05pcG3maB9uKxeLpEq7vIiTzRYr1Ghql/hVvekr4t1rPUe
	 D0IOmTjtMkDXg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a9841363b5so52845351fa.2
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 02:00:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzXUMp++Ri0eVBq3nPgfIt/WK2ss2j+1dOXaJnRQ09A4QLLD7pRGt91hGO1dRMSTsS16aiZF7JBYefG@vger.kernel.org
X-Gm-Message-State: AFq9FYKB/WmEyqpWxAPFgy0WCvyvNqejkSe/jg+0mSTxsZolaGIb4GZV
	iUFXoGNpI0HJUIpxDC7LDEZH3xpZ8dqOFU43wirAYd2iwAUOOWcm1OY+tmKSPI1n6WfrQ+qXAoy
	SrMjWn8+4Ad2xc5in3A5MdcDeb3Zvj+vgUJzSq6uE8g==
X-Received: by 2002:a05:651c:2113:b0:3a9:6f4d:b345 with SMTP id
 38308e7fff4ca-3a9c53b2d41mr51439991fa.14.1792141223088; Fri, 16 Oct 2026
 02:00:23 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:00:21 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:00:21 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <atEur_R_jFnlsZYU@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261015193924.4081906-1-mario.limonciello@amd.com> <atEur_R_jFnlsZYU@ashevche-desk.local>
Date: Fri, 16 Oct 2026 05:00:21 -0400
X-Gmail-Original-Message-ID: <CAMRc=Mdr+Kk_SRA4r-uPg50yne+1D8tJG+KQx0HAfRTX2ocBBQ@mail.gmail.com>
X-Gm-Features: AclHuK-_qNhQiMeTjXcDLNppPJhpgw3zBpeRo8eNpBflVYPIx9jAl_2MfPCY95E
Message-ID: <CAMRc=Mdr+Kk_SRA4r-uPg50yne+1D8tJG+KQx0HAfRTX2ocBBQ@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on ThinkPad L13
 Gen 2a
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: westeri@kernel.org, linusw@kernel.org, brgl@kernel.org, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, Nikodem Sanecki <nikodemsanecki@gmail.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Mario Limonciello <mario.limonciello@amd.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Oct 2026 21:51:11 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Thu, Oct 15, 2026 at 02:39:21PM -0500, Mario Limonciello wrote:
>> The ThinkPad L13 Gen 2a firmware declares GPIO 11 as an edge-triggered
>> interrupt in _AEI, but the EC uses the same GPIO as an output to drive the
>> Caps Lock LED.
>>
>> When gpiolib registers the ACPI event, the pin is configured as an input and
>> firmware writes can no longer control the LED.
>>
>> Add a DMI quirk to ignore the erroneous interrupt declaration automatically.
>
> Bart, if you are still okay, you can add this to your fixes branch.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> Otherwise I handle it after v7.4-rc1 in a normal way.
>

Ah, dang it, I already sent out my final PR with fixes. I'll queue it and
send it with some more upcoming fixes next week.

Bart

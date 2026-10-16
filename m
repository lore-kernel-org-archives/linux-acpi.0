Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F5A3BE146
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 09:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141336; cv=none; b=VP0mtHZfvVkpOPw841LjxRlGOm4jlz0T2DhzQSQqvgssLFJwqdIxXTO+i1+UUqqEEs2GX97J6D4tPOWZpUX+co5ItLAMz/FNLjxasIjvosaWhqUD/MS0wqB+VWnst5BAuGvdCDsLqT/Pd1mKSth0+1jM11BD37jjHzxw6r7QtpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141336; c=relaxed/simple;
	bh=eOps8TEcAjAF4fVwBR5xFTjIImrCuU78zcWSRFmuzYg=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E4MCb/tR8kJjoW7zJDZPXu/l/ee2Ib2h8GKA90IBxbAULsZw4nQ/WdhvCnwsU32cEItyhCwvsvItokKWgKMioE93uTHHHR9nkVllHXrzlAil7m3r46m9jVDTVlXW9DKDMZzMn5p53JOCUjOxFPkZf9rU3sAZ2HwRxh8RvXpXOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g90tNsX6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g90tNsX6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4CE51F000C6
	for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 09:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792141333;
	bh=eOps8TEcAjAF4fVwBR5xFTjIImrCuU78zcWSRFmuzYg=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=g90tNsX6Te04keZgoa9HYbn3j5Md94xnGBO5hJe2tC7KHUKlo16Pm2OzU7ZYQT4X4
	 YDNRyA5jgtV6nE1R31E0PFpTaCKfIkz1XG3ZTIVvV9aizby9L3AYtdr1f3qolNPkyg
	 uihF75OfllMu89NHb/QhDFBVD2Si8cvlhFloFuF2qznWUAArexBEyLM5vYLgJTt6WN
	 6szK62ogLF60w57ge387D6PemUfFbJI6SW1+wRA+YflGuXN8vqgRoo+63GrGbGUmhm
	 VtRVUmUX71333WVcnS/0lvaFU71XRqzKvgzV4WqqBqq+88T5ieUcl8AXPJ48kvlyQF
	 tsdBEFJprk8pQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b8b3c8c4bbso854953e87.0
        for <linux-acpi@vger.kernel.org>; Fri, 16 Oct 2026 02:02:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxd/TXi23IUxRYLvHCE41W/eA0plUwxipe3Va+0inJwa1jbWyyo3Mbac8rWUCIK1y6yAHn2qkAJdqjz@vger.kernel.org
X-Gm-Message-State: AFq9FYJd7tAe0bNyPjo/eEafQWpJRgHWZOTdsxAquINDFfshtt6Psy0W
	y489u1WmQz+hg4ZTu9IP7DW224OqjYIxUHMbev+C4Y1wo04QIqB+CGYo6EDRN2xqsr4/LBij0Yk
	bNPDxELGa9aVqIfFV3nzaLiDEUkMr+SiDHJOOlohkfg==
X-Received: by 2002:a05:6512:1281:b0:5bc:ec72:4edf with SMTP id
 2adb3069b0e04-5be475c279dmr881533e87.11.1792141332643; Fri, 16 Oct 2026
 02:02:12 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:02:11 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 16 Oct 2026 05:02:11 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261016052602.GU176164@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261007120944.1705014-1-abduvaliy.hbai@gmail.com> <20261016052602.GU176164@black.igk.intel.com>
Date: Fri, 16 Oct 2026 05:02:11 -0400
X-Gmail-Original-Message-ID: <CAMRc=MdgwgA_h0mHzQ_Jd4hQYe0Z_zFWYE+T441Cc_kCRLFAbw@mail.gmail.com>
X-Gm-Features: AclHuK9XlRqP8JQi1UUbszfSw3iq5yqO7rBpRtzc4klSoojWaTN54G9nP2vb4-g
Message-ID: <CAMRc=MdgwgA_h0mHzQ_Jd4hQYe0Z_zFWYE+T441Cc_kCRLFAbw@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: acpi: Ignore GPIO 11 interrupt on Acer Nitro 16S AI
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org, 
	Trijan Koju <trijankoju11@gmail.com>, Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 16 Oct 2026 07:26:02 +0200, Mika Westerberg
<mika.westerberg@linux.intel.com> said:
> On Wed, Oct 07, 2026 at 05:09:44PM +0500, Abduvaliy Abdulazizov wrote:
>> The Acer Nitro 16S AI (AN16S-61) has the same problem as the Acer Nitro
>> V 16S AI: the firmware powers the internal USB camera (0408:4059)
>> through GPIO 11 of AMDI0030, but also lists that pin in _AEI. Requesting
>> it as an input cuts the power, so the camera never enumerates. On this
>> model the same rail also powers the internal microphones, so they do
>> not work either.
>>
>> Booting with gpiolib_acpi.ignore_interrupt=AMDI0030:00@11 fixes both
>> the camera and the microphones. Add a DMI quirk for this family too.
>>
>> Tested-by: Trijan Koju <trijankoju11@gmail.com>
>> Assisted-by: LLM
>> Signed-off-by: Abduvaliy Abdulazizov <abduvaliy.hbai@gmail.com>
>
> Acked-by: Mika Westerberg <westeri@kernel.org>
>

Andy, Mika: do you want me to queue this as well for next week's fixes PR to
Linus?

Bartosz

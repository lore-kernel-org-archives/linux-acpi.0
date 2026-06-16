Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB8D3B71DA
	for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2026 10:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781606558; cv=none; b=L65vVzxJYvDSYDoLVcnR79ctavNWKu8G9b4F/qaIyhi11cYkrBpwzuiQ9cQVjpjShrSyUk9sAwlmAMOuYfPCI5X4o8D4rWyBXPJD5ZDP3lfkoXoI6sp3ZgfZIYBxHq/WF53c77fl0N+vmLaO+TZT6Nn2TwgtqPxDdCvihrg0XPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781606558; c=relaxed/simple;
	bh=seETpt2kezGJcbg8U+oSpAtCcLCqtzh87l64TU0kPBc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bLRCbCvxYn+sa+s8uwLse17KVRfoL6rbi2qKHXjANRYxwPm7/HqqBWfb+Wlp91oeFVyBI+uikFe7iLhB1SgKzf6mg5ViYjLJPgoMRLLTAOC2eq9WQOc+IzW5BcO2hZuGKRWbY1D/Yv1Ok0QXk2Zk8gvHgA3CW3UB6u+wggIxqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfEVxasD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfEVxasD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17E431F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2026 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781606557;
	bh=seETpt2kezGJcbg8U+oSpAtCcLCqtzh87l64TU0kPBc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=DfEVxasD0DCyUyT2QktKXNWzNNiA2tqVaLgtLiWbUFttfItL5Emjx7Xi+emEezaKe
	 iiTuf0/6ID2Z5qGxhn/ftKFyBkGiwUjyyaYdIXI21llpFCSf9fgYnwgGPAXKRlvw0I
	 DP1f8pZsSJ561BvzjrLjtiQ8qQk5nY9Cb1cSeKXSdAnEvIQwufAc4nMz3X1SJ1IfhI
	 yPYqtyo9Fb0bkzUqjXDYUn36t9QnKkEMt/KdKYy+Bj5W6X4g43kaylZvyUdW14fq2L
	 xxkf2yiXeKlqPX0psKnvcBUJk/AzETnRAxiOo7Ci0ZSQpen62Hp9VwCCPIEVSF+j3D
	 hhPaq7HChtrDg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa68dbb38aso3937730e87.2
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2026 03:42:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9797HqojBDsxeyLrIuYpN6VcBk5JS081aOMcPGMyLdOgq6axcstL091v56l1qtidkBk8OEgLz+1Wb6@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5wqPRjBEudTORemS8N60XgJw6qgo9fuInslqAkHETRrQ/ClI0
	O8ypxmvAHQ1sFqYPT0QWZJdC/fw/clYKBiJHYWLWVrgGy7Km0bEnScMOPgBSB2GBDbElVczoYvh
	OiVZMgRVr7Y0570vJa/AxLju7MlIZK2j/4EKeb4iaYA==
X-Received: by 2002:a05:6512:60e:10b0:5aa:6e01:ff81 with SMTP id
 2adb3069b0e04-5ad4373d037mr711961e87.24.1781606555874; Tue, 16 Jun 2026
 03:42:35 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 06:42:34 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 06:42:34 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <ajEkvstS6RgRTATK@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610154204.110379-1-scardracs@disroot.org>
 <20260612085257.GY2990@black.igk.intel.com> <CAMRc=Mcv7SWVYA6rNZo+-tYx_ohOdedkewLZOa=X1Eei=1fTzA@mail.gmail.com>
 <ajEkvstS6RgRTATK@ashevche-desk.local>
Date: Tue, 16 Jun 2026 06:42:34 -0400
X-Gmail-Original-Message-ID: <CAMRc=MeKdP46ohf=hJQRo=afe8WhTQ5yo+Zu3f34h-E4BiuSmQ@mail.gmail.com>
X-Gm-Features: AVVi8CeC8o3SWpSd_7aERe1gvbHhdS522V8qkkpr6gW-7r4k9LxDWgtrZHM8J8Q
Message-ID: <CAMRc=MeKdP46ohf=hJQRo=afe8WhTQ5yo+Zu3f34h-E4BiuSmQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] gpiolib: acpi: Add robust bounds-checking and safe
 address handling
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Mika Westerberg <westeri@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Marco Scardovi <scardracs@disroot.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Jun 2026 12:26:06 +0200, Andy Shevchenko
<andriy.shevchenko@linux.intel.com> said:
> On Tue, Jun 16, 2026 at 02:54:02AM -0700, Bartosz Golaszewski wrote:
>> On Fri, 12 Jun 2026 10:52:57 +0200, Mika Westerberg
>> <mika.westerberg@linux.intel.com> said:
>> > On Wed, Jun 10, 2026 at 05:42:02PM +0200, Marco Scardovi wrote:
>> >>
>> >> The series adds explicit bounds checking for GPIO pin accesses and
>> >> ensures safe handling of ACPI addresses in OperationRegion handlers,
>> >> without referring to truncation or wrap-around behavior, which does
>> >> not apply.
>> >
>> > I'm fine with these now.
>> >
>> > For both,
>> >
>> > Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>
>> Andy, Mika: do you want me to queue these directly for v7.2?
>
> I believe there is no hurry, but I have no objections if you pull it in.
>

Your call, if you thknk these should wait until v7.3, I'll leave them for now.

Bart

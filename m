Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D45CC41C318
	for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2026 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603646; cv=none; b=UOdaLh2QJnk2uZDU6bvWdMjqJHlkGb9luqQYDKMqQ9bU1J41gfNZjmolz1q/OK8vmyKbjAJkywV+T6ZH9j6CdaDwWDHpDOdCjbEeeGOlgqd7SyMZk2AO4NLr3eRF3dGViJsfApqcThhLtiVBADlKPtsPInaalCtCbIzN5ZDDNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603646; c=relaxed/simple;
	bh=+URwGBoKKQopuhgwzkoaWddBJJZzAiMnIIQn74OaPNo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKBihaomLzzbTuJt0uft9jyuq2G7Yp8gKkJx1BhzvjII31ex66A7etj169cv7NXf1lAIiDzaOXYAQdoHKwE4AM3D5fhvDp3yxN8SJR02OmnNYNKTHMygUEGxMpvQN5B9Bh4SS4UGPRQDUyLavIwTZM6rksUymgYdQJjQbxnWFdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ns/tzrJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ns/tzrJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D631F00A3E
	for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2026 09:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781603645;
	bh=+URwGBoKKQopuhgwzkoaWddBJJZzAiMnIIQn74OaPNo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=Ns/tzrJpIglOiySBTbQdfr0f6rZR2z+BRM84629Fi0M9YFE8eUzX+UviGviW4mnyW
	 +LK6V7Q+ZsA3D4peLthUK8hWS6+MKP25gzeR1VRCnky8pj7h5GHL41J5S0BWvyHXK7
	 2BhesK0GP1nhcuSaKSRD9F3uQnwV0mzkIMv0rhco+hnK/lEHADi4wG3b4t+XrZ1mO4
	 B56J4+hk4af/FedqGCN0Lcruq5lL8olhq4jTyDNWDPnmQzm28gkAYP0C/kOEy9BgAm
	 J0ThWvyPswrGkjdfz7Rf91e0VmgWqJQEds1DHcAse4p+kQbRoBvLQ2naMdu0I75/C7
	 XYq7OLo+7pQFA==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5ad0abf1f7bso3283274e87.3
        for <linux-acpi@vger.kernel.org>; Tue, 16 Jun 2026 02:54:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+ZhSMtUXA8xtaNKKZkRtyv0nUBhBiuZ/N6Xv/aV/DtWYkBsGXFa1uhSupcfDWdli1Sb2DvWnSiPQfS@vger.kernel.org
X-Gm-Message-State: AOJu0YzXEWQuUCj21zBYzgyV7oTeGWAsc4vwqNIT4Yqmx38vYrOMhYzS
	ZDaFip/yvu+dgPhsHjMEslMXVJX9BM9MpZZAP/NUARjxAHMqE0xzN099X4AbEsz4tWYRg0ljvSG
	CVnk1AS5qhp3QXEgTd9IdkYLBHF556NPvlRd1EIN9yA==
X-Received: by 2002:ac2:52b9:0:b0:5aa:77e2:51b0 with SMTP id
 2adb3069b0e04-5ad43730740mr629116e87.45.1781603644454; Tue, 16 Jun 2026
 02:54:04 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 02:54:02 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 16 Jun 2026 02:54:02 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260612085257.GY2990@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610154204.110379-1-scardracs@disroot.org> <20260612085257.GY2990@black.igk.intel.com>
Date: Tue, 16 Jun 2026 02:54:02 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mcv7SWVYA6rNZo+-tYx_ohOdedkewLZOa=X1Eei=1fTzA@mail.gmail.com>
X-Gm-Features: AVVi8Cf8SX-PFW9ubAlWfGkrgV7gQ9a14lXvOtYxhpfIKCXMWl99SlqnsWEeRzY
Message-ID: <CAMRc=Mcv7SWVYA6rNZo+-tYx_ohOdedkewLZOa=X1Eei=1fTzA@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] gpiolib: acpi: Add robust bounds-checking and safe
 address handling
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Marco Scardovi <scardracs@disroot.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Jun 2026 10:52:57 +0200, Mika Westerberg
<mika.westerberg@linux.intel.com> said:
> Hi,
>
> On Wed, Jun 10, 2026 at 05:42:02PM +0200, Marco Scardovi wrote:
>> Hi all,
>>
>> The series adds explicit bounds checking for GPIO pin accesses and
>> ensures safe handling of ACPI addresses in OperationRegion handlers,
>> without referring to truncation or wrap-around behavior, which does
>> not apply.
>
> I'm fine with these now.
>
> For both,
>
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>

Andy, Mika: do you want me to queue these directly for v7.2?

Bart

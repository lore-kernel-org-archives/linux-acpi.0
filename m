Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D633C3A9629
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775223865; cv=none; b=R1wgGsE15aiQUAXi0PFw9T0IewVFHrCzuAk06FMWmXD/ifc+FGc6YUt3nm2ETCb/XkKwYjE4iI4WEHBX8KemaBD+Y7rZAniEloIitzVv4DM7GeO1z2XF1iBgT9ZOl9VZn0uk71PyDfcdqGsic420nLY16Eo0a8WPvCFimIDykp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775223865; c=relaxed/simple;
	bh=6t5r9418LvagyoUOMjuFHRfkHnMedtZ6I0B3/J6r/BU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bpQC0/RC8Mgwq1TxkTREgyO0xinIWZsDUATyAG+3JGfHudBW08XxMPUk4r+TMjlraB8VbZEcph+4TkvcIas68oAYuOOgqspHaDE+o0hx+kr1I3c8wvQ3joXkIGg7uTyvy2arCM+2UgX2xLwIjdtwuX4DLf50pms99LlNaO9bRZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yf+Sa9Lp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yf+Sa9Lp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8BCBC2BCB3
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 13:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775223865;
	bh=6t5r9418LvagyoUOMjuFHRfkHnMedtZ6I0B3/J6r/BU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Yf+Sa9LpqjE5bQSyUilcDzH2Q24BcWkdBkfOQhXrhqGm4Bk4rEwF7mimZ64dco9xm
	 KNwsG/DhnzWsgl2gSmKDF1fl+4yIhYdMCNOuFRgthtCkOEbXme/chZCowT3Rpi3UdL
	 qDm5b7MUc/m6ifExnIWtHHfrW8yv3onh7ac31YGoCAT8I2q3jC8/soMoUX6p/VYI0m
	 82WiNn5xczOPjUuEvkiFYsjijVlKbOtI7kAXCY+QvC3TIJAuFg3JLQ+1+w5rbUFXXu
	 LqVMqlcW7+FTgWJofB81sZwLt8SLiglizQ8QnYa3EuA/+zosJFpwjz5pm5gF2aA/WS
	 +En24+/iFiv9Q==
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12a71ade78cso2269715c88.0
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2026 06:44:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW07oJUn/VDOSKnaMEyGk3DOYWPbsQIlf4TZfzTslCJgCgHqF7lmcjpgCuUQuh8ehTO1Rbrkhd7M2qc@vger.kernel.org
X-Gm-Message-State: AOJu0YyZdlz5bNjEy81DbuoYg+X5k53lMbD8bEuDvqenMNvjGzKXlYGl
	M12H0YXGDRxU7RN18D82eQcgmFBdd/MRWeGs4rn7BBg0ZJdThyB8ixj7trjJYLXa6OOmpvLU4ao
	xUzNZ7J+P75fFD30G40j5/JT/8Px6CQ2sW6tW3bjBtg==
X-Received: by 2002:a05:7022:b81:b0:119:e55a:9c03 with SMTP id
 a92af1059eb24-12bfb765d17mr1120319c88.31.1775223864867; Fri, 03 Apr 2026
 06:44:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
 <20260402-baytrail-real-swnode-v2-2-6f5054a4cc07@oss.qualcomm.com> <ac7ZA6HJFBhyCROM@google.com>
In-Reply-To: <ac7ZA6HJFBhyCROM@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 3 Apr 2026 15:44:05 +0200
X-Gmail-Original-Message-ID: <CAMRc=McaXJbjy04gwyZmszdPs_4RW4WLrU0X6X6wuqKbm_mj1Q@mail.gmail.com>
X-Gm-Features: AQROBzBvZ243TFYFU14BrtTCsxbTjeeOTP888iqw5ZnYmqyZQD-y8m0ypGLIgFE
Message-ID: <CAMRc=McaXJbjy04gwyZmszdPs_4RW4WLrU0X6X6wuqKbm_mj1Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] gpio: swnode: defer probe on references to
 unregistered software nodes
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 11:04=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> You need to change that to
>
>         if (ret =3D=3D 0 || ret =3D=3D -ENXIO)
>                 break;
>
> because if we get -ENXIO that means the GPIO must be there (the property
> exists) but not ready yet and we do not want to fall back to another
> suffix.
>

I'm wondering if we should make this check even stricter and only
continue on -ENOENT - which means: there is no such property - and
bail out on other errors.

But that would be a separate change.

Bart

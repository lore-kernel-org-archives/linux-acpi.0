Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52A32C08D0
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 21:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775165581; cv=pass; b=aAwYKzzZuHaGVBNw/nwoiTbX3ZhuUtocbdXFmWF0bRPwdrIVSNWM07YMdh1Jn2fgAEGkJrhLpx0z3YmTkwHl2m+Hyh2ru0fUxT4MJBlV7NQnFa4IbGp9s/UD3St0SrOIy4KJQEJpn5eOaK3szUkgoMHT38yE4eg+oEH/hqUwEDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775165581; c=relaxed/simple;
	bh=I/iSptK1BbUczXUEXqn8QfJWGkzsfP/xsuvtoUZvNf8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hqg81vmepmHeDZkhm+eJhxWURl3H6vByFpjgidl7/3wwqjXvRNlkRF2MpqASfhoffTD7ZX2spGpVZu9+seQnJTciDcK/nBNLcYvaZrIe+3N7t9rFVqScB7Pybi7fNV4BdYPX2/zKRGbtnyO/4xFInDrN1K1swDJ98JMO69Zn7uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me; spf=none smtp.mailfrom=joyfullee.me; dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b=Y3g/Tk1i; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=joyfullee.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=joyfullee-me.20251104.gappssmtp.com header.i=@joyfullee-me.20251104.gappssmtp.com header.b="Y3g/Tk1i"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b93698bb57aso279204766b.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 14:32:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775165578; cv=none;
        d=google.com; s=arc-20240605;
        b=DWVgM0Nqf4DMssCbCJWesNYM7EfELZI3uxuYxMSnw1iQas08EGbKNI/thSI91DJQXI
         9SmYAXnfQ19jL7mxvXaygytYEu3lkAf2b6/zVCnCGP5tCPnRa4G7Byel2SvzM3vZGMpU
         JBBn4dA+7TyerU3UyPiVARoYS3I8+ZJ9+Wh0qTS9Tx+Ams9QFyCiRBHt4yRNjVRkU8QW
         4N5BH55tpOvoxLjTkbFrN/7G8jOtTE9/ADISYwoTsQd87SrGiZunQJ/OuYtwd05++yt/
         9TVQkhxX2XBR25KBSMs0ikwX8ldayWskDkdA9ypquzG/BlG6xNxYCxUcIuKPwsGIE4ry
         Xscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MqhKLfahGrgncfeqRqjGzkN2toMZpIx78EgbNIy9990=;
        fh=dD0Db3BSIiL50eg90zEhHKb5zdIvAfZkHhz2H5lu1FA=;
        b=fh3UQBQrkB1NsrFeOGgLSFIj9eCpXpa8OYjT4E5bnenZYykIbHXlAkHCJr6ZOw8M38
         4no9gStC/glFv5Dq9lfhvB4KHxQfk3sVLUPhc2QWC+vu8iRSe6aH5hLkzTK4XgWJUPIh
         QOSNlha1S1g/I9ILHUayndlnCozIx8HLXDwOkY6EMAh7mEKErsI2Vqr/hGvC0WM0RdFg
         f4KFL9v7rN6SNRM3Q9kktdduj5wJRPt2KNxOBdGIayVSaZAZUVc+3wiP2LEQmVFilOxu
         QQQGhA71vREoIxeKZvm5IvAcFo067KerTrfG5OpgmU2swGa3bgzfiK8ABUIUI27xDJW7
         jMsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joyfullee-me.20251104.gappssmtp.com; s=20251104; t=1775165578; x=1775770378; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MqhKLfahGrgncfeqRqjGzkN2toMZpIx78EgbNIy9990=;
        b=Y3g/Tk1ikpTnBZMua7iRJ/SWoOLit1ReMbdLFKM5atwJ/oKYRqbwhsNcL6l2Iwvwkg
         v6br7WZz20V1BT2d5zP/5kjBXRfGwwyvmpy/UPjOTktHDmoYgWY23LY8Nbf9fuYBcrPF
         MWy3ZTYxPwooaDyoyBsPrQhJJN7gD+83YffopURCxET1dOdR2qjX+GlXikwM7ESKMG4W
         6KXE+e+00GaW9K7A3hfwviqEEfhyPj8tK47EwQa+rMuS0TMfg0JZVXYuKDp6mj3BrkFR
         MXQIkCoPQoGMIoqe8xzt2tCfzhrcrGQAx4nNEO5989EJBMMQ1TCyS+L6vPpVH6D7HBYt
         l7Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775165578; x=1775770378;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MqhKLfahGrgncfeqRqjGzkN2toMZpIx78EgbNIy9990=;
        b=mvwkfFS6gTmqo8T0i0Ghf2jRTIKoyWxT8iPKY0Sd1giBJFPHaVDqp34X1f+tKpfR6f
         uyAznsBgHbnuy/FqIQmQdLnoSETrNa1WhoKS1uxOMvG3vGw4wZzyx3jcYIa93b6E40PQ
         6LyHRdVyQoZlQ2yGsd5tDRwu9RJyTDNrvK57q31dLisiYKUnKacBVtiuf9xZ5XnbBbfO
         n1aBBsvIL1jdwy96nFw6VQrCLLfe8eB+tHPJoIjVkJLOMvGBjQoA6oWd4ZUCNXZ0c0qJ
         AGg8tIXu7Y2dbHow7bLqoigl+cQ+KGd5vnVOYkeLtaEaKY0kilh9CuXywdyACFLOhTlN
         2zOA==
X-Forwarded-Encrypted: i=1; AJvYcCWI3PUo7MWX4PO/ggf7s7/E1jpZHmM5m7CTc0vwwLZEKVWRF9oij+Wm5lH8K69qiKo3jeh6Fy2ittv1@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ1+yDAatHVFcPDBuGJi/vYMKYUzSLvklYk4yKW91XBQOQI9Wn
	ivLI2KQtejZTnXjyckGMUWFmLNK80AP9DqaagainVTBrJHiHtL8vDJsUvbNKSsIqVt4355wW/HT
	j9D/pY/T2+Wy/PVIXycSiIJqW+ESf0ztQY11ailP3ug==
X-Gm-Gg: AeBDietmYXcf6aTf8gc83TYGzUzK/998Wh+GeG6sN+cZREm1XdpEc28GWDtT/Tvi28M
	2Iyj5yhFGkCcoyvyEyZJELqA7BXVtoaS4uraO7tsi12+w65PdaL5uNC4pGXiRPq4SOa39uSgeW5
	rNJ3UR1sAzZZ1b0P6lOkCKdtQRH8xZBF5QhO4oGOanmZt1IRgK4RS2oEsyDEENi84UmYG5qeJIY
	y7qFZXIc+3HJ3C3v4+kaDPgMvm77AfneTrYWuYbg5CYI3q85JQ2S/p7RXKyFcaihR1aexYpDC8z
	+ZblAw==
X-Received: by 2002:a17:907:3f26:b0:b9b:6b86:66cb with SMTP id
 a640c23a62f3a-b9c46de6747mr174196666b.2.1775165578007; Thu, 02 Apr 2026
 14:32:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADj6jrgK+sRXoNaYH90Rdc8DYEFK2iSF4vkJC=KE4UaZ73y67A@mail.gmail.com>
 <a935b2e3-e11d-47ec-af47-7eb7e86a9dd0@amd.com> <CADj6jrgcuz=Bcp0q7BHVizVeF=C2r_8qXw7r0Mc5X9Vd8uWK-w@mail.gmail.com>
 <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com>
In-Reply-To: <4192851c-20d1-4185-9f63-32c66ed2a664@amd.com>
From: Joyful Lee <joy@joyfullee.me>
Date: Thu, 2 Apr 2026 17:32:47 -0400
X-Gm-Features: AQROBzARiAf_yZZwTk3-KCMyBYeIOnmMVmiItOYF1PDxghtRboGkZ851yyqqxZ4
Message-ID: <CADj6jrgse2NksUgkHUzTm0332ba4qnV=0QOJAnupS=Lr=5hh4A@mail.gmail.com>
Subject: Re: [BUG] ASUS ProArt PX13 HN7306WU: amd_pmc s2idle S0ix corrupts AMD
 1022:150b root port, NVIDIA dGPU returns header type 7f
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: platform-driver-x86@vger.kernel.org, 
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 5:14=E2=80=AFPM Mario Limonciello
<mario.limonciello@amd.com> wrote:
> Can you please explain what root port corruption means?  Are you
> actually meaning graphical corruption?
>
> A few things I want to point out after resume that might be relevant.
>
>  > pci 0000:c4:00.0: Unable to change power state from D0 to D0, device
> inaccessible
>  > snd_hda_intel 0000:c4:00.1: Unable to change power state from D3hot
> to D0, device inaccessible
>
> Both of these devices are part of the discrete GPU (VGA and Audio class
> endpoints).  So neither came back to the right state, which to me has me
> wondering if the EC is cutting a power rail used for the discrete GPU
> and it's coming back at the wrong time.
>
> It wouldn't be the first time that the kernel raced with firmware and los=
t.
>
> What happens if you pass a PCIe reset to the root port above them after
> resume?  Does it recover?

Corruption is just the best word I have to describe the way the dGPU
bridge (00:03.1) comes back in an unexpected state after resume and the
two devices under it (the NVIDIA GPU c4:00.0 and its audio device
c4:00.1) become unresponsive. The two lspci attachments on my original
post really demonstrate that weird state.

Indeed, the "Unable to change power state from D0/D3hot/D3cold to D0,
device inaccessible" messages are the main symptom of the problem. I'm
purposefully avoiding the nouveau and nvidia drivers at this point to
reduce confusion, but the problem happens even when they are loaded, and
both of them crash upon resume.

When I issue a reset to the root port after resume, it does not recover.
The kernel prints the "unable to change power state" messages again and
the devices remain unresponsive.

Joy

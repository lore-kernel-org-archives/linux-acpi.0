Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12C1280318
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 13:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775136938; cv=none; b=alpDCeHKC8iMValOrolJhEQiW2mo8Vrd8olkAhQ7e7XmzmRYAUDLSRBC96FC0NH9VKQr52yfpr2wKuyM7ZNTeiPA5T+qZi0wJr9KOAptVEToF426nyMcaaefWR2z7KUwyXY/0tZjzPHIzA9DUsTGQyOrnUemd+eB1/dvZwpOV9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775136938; c=relaxed/simple;
	bh=7uEYQL7HD9/Dkdn1yxfoKID/JvNmDVrxwOtZ1tVhHI4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jtdDWUgW0UvLb1DtSFcDs2+3UBTNk3X9Rr2NztwoVXT4Vl7M8MD40C3z759xQRQSMMs5oiMPa6GKdqXChzoJHRzmqnwdi1SJM4sDH3fVHiGXTB8Mi7ELpRuOGW2nMH8CXFH43WeJVQanqd+/GA2ni4E2WJAMr8H6sakUephH4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skcYctrt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skcYctrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C34C2BCB2
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 13:35:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775136937;
	bh=7uEYQL7HD9/Dkdn1yxfoKID/JvNmDVrxwOtZ1tVhHI4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=skcYctrt2MM7OmL1A3amxb8BYZSXVzPGIfr/zsQG8fia7FInDmSWGKVcub3pzmuDv
	 e6dt6GcuybRP1I73fCFh5+f0Im9WIOP6h4Dp/b6FPxNu0S1Yu1l46+DvLqV4JpGb/u
	 72XqO374H7fva6orAyRcK84YY6suMdGaPTY7KIzbPMFsoUKtoUls4lq3h0OS7gasc/
	 TpI1ibpGuq4lY8be3GtElSTR84ODNqDcMnc2LJPVFMyMQooK9OVgewRNxjH8LnjwVb
	 97FLY+e525bmUUrbSXYPzR1m8ClDRuiybmfsH81lhGBuikdSyU/KaxfMhjp2w0zDjC
	 uEDuq9FnBbWAQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-38bcda08c76so9086461fa.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 06:35:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWD3crSjQjEljJ7NsaNctpOmaLJRtBWqnwMuT3eNWcjd2Ko8Ync2Vt688iZEoVGtL205C/w++LMxYBV@vger.kernel.org
X-Gm-Message-State: AOJu0YxNjJGXUFODMMe2ciwm8zouiYWnGMGtXA3zCSOFHaTyBIXqznZ+
	u5DhR/acoj6qpVYJfHtIVcJk0Ud/ANLSO4JXE5gfroEhfpAwH7O2FydGs4Xqg6pVPCyvARC4SxM
	Un0LruZrYgJ+xNf8eNbV+CvE31M4CgqkX2oLZXG5CHA==
X-Received: by 2002:a05:651c:438e:20b0:38a:4de2:8807 with SMTP id
 38308e7fff4ca-38cc305253bmr23362071fa.18.1775136936479; Thu, 02 Apr 2026
 06:35:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com> <ac5t5XozmzN9oq96@ashevche-desk.local>
In-Reply-To: <ac5t5XozmzN9oq96@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Thu, 2 Apr 2026 15:35:24 +0200
X-Gmail-Original-Message-ID: <CAMRc=McR+S9LCHmDjAS6Wn=SrNvq5Ojr-w1qeLsGNJ+L39pbrw@mail.gmail.com>
X-Gm-Features: AQROBzCueRALrTZuDx_r_Y8DgGoZK4uCubDxSqHkQnTQ6s5JA8TFv9V9OgZrdQY
Message-ID: <CAMRc=McR+S9LCHmDjAS6Wn=SrNvq5Ojr-w1qeLsGNJ+L39pbrw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] platform/x86: x86-android-tablets: use real
 firmware node references with intel drivers
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 3:23=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > 3. Export the acpi_bus_type symbol. It's already available in the
> > acpi_bus.h header but it's not available to loadable modules.
>
> Nowadays we don't do that but export the dev_is_acpi() or something simil=
ar if
> it's not yet available and to_acpi_dev(). (Names are derived from the exi=
sting
> pattern, they might be need to be adjusted, dunno.) See how PNP does that=
.
> Note, I haven't read the patches yet, just a quick comment.
>

Maybe I should have said why I do it. It's to register a notifier call
on ACPI bus events. Is there a better way to do this?

Bart

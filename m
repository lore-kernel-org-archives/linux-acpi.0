Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89F47010B
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784661888; cv=none; b=kDmkde5T9hdhSLGGqfokOvBTKHwcfvAWurrMJzK8lWCMLbPVNek+poq8hG6aKY5DJlaFfgfZLLyNRBoqvAsI+D2zpi0BrvbONcn+GjAL3R+/u4iJ3XO3vadDQFAc2wbNya+tOIz6c/SXgIU939Ad0nb62xz5UWGj2CePEu/iyIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784661888; c=relaxed/simple;
	bh=U4bsANnF6FFsT/CI/M0lFNQsXCMrqrEKcDPLj90J5uc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ywa+1lMHSICrPAfdr2+g0xav4wXmu1kDlwjfcZHXlM19B1KWOytOda8HhlrTq0ryhzJsQ1Mll2z34M2dKixyrsimFAL/demETozEPmjCwG6FP5GAAATDfCioRPhjobVDyrKWkQHiyHUwlzKqIO+lkotbYRxHLUr9N1XyWlU+RH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U+UZxSXo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U+UZxSXo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 193EB1F00A3F
	for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 19:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784661887;
	bh=QfAiFp7amZnjZhNNGCC8NrE+kHPeXbZO+yUHu/d3V8A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=U+UZxSXoXOPzOWhspHmS5PpA4w26nx8DkFwa02goTNXnWaKVpt0fZw3hUxFij1CIJ
	 0yk+QXxjRKd6DJTp2OWe+BAck4VwBbV5H6b3sgM04sHcJrlyFizdcZTfD/wsiRrzlN
	 Pqtt3Rz4Qbem34oq6Dk0n7+00LF0+MwcxRC+K9LMmc3Etg+ys5N3MAQHGj2OcdnVg6
	 vVmgi/UheRc8XaUIwcrDWPNX4fAzLn5RyQdS+1eok/hjb1xNwj+t3yIl+JQSjxbQUo
	 7mbRkrMYwi/wRu30czK3HgE+TDhrjfdIFziVWPhjUN1cxSsGjkSYUz+9tNWUd7oGIB
	 aih6t8ULyjH3g==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b00d083818so4323669e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 21 Jul 2026 12:24:47 -0700 (PDT)
X-Gm-Message-State: AOJu0Ywr4b3Ek+mlhzCyjf0sX1y7mlObrwFlfTNYq3+SqWRZGVJ0RvlR
	1d8gE23+qXv9unYweTkeWFTA3dCiHf9yCjWhN+GNb6z9l8cGRRM0gLKPmIQn3rSEabpkHkaecIc
	/3ZXqxTDRJI39nGYiDX0egpWwWI6FFsQ=
X-Received: by 2002:a05:6512:3604:b0:5b1:4c14:9b21 with SMTP id
 2adb3069b0e04-5b2a9d068c7mr101835e87.29.1784661885533; Tue, 21 Jul 2026
 12:24:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717170951.1782863-1-andriy.shevchenko@linux.intel.com> <f017b09c-e82d-4523-8c45-22bee90c79fd@gmx.de>
In-Reply-To: <f017b09c-e82d-4523-8c45-22bee90c79fd@gmx.de>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 21 Jul 2026 21:24:32 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iMN4xy-DNm89A_-7aS551PRZZR0P-3FkHa5U8bsCX0JA@mail.gmail.com>
X-Gm-Features: AUfX_mxQ4LtefwWAC46q5TkNMi9PZ7rqF95CVs9iRZsHLkICqi5dg2sngdh2qL8
Message-ID: <CAJZ5v0iMN4xy-DNm89A_-7aS551PRZZR0P-3FkHa5U8bsCX0JA@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] ACPI: fan: Ad-hoc cleanups
To: Armin Wolf <W_Armin@gmx.de>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 18, 2026 at 1:02=E2=80=AFAM Armin Wolf <W_Armin@gmx.de> wrote:
>
> Am 17.07.26 um 19:08 schrieb Andy Shevchenko:
>
> > The main purpose of my work is to clean up always included linux/kconfi=
g.h.
> > But there is room to improve the drivers/acpi/fan.h. Hence this small s=
eries.
>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>
> >
> > Andy Shevchenko (2):
> >    ACPI: fan: Don't use "proxy" headers
> >    ACPI: fan: Update ACPI fan IDs to follow modern style
> >
> >   drivers/acpi/fan.h | 25 +++++++++++++------------
> >   1 file changed, 13 insertions(+), 12 deletions(-)

Applied as 7.3 material, thanks!

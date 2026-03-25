Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC9C2E612E
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774456340; cv=none; b=fpW9frgwfSH9Jd5exjtGTNMEsRRefp6uiFrRFxumSOCnEIwiy8qu5+hY8R0PX+3kjFyqHekA9eDTWG/VhOPzFx7G9v5tk95N+aP5OVOQj6hGGiEXh5p2SdGTUli2wpJr5zJrR7PXN0xBgvIqbjpmPutOoai7uAG68zGoPPapef4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774456340; c=relaxed/simple;
	bh=RVvX9WAFEhVtPt/A6m/VY4H8Dyul+fwHXOyz2qTZobU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XRPBkRQrJKdwH93NZwuKopx3DcCLqdlPOUDvGSul+zkHYgM59Lstg2PQxXaeL/+iN9jnTMiav83w/IZ+p6Jhn7N7pPHiQ1R7s0szP2brBkrWNgMhUgQm9iCWGDR73MWSw7LXz1L3pmSAzxzMD9PoRpgDBl9cX6VFajLUZvsgdvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ7jd3Ag; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ7jd3Ag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83972C2BCB0
	for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 16:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774456340;
	bh=RVvX9WAFEhVtPt/A6m/VY4H8Dyul+fwHXOyz2qTZobU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YJ7jd3AgPDXk4CTvnlEazfPFImawt7Lq7SGPu0mOdlLlXLNn0ePgNW8++8+/OiODa
	 1bLPVs85qTek8mz1EEu0hCecVPMLB66L/RkLgovRgU+8IocK0c9ZHJ67QSYMoTFwd3
	 KmNeLgVF6b98Vl0xeYrWwEJQxejSC11YESoX4wjctFQvRNv4GbrofwblciQif8mKHq
	 Z1Zm9ZWFrzigiv0aKAgXhn1lmLJovAMD7R3DjP2ogrJ61oKwaehADFS2OTIZFXbfNl
	 Iv8tA56CHKhSAdMKVf++gFIBGq0BWFTPn1CLxXAUliBA/9J+YVw+C5tmH07vsUTI2v
	 G65Z5uKzz/3rA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38bf85e4810so60891fa.2
        for <linux-acpi@vger.kernel.org>; Wed, 25 Mar 2026 09:32:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWh5WGIZyYrMJTLgAtnpWYoRtUshA0htmCtBQhuchpY7zBOCO13CepjIEF3ysxvn66g0vZmGtAz8WY+@vger.kernel.org
X-Gm-Message-State: AOJu0Ywsi9Sa8NWefzG82BarSMUTt2A7QFFK2J87uyxsQDR21S+FdX8P
	9MmdQwIFhI9RX6yVb9SY1yHvjLrlYoIx2UeVozU69wyLJMGFyqHy/RJGA/Fj/nXseab+tlA7RIP
	fesS6eat6Dc1AAUz5wAtJquwl0qyThG65sfClu5ttAg==
X-Received: by 2002:a2e:b2d5:0:b0:38b:fbb9:42d4 with SMTP id
 38308e7fff4ca-38c4309d2d3mr11873351fa.15.1774456339210; Wed, 25 Mar 2026
 09:32:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <acIV6xF8mY-8wd5e@google.com> <CAMRc=MdJ0U2_ZQ5rP0Vmbv7+-xurf9F+WOwD3LwV=n5Fx33U=Q@mail.gmail.com>
 <acK69OColNT7ViLf@google.com>
In-Reply-To: <acK69OColNT7ViLf@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 25 Mar 2026 17:32:06 +0100
X-Gmail-Original-Message-ID: <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
X-Gm-Features: AaiRm50GHVTur6F5-4XrKQWDOxA52-cQ_t38ZB5tAUrHvudHMO63OUlYKaGDlx4
Message-ID: <CAMRc=Mcw66QpjQt4+_JdMq9JiAY28hjzNHa24gfOCCXyie-uRQ@mail.gmail.com>
Subject: Re: [PATCH] software node: allow referencing software nodes by name
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Danilo Krummrich <dakr@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2026 at 8:30=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> Please post the reworked version so we can review all the details. My
> concern was that it relies on notifier chains to notify when devices
> get registered and unregistered, and instead of matching node names you
> now need to somehow match device instances and software node instances,
> which again likely is done based on some name. This just piles on
> complexity where a simpler solution would be sufficient.
>

I will post it. Hopefully before the end of the week. I want to cover
both OF nodes with paz00 as well as ACPI with android tablets. The
latter case will have to wait for devices because there's no way to
look up an ACPI node by name that I could idenfity (correct me if I'm
wrong).

> I think this approach also will give trouble when there are multiple
> users of GPIOs provided by the same gpiochip, in cases where users are
> split across multiple modules.
>

Do we have any such use-case? I haven't found any. If we do end up
running into this corner-case, it can still be done by centralizing
the software nodes in question. But maybe let's cross that bridge when
(and if) we get to it.

Bart

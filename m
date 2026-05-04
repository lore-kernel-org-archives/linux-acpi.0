Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA993A5449
	for <linux-acpi@vger.kernel.org>; Mon,  4 May 2026 11:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777892465; cv=none; b=UW0OF8ctnNiBUPG/aERhpY/7J3O2jigwTyEj0grkuz2Uh3nFZkG38KCwSRKgZgzOvKpatYhfvYgyl2qIMRPpcZoBr5fqXvqoB7rCxLhNdG4acubrxeseMewl/KJ81iqVRXYnYDKoOr23wHmsWD0biG9D1AJR4l+th2ybGX7IKIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777892465; c=relaxed/simple;
	bh=ouskFgDOEFnHYqrmvdT0v5kdL0uhmxU82mtpqCG5tqg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kUWKV1rimNYTAxT/mp56D39mb66s/8JPj+pOmKp1dfP/N9mz0d8Co6+Tzp9YCFq9o8zMYIJ9S9hrjy65rrFk9R7tt5FnjiqCPBKCIq7VsZxF3wos782AryMSej/LNuF6lcqF4jY7yOAZTeQBaSEOu5EMyG4uuQom/XeFsstQiB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GHmPvoc4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GHmPvoc4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45444C2BCF4
	for <linux-acpi@vger.kernel.org>; Mon,  4 May 2026 11:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777892465;
	bh=ouskFgDOEFnHYqrmvdT0v5kdL0uhmxU82mtpqCG5tqg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=GHmPvoc4lc62QgQ03zIFpSWvkjWnjJGT61bQQaSHDTwvXERIPEvbrH/cwcNC2798r
	 QSQAoR2ZNEs+sD5329CtrniL63ChDvyjWoajAQqzdTLrOoYCEKgvOB7v/GAi3/O7Ga
	 GCLf7WKfGUw6eqlMXN6CbIj5tKojz+N/WPitZQ3irno8rLCYGmEI39410tgPd+CGCC
	 5NOpameYINQhNc4hAeT6q28mf3WxNnSFRdax25hwOgC/NvAgbxJBVaXMPu8jK9WEWm
	 Sbkk+ItFGGam29vU8rjhcxblc0y6QPREXeWXpB+JNtxAbKKqORlZJcKEM9qF9CyY7w
	 DmkSOmB6+xcJw==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso4218108e87.3
        for <linux-acpi@vger.kernel.org>; Mon, 04 May 2026 04:01:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/WaVZTclk5fe2rpkXIOGGU86U3mMyVxz4PZ6iGdRRwWxkWtJLOlNLU9puebDc5tnIAXdsxH2rIi1V0@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7ZAngLCffbi4ZHRBIjb71KMZCmohiNOrLbjjapsscRUYr3if3
	YJ6cvmAQ04QBL0ommvgHDxk2FVVE2fkiGLNs4PP5if0bwuUY+k32xZ51nSQ2Fw2vOjuDyKg3e+A
	kgvX5W8nBCjHrJy6qVpP5S7H8dsWoGI7PqmAG4mrxmQ==
X-Received: by 2002:a05:6512:1588:b0:5a8:763c:ab87 with SMTP id
 2adb3069b0e04-5a8763caca9mr678854e87.24.1777892463756; Mon, 04 May 2026
 04:01:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260504-baytrail-real-swnode-v5-0-c7878b69e383@oss.qualcomm.com> <20260504-baytrail-real-swnode-v5-1-c7878b69e383@oss.qualcomm.com>
In-Reply-To: <20260504-baytrail-real-swnode-v5-1-c7878b69e383@oss.qualcomm.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 4 May 2026 13:00:52 +0200
X-Gmail-Original-Message-ID: <CAMRc=MekeGHdFNKdB9bxTOLHp+3eCH==ve9dhEwm890HzKYyfA@mail.gmail.com>
X-Gm-Features: AVHnY4L6wTAD8jRSt-eYWSlzfZvS1La2BhlvLMYMjtNMOHeofVqZ7Hnu9KJ4HIU
Message-ID: <CAMRc=MekeGHdFNKdB9bxTOLHp+3eCH==ve9dhEwm890HzKYyfA@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] ACPI: provide acpi_bus_find_device_by_name()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
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

On Mon, May 4, 2026 at 12:59=E2=80=AFPM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Provide a helper allowing to locate an ACPI device by its name.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

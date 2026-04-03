Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A937648F
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 07:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201392; cv=none; b=mHImeTXF6JIU1lrqo44RK1JMRR6Wg7Qp4nMWNPi3Ps272zYDruTod4CVHtGDfFMjTR68E51tAnXRJcQjhPXYR7GW1g7c/Oe7ovro8Rrxst7xxyybE7mcsyVxYhaCb2bDjKFvMasB73UnPzoiDyTOsydVGetyQ/oCxYa5zc5NOtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201392; c=relaxed/simple;
	bh=o+bZHsTAqtziXuBsNd+plTbXRxbHoO6NC5HHzgU3PU4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iuMlUu3RUXSOD4fOy4pz2KAaLDsbEyEkHqxxM1Ip0aZ5J5Z9MeEPtne6hbfn5bTcpBi7/YVZq/Han4SJrRJFfHnx1KL7xaGRNq/WMUUAiB5B9agpjsW+YtnzTseiA5cd81W/sn7WFmP3i7VD2AlrwZChB59GcaPcCRtFIHTriC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ufuE3aPG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ufuE3aPG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FF9C2BCC7
	for <linux-acpi@vger.kernel.org>; Fri,  3 Apr 2026 07:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775201391;
	bh=o+bZHsTAqtziXuBsNd+plTbXRxbHoO6NC5HHzgU3PU4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ufuE3aPGGnvRozgJelrUuR+95zug3LqzWGJlK/3JEpBBP2rD21IpOrQCkkZ/TwHgv
	 eDGPCaR7uV+RUHq63WzzHRu1al+HFhHwyPpIGo1fuDvxpKsDNvey9fq2fJRJR6gmG4
	 J3yGQkpZPuhN91xooONIt7qurzA3dHDlm/zYFEWWzeYyuVDN1jOrJX7Gi6XrSzQbOy
	 LtDnjlMTWhRo5O0utkp+eVHf0R54xF5OIfGqDcIYJoSYgGUTAlwzKvbAnjvIOyWik2
	 zdfKPrSHOoBNyiUjq7YkwOBI/1SqN8Aunqt5wKSRxed7Vng3frebRps4X8bJ2vQbPD
	 j0REPppOrJiMg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a2b636b944so1857696e87.1
        for <linux-acpi@vger.kernel.org>; Fri, 03 Apr 2026 00:29:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWAnwR0MH8jatMyIlS7nR5ygGecXkfLRuCGn+YOxbqGv6Iq6eRPmbBSIeWp5ri3IPQsiKDnKGh9vKWb@vger.kernel.org
X-Gm-Message-State: AOJu0YxOqPDPyXpljojFIZk6WPN61GMbEZl5XqdlL4/5EzzP6IKGjNTG
	S+KZpqSL6zf8Z/BYKTriDG2wbwv/vNvnQRscsPdGEJxbeTs4ceKUWks23njZ1FXpuxqpfCeqjrD
	sAL+oxee9/Mikff96q1hHMNXzNF1xeJe5bfpbbgBS+g==
X-Received: by 2002:a05:6512:b82:b0:5a2:c409:8ed3 with SMTP id
 2adb3069b0e04-5a3377823bcmr620861e87.40.1775201390408; Fri, 03 Apr 2026
 00:29:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
 <20260402-baytrail-real-swnode-v2-1-6f5054a4cc07@oss.qualcomm.com>
 <ac5wprh9vfTU5pGa@ashevche-desk.local> <ac7UqTsPC8yUooAR@google.com>
In-Reply-To: <ac7UqTsPC8yUooAR@google.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Fri, 3 Apr 2026 09:29:38 +0200
X-Gmail-Original-Message-ID: <CAMRc=Mcq-T=4fnGTWXzEBjfiPaZLGw4HVAuOm48v-5Uf++K5xg@mail.gmail.com>
X-Gm-Features: AQROBzCzQrtkyxRFQGk9CJN4liBRk5TYi19gtZVgUqX_Bqb_Om8xmXeCvKqn5jE
Message-ID: <CAMRc=Mcq-T=4fnGTWXzEBjfiPaZLGw4HVAuOm48v-5Uf++K5xg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] software node: return -ENXIO when referenced
 swnode is not registered yet
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Daniel Scally <djrscally@gmail.com>, 
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

On Thu, Apr 2, 2026 at 10:43=E2=80=AFPM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> On Thu, Apr 02, 2026 at 04:35:34PM +0300, Andy Shevchenko wrote:
> > On Thu, Apr 02, 2026 at 02:54:26PM +0200, Bartosz Golaszewski wrote:
> > > It's possible that at the time of resolving a reference to a remote
> > > software node, the node we know exists is not yet registered as a ful=
l
> > > firmware node. We currently return -ENOENT in this case but the same
> > > error code is also returned in some other cases, like the reference
> > > property with given name not existing in the property list of the loc=
al
> > > software node.
> > >
> > > It makes sense to let users know that we're dealing with an unregiste=
red
> > > software node so that they can defer probe - the situation is somewha=
t
> > > similar to there existing a firmware node to which no device is bound
> > > yet - which is valid grounds for probe deferral. To that end: use -EN=
XIO
> > > which stands for "No such device or address".
> >
> > This error code is also too generic to my taste. What about alternative=
(s)?
> > EADDRNOTAVAIL
> > ENOTCONN
> >
> > (The brief grep shows that the second one might suit slightly better th=
an the
> >  first one by existing use cases.)
>
> We are in the core of the driver core. Why not simply use -EPROBE_DEFER
> to which all users will resolve this error to and call it a day?
>

Because -EPROBE_DEFER only makes sense in probe() context, while
fwnode_get_reference_args() may be called in many other situations. I
think ENOTCONN as "not connected" makes sense, though the string
representation says: "Transport endpoint is not connected" which
doesn't spell out quite the same thing.

Bart

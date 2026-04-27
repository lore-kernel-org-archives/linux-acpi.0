Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9309530E0F1
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 11:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777289449; cv=none; b=CDiVAa6T3yxAkZJXCvpfVEL3hnSPDtWoo6q6qduedKEPEdzroS6QAMbT8xkUHBKXC2QsfEM8A9QVH9QD1lBrk/uTkIB1s55p7q6WeTnvKNTY95mBvKwszIfwDp78vHKOwfMFpCPez1KcnrKRIKrNHPxQunnUzViIK4uCPMzKdNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777289449; c=relaxed/simple;
	bh=uuhq7sA60Gqf+d9o89HegPUXAaIeJCCjhTAYQjVkdZw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fOaP95iA6A+8VTbaTEnh8IdFhwLGUixGoDccMQ41aNlEM3JB7UVKCz/NFn40exhzQt25//uRRuZYwGe1jYig+hEj4wfQ5dYpXZ2EaYXsHrebXWn3FtWtUuQK/d7x4/k8woIdqXnn2oadseiK8I3vfJfYAsekmijx0NWFPv4xxSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSvWRqAj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSvWRqAj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5147EC2BCC7
	for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 11:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777289449;
	bh=uuhq7sA60Gqf+d9o89HegPUXAaIeJCCjhTAYQjVkdZw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tSvWRqAjQZPnE18tS/WSED4tXggK1kOvZF2lng31Vexe4UnmzFi/U/s5xZVxWMc0L
	 M2PKVyk3iwd02FqluEWz+50hjpy6fL64GWROhU7zNqTwSRP9fdxHiBd4doWfvq7e3P
	 8ERgmh4JvUYQ9P2GKx6t/D74EDZ2fdnEWoxZLGCBTMHQ+y/9F/5lxok3CJn7DElNQH
	 30LGawrLnyQHTjC+emfAAyLM5MWXgJNPiKrGJoeoRlNHu1b6nbtCoPGaPqBMFuoGXl
	 BBYt79Ea1YhGM2NXSDJSranc3rlxJ5d0gJzevFkGmMoHif+q6i0o8YiYELxYFZYcFO
	 6O9r8OwtZnPtQ==
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38e8292423fso88853161fa.0
        for <linux-acpi@vger.kernel.org>; Mon, 27 Apr 2026 04:30:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+Sb+7CNAn0e1kkjuTaxm4MnU9DK9K9ZEsVtEKrqOdF6Wcv1oxdC0Tos3zjJWDKn4cnZGNAISQGAlHx@vger.kernel.org
X-Gm-Message-State: AOJu0YwBY2TTF+4cogncIMEKRNhEVZYcR6nZL1sXskuDdBO2yjKdwiOS
	swAdYKc4FQO6Ie7rJRojc34xYtn2oSHDPpeaoNb2kxwf/dRcv4V5asL0bI/7HM6eMws5WpkGOwd
	YeU+mXczRvvRWE9t9UXnxmPGuclhkkGu2UIuL51qWDA==
X-Received: by 2002:a05:651c:41d7:b0:38c:6b42:3d77 with SMTP id
 38308e7fff4ca-38ec780c22bmr131866391fa.2.1777289447975; Mon, 27 Apr 2026
 04:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
 <20260402-baytrail-real-swnode-v2-4-6f5054a4cc07@oss.qualcomm.com> <CAJZ5v0iwfZPcFtM7Jv29bXFmh3zN0OaG9UfNY5iC5RpzRzp07w@mail.gmail.com>
In-Reply-To: <CAJZ5v0iwfZPcFtM7Jv29bXFmh3zN0OaG9UfNY5iC5RpzRzp07w@mail.gmail.com>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Mon, 27 Apr 2026 13:30:35 +0200
X-Gmail-Original-Message-ID: <CAMRc=MdU7RPefrq48+UwNZRZyY15xaVJxGPtgTkb=kormDid+w@mail.gmail.com>
X-Gm-Features: AVHnY4JlotpDuyz8EzI3eJfkgs-1h8ebDHBxv3BtsLxXORU4YbE7QcSHGar9q8k
Message-ID: <CAMRc=MdU7RPefrq48+UwNZRZyY15xaVJxGPtgTkb=kormDid+w@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] platform/x86: x86-android-tablets: enable fwnode
 matching of GPIO chips
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, platform-driver-x86@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 4, 2026 at 8:25=E2=80=AFPM Rafael J. Wysocki <rafael@kernel.org=
> wrote:
>
> > +
> > +static void auto_secondary_unregister_notifier(void *data)
> > +{
> > +       struct notifier_block *nb =3D data;
> > +
> > +       bus_unregister_notifier(&acpi_bus_type, nb);
> > +}
>
> Instead of exporting acpi_bus_type in the previous patch and defining
> this function here, can you define
>
> void acpi_bus_unregister_notifier(void *data)
> {
>        struct notifier_block *nb =3D data;
>
>        bus_unregister_notifier(&acpi_bus_type, nb);
> }
>
> in the previous patch and use it here?
>

Not really because we still need to call bus_find_device_by_name(). I
think it's better to just export this one symbol than to add three new
ones.

Bart

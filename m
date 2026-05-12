Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C820D3ABD8C
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 16:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778604261; cv=none; b=YyVz4tovnhTpg0RCPN57sVnDlnbvRWtW/XZ0KMHGk0ORlCuVUaLMDa7Fzlwp00K4WPhv3Lwg750tXhIuxaPpz5n63+cThcSayRSY82QJoj5kqVo8ovyAJuibq3lFHG9NSL2ulC94USw2Pxce4qnWcImDgVjwsy0WohX7wguZ3h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778604261; c=relaxed/simple;
	bh=Zz1IX+lrd7hUfoC9aPHHRqwg/Xf7BPknG3w40JU8IkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QVWI35FzIHJTLinODgz6qY3a+vgQ13ADqQO47zrhiCff0Zv4W7HqGebjFxc+NYoVHDBzLpYyXhrriLmT0RIpEmxm7rUxVFmnj+pVfCXgLg3gj4RCS+yi7TEJcSwlbhcOw3EwyOgxC9K5PibYUONbFkGjqMvJWfhg3nIte7WNbzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b36EVLuw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b36EVLuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82DBAC2BCC7
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 16:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778604261;
	bh=Zz1IX+lrd7hUfoC9aPHHRqwg/Xf7BPknG3w40JU8IkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b36EVLuwYfys7WVFImKhkITAqlDhyF/2Vzq1X2AuoJ8B5NzdjIDDG90Dhw1/I+PZq
	 P7zlpSIofBsQ5b0VIDxc8geXO+VOca7PEVOZjpPNUzrrWXCdEp57on9uKUjcJwk6l8
	 VMe+9hymq+DgseK5eZmXSk4z+bOluVGG7DxvWz0WAY6xtXzWyjIbFqVf8wPE3qs5Yn
	 Ygf9pFM9WkfyddV7ZCUVDdjHEHyseiDFF3wMaLR2+2SmhnAzE4gX9JKVhGtk+P06e6
	 dEXw378ujTod9pXa0fCLXJhwiI3dHyyYckGTgV2HA9+ZkE/yl4jxe9fKA1hzqV36Fa
	 TpnvuYvJfvEyw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a74ac8b40aso5343886e87.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 09:44:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ/oMlf1SFwROxEGcWPHGNps2A+vJfQtQzkdiC3FXtfaViTgwdOf5UnMucTri2T640ayxAR5hMViPr9b@vger.kernel.org
X-Gm-Message-State: AOJu0YzNEwGpUJYSrxCusZ+LY/wLf8hskDywpYlWdEXdtOFWFyeX5ykB
	oimVuUlU2/5RlGk35Ald7CVXwNkZLsBoHcFB49tatBj+X1hIFoaPN7Bkvv/w7b1DsC0UOvhlPjb
	sY8G+0wKJ6p9ybgu6flq1FekZL8ihyzM=
X-Received: by 2002:a05:6512:1153:b0:5a8:9f6f:4647 with SMTP id
 2adb3069b0e04-5a8b719653fmr4619160e87.35.1778604259888; Tue, 12 May 2026
 09:44:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <23119222.EfDdHjke4D@rafael.j.wysocki> <agNYU8Q7Aa9Nm_V2@ashevche-desk.local>
In-Reply-To: <agNYU8Q7Aa9Nm_V2@ashevche-desk.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Tue, 12 May 2026 18:44:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i5PCLm7bLXq5q1X9QYPh=55TBqKw9RJOzoDP36adbpvA@mail.gmail.com>
X-Gm-Features: AVHnY4I495TIQZnlmmexbTCIrtt61DIs_9KSkq4ruGjHKKgUoJiyZYp7xiBGMTE
Message-ID: <CAJZ5v0i5PCLm7bLXq5q1X9QYPh=55TBqKw9RJOzoDP36adbpvA@mail.gmail.com>
Subject: Re: [PATCH v1] platform/surface: surfacepro3_button: Check ACPI_COMPANION()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Chen Yu <yu.c.chen@intel.com>, Hans de Goede <hansg@kernel.org>, 
	platform-driver-x86@vger.kernel.org, Maximilian Luz <luzmaximilian@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 6:42=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Tue, May 12, 2026 at 06:30:26PM +0200, Rafael J. Wysocki wrote:
>
> > Every platform driver can be forced to match a device that doesn't matc=
h
> > its list of device IDs because of device_match_driver_override(), so
> > platform drivers that rely on the existence of a device's ACPI companio=
n
> > object need to verify its presence.
> >
> > Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> > surfacepro3_button driver.
>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks!

> ...
>
> >       strscpy(acpi_device_name(device), SURFACE_BUTTON_DEVICE_NAME);
> > -     snprintf(button->phys, sizeof(button->phys), "%s/buttons", hid);
> > +     snprintf(button->phys, sizeof(button->phys), "%s/buttons",
> > +              acpi_device_hid(device));
>
> I'm wondering if some CIs will now generate a snprintf() warning
> (this was in the original code if the compiler can prove no truncation
>  of the string, though).

Then I can send another patch to make that warning go away ...

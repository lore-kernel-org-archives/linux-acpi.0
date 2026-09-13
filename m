Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784433E0C73
	for <linux-acpi@vger.kernel.org>; Sun, 13 Sep 2026 10:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789295997; cv=none; b=N2tx8nWIofshA3X9kGtmvV3GV7XSiDCsFNEqfvQjZZOYyiBGaJQuH4GUBhUrS7tdmayGTqjvFsh8EBFnySyD9IfKfIn+4xCom4T9hBa6PWFfqXg8oR5iOp91M3/fybhomUwfGLhnQRUgkjTf59Hj5VUEClJ2hOJYlP8q7OtBmaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789295997; c=relaxed/simple;
	bh=tHR8MbHYnydo88nNqFpbUFuYlV+Az69Ygft7I7d7Z7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OxArjXKGhzeH4UitV7Twn/ADvXaSP4uWyTlwMFnbNUtaVQUe6L1OgWSjNx1J3TidA3LKXcCB99XjPoRX4o0SSGcW4Fcs7mVK1YxZq+1535KoyTwkrf42EmwQ0R+PTRb8DvPuYRmfWUCyfFctAsIxBky5xVtBk1ARF/CjYvcdDH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0qelsg8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0qelsg8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5F31F00898
	for <linux-acpi@vger.kernel.org>; Sun, 13 Sep 2026 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789295995;
	bh=tHR8MbHYnydo88nNqFpbUFuYlV+Az69Ygft7I7d7Z7E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=I0qelsg8o0zKdJP0HVkXin8YAkigNM1TbFg9+/NjYO8GwClKgiohyrd7hAlvS5AiM
	 E4Xk/AR0zoKz+5Kz1GgEKM4DninWm+4ZulXSMR08NwMvPyeQJ6jS+XiZIBqE/xJvR/
	 SKAqVfdQtce0EPPoJx6eUUQMfi5HlzaClvAA4K5Pb/yo8TCqpu7wfHXnXgXR2k77eP
	 pMHleAdMTtrpUz+f476mSReB2rZsU8CwpjdPJgunR8M6XwPpA9QsbzyqE373VYWbQg
	 HGF1biDaEasMmF3rMaSy4nCcsSIDgwYJpahqsSXifmXJEAclGW9WPITMbzTzBId5p2
	 xuNAyr/h0wAQg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f16f15so1402379e87.3
        for <linux-acpi@vger.kernel.org>; Sun, 13 Sep 2026 03:39:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBykOMEbDe1LYi84R9NY8NX15sGbx4HK2ssglzQ1o3SrBkwqGXdq+E9Xa1+V3lFHh8MTA5VypH0e1aPE@vger.kernel.org
X-Gm-Message-State: AFuF++miSMdeGCgWwzBWjuszmkzNdWVdWMJNP/zRib+p1JosEvFVuTN6
	Dwe6CBDTcumv1eUHwvL7v0AprlKWOAg+O2N7YAsjlZKmgE3fEXB3REbbJu+pZWmKT/Il1p+cdzd
	2Vr3Dku/GQU1rgW8A95pL0aJcTa1ztrA=
X-Received: by 2002:a05:6512:33d6:b0:5b0:113d:8ae5 with SMTP id
 2adb3069b0e04-5b8a02fa142mr4883555e87.10.1789295993364; Sun, 13 Sep 2026
 03:39:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601194040.18223-1-miguel.vadillo@intel.com>
 <6e450fa2-8b40-48b6-b0b0-a1c4b72a383d@leemhuis.info> <d7f4a573-1a2e-4274-8c8f-41d398592356@leemhuis.info>
In-Reply-To: <d7f4a573-1a2e-4274-8c8f-41d398592356@leemhuis.info>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Sun, 13 Sep 2026 12:38:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gUJpgy5aaFfFqz273kE6kXkvZdHOAMGaOfVYK1pGFYsQ@mail.gmail.com>
X-Gm-Features: AcwNN1U9mqIuU8DGcOAOBLtt3RB7sQ1rI2BqP9L0P-jjkEGcBXPxDq9INxt-0Io
Message-ID: <CAJZ5v0gUJpgy5aaFfFqz273kE6kXkvZdHOAMGaOfVYK1pGFYsQ@mail.gmail.com>
Subject: Re: [PATCH] ACPI: scan: Honor _DEP for Intel CVS devices
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: Miguel Vadillo <miguel.vadillo@intel.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	sakari.ailus@linux.intel.com, mehdi.djait@linux.intel.com, wei.a.xu@intel.com, 
	atul.raut@intel.com, 
	Linux kernel regressions list <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 10:30=E2=80=AFAM Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 9/12/26 18:50, Thorsten Leemhuis wrote:
> > On 6/1/26 21:40, Miguel Vadillo wrote:
> >> CVS (Computer Vision Sensing) is an ACPI-enumerated device that sits
> >> inline in the CSI-2 path between the camera sensor and Intel IPU.
> >> On platforms where CVS is present, the camera sensor's ACPI node
> >> declares a _DEP dependency on the CVS device.
> >>
> >> The CVS driver must be fully initialized before camera sensor drivers
> >> probe, because CVS controls the CSI-2 link ownership handshake (via
> >> GPIO REQ/RESP), the MIPI/CSI-2 lane configuration, and the camera
> >> power domain. Without CVS ready, the sensor driver can bind but the
> >> CSI-2 stream will not function correctly.
> >>
> >> The CVS driver calls acpi_dev_clear_dependencies() at the end of its
> >> probe() to unblock waiting consumers once it is ready.
> >>
> >> Move the CVS HIDs from acpi_ignore_dep_ids[] to acpi_honor_dep_ids[]
> >> so that camera sensor enumeration is deferred until the CVS driver has
> >> finished probing, matching the behavior already in place for IVSC.
> >
> > TWIMC, there is a bug report where one or two people claim that this
> > change caused a regression; the report is quite verbose (guess LLM
> > assisted) and hard to grasp for me as outsider; requests for
> > clarifications from my side were not really fruitful. Not sure what to
> > make of this, but I thought I'd let you know; for details see:
> >
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D221988
>
> For completeness, a report that is more straight forward to read (at
> least for me) was now posted here:
> https://lore.kernel.org/all/20260912185836.309071-1-manuel.knitza@googlem=
ail.com/

This doesn't seem to be about the same commit though as it mentions
ipu-bridge.c which is not touched by the patch in question here.

Thanks!

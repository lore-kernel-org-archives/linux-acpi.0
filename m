Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171223093DD
	for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 07:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781248036; cv=pass; b=HKtyS+DYx/bYnfxSA0rdn7HT5qnTMCZaJUl54KkpmbrF/mQV2xXjqBXIWC6Ed/ZQd3dhGCpRll/cpUjJ2IA1r5zpMvn43SNQnpA/SbdUAI7FKz1YuQdJNFEwyDgk54jKDr8uFInn8ZYs4lM0QuZjtmfgGGHdmOpoRyOPXmaEzFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781248036; c=relaxed/simple;
	bh=J5d9WCaKRJWtKyrzyOLIKLSZnATYEhNsU0US0PNVOy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i3ecZUJjESh7kPREKEgwYSNTgliayg0eYxntL/yUqeLHGOYrQHYZLMnzSu/gs/KA2l9pri5PHzaUcOC2NVlb3/0H5hZK1HzgDm56wlBcklh1D5U6Ll28KuqlaRvzfB+Eg7l479xMUl0YhIPH74PPsujoS6Gxjgx3/vZhUNdEhv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GX6a316Y; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GX6a316Y"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7e2cb01a974so6856777b3.1
        for <linux-acpi@vger.kernel.org>; Fri, 12 Jun 2026 00:07:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781248033; cv=none;
        d=google.com; s=arc-20240605;
        b=Jw8SBtt0LYC2twy4kDT74+bY2L9Nc6mcHBMEkilo8LSbRlEMpeBVI7hKsqOzgBf4Xc
         0aseZtQREOY35VV/93T+X7CezV1IVTBJGQNpwt5hXKm7zu7dChsDOUce3DJbIi2DbM0c
         TIJILC9YJnzybPi1KP2v+1WS8IcHZFn/VEox+vW0p+HkizfqrbSi7HrzlKjbbXw/TOmI
         LT4df5SCzSpdlbd5KoklSF7yx2W79dBNi0DAIAktkCSqwnEvGpxc1fzH+wtB8//BodzQ
         8J2T+ki6omTYIiZTrZ3RVBMLrcaiuz92TJ6hir94cPEvEQ7MMB1fCB/nDyVzNBGKzdxI
         VBbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=J5d9WCaKRJWtKyrzyOLIKLSZnATYEhNsU0US0PNVOy0=;
        fh=1bmCNBgHoTwkt1ZR+gyp5ijEq8YRS4/LLp4PgpzI2kI=;
        b=O8VKHK1Ck0LCvjOdtivrUo5By7p5i6GozFtYSZUvgv/1I95e/NZEXa7jD9tD69T5fr
         pfDSevjdh0NHCA8/8i7OIcuFTtraLmrlwTbtRQFhaqau54jSsc7FbHqWTCutQxBYKKp7
         x/5rsvNnzqPmSCkCFao+SgYPWPZFaGWDfYbYAS+Yk+sntnrATURab+BDoH7lc0D3o9py
         UNKrEjQRcMXvP8QXeD+MNvRAtBc5CAnn7MlxUUBZMkqD5J+5vcWHlIiie48WXc/9K142
         1thefsclgBkkjCEfLcpfktHY5p3rSO4SV1xRc2aWCxSyEF+r4WlWMGyn3ZbYSnb6fufC
         Rsdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781248033; x=1781852833; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J5d9WCaKRJWtKyrzyOLIKLSZnATYEhNsU0US0PNVOy0=;
        b=GX6a316YJGltvP7NQQNtDlNb59sOQi88Gn9mV1Y8TuxfeZyuhU9puM51+9riltZKfx
         JHWs8YDubZD9ui4RTOdUsaFTPaj91O1gorrBEECB6BwQPfCHQz+vtI56oYtN5Xxwvhzr
         yDJo96lcZ6Yu/IHeXD9RRo3g9YtRxf78bYOiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781248033; x=1781852833;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J5d9WCaKRJWtKyrzyOLIKLSZnATYEhNsU0US0PNVOy0=;
        b=s8+AvSS0NQeFO7L2fhDmEN2atwhJ6YrA8vS2vpgJTyW2wb+OSltBTLmryu9cu+Ityv
         UU/jtyEFPRfGFybNjsmP+b/xQRww02uCBvW6r+4ZpfA8lPH7rLd/m0kGb3eVMbB8ZwBF
         9teZJ8C4dZjwGFNRNVcsXwR58it+QT2RAuLoaE2V/6U8eV0/EmJHMthST15TcLukTfjb
         w9S9m3suIDKgSvyDgQ4IJaJO9BvmnTZRGfS7ZEve35bxyANsExBkiVopic/8BgusqKAs
         yCrSdEOtVkj3jezO5vOPPUCYuSpH9e8BhndDqWJNp6vcZEvye2OXXcesGfUEyhNQx8cp
         oJgg==
X-Forwarded-Encrypted: i=1; AFNElJ9XzaE4jWeYY9P2tmOoEETL62bQZthNPmI9988wJ5/6BdlKuDtgbTShI+pz2bYedIFHHWIA8ZXtpsli@vger.kernel.org
X-Gm-Message-State: AOJu0YzCzr2dQMmbZMQTTmnagAP4xMvPPLp4Iorj5cTjBPq20ayS/AWD
	EDhJaEPrdQF/v0FGU24TBxbKoygltYWiVk7KiZif7YAxc4iqq/XBWMIlsDLNwRbCKozO4tYxqHz
	iRskqa1d5L2+0sk9abwe19pc950ecWYCE4Ycjq1Q9
X-Gm-Gg: Acq92OGdB8sB8qnfuAeY1sCWwFLNuIkMZVbbEqLRWQeJW0EGG1s+vYp+gWHDGRLd2fq
	HRyfq6zDui1CxME9lWuGmyvuVkqVhcstCwqr2W+WECv64xAYObCcib10KBBcE3r9Nl73s3JFxah
	5TyHXAAjPTEAlArUN4mlMjwN4cAVui3VYZF8pzXQDiAoEZyYD7DqgWKJvpSF2974M8v7kLKBXFG
	vF83FRme75OWz96eEz/pOf45YBlhMdfblFvWa1OYa84+9KmFs6xppA8+OFWELc0qgPjNL+YJ3Nj
	k7oBasQh
X-Received: by 2002:a05:690c:e3d1:b0:7d2:6b8:6e4a with SMTP id
 00721157ae682-7f7b6448b2bmr14221767b3.18.1781248032935; Fri, 12 Jun 2026
 00:07:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260610084053.2059858-1-wenst@chromium.org> <20260610084053.2059858-2-wenst@chromium.org>
 <ailtMyYhbkOgaZWw@ashevche-desk.local>
In-Reply-To: <ailtMyYhbkOgaZWw@ashevche-desk.local>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Fri, 12 Jun 2026 16:07:02 +0900
X-Gm-Features: AVVi8Cewi0jX5G3AwANJfv_JfU8wtj5jI6ryJrZRjeBtUWWvLVEyokylnfzsf8o
Message-ID: <CAGXv+5EZp0KvTqMde9da9mUWJyg+6X6Eon9Sqxx0VbikfVr8fw@mail.gmail.com>
Subject: Re: [PATCH v2 01/16] device property: Add fwnode_graph_get_port_by_id()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Alan Stern <stern@rowland.harvard.edu>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 10, 2026 at 10:57=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Jun 10, 2026 at 04:40:35PM +0800, Chen-Yu Tsai wrote:
> > In some cases the driver needs a reference to the port firmware node.
> > Once such case is the upcoming USB power sequencing integration. The
> > USB hub port is tied to the corresponding port firmware node if it
> > exists.
> >
> > Provide a helper for this.
>
> Okay, if it's really needed.
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> ...
>
> > +/**
> > + * fwnode_graph_get_port_by_id - get the port matching a given id
> > + * @fwnode: parent fwnode_handle containing the graph
> > + * @id: id of the port
> > + *
> > + * Return: A 'port' firmware node pointer with refcount incremented.
> > + *
> > + * The caller is responsible for calling fwnode_handle_put() on the re=
turned
> > + * fwnode pointer.
>
> Note, the Return section must be last one in the kernel-doc. The last par=
agraph
> sounds to me as a better fit for main description. Basically check how ot=
her
> kernel-doc(s) in this file are organised and follow that pattern.

Will fix. I likely just copied it from the nearest function which happened
to not have a Return section. I did a quick look through and it seems many
of them are missing this.

ChenYu

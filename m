Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819B346AEE1
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073377; cv=none; b=EAESuaX7CU09Rv7VqVzH4DDI6Cd+pGLl0MDdYPhtuCN7PjrxnRn4pWc9FjM1bdRxJRb7UWKuUPejtulfU8vg6St7stQcZQB2W++0mBlqW8zCxmghD/Ts8fbGQG4yHOBvsS+LAafS9QAS1EmvXfoeTL8pDfi4YCH/ak/b/mL46Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073377; c=relaxed/simple;
	bh=xdp7JO+fSdF3RrNN0w+7CescScNY+i+OM9hNrWuKKqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XN0OFaIb0/QqWpDni7DA6fKIPJzNMwKVQDZ5MNVgHKvFEEA20UyGlbkgHNNno3nukf5vx+85hFvKm5teb0RybZZRLEd19C1OxSmAqdl2BEMxrZvxvxhc0rSMQ/M8K88uAT/0PdqwEJzGGpM3m8KBkSqi54NNluUvTsz0+EBrAjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=STgmolnR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="STgmolnR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32922C2BCC9
	for <linux-acpi@vger.kernel.org>; Wed,  6 May 2026 13:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778073377;
	bh=xdp7JO+fSdF3RrNN0w+7CescScNY+i+OM9hNrWuKKqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=STgmolnRodmEL41fALoTXYNv7Rbsnz+kPv4jFivsERSXI+nM3/MxFo1l5sCfR2Pqv
	 iJBfKfOHTYtlJRSq5tT1vc7QELexQq7xcNiUKBQJILM53duoUiRY5exD+S1S5UzshC
	 Vw58HYyLUwtNdSwTkY804tcVMCPI7Z0qVy/SWzTUq2idM/8zHf22XNy3K2qL9HAB08
	 RAsmHdb92S/2zAED6IO8jiMLS9txHD3Jp1sDsK0vX8a5qB0A77x2HGGlm2mQIoh3fF
	 g44E+EdJIiSPcvffCjWWDST65yrA062MSLcyLX8NfGSqrCq5yNRmvy/nlw7+i++gdz
	 jqti1aCFOe/Dg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5a865004748so999907e87.0
        for <linux-acpi@vger.kernel.org>; Wed, 06 May 2026 06:16:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+yakJ/vdwNbU4y8RXxR9YTZtl0gmE80uFCoD0RFD/cvJ52HAEhUiOePYIK3Uht0BJotym+QrJGLGiT@vger.kernel.org
X-Gm-Message-State: AOJu0YwWc/xA71ZOb7+8O9PQsFaK5T1pRm9VQ4arnEEJJCB3MaGeBiyK
	Xl+TaMK/gYfcRrsYEjzoRGrx7MphllUGTHLC5Wi+gcokdAb0TQ6gjYWU95j3Kt6RB9VMS7F+Smg
	oYYko+gd618PgvhJ7PWo2c9EvK+l5sQgCJWU2GMOEXw==
X-Received: by 2002:a05:6512:3d04:b0:5a8:6f3d:6cfd with SMTP id
 2adb3069b0e04-5a87e66e8d0mr2759547e87.1.1778073375835; Wed, 06 May 2026
 06:16:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com> <afs93y7nW_VTc1Y5@ashevche-desk.local>
In-Reply-To: <afs93y7nW_VTc1Y5@ashevche-desk.local>
From: Bartosz Golaszewski <brgl@kernel.org>
Date: Wed, 6 May 2026 15:16:03 +0200
X-Gmail-Original-Message-ID: <CAMRc=MeFCyi7aOcyEcaiwWa_vxLxXD1Y_6LsO2R8K6AfrxzHQg@mail.gmail.com>
X-Gm-Features: AVHnY4JMmI4Fy_4mOeAD3iaBKBIc2zSpCdsRhmEz73_REvV7NEjtzeTHbh_DXYw
Message-ID: <CAMRc=MeFCyi7aOcyEcaiwWa_vxLxXD1Y_6LsO2R8K6AfrxzHQg@mail.gmail.com>
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in fwnode_init()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, driver-core@lists.linux.dev, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 6, 2026 at 3:11=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, May 06, 2026 at 01:57:00PM +0200, Bartosz Golaszewski wrote:
> > If a firmware node is allocated on the stack (for instance: temporary
> > software node whose life-time we control) or on the heap - but using a
> > non-zeroing allocation function - and initialized using fwnode_init(),
> > its secondary pointer will contain uninitalized memory which likely wil=
l
> > be neither NULL nor IS_ERR() and so may end up being dereferenced (for
> > example: in dev_to_swnode()). Set fwnode->secondary to NULL on
> > initialization.
>
> Hmm... Are you going to use that outside of fw_devlink?
>
> The patch itself looks good to me, but I'm not sure I understand how it's
> related to all the work you are doing WRT fwnode core implementation.
>
> FWIW,
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>
> But Saravana is the best person to actually tell if this patch makes sens=
e.
>

I just stumbled upon this crash working on adding support for
fw_devlink for software nodes. I figured it makes sense fixing it even
if we have never hit it before.

Bart

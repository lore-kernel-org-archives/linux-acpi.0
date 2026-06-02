Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2213B8BCC;
	Tue,  2 Jun 2026 07:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780387192; cv=none; b=t3Yw8JreYve1VvnZfNwnB9phh7ZwJeLbGJ5ArEaoDY5b8b1Y8EftVWXI1Pm7jef/9tw9L+nlm7qgC22mibVi/RE5VbgHEBA4qjdAj9s+LmXegFcMA4Gs4XUOJhGIgC4VNQH5qHz/kH8sMFlnH57AvFOV8EqdBxLY/+4JTwhLFBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780387192; c=relaxed/simple;
	bh=PWDIHCd0ekx1HTEpu0G+vMKBkiRP2XQTiOmkDL3I58M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VRCY/Ekp3NO5v/rHmUxgS8CpQo7LTjAKyFcOT0Ma46LWsgm4IjpI6MhG2HBrPscFKM2JolOWofZalzs5eCa6s0BgOSSZrzt12cuHAV2g9r5C7to9SmLqpzxusM2t1mJfdFBkqOynLN9N9qUQQvUWKqP/9u3VqSonTYL6FC6ExTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=WaBTtFSv; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="WaBTtFSv"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 04E7F272B4;
	Tue,  2 Jun 2026 09:59:48 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RDCF_Npn-AQi; Tue,  2 Jun 2026 09:59:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780387187; bh=PWDIHCd0ekx1HTEpu0G+vMKBkiRP2XQTiOmkDL3I58M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WaBTtFSvHzA1eCwn6vLfePuew6Jl4mS/LqQ3dNzp08m2AXEbbCTmZTv4LHI6TET6n
	 HRBYHELTa3QmMgWzHbBTHVmokXbVQXhtid9OWGvKWv8SvIuS++qkACDG+DZ1tWA2vh
	 fsmRAWkutH/P5IiOIvsBFgtKj6/7x4PvtkEOOrSRdOHrexS3euMYh3XZ6prYvJqmp+
	 uIMsIXzUhxiAozeoXyEXerKIo0mXNRFa3VRhojGK4cDt11PmLwE4FjfjL3lPs+vm4w
	 Th4Xh7wI+tVl10R9GfFC3SpKwSud4loZT7+suGtC7I8QlDO/15I2g4Gmfitvj2N0oQ
	 5GAOHZ6jmFRpQ==
From: Marco Scardovi <scardracs@disroot.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 Re: [PATCH 0/2] gpiolib: acpi: fix bounds-checking bugs in GPIO ACPI core
Date: Tue, 02 Jun 2026 09:59:34 +0200
Message-ID: <2QvGwYNxRj2rEr3AgUt9Pg@disroot.org>
In-Reply-To: <ah6Lzn4NbilZQwvy@ashevche-desk.local>
References:
 <20260530094012.184276-1-scardracs@disroot.org>
 <ah6Lzn4NbilZQwvy@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In data marted=C3=AC 2 giugno 2026 09:52:46 Ora legale dell=E2=80=99Europa =
centrale, Andy=20
Shevchenko ha scritto:
> On Sat, May 30, 2026 at 11:40:10AM +0200, Marco Scardovi wrote:
> > While reviewing drivers/gpio/gpiolib-acpi-core.c in linux-next,
> > I noticed two bounds-checking issues in the ACPI GPIO handling paths.
> >=20
> > The first issue is in acpi_gpio_adr_space_handler(), where the
> > 64-bit ACPI OperationRegion address is truncated to u16 before
> > validation against pin_table_length. This can cause out-of-range
> > addresses to wrap around and access unintended GPIO entries.
> >=20
> > Depending on platform firmware configuration, this could potentially
> > affect GPIO lines associated with sensitive hardware controls.
> >=20
> > The second issue is in acpi_gpio_package_count(), where malformed
> > _DSD packages can cause pointer advancement past the package end
> > during element parsing, potentially resulting in out-of-bounds reads.
> >=20
> > This series fixes both issues by:
> >=20
> > - Validating the full address range before truncation
> > - Making the length calculation overflow-safe
> > - Validating remaining package elements before pointer advancement
> >=20
> > The fixes are intentionally minimal and preserve the existing
> > behavior of capping ranges that extend past the end of the pin table.
> >=20
> > Patch 1 also converts the related loop variables to unsigned types
> > for consistency with the updated arithmetic.
>=20
> You got me lost. There was v3 of something, what is this?!

Hi Andy,

yes I messed up the patches on my side and made way too noise for my own, a=
nd=20
yours, peace of mind. Please don't consider this thread anymore.




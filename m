Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FDC375AAB;
	Mon,  1 Jun 2026 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319007; cv=none; b=cJRZMlHL/6AqiD1TcCY5SbM/bAMCs7QnP4pC5fwwGHbN28avi5JHJT9e1cCrbgH/BWOHf/ET1ne68tw+LCAbHOWBKQVIhO/sKYCj39VXP9sy7z+rqoQ/IWZ92Ve8Zntzk0HuxNDxGH2JtbgfPVoOL62RAYLmrOGPyuPIIDqU/9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319007; c=relaxed/simple;
	bh=bY2IR9oRsViHk7XO0FYniIw47+5KZ3MwdEqYYxKXnIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6RTGzb07+SPT4oMxjV4jwjiwu/GYRONqSKU1kElIuULBC5VDrS2YQBwAv0WAZIKU83z8HAqFZaZUTDoOpG3iawpXIUWMe6sCoJhklCKJNEk3xtqB9irOkJqcMC/8uJtKCdP/A/JywrQDNKJ6rH5ZIcb+/rH+QnKOKGhgQ7WAv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=eWN/DXZt; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="eWN/DXZt"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7F9E026795;
	Mon,  1 Jun 2026 15:03:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z2417K_TdMw0; Mon,  1 Jun 2026 15:03:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1780318996; bh=bY2IR9oRsViHk7XO0FYniIw47+5KZ3MwdEqYYxKXnIk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eWN/DXZtPCmJfR6XyN9BO6erV7yXlA2zYhc5BdbZXU+8hZnieozwS1Y+wi/hVz/uv
	 lRhFvCheB+qrw3cQ0Zyw+Na3k4wY4BW2ByP3ehB7GiBtDAg+GEbbVEn7TdZ7k4tYIm
	 AyPbvaMZzufLQjjRnJigG6cW6JBD3twMpIDldUYZOHSun48LVcsUN9XaoY6Nd5iuIz
	 cgn8ZkxngAGXue1e/MUo5d/DBEIm9oavrSLFevOfQGweUYsO9xxzbIvaaBIQtIRm8w
	 /WiY3O4K7Vkn1EI8qYcoUB2NcTJ61rcbwq+KILyKVLFeiJABmcZGJCoDJEFdOLBtzg
	 LEmgz6/rn8XUA==
From: Marco Scardovi <scardracs@disroot.org>
To: Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 linux-gpio@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] gpiolib: acpi: fix resource leak in OpRegion
Date: Mon, 01 Jun 2026 15:03:02 +0200
Message-ID: <Ycld69QSTaaxOgK8F11m2g@disroot.org>
In-Reply-To: <20260601121815.GS3102@black.igk.intel.com>
References:
 <20260531120816.17255-1-scardracs@disroot.org>
 <20260531120816.17255-3-scardracs@disroot.org>
 <20260601121815.GS3102@black.igk.intel.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

In data luned=C3=AC 1 giugno 2026 14:18:15 Ora legale dell=E2=80=99Europa c=
entrale, hai=20
scritto:
> Hi,
>=20
> On Sun, May 31, 2026 at 02:03:09PM +0200, Marco Scardovi wrote:
> > ...
>=20
> If we fail to remove the OpRegion handler and continue to release the
> structures does that mean any AML code that accesses the GPIOs now are
> accessing already removed (below) objects? Here _REG is not called (we
> failed to remove the OpRegion handler) so the AML does not know that it is
> gone so it can happily still access the region. So IMHO it is safer to ke=
ep
> the connections instead of removing them.
>=20
> Of course it is possible that I'm missing something. It has been a while
> since I looked at any of this stuff.
>=20
Hi Mika,

no, I get your point: I was being overly cautious about something that may
or may not happen. Consider these patches as void and sorry for the noise.

Marco




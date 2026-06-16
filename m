Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3498421A05;
	Tue, 16 Jun 2026 09:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781603053; cv=none; b=sdyAbezpIJkiDLTmkaBaQ0h84vCOWFeqW6hlot1lPfm/OAaWMxnK4+9kYVBigowGVJaQhmjJdlr5BFr6W2Pgrc3b6+uMHkYYKsmI8HCXh0KBlWOpFtLrFce2FgVW/rTnXuDV9Ec5xbcxSOFNbvQmUn7mcY3kQPLAazGYrbMFToM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781603053; c=relaxed/simple;
	bh=mWWaJuOm2MSxr7vAoqriZoUvC9+aAaZ6/3TJS9Nvy+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nM3E3KpvbxMxoV5ztggIIsl26whZtRyN0Lxfp2mkEYc7XFJEQuaC02qhVSbwqoYFe2XtTM94Ho7iDuOkD/p6wt8dhZVvHVtmJMI3cKMq40goAxA3gcMM5n1QKhJalCuAa6ogbC3rSm9fyCcONOtGS8gZ7QXNhYrLuqST5b7bkVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=AYFSXRX1; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="AYFSXRX1"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 410C3277CE;
	Tue, 16 Jun 2026 11:44:10 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id htInjrjOE_y1; Tue, 16 Jun 2026 11:44:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781603049; bh=mWWaJuOm2MSxr7vAoqriZoUvC9+aAaZ6/3TJS9Nvy+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AYFSXRX1OU1syY4HtWLAgayQSVJ+ScjbizFZwDPoSoY7p4wNtHY/3RzmqkDAitHMA
	 tF9COnQXnKIEh53H7KnproEY1n5+tDocQvCVUZo8387VGu53jGBJki3w/Rs7z6xk5N
	 ER3h+tiniwkipKTjxXKKVDdlSTY5dbjQvG37KkEs6j8S1YXCBZD3XJcMTNax7oGXz3
	 U6SkLwUV2Qe3O8qJWBGCdfil4XH/Ai/bSplQpRnKoLdqEw+K/CW7p30UA2bURULPQB
	 wYtNshXcv7WVm2hbPje1Cb2IUqw34vdpZ9GfyOFWvG1inDECDlnm59VeeHJGFd/JHt
	 oh90zzGou938w==
From: Marco Scardovi <scardracs@disroot.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <westeri@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for ASUS ROG Strix G614 series
Date: Tue, 16 Jun 2026 11:43:56 +0200
Message-ID: <RqcbSmnzQWas394Kq-TG7w@disroot.org>
In-Reply-To: <ajEX8L63vAhhndv7@ashevche-desk.local>
References:
 <20260616090824.5967-1-scardracs@disroot.org>
 <ajEX8L63vAhhndv7@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Hi Andy,

> 'slow'? Did you mean 'low'?

Yes, sorry, that was a typo. I meant 'low'.

> What is this interrupt for? Touchpad?

It is an ACPI event interrupt on the AMD GPIO controller (AMDI0030).
Specifically, it triggers on pin 21, appearing in /proc/interrupts as
"amd_gpio 21 ACPI:Event" and as you guessed it is the touchpad.

Previously, using "gpiolib_acpi.ignore_interrupt=AMDI0030:00@21" or
"gpiolib_acpi.run_edge_events_on_boot=0" as a boot parameter successfully
bypassed the 36-second delay, which confirms this specific pin/handler is the
culprit stalling the boot process.

Thanks for the review!

Marco




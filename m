Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C46C311C1B;
	Wed, 17 Jun 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781686342; cv=none; b=giWOtFwVvcyok1BZgOSZOSvxMiXXFmggEB+NuKu2YVxU+h2IAK5rD96dRsmsTWaCG6TDfvcju9e97LTnc6J2RauJ4ilQgIiWAwGJaOU+2S39B0M5Kwd5/gsQl85rQNVIIVcp2ZSIPyt1S6OPTrNUQPXVqoS9n99Q5l1ne4Xi0yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781686342; c=relaxed/simple;
	bh=SBhFBik6Q8jsMrDc/brKC2mrnipQabc3lq2zmQMLUtk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLDVrNIe2Nc3GRhRrHu9hDK/nbhCfmdAjLRzhNBf8SY9WqjIV4jK+BLG1PMX2zEKf4MgLCjU89tCVTmN629oL5zB+gk6OPf8Xj3rGbXWrU0UMS/4LPVL6Ed6m7Pg7sNy+Gf3dq7K3/FUBhrZZk949qQqVY2qD/hjin8ygkOPElU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=H0ozDqsH; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="H0ozDqsH"
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id 7DDB4262BE;
	Wed, 17 Jun 2026 10:52:17 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uDX0bK4BAT47; Wed, 17 Jun 2026 10:52:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1781686337; bh=SBhFBik6Q8jsMrDc/brKC2mrnipQabc3lq2zmQMLUtk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=H0ozDqsHs0e0fHmZjPi/T/PAd8NzLu7y++GhJD9DLAradDeb83obBXbeHL6fC92rA
	 PQSCd6NCMc8W1zOF6WJ3lfqcYOLR2oQ1onwUQOWQCAYqVs9Lc7dcr1GuM1JDll4VQA
	 2/A2Sb5doESCY+6xdcWHn2vGD/QEqVthlRDxMZXlW7ZPiRkFFISn7fh/BbBXOMpl8H
	 TP9Xcu7hA4HS49kOIPtbOCTeYefY0snhZgdge+fodhy0vKBlRyOADPCVYZyY80G89s
	 pxFJzGl4Wn3RT39hLN0BmIv4kKoWu/hD24o+4BWwG1Kn1smDxJj32qGApqKZQKtINu
	 b+h792K5Sm0Ig==
From: Marco Scardovi <scardracs@disroot.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
 Mika Westerberg <westeri@kernel.org>, Linus Walleij <linusw@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>,
 Mario Limonciello <mario.limonciello@amd.com>, linux-gpio@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gpiolib: acpi: Add quirk for ASUS ROG Strix G614 series
Date: Wed, 17 Jun 2026 10:51:53 +0200
Message-ID: <cnSvmmfhTJSP4OtS9WWGJA@disroot.org>
In-Reply-To: <ajEtpY101OpZdtaF@ashevche-desk.local>
References:
 <20260616090824.5967-1-scardracs@disroot.org>
 <KW1oy3-UQRW73tAAP5-cWQ@disroot.org> <ajEtpY101OpZdtaF@ashevche-desk.local>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

> 
> Okay, perhaps this all needs to be elaborated and summarized in the commit
> message.
> > Sidenote
> > Personally I'd wait for Mario for further info: after all it's him the
> > maintainer for AMD side and surely knows more than me.
> 
> Sure, I am with you on this.
>

What I'm saying below is purely based on my own speculations but it's the
most plausible thing I can think as for now.

When I tested Mario's patch back in April it totally used to work on my 
device: I have an idea that the value probably happened to be equal 1, like 
requested on the patch and making it working as intended.

In the meantime I updated the BIOS (from 310 to 315, released in May),
changing the value from 1 to 0 and breaking the boot time again (as said it's 
my own speculation, I'm not sure if it is actually possible).

I didn't test the patch after the BIOS update 'cause I had the
gpiolib_acpi.run_edge_events_on_boot=0 option enabled and didn't think it 
would stop working again.



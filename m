Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 816DC3EDE56
	for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 17:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608669; cv=none; b=R+uNSYm6RYRC5FzAeqmg5Jwn4rCrmiVDwPgM1GViIaBY6wRG8PJhdbzX7oIDYc3ow284L6u8DNuKMq4nTnhVZiDFCVv2UUzO/S9olSlSJQwsHu9/n6+zSnnRgTure/FQzkJWHELgEFuDVtyblQMcO8LUITk2ZldwIBoBMaDXGKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608669; c=relaxed/simple;
	bh=DbC0giau3tkuoc9dJAE1gGKTry0Z6rr8t2gh69mnvFI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ozx1agJtdqzfiTkaZbaiyoMP67HgZ061H46Ytga6ztyFVqICQMulJN6Tl3evpK9LYuQ7qUtMQN2692AulmzWOh8L5CUFZOeVXGVGhkZDoOhUufZEEfqaD2ZzfsixHg7n/DUC3yB3rGjKn66vtTWT9BYCVS8hRihZOn2uc9dKrXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+ivjFLt; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+ivjFLt"
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1329507c387so2007909c88.1
        for <linux-acpi@vger.kernel.org>; Tue, 12 May 2026 10:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778608666; x=1779213466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dAT7x8PLis38MYgBl49P0EwUw9EMtbiaXZUfAfDowGo=;
        b=e+ivjFLtq5sJ8wRVzdzV5yw2kQA1Ss8iHkg++dzeRGiIpHo14E7Q27vVyCgtW0gDQY
         iwI0fus2QiD1PJHwld4YBpbVMm7y3fNIlSFgQEq/FsfuzZpMvxvY0RdnInyUG5CQDr0S
         cnCalAcFoDc66HKG8Xx92eF0DpTEZapWOYfxMUNhWlKdS4RehlphIedt+aa7tE5vDeIM
         XBZnSeCOpaSDxJ9GPe4NwT0fJhr9bqk8g9EwzlW+HaqSE8nBXKgpq2FjbuKPyk2CNkaB
         l9+3xOoMGk9QPa5QjcV7OEOXQmjrxIyfcC/Mqpd2G0UvSF4vdDy1+I4ZC1agdMJWNhJb
         wCHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778608666; x=1779213466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dAT7x8PLis38MYgBl49P0EwUw9EMtbiaXZUfAfDowGo=;
        b=ByyHYTrh6LnZW1e5C9RQovrEm0vyj1Fl/x7FB0njieSw9Q4usxuxgMXzZvpKKwYtOn
         z7d1wyh1cf3Fat3i4UNHzYhnJlwueC582cTyHRrCnDznxc7Xh/6ePxxnazKrtjmxj3g/
         bD/mADyBXmUIZD4mvKePT25geiUBwO/bEdYUlOExYjBn24/NUda2j6ClSTSBYwp6cZ25
         vm1gKQajpU9P2tWR9+tdtYTc7eO2g8TAUWCVkydJ9iM8sP7CPNHyACjiKxridNVVzyJk
         SF8fQyEScN5mXHgY90iQ4Ema2x32jN79e7f0d72zHf3jQUSRp5tDEDq0V+zfiqI5H81Q
         hMPA==
X-Forwarded-Encrypted: i=1; AFNElJ+K70lI1oB0AJlcRk7TsRcPo8NJHY7Y2hmLr65Qmpg0d49He1fApc2RfnS+RoVNsOwOl4FM3/Kc5b/Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxvlhEYTH8I1e/6K9BTNeYLB2OmYrgYV4Ux2z7C4We0mxPWgMf2
	RgrLGM/KGzciqD25G/USEU5YyPcP4K6lf2gLA63QE7hyIP6Uue9IMPa8
X-Gm-Gg: Acq92OFqNV/IvH8ZZXvZOZb/58/RKxzfPkT9N8iUMreYQqDDnZO8KD4DwOA3T+IMbZE
	EnUSimix2ZjweRbG1RXBn+ffLx7rqff9PDEOfBM85Fe5mQU4ZvqM3cPgGYXJSaqxUget06PFCCx
	9zI4pWvsSqvHG3vTUMq0HlnqSC+mlDyKOxGzeDyetqKK6OZLn7RqVSEuX7/BcLzb63D95uYjBB9
	A/CI1jaQzho4tQ3CEKDQoUaHEHAlEaA4AAMoG+1aYRDKfwRdbXT9l4TLl1MtnqH1L2uLf2eW489
	NeJOaLqctoBIMygr4Hs8Qkf0Xi9PTGstxeUeIkqK48jfQALWxizWgOdV9zjZkaGRPC48TxE35BE
	HrtKdkgEawQoz8d3mErKA1sg5XHA7OG4GbGKMNzdT+Q/cLYTXOlMLefkJFg2ctXv46qkb+umqoI
	mK3mpnC4q2xIxIUSwJVV1SdsgglkovV2P+ePR6c7eMWYK5SogczE2gNel0SuTlmfGW
X-Received: by 2002:a05:7022:221d:b0:130:9f2d:ff99 with SMTP id a92af1059eb24-1319cd26692mr16497110c88.20.1778608665652;
        Tue, 12 May 2026 10:57:45 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:84ac:d22c:b037:1a93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-132781103e7sm24271153c88.1.2026.05.12.10.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 10:57:45 -0700 (PDT)
Date: Tue, 12 May 2026 10:57:41 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-input@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Linux ACPI <linux-acpi@vger.kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] Input: atlas - Check ACPI_COMPANION() against NULL
Message-ID: <agNqEisfkJds-8yy@google.com>
References: <8696590.T7Z3S40VBb@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8696590.T7Z3S40VBb@rafael.j.wysocki>

On Tue, May 12, 2026 at 06:26:54PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add a requisite ACPI_COMPANION() check against NULL to the
> atlas_btns driver.
> 
> Fixes: b8303880b641 ("Input: atlas - convert ACPI driver to a platform one")
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied, thank you.

-- 
Dmitry

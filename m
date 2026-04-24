Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFEC36DA0A
	for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 13:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777036616; cv=pass; b=Nsh/9vcai+2jHYHXicZF/ld4V0cZKEOOYvzbu0Pa88wr/vZeqIme97bJanzv6Mh1u2RaHJfqwpgG2siq5RH6z7y57ux3/HuPArV2lcXtqmyVetMMXJ5v7W9/ewWpNQJqJlIeFwh48/OSePLtADKZr1y/rFlVCPDrofRqwNoOj6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777036616; c=relaxed/simple;
	bh=bgpykBiGFmgfbB040q2IaZLJIblegELKxJ3y2wnB8v4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IS62pfrbRMDo5gqalMwCj+q4j1wdUb9umZgSkV99O/qyVCeKbJ5P0L6FQo/TFhZrTQEz+bHRGVw2VAirDD/PE0V8/9EbIgCoZ/9nekMGXO2Nq2Ie6vmi1p7eZKMg44cjsVdE6lq+QgTwXzEV6aFzjZ67Aw40tffmUnx8v5I2XSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jdfcKmSJ; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jdfcKmSJ"
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64d5a7926cfso7830827d50.2
        for <linux-acpi@vger.kernel.org>; Fri, 24 Apr 2026 06:16:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777036612; cv=none;
        d=google.com; s=arc-20240605;
        b=D/s1/PKy7vnfJGg+NzSRP+xl3TwOZ7TYp5vcDp5h87yHYFBiLh6JHFNG8D4Q1nF+M5
         E52qXoYJf4ldF6aCkC3DYy65cmiu4l7LjGwDyALnAgLkOfvxqPjLgTSdmD5KCjRCzmcu
         VVVCGTQ99pwcGXK6m2PqCDWrwgxyauzcr/slaCMyXyzHk6jl6pHQM+mCRBB3SkCjIGAx
         0frT+h6JVk+7N3Rttk32aalNhbZBELIihH011L29RTrmXrQ8oU00Ps9+ZXvnOaDHic8c
         SYMAwxXXXQb5/T86U1S3h7rDTW5WahnJU+6SjDzpr1R45k4sCfM2ZULE8CzcFscKVxao
         e+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bgpykBiGFmgfbB040q2IaZLJIblegELKxJ3y2wnB8v4=;
        fh=Nf+Usb52Js0RXqAuJwncaAq30EuYw8/oEX4hoz4Fr+0=;
        b=QszJA1nE2krS0JTkcpUspHcUYVshLaVEuICeqCUADs1Ame87eA4NtEWgS+s6rE0a33
         VCqocVDCGRApV0xbpnRQjAkIPdbd4iFdngv/soOpOYsVkeWN5vRMf0NpdXacUcH9E4YB
         ONcGlcQp6PMH8VvjQ1FF/TLEWq+S2+/xmY+Nc699R6hRPggd3laL9kmpZqINARi9Wp7X
         iV+EyZD1HJz4r318nb/JCL4Aj7BHn3orkHJFhI4wMqrhQ2kHZQDUQ9ZRTsqnTn/dkiNS
         9sdp1zQ9FucsGAitaAj8bQb05A9S6XQ3bZk284WzVKOP0FOaivvAekBwUot/vBbcZWOc
         GMjw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777036612; x=1777641412; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bgpykBiGFmgfbB040q2IaZLJIblegELKxJ3y2wnB8v4=;
        b=jdfcKmSJNC/d9dNCO5rXDoxHkKyy14nyJt/I4NZm61GsG/JN9eGycDsJENg02IS68+
         0OsvTlJCwOBtY0IqfbstVJkdqv8CIe/0WFjMtoRU1I9/QrnBifeHe0ixIRHDNSD3Hu8n
         7HsVK+pUflJ1yXT54Ylz/pnp+bfX9FupoQfnTgoeKsqYUSpiwIZAudF/H+e+sHWiM26L
         0iVbMFiByM4i9DU2+fuoyGC4EiRD+fFbzmBKwVl+NxzFgC85DSQ9kIQWdLcdG4+z8wAl
         KF+BJGCHqqYWrW8EklSX8nK3/I1mSDjD7Qmi4gmU7ksDAjpDdty7CibmMZsxqPKXefem
         VPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777036612; x=1777641412;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bgpykBiGFmgfbB040q2IaZLJIblegELKxJ3y2wnB8v4=;
        b=PnAOmfReL855kUiHaP8FXegjpW+WEOXkWf9lQmJpsfT/6++P05S/LjvKTjd3vgO8Uu
         Op/u+D0iAaVPWabjkf2P9/PPlF97nrV+YHy0poxDVi3CU/b1pNyY2VLz5WjtuH/7dkgv
         N4Q6UMV6vYaaI3FTbvZmb+eGJBgDnjcOlLeoyunnYEwitnam9yLXNeK8q92emwUa7j5x
         paWvgBE5/2ooGyNeSAOmgO9E7ByiknIW3gU2O4JdG6huPJkp5UGNZ63/YF7TJbqVz36h
         nTRr/i0JmyorV/hWUrVMtnbllK48gm4SaKsWbiXz7VGaKGxgkEfKgOJVhSQgDZUwbqLT
         QGIg==
X-Forwarded-Encrypted: i=1; AFNElJ/qDQag3VCmKTgHVGmf43gaK2wC+NUvO/duvg5YhGeT6Zs4WGUlWWMgvDantYSEPP5LkhQgHdGh3Mcp@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/1w3PY7bGqNTFdxV77tLH9k8K6w01Rtw4Qc0RQ5qWsYBLLndm
	LuKg4rAvRsy1xFsddegn67lcwttFGyKTmXSLclFJtpVzHnixgDUh7pZXoNq5MxdhsXKnLuS3pkD
	LHUrlc5q7V3O5TzuL+k8eIrpEMC31zeI=
X-Gm-Gg: AeBDieutnDEhxEirf+L44n7P6Emqqyp7ysbhvdf5b1qj04/xWcp+kTmW5aSiyvtV70Y
	1pEfNxbvZN068Jdb3riI666f4g7uQeY1UOCRwehvH8YgscDtAMeRgH2xBwc5LbWaodCCuhZJ5KN
	LAtYkbGrjonOLB9xFiQiTv8p6UlTLJ4GhjT1XelTK1gbm24PzgNUwsId+K7nOYhwjxwb4acBdv+
	FuwIJO06S+/WoDyV6xJgSVXsaAMybaBVBI5opxPdf8sGnaR/HhrqEnPIznK0gFLYQCTcaXGucPn
	XAn3alX72ZHvQJteU6oD
X-Received: by 2002:a05:690e:1c1a:b0:64f:c830:1e47 with SMTP id
 956f58d0204a3-6531082d925mr29744782d50.21.1777036612180; Fri, 24 Apr 2026
 06:16:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260424035501.219946-1-m32285159@gmail.com> <aes0QGXqZEpsZozV@ashevche-desk.local>
In-Reply-To: <aes0QGXqZEpsZozV@ashevche-desk.local>
From: Maxwell Doose <m32285159@gmail.com>
Date: Fri, 24 Apr 2026 08:16:41 -0500
X-Gm-Features: AQROBzB5XsLpznYpC7OQJMplgRtZMG3X1TrnYaf_fIBN2D758HQDBFDHWjrcTdA
Message-ID: <CAKqfh0F0EM=AtSMLttEhbdRCjPWA2zOA2U1pccU_Fqzu-eKv0w@mail.gmail.com>
Subject: Re: [PATCH] acpi: pmic: Replace mutex_lock/unlock() with guard()/scoped_guard()
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: rafael@kernel.org, lenb@kernel.org, andy@kernel.org, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 24, 2026 at 4:13=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> No. You need to either split a helper and use guard()() there, or indent =
the
> body of scoped_guard() accordingly.

Ah, I missed that. Thanks for pointing that out.

> This is not a switch-case and direct returns in if-else-if makes it harde=
r to
> follow. What you need is to drop now redundant 'else':s and leave the las=
t one
> unconditionally as the last code in the function.

Sounds good, I'll start adding those changes for a v2 for this at some poin=
t.

best regards,
maxwell

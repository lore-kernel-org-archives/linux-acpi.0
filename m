Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898803AA9D8
	for <linux-acpi@vger.kernel.org>; Thu, 16 Jul 2026 09:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784194773; cv=pass; b=I5mXFjn8aWEQDPuLshTHcVSVbZnfifq8R6RVBGk68O4OA1gENjTLg3UWz5AlCUwDalv190NHtfS80vFF5zSimiet2dPVRdwPoB3DCRSUd8T1/K7PJKVrSD7+O84wBfMQWZwjybF6J2alnlfDFeDNeusEA+LAHsQTPrs/WuJVnMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784194773; c=relaxed/simple;
	bh=r+ToMI4+W+lt99JNWQfbUojCN1C49muMQY3/rKthzsg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txwcd0oj+KwK/IqVrrAHLvwhWEJ8M0931G7vaUYef7BYiQ4HErgYyDimGn/1FY1zTeenNKIejOCKwjlOMcsG2VCYtH7UP7DHBATeLPV9PMmUP2HrD+AAbAbjacalHy9UsDZXA3pH+C91o/SLYDD3wc63SgOCYDjxaQTXF1TYglg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lLFwUY7j; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lLFwUY7j"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-664c6304683so2851584d50.2
        for <linux-acpi@vger.kernel.org>; Thu, 16 Jul 2026 02:39:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784194770; cv=none;
        d=google.com; s=arc-20260327;
        b=rJOxTRuv2FlK0Shzc6jLbdeOr64vl80ogwZjVcayvaatM/OKR44SGGYVFHLe8tdyhQ
         nkLSUrWJcI8xceoi9rFEEjeQDhh9kY6tg2EI4x3UuP+xUSvnFLgo4LmirZVej1OIPj+Y
         oA3HGzBnlND5nUACc9cdl9ueI7FNjoyZMnxrAfVkTHBx/3IUAhv5G6+ir4CDHt/fL2/b
         I/emxzMrH/HvXv3oVXFZsYFQnNogHWeuHUbbz/rU/CUP7EncKOFSLEbbKTMrc9m8hPl5
         ZRLpSp0KHoVd/hRYvt8wnezt/6bkVsRlLM2Q0WM8qXIONxvpVINWxtGOtvh21gDVdBYl
         DtNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0CHRQwxG2g8NAYPuVqgPl5XkBCDxSDwrk5H6G4V1gVk=;
        fh=cHFfLoy5GK6QHNm/BLEQVZBshKgi0/hCaRAB1iZJauQ=;
        b=sAaYdB1OxXo+4K+UbY7X6wK3i80G3VbRRMwelsvyskI6JdOpL2iVnk7tdxBwVnbpw8
         LK0glKXLxtoB8BdLCriVEMJIAgw92w8YwwiYmcbHBuaFtlvYvIlpqpdGM5bbFNvemiAT
         abNhIl4v+dIpnXYxU2Fta5s60yh2xOtzmrattmgy1CFTerWme2p6HQdvClbN2TFooavu
         6xzErbx6c0w/NQqhLzEec7WDNpf94HyqJUPEBoB8zJbZylNwFPaa3qF8F40EvgB1DQJt
         r7iK9RIVNwJzMzh1P43il4hCm5HXKsFatJM5aBJyEZzJ4BtxJ3zhI9sLI7JVqqLk24sT
         n5qw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784194770; x=1784799570; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0CHRQwxG2g8NAYPuVqgPl5XkBCDxSDwrk5H6G4V1gVk=;
        b=lLFwUY7jZl2FL45dDxrvV5aO08cC7FDULMDS/c29i2SPhEtMixURAkz+FMyJsK6m+u
         KQQHMp6R/FPVBTm3LBVoP7iTukPr4FkKJrm1ssy/+7F9E9C8ScpfbaTIXNP414YLiDFC
         EUEx5ovG3IaPQ3BeSCr+kKTeIyiyVTR7Lz0M4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784194770; x=1784799570;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0CHRQwxG2g8NAYPuVqgPl5XkBCDxSDwrk5H6G4V1gVk=;
        b=n1h+YJqSyNSVaRYZxvKhwyrd2ds7FDPWVPnHSqdhdc2+QBUZJfTI7nJ8Sx3J0o7KRy
         qLpecbN9S9BBwjDaxszSdlbWJUJnsg7eiYKXUMGNNxQhE9m7GVv/W2BDO8w8yTzul468
         qmOgT47PEmjxDR+ZJgxe1Cf8rV+MmFOhGBljk39ch32TJzqCMHN1zE0nhGxgx+bnMPBk
         tHiYnEoerTuAuWwKtXEjC+TcAq3QouNRU09AS5LdGkGPxY3I3n/J4NT3UAoeEodD07zn
         JXRBOjmJ0lSjulZeASlk6caq6jY5bcx9ImAtYoNIaTwvT6pLu1um6D+nAfPvJqDpRuXe
         dXoQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr9fUWpwJBDkuv4UfCIPMNC1ZK1ul17kBL4sFjtJv8w04pp2ILfumMzeZE82cnZWQKQLN3x1J8iMCpf@vger.kernel.org
X-Gm-Message-State: AOJu0YzjUzLZ47ZCm+gNvf5qtgVNeUgwZ+AVphu3/MOZsWb4eo+vPJ/c
	HA9sUJyXK3RSuZaDqb/j7PJFlxHaseEkWnqtowUK9DZUB7jAviBcyory8CvUt1s2SB+9MaXqsiU
	20gnzg1KovFfSnEZYev/qxYoym4ofi/U8dBO4Yp5A
X-Gm-Gg: AfdE7clxIUFapY0UF0h1VZsP9rkN5Ody1g4gBqfwnIxGdCF2mFs9d0hPbSPEJJ5lyFC
	wJ+KPRQ9nTs2rkD5HHEcMTxwAc51k+69IwYmSS3kZqGvRcbNMfR0U6fcXNfTmpnNgXnCFkN+XD9
	I9FlowStzogn9o0e6PJAVWxovtVv4wAhWCXRox7vMmBJ2YynTHRkoqQg0SZMyiavnEnW1guFLYe
	1dZ3G9sw6rv6XlmAH5bhwh4FpG5snHBTg6d3N1o/MvZyCtHo+usUyoTXR7mGS6xIJDwdZXFGdif
	5LmcE7hXJIsY82ME
X-Received: by 2002:a53:c80e:0:b0:667:bb38:d969 with SMTP id
 956f58d0204a3-667d7b0060amr9599454d50.16.1784194770410; Thu, 16 Jul 2026
 02:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715085348.3457359-1-wenst@chromium.org> <20260715085348.3457359-4-wenst@chromium.org>
 <aldS3qTympJuVXYj@ashevche-desk.local> <CAMRc=MfHmejks83bPfe3fKzAzFySGXk2GHMA9oZdMQj0f44eTA@mail.gmail.com>
 <CAGXv+5HGjGTrqqzJrpiQhLrCn3C6H20LXq3niPnoujQLOwgqPw@mail.gmail.com> <CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com>
In-Reply-To: <CAMRc=Mefxn81d0VUwmQgwFtffkL1=Er_1VQZCbC1Sa-Qph4t1w@mail.gmail.com>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Thu, 16 Jul 2026 17:39:19 +0800
X-Gm-Features: AUfX_mzbe7WMgo0cPdR-Yi-m3qfqJETc7DH9Y1NWKQqSMqgCgHS_ReKsQ1v2DI0
Message-ID: <CAGXv+5G0Ffrh-8UohJuGPQ0e7KGpy11=X7t1JtDYLTJ_tZgMCA@mail.gmail.com>
Subject: Re: [PATCH v5 03/16] power: sequencing: Add pwrseq_power_is_on()
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Wei Deng <wei.deng@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Manivannan Sadhasivam <mani@kernel.org>, 
	Alan Stern <stern@rowland.harvard.edu>, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 4:14=E2=80=AFPM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Thu, 16 Jul 2026 06:59:01 +0200, Chen-Yu Tsai <wenst@chromium.org> sai=
d:
> > On Wed, Jul 15, 2026 at 8:10=E2=80=AFPM Bartosz Golaszewski <brgl@kerne=
l.org> wrote:
> >>
> >> On Wed, 15 Jul 2026 11:29:02 +0200, Andy Shevchenko
> >> <andriy.shevchenko@linux.intel.com> said:
> >> > On Wed, Jul 15, 2026 at 04:53:33PM +0800, Chen-Yu Tsai wrote:
> >> >> The power sequencing consumer API already does power on state track=
ing
> >> >> internally. Expose the state to consumers through pwrseq_power_is_o=
n()
> >> >> so that they don't have to reimplement it locally.
> >> >
> >> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >> >
> >> > ...
> >> >
> >> >> +/**
> >> >> + * pwrseq_power_is_on() - Queries the last requested state of the =
power sequencer.
> >> >> + * @desc: Descriptor referencing the power sequencer.
> >> >> + *
> >> >> + * This returns the last requested state of the power sequencer.
> >> >> + *
> >> >> + * Returns:
> >> >> + * On success, 1 for on or desc is NULL (optional) and 0 for off;
> >> >> + * negative error number on failure.
> >> >
> >> > I would rephrase it a bit.
> >> >
> >> >  * On success, 1 for on and 0 for off; negative error number on fail=
ure.
> >> >  * If desc is NULL (means optional) return 1.
> >> >
> >> > And this rises a question: why 1? Shouldn't it be some "unknown" sta=
te?
> >> > (But since Bart Acked this, this doesn't prevent the patch to go, yo=
u
> >> >  got my tag above.)
> >> >
> >>
> >> No, this is good feedback. Maybe we should prefer an enum like so:
> >>
> >> enum pwrseq_state {
> >>         PWRSEQ_POWER_UNKNOWN,
> >>         PWRSEQ_POWER_ON,
> >>         PWRSEQ_POWER_OFF
> >> };
> >
> > Well I think the crux of it is whether the API considers the descriptor
> > optional. The power on/off functions suggest that is the case.
> >
>
> True. That may be an inconsistency of the API contract on my part. There'=
s no
> such thing as an optional variant of pwrseq_get() so perhaps pwrseq_power=
_on()
> and pwrseq_power_off() should be converted to returning -EINVAL on NULL
> descriptor.

OK. I guess the other resource subsystems allowed it more as a convenience
to consumers.

> > I modeled this on reset_control_status(). I believe the rationale is th=
at
> > if the reset control or pwrseq is optional, then either there is some
> > other mechanism to deal with the reset (GPIO) or pwrseq (GPIO + regulat=
or),
> > or it's always on and operational.
> >
> > In such cases and the rare case where one has to query the state, the
> > queries are possibly chained together and I think it makes sense to
> > assume the "operational" state as the fallback.
> >
> > If this returns an enum, then I think the previous approach of returnin=
g
> > an error value for an invalid descriptor is better. One doesn't need to
> > learn a new set of return values.
> >
> > I'm fine either way. I would just move the checks over to the consumer
> > side. But I think the principles guiding the overall API design is
> > something you need to provide:
> >
> >   - Is the descriptor optional? What should the action functions
> >     (power on / off , or query status) return when NULL is given?
> >   - Is the subsystem optional? Should the stub functions besides
> >     pwrseq_get() return 0 instead of -ENOSYS?
> >
> > Right now the API feels like the descriptor is optional but the
> > subsystem is not. One has to add IS_ENABLED(CONFIG_POWER_SEQUENCING)
> > around the consumer API to make it an optional feature.
> >
>
> There's one more use-case where the power state trully can be *unknown*.
> Please look at the proposed new function from Loic[1]. Here we deal with
> targets over which linux has no direct power control even though it may s=
till
> control some of its dependencies. This is where an UNKNOWN state may make
> sense.
>
> This is where I also floated an idea of renaming pwrseq_power_on/off() to
> pwrseq_vote_on/off() for better clarity of their purpose.

OK. Would it make sense to revert to returning -EINVAL if the descriptor
is NULL now, and then add a different error return value if !controllable
in the future?


Thanks
ChenYu

> Thanks,
> Bartosz
>
> [1] https://lore.kernel.org/all/20260710-monza-wireless-v3-3-46253587af64=
@oss.qualcomm.com/

Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E444606C
	for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785425575; cv=none; b=BpmHEAV3SULcInIcFHbEYv58QS9IZz5kcN455VYryfssklroHnQQ+HtMhB5Qg9I1Woc6s+9BD3Hiu+y5yGUnTQ4T1D0HP87JwGPEOMfzHaBNijg/eN7z8XjphZZYpvc0SIKDkHnrMNztRciWNjzbvBYoqfziqpN2huW3o9Gtn4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785425575; c=relaxed/simple;
	bh=kcxnimzE+NwrpZXTyFkDpktSPBy6/V8uveOxUQRDcak=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H96LMgjOs2FbRjEoxK/6PGU4Foir3rs8jBITv3ub8drM07LZIExM9yHx3ub8i1YNL04/gQD8xcLyI379HEm3TjAv6C3e1L71BYeHB4Ax6aTCizAotzDoe06PXA1ezJDOtcn7uzQNGdTXCg15etyHDN29YBWjq5mXJ2/fPJOdA3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXF+ANMw; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXF+ANMw"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-47f6609c657so1170761f8f.2
        for <linux-acpi@vger.kernel.org>; Thu, 30 Jul 2026 08:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785425572; x=1786030372; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kcxnimzE+NwrpZXTyFkDpktSPBy6/V8uveOxUQRDcak=;
        b=MXF+ANMwZ8VmyC4VoegeGRmnepuPsf/pe2pK5/9RrsiXS2659ccvnhFk6+fAP3Zdbu
         gITuX1PU0vKBtnCLvzSS9cebOg2kusXM26RR20KlU4+mRzUWlOx3Pnh40k5Xu5a/Puk+
         Y+9hoxD8z+ETkXyL9M7fJG++Iw6RG6d5KzVYW+/ozUYTO+blerHnBLqLWCI6dlVvpxMp
         kj19p6+GBqcMFRQWOEeWF1JEoL8jCmuOh5yx7KmhR2YJm4lTLQHnJZc3uwDKDwnRnP3n
         tvfxGA+OdNYpzTNZHnpMND26oEa6kQdt/gcenhrUw8rZg6OAcLvPRjJA2q9EsYHf4rkG
         /JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785425572; x=1786030372;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kcxnimzE+NwrpZXTyFkDpktSPBy6/V8uveOxUQRDcak=;
        b=ZWHRg7q3jLVtdFj9dJkYm5SjmZjQKN4DCwsrTFt4v6R7AfqYs3PBqvji7TUiVNDBCX
         QNTJDx+NZb3/UJhd0Z1XzfGgAA8Aac2fS7hrNF89Lfh+Yvg/qmY2PumAxp3ijmG43VpJ
         LGI+k0mSBa2kYG8h0J9bbcTAWDb82OM0HntQXzDIykd3TWCtzXnCKSDFKA4bXjYqGoU3
         CK7hVaaplI+towfmy+zmYyHPmCPI8ryO/44ofRsmU8tBEC6VoJwEK44jxb6xQTpr+Jou
         8XI5YvtjteyUfE84gwaq7h3OBhKCJh8HhSnFFrWgveg+hvi+WCQ/jtJTmsYo4xmDwybX
         +K8Q==
X-Forwarded-Encrypted: i=1; AHgh+RonRAXja3L3xz5TdXOY+sp2UWxG548NjE+reh2A1I5oIyJhxm8RaHBLKrdeZNaErpXGp1BZ/1AocMGl@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0b9R+Z40/5ewlVVVpU+qct5PQ/ez22xqYk+z9SByWRbVxyrW
	0zvQORA0T/D3YU/G9yubygXWc0pXwpkKlXGJccyQivQOP2aFJl4ABlcaUGDt6nkY
X-Gm-Gg: AR+sD11FjRCuzOCb6w7RirxqN279K1u/pwUPb/hsuvmRr3BVSri6TV7+W69ARBZraOe
	OZEejuPTlalMktSYbroqhapVeg/8LdPtqCGaLIoUN50NrJzco88UIt3k2hgs+4/cbyWRELExmqQ
	16MbWJLR66ep7H4RCiQnJX5B9ayEtEPOPEeA1JhlBvqkmJw9gfFQ5v0i47NFhCbKsWvgfy+7BbQ
	pHmyNrP0J82cTiJfVOk/ucIOOHMHipA2rdp/sVp/9eJx6Sm/zyx85H3Sy/e9eB4PFGlHeMomsoz
	82/UkA0H/5tixQMoL3Q5MgY862tMHq6vd4QRWAjIsanU3MlHEft085OrzbfO1NH+5qvMhE8v7dS
	Qwyz6Mtdswkry4lNjs9Q+LJhbn2Dqk9tpzeBWMQq3wu9FhwTubL10RXAUyq3Tswz9Bb+LA/A/Aw
	Nm2YraUxU9HaLrixF0+Qu12JA0vfeC0rIcOGCaL5zyGD7kw2a2b8sq+FljqQ==
X-Received: by 2002:a05:6000:4383:b0:47f:8e50:93de with SMTP id ffacd0b85a97d-47fc8558e5fmr5006031f8f.54.1785425571669;
        Thu, 30 Jul 2026 08:32:51 -0700 (PDT)
Received: from [10.10.0.5] ([59.152.127.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fc88e64d5sm6485544f8f.15.2026.07.30.08.32.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 08:32:51 -0700 (PDT)
Message-ID: <daf0bb9b-246d-437d-87ca-16706113b201@gmail.com>
Date: Thu, 30 Jul 2026 23:32:44 +0800
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] usb controller fails to initialize on intel s1200btl
To: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Cc: rafael.j.wysocki@intel.com, linux-acpi@vger.kernel.org,
 linux-usb@vger.kernel.org, regressions@lists.linux.dev
References: <3353bdf3-4f33-44b1-809b-b0378bee5816@gmail.com>
 <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
Content-Language: en-US
From: Julian Silver <mendaxca@gmail.com>
In-Reply-To: <CAJZ5v0h1kqDEBYk0k05rv6f2SJ7g+TN4FhBDJYZSVUctu-0FdA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-07-30 21:55:14, Rafael J. Wysocki (Intel) wrote:
> Does adding "intel_idle.max_cstate=1" to the kernel command line also
> help, by any chance?

Yes. "intel_idle.max_cstate=1" also helps (on kernel 7.1.5).

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795561814;
	b=h6Wzq80uOlTm9MBSb+Dhk3jQQBFTQSxVp78j76VO0Sa2jPiFu78VxsgomszhKAj8gLL8
	 673xHnrbCnWxLUGsitbxiNbg7PQbZ1ouPM75iyrhrfdmM/24lQbivhtM43HbD6GQGYZW3
	 HqgwLhsBbL5RcdiKnckhRucXO3B4kQLsXwTlj8ab8VkTmi9BFhCSzXYl+UI7YLgkF6ngn
	 +IDnddeZJXGNPn20qZhpxqr7RioF263rYG8ibippr8uLGhJ7uWbcsxLoH5QfBnSPEvx5M
	 Vm9sFKk1drHbRcKZXVvTKLVAc9prRZRjmwSn140GJX5P8nh4IOQ9opNesQAFW0OQwkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795561814;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=hn0+1PqSwIkZe/gXF4MljP/J7Q+abXQ818LN43GM8lI=;
	b=WKQ4P1rFKu2Ijk23tjJ6P1g2N2UcRAhUaO5pGvfCJS/JnyrX6Al0VAKZ/fqkgRepPWL8
	 wOASYErkNEY/MAAStcbsrpQscax738WlGCz8qPAf/4NCQmnPCR4CjiCECxxWnjoF5/yoV
	 AS6iozZsuccbtR8KOaSjEI16HFu5uhu1hqWIeug+6BSZz2ProvdZ7umUsaPyPiEEJutm3
	 HOupplWemO11uc6OnG/P2qwL3Ww28AOQyPMLApNHym84vV6pd+oym+2ePLEKRZF/Kk0FI
	 jgZp9f4p2nWFIH7DFz+h8qEDHH1U+UVUVQV1YKacunCeYmYYOzdQNvUuduchroZLfhg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqttAE0+;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.46
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C850D606A321
	for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 23:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C850D606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KqttAE0+
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-67990a45e02so5270615d50.3
        for <linux-acpi@vger.kernel.org>; Tue, 24 Nov 2026 15:10:13 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795561813; cv=none;
        d=google.com; s=arc-20260327;
        b=bOSGBBzhkngo1KvS8zNZLqn3qELa345vPBqBvYjX/+KY+qEKe4ucHAsJoECqk7NwA9
         b4UE2yr3wGbSfBpzFfI5oehweNr1dpdR8XiGb4gjUJGUsORcbOZPBa/yIObOi9GPOOJN
         jo3mFWdC+8RjrT57mNs4MZXFzOOLUQc+LSF7I+DXgdcq57W/Cnm+/Kh/aYp9+xtj/75h
         Idh0YJ0y9a8vSFnfDRQ4T4oCobjDy2yDqiwrG2AL87HpQv/AevVZg6FFJNXq1Kp/nWgD
         H4b6PXXc5itXc6PcRVk+Q9iWp04mLATRZsFWHp73HNMSn3PoeqIaqZqP0g0XZHa3XNHc
         zMSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=hn0+1PqSwIkZe/gXF4MljP/J7Q+abXQ818LN43GM8lI=;
        fh=GCUqFoE3JR2eOr5O6zZrmfOt9ol/8DTYdKlXKhvaSl8=;
        b=d100WB/lrHjrpwcE8wrCIEBlWUSYeR0dXZdAFu2p83ZSqUEbQO1oS0TP0UC2xwRhYf
         VaF/fnfNs4FbNP12pW/OZKVeFsj/aXJ+jKY6hAKGnfTbOq1PdnnrsYdcRZIl9chH+GMj
         cvXSZdSS/ygZl1GdNBi0wz9iNlO65XOUZpPavT/MaFAOSi72s6PXbvAcZlCs68/eBCQW
         Kn6ZS/sk1cajWGeuvJe5rzqu2GrC2Ll3vHVXYNUfW5Ol+/TKDFLJsWSXjvDjpCxEBoTQ
         V1NaNIvyA0I1KBBH+vcY/9cKP9jjPx4Dk1aKz50Qkfpcz5jDEt5m+d0sLscK+ULv8saA
         0BKg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795561813; x=1796166613; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hn0+1PqSwIkZe/gXF4MljP/J7Q+abXQ818LN43GM8lI=;
        b=KqttAE0+RPgMGy4Ec6nastU4fvOf/z1FAjdKUOukGbEfSDr1fQxtw3U7bCgUbRiGO1
         xo8l2th4c4sHFl6cU9hBW4yAer2w5B4qOCCMrM+wIlkVraqoq6n458thMkCBqjWGt/S4
         +YWZrqQqKcMXOdEeVHCoOEICIn9DQNhLPQ/ugHKKEzHduRfEdUG7pGX0+KUQ2WDId0cf
         1QOVMTHB1vYzRw978mWBleioSjGxnIhfdudhCNcUcEzoGMJ+xau/4aBmA+OSlDkTefW7
         A4jzJibC0nnscLjg3wiR/DciLHZCu5dvuwPMvQcQpMIp5VphmT5/+Ij6pcb6sulG3HmA
         DCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795561813; x=1796166613;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hn0+1PqSwIkZe/gXF4MljP/J7Q+abXQ818LN43GM8lI=;
        b=fCdH2NsRhakjeTl8s7aQYLy/Lpt4VoLu5Hvkmz5qpePIMXjetsukxD7xnYjYhDvzeM
         se2MgJpRZ6/+Y01S5qe+eltY+WHDTxfnqBQBzqO+LAgDSMJi5X2xi0HxM+SgLP7TAagC
         3X2KDppP6s+fEGx7CutIfp0wzQYwlsupsrcS9oqp9M0D5b1a2iSkxC31hJ0oEn6m01YB
         x+uxgfMFtoqWNlHvHH/U70dson1nqufp+kTFNaSmNrQsK2TTdYBAUKeOzOv8Jn41zZo4
         fN6SZnPl4wRQ8iJ2hYoKiat6cCQte5Lg7c6NpXf3zNf7ZGopaoOwtmxhJEVHJzI2T/jC
         Aw9A==
X-Forwarded-Encrypted: i=1; AL+hErFhx3yldxqyMl4JygngxgvCusdVWsA9a6ZfL1oXrH4v401K0ih4HzUXxik3LMcXhhVR3rYeY2fqvypj@vger.kernel.org
X-Gm-Message-State: APuU4Z/TjUkh/F/dwLAsT0W3vrMwbbpo2Vau41BIiJRLlBxh9utLcgT9
	AXlNtHESnkgrzoLbhvswyYF5DNGIoM2aGXxJEeGU5ezsvVd8U9l5KuhP/Mganp2E14l/tIXLp69
	L7rGoxCwCZ19UbI8PRKEWA8QzH7TjV+5DVgEaWFs=
X-Gm-Gg: AZFdTZdXatX1jiaputEQee1uF1z7U4IT6vpIRz75Uv0uFoo8wvmkxrBM0/Fe0dffqSj
	pSB3AI8QnO6fdB3UmRnZMjcl21wUcF0S3fq9+Yme9F3pKrlVi8QVCwEb1O4XhVL8jC4TgZasQ46
	iINHWBFbqMTtocfAdnnumPu5PEcsEj+yO+ALSwT8h8PBwwTiutlztmY6dPz2TsYEzlrDnYzLPxZ
	t9Wt1PZ91jJIlmRg3Ik2Jw9jP/RObv0vCAyoOvXG0dz124ocPhNvMQ2XThn2deC7SFVwQLLmpC5
	5/DIuhzYU4nC3s5OC5w1qoubOjGTSRBf59ljVzCKJUY+xKZaAw7l1Y8j+MnDBppYsDc5HwqCuBG
	bKugjk29w1Qbu82eXMAWUwLvK4v19CFokFDg=
X-Received: by 2002:a05:690e:1382:b0:67d:9d2b:91c7 with SMTP id
 956f58d0204a3-67df443cac9mr7933863d50.54.1795561812707; Tue, 24 Nov 2026
 15:10:12 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAMnz_-Dgg2eCgZxcCaGuKPV=3-kCfg7ajd9w=vs2fGL-Cb6hvw@mail.gmail.com>
 <f1b7d729-771a-4fba-89c0-996a8a168126@linux.dev> <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
In-Reply-To: <ce46d69f-2a3e-45fe-abe2-f643f683d09f@gmx.de>
From: =?UTF-8?Q?Riccardo_Zangh=C3=AD?= <riccardo.z.dev@gmail.com>
Date: Wed, 25 Nov 2026 00:10:01 +0100
X-Gm-Features: Aa3M54rb6RWkm-PuZp35gli3zHV9Wd4GPfoXO2Q-4EKdCSZqJ0SYAzQEUszz2PU
Message-ID: <CAMnz_-Dztuj3CRsxcVnfe2=OCB3tTJzK6Lu7-AKfkbuqn5N-UQ@mail.gmail.com>
Subject: Re: [BUG] ASUS TUF Gaming A16 FA608UM: working backlight device
 differs between MUX modes
To: Armin Wolf <W_Armin@gmx.de>
Cc: Denis Benato <denis.benato@linux.dev>, platform-driver-x86@vger.kernel.org, 
	hansg@kernel.org, ilpo.jarvinen@linux.intel.com, 
	"luke@ljones.dev" <luke@ljones.dev>, "ddadap@nvidia.com" <ddadap@nvidia.com>, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Nov 2026 at 21:17, Armin Wolf <W_Armin@gmx.de> wrote:
> AFAIK Windows will automatically fall back to the ACPI backlight
> interface if the driver does not provide a native backlight
> interface itself, so this strategy differs a lot from the strategy
> used in Linux. Can you share the output of "acpidump"?

Hi Armin and Denis,

Here are the acpidump outputs, one file per mode, taken from separate
boots after switching with supergfxctl:

https://gist.github.com/Piadineitor09/062d3327731e5ec38fefcf5ae9064a26

acpidump-dgpu.txt       (gpu_mux_mode = 0)
acpidump-integrated.txt(integrated mode)

The two dumps are different (cmp reports a difference),
so the ACPI tables do change with the mode.

Thanks,
Riccardo

Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794569361;
	b=w6Q/g0+zAmfLEcxjrKD1wbHyJkvSZr76ZeStRhoBwPJv+LpD/5L7UnGp0t+ZX+UQx1Ok
	 8eJcxwAFvXaqIkFnDzaUNu01FRpNyZ8K775KhsoiGaNqYrXYMvwg4EIY0h2lpzFf/Amhm
	 AMxkE5G9mGgA99RDExYRHKurJhHEiWNI/q9gNiCE1B8UwEsmEoaD02xBGXgv8mwwk0sv4
	 C3TePdggIaPaHyFsgnLJw5Az1NxNH/1XgGXH0JsliB66bVjqBA65V7riGH/Ldeg/y2vAO
	 2edP1fau5NiKQmKmPoIsLm2C7p7xM9JqwoOiQofe3pwwdSrZJfySxx2l3UpauCS7Z7w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794569361;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=y5+YZN4kuYSMz/+TK8p/WErG9vs4h43P03FRIOTzw1c=;
	b=d9uvkIKJpsRjak9EjonaYT1ZRoDiDCqwIIuaFkRSptpv71RuKYhwIqOV5WQ7T162re07
	 gTz5x4qA6utvLS0Dcc2hwAPbvPjtqt/BgwuIHO0XmmBEdv1r8axd98UZbFOhbj7ANKx6A
	 0bps2YAM6cte7dz9dvvtnc1t2csDqKmRhxT2SkNuMviaGyZCUe1oKF9vD0xsa9iJXhW9w
	 JC45p2XZtup6NY/0WAqW6Phe8sTndPlDEg3F6AesEYrcnM/+ldDFgG4K+3wztBwKz81kT
	 WHIYroO7o1BT8s4i0G5EdOMc1NNGHtdpL6MxaQ89eN0XZXo7immBvZpMeY3o5v155VQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v4LfJo7t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF5F860A2611
	for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 11:29:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF5F860A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v4LfJo7t
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b33de9d2b1so5902217b3.3
        for <linux-acpi@vger.kernel.org>; Fri, 13 Nov 2026 03:29:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794569360; cv=none;
        d=google.com; s=arc-20260327;
        b=AmzZbKKQFGGWICKYUFK7zZ2U6DEaZ/bz+SfzMQ3eab6RMXFqeF9+1MIb3PoUYCYjWL
         1iWSOMW9x/9cQV4x7HSt4231KmnZv2H+ozuOOj7+klbNmvYtc+3jDgeSSbBhcPmMy8tk
         8npw7C4e42Icdu4qiE+yiuztxJh6HbvQC0KVbYx6lRajc89IRUzl7wLAt8o6HikfBRf8
         EFgLU729d3bUvFwyivXjWmegy8YIMaUSXW9DFOD+bHq7ZK7rUhVb3r070xJZH7g//oIO
         Ugdt9HnABkUEiLIQUTM2OeR8P5Y1J+pSmgdJ1nm5c8I4FVS/WEE1MN3MVYoeyXCHWUFX
         ozRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=y5+YZN4kuYSMz/+TK8p/WErG9vs4h43P03FRIOTzw1c=;
        fh=hmUnt99a7jo5BYub/LjE5TC8HS9AYp13poC/LaIteuo=;
        b=AYu96+r+hxhMYWHH+AG97fj57A+YUY+MToLXbfTb/F/AAQ2osD6/T1ua5Gz2rszd8P
         FmUZ9vKCvpqswiHe1ksadzwYnB1iUQTwFoAkprOP0hLC6uLow64yukvHaLes1+TNpj8q
         uh7wAOwiTDBY2ZeWpCmx+3zMs9OrTz0AsYjVTG9F4sk1yC9UIpxYzrq4/VVHILZNoJUQ
         x9Ko0Nfc86vZN0qgi/g9i0Jx6jAcLYD3c8vIjGv4wP3NmyASFpIIV53WswV6mbsOJ/TA
         BVs9Vcuuc/a+n41DMOfAOXYQ9liKxDkSZZgP0FfyygpY2foYsBUokZchewQWJJ9BAx7j
         ypTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794569360; x=1795174160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=y5+YZN4kuYSMz/+TK8p/WErG9vs4h43P03FRIOTzw1c=;
        b=v4LfJo7tquKOZY7sBr/o+Hs9E7el+fw7zYEK5wgnK9ANucz4kI6u1PItAnG5C60p7q
         SM/U64waRJamGLxooX/xhSyOROaiF5Bu6iTQh+XnIs2wSAmnbDNa/WGCoFMa4epVpFdK
         bFW+SqbdKRlnQTUNmVKkHWgeb9M+tfQN8eidD/3lh2AUuqDfQLcuCsUidvSCLj4q+Fj1
         D7TLyhUg64xdtQiOY/tQcj9BROnrwR38gnd/BbIEGmAOF19HN4q0z2XBeieYkasTdAef
         NoHsRse4Ch+kUq42r9jKQEVD9U4p5L3LQITtzFdXb4BqqgDWVpAVcezdFaQEYdfefJ2E
         73Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794569360; x=1795174160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=y5+YZN4kuYSMz/+TK8p/WErG9vs4h43P03FRIOTzw1c=;
        b=gZzI33c3riPrFbbJVlX+ky5+vnPPoXTdYqG3duxTCrcC4zMVcEx0RmOzznx1OlIQrj
         kNysPgxUYtqqkD686JNqYYgZNBQc/BScxp2rQJdrpN3OGWhvVhlpGSiAKGxwVnbioRvY
         p1mOkxmgu/5D6LWWVcYkLlspRiO97h3k6/6SmdGN+Cv941UacFDXN6bURX3bMv0L2lxT
         hLwbUtiKTCcXoJlfiqpcXO82Biz99tJPJO7NVGSVEQRfC7qGV6kBDwu36yY8pEg40rJE
         nnPg+qvrvuBNe13EW/rO0w+uOEEgdG+Gga8Ucl2uDdSmMX2/RTtYxxvh4lNI14SzaLTD
         hrIg==
X-Forwarded-Encrypted: i=1; AL+hErFaAWCEY1H/AttxcKt2LcWx5/fe8XbuuKEY5wW9uGe++LgS9tjg5Lm4A+ByhRgVqpYBswclzAz114Zx@vger.kernel.org
X-Gm-Message-State: APuU4Z/nY/Feb5s0RycWgftVEEJu2CzPpZ/mnwVzkWAX62eOJLThLl5o
	KL9B9or6oscKnRPd1uN703aY7l205l81RScY+Ol/u40/xUa0DkrwA3q5EYqX7YNpE4IOCMmdMzI
	jE7sR8F12UN7pLDq+808+71zbmMEZIDE=
X-Gm-Gg: AYBFou1ulevdecJ2Vj02zYr1C1vgPGDA0h3CN+DrKFeNlmjG45SL0nG1UQp0A7yUueF
	xVaOScW0plhNUFys5FNLO1CN5uzvM456eJVWdZsmDEeQ9qBx4TBErKYZYXHnxvJNUh4G4trVKRh
	sXRpC/2wRdnK09PamYR7IFP3Xeua4lp+D0tJ821T/Znm190hXrAoeb1l7qAmSzads8BlhsSN/O8
	CSXlw2Y3zy96xvNdH1ncFH9PPUWHmC2WoQn70kdkrLL/uj9zkW3cg3Y5SJ06Ccxudjxre3q4iM/
	c+UH5sVw4B85VPD7Kw2fEu4GSwNonmxhEu6RJlO/uOCN39jUU9AzVMmo/p3QFsNfT7CygDQOC7v
	3Cah/KtoRkBoLcDfieG4R1A4zkUun7ZVMBK3UASk4AurhU384ty+xMX6+5ee1BKq+0rV2JDvrn7
	FUl9iyS5NoxG4jBoPEF3XsHZUVigEWhntFqNE55yZ0p/BaKmJmDdYDT4Qb+Ir3H4uQKJ9wAmFHN
	CWPzQ2qOyDzVinMkM5ZdLgem49pqD9A0Y235nGdBXMGjJvzK7UA7aRk3XxzdkwuS8OO4NfyRwhn
	eK30hSU=
X-Received: by 2002:a05:690c:a05c:b0:8b3:b952:39db with SMTP id
 00721157ae682-8b4aa239ca9mr10091467b3.23.1794569359843; Fri, 13 Nov 2026
 03:29:19 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113104218.32566-1-farbere@amazon.com> <20261113104218.32566-4-farbere@amazon.com>
In-Reply-To: <20261113104218.32566-4-farbere@amazon.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 13 Nov 2026 13:28:42 +0200
X-Gm-Features: AclHuK_l7pbfT9WtHP2ajmhTcb5eCdGVukVYrSxkY0jj7LNvZaOiW8nn193laj0
Message-ID: <CAHp75VffC0+So4CErnh7eKX6_uMPqBJ8Q7Jz5yYZ2GSJv92amg@mail.gmail.com>
Subject: Re: [PATCH v6 3/7] ACPI: APEI: GHES: remove unused ghes_{,un}register_vendor_record_notifier()
To: Eliav Farber <farbere@amazon.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Armin Wolf <W_Armin@gmx.de>, Sebastian Reichel <sre@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, 
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>, Tony Luck <tony.luck@intel.com>, 
	Borislav Petkov <bp@alien8.de>, Hanjun Guo <guohanjun@huawei.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Shuai Xue <xueshuai@linux.alibaba.com>, 
	Len Brown <lenb@kernel.org>, Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>, 
	Pawel Chmielewski <pawel.chmielewski@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>, Breno Leitao <leitao@debian.org>, 
	Terry Bowman <terry.bowman@amd.com>, linux-acpi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, acpica-devel@lists.linux.dev, 
	Andy Shevchenko <andy@kernel.org>, Kai-Heng Feng <kaihengf@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 13, 2026 at 12:42=E2=80=AFPM Eliav Farber <farbere@amazon.com> =
wrote:
>
> Remove ghes_register_vendor_record_notifier() and
> ghes_unregister_vendor_record_notifier() along with their
> EXPORT_SYMBOL_GPL()s and ghes.h declarations, since there are no
> remaining in-tree callers - all users go through
> devm_ghes_register_vendor_record_notifier() instead.
>
> Inline the register/unregister calls directly into
> devm_ghes_register_vendor_record_notifier() and its destroy callback.

I'm just wondering, if you use --histogram diff algo when preparing
patches. I think it might look better for reading with that being
provided.

--=20
With Best Regards,
Andy Shevchenko

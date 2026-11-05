Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793877896;
	b=Wqp1r9QaBDJu11xR5HRaT9JSb1NVJ3bqYRmQ96W2pK2rqLKwcz/j2CyDyepJgQZBaxJ5
	 nMxJvc8iQtIBFHF6LALDzGQNRTOyMHqo4UjTzJOmX2/DqJpZEvTw2yE5zMSgY2Hmfb6u8
	 c4yUb+XF/rfAXyXnbsc7XEcuVsoTnGBqB+4jn+0bvSjn4ZMcWpflI/RlebMNx01q72+gc
	 u8saRS4I1Uy1RtJS22FhgHfes+Q1bwQOoUdxLHAFTz9Sw8WUPrn1dM7mxWI4MFohQSOA/
	 1LRgzpHi0ob32XdtS+5/3N+1DivyP49XyAsNgesrcdmuqrS+SiShNHt3BsgmKU34jOw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793877896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=HjqOLsC9Wph7UCiYV9mqAnewJ39Cf8CLpFtU3LV33mU=;
	b=2ElAb8kbBt1mskZrV2OI7j7NiyBiEiJQ3ic71M+NKGpt281eUfbHQMVnc5VkuOpaI70d
	 nACvxBWkBfstYA0xTlGxvyUAno0YWhYPMhztD4WPaYIcOFR/mOLGaMaqFpuYCmYSDZyh/
	 eHkEXDabu24gxwYNmhtFO9ufjOr0UDmktjljxlZmapr0FC0qhxPseLfm8HvJOjMEy3oVN
	 3QZOYcDQE/mdnKUxJdB2kff/VfhpIX6VmDqtWeN7Ww3/Rf/FsYffgL8mzUm5Z3T9TUghd
	 fvnNnjJ7GUgva9OhXlRxAJuDRISUT8uHpJ5AVYRdNjSceATKJ3A51ajo3T5dEEq9z7g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCyRuxf0;
	arc=fail smtp.remote-ip=209.85.218.54
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB4B606A329
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 11:24:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CB4B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CCyRuxf0
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c4ced671398so269935466b.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 03:24:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793877895; cv=none;
        d=google.com; s=arc-20260327;
        b=g3VJbpGRUQMtDjKYCWXB+kWQ3HoobNHnjKwdQ6Hl+sXLtTYvDGY4vz3iS4rS02Ueoy
         IFA2IUHrY6u8bVs+CX8yYZDppHeFwrU5Yr8Hd7cbsTA+XDYeGQQ7B76wwyJS+zrv3moq
         kZz1ZMjbPSQ9ZNYKEntplBWmmLZJZCEMWvN3uy/yF5jFKZuoF0mBh+aNkZbzi7/DO3RU
         qSKMDjdhsIHMF3Qra4oDE0J41vm4rVirWcm/m0e1S3kkw7yk86xIiNolvC5G3VLJqIe/
         PR4x3WnKbDYg+X6/ZAAtJPdoL8EsnldgX1PTl7yMDWETYhpA6XGiu/mfFaEeQsCXIUes
         Rnyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HjqOLsC9Wph7UCiYV9mqAnewJ39Cf8CLpFtU3LV33mU=;
        fh=CGwRoiLzTBCb07YkT4rg7DKXowOTwQ/kAAm1xlwWflE=;
        b=qpuFKA5bpIDqykcq+7cLuIUhh4Oy/k5TBshI5deBB3qCqam/XD1SweYff+uSLLACpD
         vLnCBSC/XLoEJZDwMoq7+iuA5ndZCUeokek29YYRbiweu0jJ/GvI6webZQkOAg0wf+9y
         Jl3V7gi0a+MeoCW7oo0q43k3SmetO5D+dNw7XrfMJY+D/AAOdZlX/euLVqTZCB0ihNwI
         Hxw5x+QJqk+9qK3+PWj0lkkAV+DaSjdfAbjAnnqciMZzVLeu5APUHTiODz3TmVnrSY4V
         2n/Sb9nf4codVmxcxcBbvWaENf4wEdh0eecNbFzfZE7eVm/E9wQ87XFNwi5sXTHK2tyq
         lmiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793877895; x=1794482695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HjqOLsC9Wph7UCiYV9mqAnewJ39Cf8CLpFtU3LV33mU=;
        b=CCyRuxf0P6J6k8bWApFVRzmmmQ4a3nezFhlH23PgLEzGEftofIdTYht54rkMPSxqZ2
         /N6dWyeLvZ3t5ckDi74aRNo2yvUplMuzeF87p+SrRLFswIheQK11EAMfgONQoUmsEnEe
         ak3lTmUJPNYDs7n+W3y+FrnQqNLfaVlgsCS7/AoEJSXFGJS/uoo6dTu0piEUOcSwoNXy
         qSQc4qOwI5/lBCfCziXhsnKcQriiZn1/LpLXFBVGVCBa5Nm1lMvs3nCLwfOv1t+ObDwv
         66A1hJWg9khNx60mm6v/I6sK000uQTULOFdYaXulbZrAc/k9t8/TzBP4LYJIO4G33uyO
         snLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793877895; x=1794482695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HjqOLsC9Wph7UCiYV9mqAnewJ39Cf8CLpFtU3LV33mU=;
        b=JeQ5UL2nduhWoQydx2fpaxTnZvcoQMMaARzSwjV5lwsZeo8vTSpPM+5rSRyTHgY5Qz
         4rqvKO05WxCvajDgH9LM3LDiKgaoFxBhnajMa0Z8FYSi+T8VBAQk1Zcw+MWhhoQ3bmUx
         T1HLgcPG+AwyaHNyPIwx7BzxyrYfQCGR+emKpuqDgKdDpwlNDaxj+isMPNAKN9WbDCf5
         /5aw0vByySxr6Pg8q/ZD1TV36d5FQ65tcE5HGOFFGZIdhB4Fa4fUigwLIK6ix8rZgVf2
         JhHlV9nU609Thy7w4xdQWIesxCAVXiROym4pM1JfogvpFfDqcU+qqNFO9HLJH0zPGEOb
         21MQ==
X-Forwarded-Encrypted: i=1; AKwUvBxkhSr9vP7XGjGIgtHpk8XpOoCJw483sgccdhbFv1dRFYpSRanwdNtIcG/s3M/zqVG4nTC9u0+DdYwK@vger.kernel.org
X-Gm-Message-State: APuU4Z9iitaHdu7zaFdj0JuYfwxC/yEFkYNs0k5AFGvCSjJNPmFb0GPM
	5eEBuddHXRE10+jBdyXoTfYqYoh2Rumjk1tssKF1kq2htwb8K2Crs08Z5T1fwdYDuSB4jNDm0Em
	NIhnEPD3ZToPdhx1rAmM+8yIhXMetZo0=
X-Gm-Gg: AYBFou23IkdqKZTXUgDNgfColS2vqz9yyu/FOBPgFaXEjCsm2yUm+f8wfZ37C8frW5l
	tjppW+NL+cfzie8V/O0LjbZwB9L2IUMpKyRBSSHiLsTh+jhzm/7riv2lXvLFtwB2UN/0k0kHerQ
	rCIgM63ht/G8mi7opKcL/Q0yan68bl7YRticIdYxqNJeQxvrEmvNDlmdkLuT+VCmgZ1iRmnI0uJ
	weGZFHRO7T7y4tDEAsx6hIYde1lkbDGw2LcRjXyTg0hURA3/+2xPDbhBAf7fcJ/a5wxEVtIJZlx
	K4UFaUzOHu8kJveSkSB17hN9pgg9z0F0G9wVqJb1Ntlyohb/LlZWa6xxXM8yEKlW/8u90g9300r
	9S1kLc73ud7Df31eFvpejJ1TxJrxpKCsROHEgF8h9TN5MicYEvKAZENqBAVaXrQ6UTEwIoVdA7R
	VKzUdrdHuIG3hTuhMSjogk/XTbqA07nFUjP0fw+Q4qMNFoegzZJNJW29E0LoQewf5jOo2vVqWcb
	WSWtG1X/D0F1wG5Unqw8f+fSwq1tDFgss4wkbnvNI3X8E+dadFmvp+a36G4ug==
X-Received: by 2002:a17:907:6d20:b0:c46:75e7:25af with SMTP id
 a640c23a62f3a-c4ca7a0dcb0mr1704269766b.11.1793877894389; Thu, 05 Nov 2026
 03:24:54 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793876837.git.alx@kernel.org>
In-Reply-To: <cover.1793876837.git.alx@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Nov 2026 13:24:18 +0200
X-Gm-Features: AclHuK8KWMbqNnaK7YSgn2BAcqklpjMSStieDr0-B_LC0DeuPxzb2lhrGJOckGM
Message-ID: <CAHp75VdFH146fNhw1ysUbgCPbpv+K++kWvbyZxU=V7tDh0T88Q@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Add strprefix() and fix a bug with it
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, alx+linux-hardening@kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Andy Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Linus Walleij <linusw@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:13=E2=80=AFPM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> str_has_prefix() is based on sizes and lengths, which means it must
> overload the valid length 0 to mean not found.  This is a typical
> consequence of choosing to design an API around sizes and lengths, and
> vanishes when moving to pointer-based similar APIs.
>
> This patch set adds strprefix(), deprecates str_has_prefix(), and uses
> strprefix() in one place to fix a bug reported by Bartosz.
>
> We can later work on replacing the other uses of str_has_prefix(), which
> might hide similar bugs.
>
> Testing
> ~~~~~~~
>
> I've built this patch set with 'allmodconfig'.  I've not run the
> resulting kernel, though.

No, all lib/ new code should be accompanied with new (Kunit) test
cases. Update the respective lib/tests/* for that or if not yet
converted to Kunit something in lib/*test*.c

--=20
With Best Regards,
Andy Shevchenko

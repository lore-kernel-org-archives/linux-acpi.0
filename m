Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793878075;
	b=tyBBx2u43rjyiCOftPcSnxxFkqrwtVbO0YPa566Xl7fMPzUbaEMSF0SwA7aerKmpWzhJ
	 uDTRdECroyXUBIZPEcn5QVkuAH3GR6hoYr6yx5onEuSlevjau2s+M6JYsvYhM36LY25LM
	 E7kJStq8yW3Vwn4/BJlwjcz8xCAQ07auz0gqhSJMTAvGpnix0SAezQrLU8/broWuOn9/P
	 7gfdPi3W+Dk3aeyglGu3cEPxu2cu3LJNh8wwkNGrMj1twbJ7zPDtTLHTROShN+zAHUCl3
	 4yzE5Pc8X0W+aSbyYk8IudnErruNiM3FhUK4aw4F4EhUfOTr1flX9BPcwghtb9bG1CQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793878075;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=UgymWUGDvRFV30kELqGcA8Yq/kp5tSw6vqhDEg+/UkU=;
	b=aTjxViDweeDjtLdkrVDio6cyuDwsEB91C9E7wHKfc8FSJK6oylmQP0y7WodWlAPChH6d
	 Dxi8hzdYWfO21Oi7Xixd2rxH2cGCtjH3IeL4LDOZB91xWJxLkourDC7RkKQYgf//Wwefi
	 7OXjUZWhfrc6l7nH2X/LeEqlt4I/iHJ3ekR3tUY4LaGalMD9ic0G6ayTwcsSf9cjP081d
	 oO/8H4knF4dLlnfb5Huxm7BjK2wsb+rTQLPnRTdsieFg/ERJ2uGuTDw4aQWBspDVNikhu
	 4JMUK/JtXfxjjuMq2UqhpDEqbHecBRkzed9uGGFAOeoH2DO9WfDlpr7JveXu4PVBwgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skgm5fm6;
	arc=fail smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93622606A32D
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 11:27:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93622606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=skgm5fm6
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4ced671398so270329966b.3
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 03:27:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793878073; cv=none;
        d=google.com; s=arc-20260327;
        b=srPtAMlB1yVfQCCRWtUcKd+sKSIkVsrLw5dW+zhfAlP62pBkEOXTXaXMfa71XHGv73
         cMVbDIJCTFpU608Td0leDchgxgmnBBuQlv31MyaTjx2mmPK6Ow8y9SIKUc+TQsfueHr+
         YhIS7K4UBjqQntHFb6093m60v1D8q8HIjT2iP04OTBI/tZyL7lLk9iw3MKdIWRd/ScAe
         JZPcfPZVg2vb6kdBThL2jt3Ha9+PjZX3iR9WyUFVJxAUUJhS2Q3r19G7T91Ctlnu6mai
         yxY3cmdPMaQKFQpw+jkgY4QlrKSoosjXRF6JfTtuA+uqSZTtTYfFJXpeQ1rjdh9I9vpW
         swQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UgymWUGDvRFV30kELqGcA8Yq/kp5tSw6vqhDEg+/UkU=;
        fh=Z69wCxrUqbDvngT53Ym8gvszGD4GbZDCXbZysg9ticQ=;
        b=Exo9rHRiO+eXYlKs+pXE+OnUPCvfdjIPuU5upxNjH1yyfjaU0Q3u4XrUfRy8rQLK39
         6NcEKlSDSRN/bw0STTfcm8w80+RAaHCjpVI4an11NT265WF9ipx6MlQu4+KVvv6Tp9dx
         r4QVqRHFJINgIkLDCAJSHd7lmCoqvjBGTv0Ck3OCj8ezIj2SjFYvMNOcvY521wDluFmf
         0QJd5/Jt+CUojd54R3F9dLyXcmyTJiXagmLctXp2YCmIkf2iiOhNgPkmv0ln331PHhKn
         +a+Z6DIpsjt2p0KUIFvmFiQVt/WO9srK/6jwvtImFXU17v8kleVXtkMUNR0vxa4TMKCf
         uJiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793878073; x=1794482873; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UgymWUGDvRFV30kELqGcA8Yq/kp5tSw6vqhDEg+/UkU=;
        b=skgm5fm6oAWAgv/QVCq1EFm/mHk6ogMQEriq5kNbbrdxCpxscJsl+DVbnoxhuFlxLd
         vpOEAXk4t8Us8lYbydo4Lkh/rrArrqli9+hvlvKBU8YfaDLyI9GZGKoooB/b0vdPaMYV
         JuKkZi4KuhaladOnnC30rn5+5auFXjI7odgfwe3bCKV6tngTAW6ACSoUfVCWKJqsXKIX
         jxEtLNpajovzg1ZAn6mqM9CQndl7qv0vcjhh+A3vKBUj/zkiqZVv5xWyOSeziy9qx4zd
         Srk8GDlwmg/wA20VyrcEYyztNba9JvovUh1RMB2E2C1KTO6V0On70HG6wXIEyNfWKBLP
         SN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793878073; x=1794482873;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UgymWUGDvRFV30kELqGcA8Yq/kp5tSw6vqhDEg+/UkU=;
        b=szHuwneyM43GxVlUv+Vnc0q8ckN6RihhxXg5/2Hwv/uXwLHJ5aZJcUxHwWUDOY7bZv
         DTovF7MA4qI8XamF5kpHlEksizhlFAHjv6JbvNeFSWMrqD3dAOUKp00FJ0XTxWyujReT
         mvzXwW/Ql1PLgovVNTGQgScgaBhjB4QZApU4S67GPxjj67QaEQa1Vx+rjOCw8UDdRMRv
         lu23nO22m5yTZ/BExWoNh5ID/DBoR7NIfOxbbv8HC9bHODMAN13Xwp/rhQz8uI1iNUpT
         KYcm9u2wpFZupdXqXXQlyO2hetlDBq659S8Wzw2Ik6+yX6gKJCdGB1dSM8Qe3hllXlZO
         AI5g==
X-Forwarded-Encrypted: i=1; AKwUvBzYU6dvCT1rBNUQAt70UZbmWUeYmdJzOzYiuWOw3vAgw6feJWVqaGs9Uweh0fFUnKWBfdy9VADpJJqI@vger.kernel.org
X-Gm-Message-State: APuU4Z8meht0ZhRWMLQQQ+lrNQfVe6Yo53SLRlJC4szpd0WveVFr0uYl
	FCVJrxBR2BexBGVq143G3RooyD9hc7w7zTIPqgCaVOsPUhLcwSPfosSv9GPynVi1uO7mXYKliKR
	4kc0D78evcRZe+CXijcNcB8Y/EA3GU0Y9cQI6vMY=
X-Gm-Gg: AYBFou0HOuGRpadnbXNp5xc38TOayUAQU2oqS2fN3e2TtTnlMY+dsqa4MNnj8XEWL7j
	8IR3w5tNFNBXk06ryDopzT32GFXTM6qj6tFAtzAz+o49f3zjBRYGtcLuPYn+iqN78gYRF3PJnpz
	+Aus3OCKP02ioz1rt34Awmm8CMQfWqw7OXPhN3/AmoLg5OZnu3b1G6e8knZE6UAmHS8uKF9wIOS
	sJmAAr2jniwdaCkwOyjdqGdW4AxHm27+59KId2ySAnry4AEkseirOqBdaOeQN6NZrTBTc4Tck4K
	uqHghxxyT6U0vqZWoR/oOvNezU+zhIZoW3Zp+WhxrJiOrkyN9zzXayyYvYrlfiT510u+l+B8Xk1
	1L2moUXE9ukWGUkRP1sLOs7xAK4lcAStcJ4wGkJ8Zipy1RX2yjUBB5ZIJ6OOxvHZg+9T5tFSb80
	uVeoLF+aB+bZkHivazoBjyMJbqaHDSpLYSzIe9PVsjR/Xtv5cdh9ZPYUwVR9xIdD7p1PKSQYq0R
	PVmRLLhFrnq0VMX+3IX2ybD2MmSuPStudpv+dz1EMp3uO4/h4OH33by+5J6dQ==
X-Received: by 2002:a17:907:2d8e:b0:c42:102f:15df with SMTP id
 a640c23a62f3a-c4ca7a0dc8cmr1782618666b.8.1793878072888; Thu, 05 Nov 2026
 03:27:52 -0800 (PST)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1793876837.git.alx@kernel.org> <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
In-Reply-To: <9c81f6f62fd0e908e683c4c08b09a1f95bc2ec9c.1793876837.git.alx@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 5 Nov 2026 13:27:15 +0200
X-Gm-Features: AclHuK9RJR52OSPl8iPokfz3apA8SScdKPa_SxHmGln1p0LZpPbZ_VJGI1ROrO0
Message-ID: <CAHp75Veb=TsXJcjqQeD3ciNGRvLebGr8t8TnZju6FX5ANeVNTA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate str_has_prefix()
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
	Steven Rostedt <rostedt@goodmis.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 1:13=E2=80=AFPM Alejandro Colomar <alx@kernel.org> w=
rote:
>
> As Bartosz reported, str_has_prefix() has a bug: it can't differentiate
> between an empty prefix matching an empty string from a non-matching
> prefix.  This is a fundamental design flaw in this API, and not
> something that can be fixed.
>
> As always, this is a consequence of choosing sizes instead of pointers.
> Sizes are often the wrong choice.  In this specific case, pointers are
> more capable of differentiating these cases, as NULL is a special
> sentinel value that doesn't need to overload a valid value.
>
> Let's implement strprefix(), a function that returns a pointer
> right after the prefix if found, and a null pointer if not found.
>
> We'll slowly migrate existing code from str_has_prefix() to strprefix().
>
> Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Ouch!

> Cc: Andreas Schwab <schwab@linux-m68k.org>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Andy Shevchenko <andy@kernel.org>
> Cc: Bartosz Golaszewski <brgl@kernel.org>
> Cc: Daniel Scally <djrscally@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Hans Verkuil <hverkuil-cisco@xs4all.nl>
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Cc: Joe Perches <joe@perches.com>
> Cc: Johan Hovold <johan@kernel.org>
> Cc: Kees Cook <kees@kernel.org>
> Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Linus Walleij <linusw@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
> Cc: Saravana Kannan <saravanak@kernel.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Tom Zanussi <zanussi@kernel.org
> Cc: linux-acpi@vger.kernel.org
> Cc: driver-core@lists.linux.dev
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-hardening@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-gpio@vger.kernel.org

This list is twice as long as the commit message! That's why I highly
recommend moving it under the '---' line below. The email headers will
get all the listed Cc and git history will be clean from this rather
noisy list.

--=20
With Best Regards,
Andy Shevchenko

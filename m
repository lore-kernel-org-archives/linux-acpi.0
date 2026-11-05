Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793921370;
	b=m451hhdYbLxbmwLVG7OdW9TeQIbkRpKpu0WvuX3wsLJXT4j1wWg76FQFaZ3keDCWKknS
	 p4KveKAQ+c8UmvUI36OuEWVK+k28EYGbzdZrsrpeOQe5Mz/odR0bJ7+uhycYGSq0KaKPG
	 YjquSZAxXECEvqCJaDV0KGz4hXnP2ieZ6jd2niTWVAD22ht6ZPQo6SbT4Iy5yCevfLXju
	 bfgul0hdMV16CD3oOC4VDwwCX5dnUtc1yBCwxi5NUadpfbBJ43Jy/LIzpDiW60kSvlYGJ
	 6hlt4CfiHdUxJCn+rTDSdC4iUgP+tldFzX0ixh6nYxhWmGFD8JWLn7SvXKr3kaINaBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793921370;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=4CY6kteulYS6YGOwsvXKGn1qUkLcgM9XJ2I0e0tk+JA=;
	b=29MALG2zI5BZiOHaeSj90FBCKNdf1ACefBR4BDeWnCkXFv1gC8D0GvWqQMisKKx4q6Zx
	 P2jC4/QFL0i8n+Y3u03HQRqzevSNro/sv6V9YcukQB+36JCfOpBYRdNdMoPNTj99gc1ug
	 P/i43shOnbTtrKxyhgXQ6/omZU+CTWHT4luR/Ste7jhsz0r2crsE8wIYCgk+mUQN7o6my
	 Zu7Yl3sEhin9Z9oAHNuAkk/UzpgR/jXHd4FDS5nlFiywPMobUweSSt+/FHhQifpweyvQ9
	 kuD7oPQ6/5Hk/plGz5puIy47C9GE+mjQYnSSFMpBwV3cQKkTpvRBiStjMNwhD9yNh7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=linux-foundation.org;
	spf=pass smtp.mailfrom=linuxfoundation.org;
	dkim=pass header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FY7XN1Rn;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559E7606A31B
	for <linux-acpi@vger.kernel.org>; Thu,  5 Nov 2026 23:29:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 559E7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=google header.b=FY7XN1Rn
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c445c95d553so7620366b.1
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 15:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1793921367; x=1794526167; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CY6kteulYS6YGOwsvXKGn1qUkLcgM9XJ2I0e0tk+JA=;
        b=FY7XN1RnMNMcc3cj31lgDd+ZPLCOU7aro01jaQ99XQefBCvrDbRnWsUI5EkHvjEDvO
         65sL9Zza9h3HGOM+q0XhWehOOx6ZeZjdkPhJJAPH1hevOHanEnOeeZEMz0oYdQIdPL/3
         /0EMXUoZyLUQbn9FqpWYIAQ86QRHrMSQbwaZc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793921367; x=1794526167;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4CY6kteulYS6YGOwsvXKGn1qUkLcgM9XJ2I0e0tk+JA=;
        b=pGA47ylT93NZsJ/4OJV1JSnnUMadbn0Cz3iwJIaRyELgMOKWA6ctCW+drvmjfzWO/b
         lQri2RBrQF49whIFCAHKYA0m0U2VU+JrG1ek4rV9wTPoxm16JSS1qbReh4gOPkwrEIS+
         mOTLA+6jUpizE6ubwwCM8yjcftu4aSYpxdQLISGV2ZXbYDoP4r7+v+mjqyKsVM/UQWKH
         CpLirMeFDWIAgMgRQCr4wwNUUuzn0wS+WhuTz6rQ/EkCv7m8waA9rSYh++BtxU/9GpNn
         zYpvsx4RRNtnHcbdsQ1IJX4RwDukKMXffgiNYK6k/evdabI5W39v6lERl58P/B4czP1d
         FL9g==
X-Forwarded-Encrypted: i=1; AKwUvBxzR7J+YHiiBy+m2iZ0ahvjgKb9MkBpL0DQUXYJ/hVE8imgYca+pqTQcbL3+2JJdgMf/nrM9U5MJEll@vger.kernel.org
X-Gm-Message-State: APuU4Z/fV6gkzSE0N3U9zpY5BMRLInlxEnm7xXfNGwv+Z5elzQw9BVuj
	mXD3OYI3iR1lggbA4gA/ZLb4cBABBFUxm6ocuBvYudDknBNOnjK6/c3rm1n+6LT+KnhmjT16ezP
	dTC3rncKLEw==
X-Gm-Gg: AYBFou08/oqTeTgye9XnXLbSFq7C7Q65RMjAYztpi8PONjLCtVttG3sSc5j+zU2i9x+
	i/BaIy9GeOEDo1aBUlQN8hGuHGTDAAmnof8rADjq3uMqiqh4AnnIn+ewCWwqbrFtwdz44twt7cz
	W1TE2nan49yKfcckRn5+VPVVi54Kuv/mLrI7AtXV9fjG5Qtd0esani42ShNKbQASTuqgVDgqMSM
	c9HPCt6dTt4SoeN5fHE/UICFdiBfB4L5BMz/SdaKMF6r1yfcEFDPAsyFQGR3F67GyiL/R1scPvq
	oDvfPaQmAXK+GJmw0+kHGY2HNfXryxct+uEVoCwk4uzJr6EN8GPtjOsMzrZJaDrzWbgP72Qu0kR
	R376xz7+LgRCmwAPtHep+lbexOlWeCwUZmXFW5i//Dj9qYrAxZvLOt9EH1rrAz2BZwY4L9QR0vK
	aKPuqv8100snehuFDpX3A+IKObu18+73gY5aIgZAr4lGD0wOAEaEKRkNlDO7oz4GzMo4ea6cc00
	Izy2MRVJgNoxOt9uARiMHuSLySFlqHhEeEhfjBCXjmKc/WvPJJUByz298gYhL9aX7pGizWUv6kG
	7NtUuYw1eeq1WTpP/+iSTPcPFAs7mWrNgqmlUd9bXnkGnolyLl5YHvCwmIHJdC/jT6p7fjMjXHT
	GIw==
X-Received: by 2002:a17:907:9411:b0:c41:9228:baef with SMTP id a640c23a62f3a-c4d34a6e657mr75933466b.8.1793921367406;
        Thu, 05 Nov 2026 15:29:27 -0800 (PST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com. [209.85.208.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d35673be9sm26275466b.41.2026.11.05.15.29.27
        for <linux-acpi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 15:29:27 -0800 (PST)
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b579003f29so60752a12.0
        for <linux-acpi@vger.kernel.org>; Thu, 05 Nov 2026 15:29:27 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwRZNgod0Z7ABtPJgEj0h7r37Igbqp5g/b31APQuT8zTofJD+cP2AuVVZTXjfIkT84UkcsLVhmWkKcq@vger.kernel.org
X-Received: by 2002:a17:907:9c05:b0:c41:cf68:bbcf with SMTP id
 a640c23a62f3a-c4d34c42700mr81823766b.32.1793920911855; Thu, 05 Nov 2026
 15:21:51 -0800 (PST)
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
 <20261105111423.360f4ba8@gandalf.local.home> <auyuINXEJKc1KoG7@devuan>
 <20261105115019.2fe7c91b@gandalf.local.home> <auy0O467UqOzqYub@devuan>
 <auzGMV1YbO9DodBq@ashevche-desk.local> <auzHFRzd86iV4-RA@ashevche-desk.local>
 <auzxXyAU6zyHtMtn@devuan> <CAHk-=wjD-fQvBvozu7+TjXa4=arAFgVzyixw4W_A=14Y8rhSLA@mail.gmail.com>
 <auz79Izf6Q5qOQPi@devuan>
In-Reply-To: <auz79Izf6Q5qOQPi@devuan>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 5 Nov 2026 15:21:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgGLZRQj_a9r9i2ZdhGZKKVxG+-mAj=pb=pRYyJaHAquw@mail.gmail.com>
X-Gm-Features: AclHuK-tRyoIoIlVqV1ObINoCwGUeXX8nUrj1waZW-FHLSpz23irfQuKt09nDLk
Message-ID: <CAHk-=wgGLZRQj_a9r9i2ZdhGZKKVxG+-mAj=pb=pRYyJaHAquw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] string: Add strprefix(), and deprecate str_has_prefix()
To: Alejandro Colomar <alx@kernel.org>
Cc: Alejandro Colomar <alx+linux-hardening@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-hardening@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, 
	Andreas Schwab <schwab@linux-m68k.org>, Andy Shevchenko <andy@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Daniel Scally <djrscally@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, 
	Johan Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>, 
	linux-acpi@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 5 Nov 2026 at 14:25, Alejandro Colomar <alx@kernel.org> wrote:
>
> I'm not a fan of git-grep(1), because it's easier to remember grep(1),
> as I already need to remember it for other stuff.

Why?

"git grep" is *literally* the exact same thing as "git ls-files |
xargs grep" that you apparently find so natural. It takes all the same
arguments as "grep" does.

Except "git grep" is way more capable if you ever go "Oh, but I'd like
to go back to an older version".

That makes no sense.

> I'm finding some issues with git-ls-files(1), though: it's listing
> symlinks, which grep(1) complains about.  I wish I could discard those
> with something like '-type f'.

Christ.

"Doctor, doctor, it hurts when I hit myself in the face with a spiky object".

Stop doing that. You're just being silly for no reason.

>         $ time git ls-files | xargs grep ARRAY_SIZE | wc -l

Just do the sane thing. Look:

   git grep ARRAY_SIZE | wc -l

Trust me. Just learn to write "git grep". After five minutes of doing
that, you'll realize that you should always have done it, and you were
silly thinking anything else.

And it's faster too:

  $ time git ls-files | xargs grep ARRAY_SIZE 2&>1 > /dev/null

  real 0m0.636s
  user 0m0.367s
  sys 0m0.307s

  $ time git grep ARRAY_SIZE > /dev/null

  real 0m0.519s
  user 0m1.837s
  sys 0m1.719s

(I used that "2&>1" to obviously remove the errors from the stupid
mis-used of xargs).

And it's *safer* too, because if you have filenames with spaces, "git
grep" does the right thing. Your xargs thing now needs to start using
"-z" to git ls-files and "-0" to grep to actually be safe.

So just embrace "git grep". I can pretty much guarantee that if you
use it a while you'll never go back.

            Linus

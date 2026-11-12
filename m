Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794522672;
	b=mC7mSr3NUS1cdXT+XfQeshlTMjm+nG15Wdy4HSCsdR4lij+MddFPQFteBhZUanNueZAi
	 z9cldbRdUIVosgbD1eeuQQwrc+N+BBdsXk/8Q86lUD8tJpQj/ToMO776HudZjWkZHWLg4
	 F7vNOi22bAIpWGaoQ7VVEAgsxZhKJZhdM/9vSjc+O4H/lliYzwu1iy674xxPeP6DPqJYJ
	 2EYTZ1VtwujkgLR/jWLPQqrpYqLdYMt9NyN7XEQsrnA3VrP9J0AIXNgVWvB11tWPlGI94
	 XcWdne38nIsaOjVREokbKWx5PQIYfD+bU5P1VTjrXdIAAqRFWbcncU6CmkkAU4COt4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794522672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+JTSqev9V+WnU5MiL+EzLENGXn9aXmam81GQLiwSL0o=;
	b=lijgXbCK9YIiFNdQBiFS7hKEAqbVLrzsaqWTCTwvksnDBFiz0nHzLTxLZG2LBwrboKih
	 cVx8ySKedpuC/jK+x9GNDzok1UnRqm/K+/uw6uPIiiK2YMLyqlO0i36+6UAJhXscYF1VK
	 WFSaokOPkz70BwgvAjSGwTbE2u/UTXaoFwMW17tkUTTG2ReJI6elLMfLYlK1Rr4vB25a4
	 cbWu81hJxrVv1qAUaw2Fh4CTzYNGwlt8yD96IBv9PayyT5hcoCR4vCO+ejah6BTPcyXzx
	 zBHL3lKbnKfoK8sSCsHPXCWg87gDRmGBYhsY09dY1N8F7RG9c1+Rj5hQVJTxzlhtkqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QK6ov+6P;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D5D606A32A
	for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 22:31:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18D5D606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QK6ov+6P
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48e3b22e971so120148f8f.0
        for <linux-acpi@vger.kernel.org>; Thu, 12 Nov 2026 14:31:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794522670; x=1795127470; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+JTSqev9V+WnU5MiL+EzLENGXn9aXmam81GQLiwSL0o=;
        b=QK6ov+6PfLWnModUmHpQoTJIO9mbqa69iTI14JlGFF9k8M6Ls+sAJSveNj8g+ueWnu
         8b1zPQX2xIDQFGLZZjP1wMJvqMwZrq8x4IVPtqAZCLsofyk15O0AyKmBHtJfr6U8kAvS
         onsPYX4BfCr1/z4vKD/vtm5bTh4Ke0Nf0vZ5qmaap6QPuXT3JM5d70mPl8hNaMJiiXOV
         BS69sbm1OaKF8ENOfh8zbA3xf8oTQrmKxdb2EsE2Sq6SkJ/ifxcWmEnu3XuTthkueQEB
         tQEoWykjpdUTsskQqwORhSWLyFmUa+cB2XJayhfwgqwrS/xatUifmK6gAIoTkDZfBdkw
         PDCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794522670; x=1795127470;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+JTSqev9V+WnU5MiL+EzLENGXn9aXmam81GQLiwSL0o=;
        b=b7905+HwYv9+CdRJzsZC+9QO4mHn4AUiLpRlgjv21DeOh3lXqI21rjURaaii70yy+K
         5dE3Z35HLD2HBRPJ3QK/B5XG/CtSdahzDm1sUDG3qxbEm0lpl3FwN/MpVyDtAeIX4bvJ
         PoAX4GCeXUOqFe3uMP+xatfKJpYruZ+CdoPTCX3uyv0uYzlVpZkssmQZ6Zs0DlemkKpk
         tlkkmcgIjyX8ClPY21EEgewkjcVSlRnOJ9nMx7KpjwoEYh2fUFujOgQPsf/gwKE70Ln8
         jFD2puSxht5H5cHQDzsvF9GCnILJ6p5khxZZQ4x8w+5a82r1jDSJwY4Kg64z4w7GqNrk
         Vhxg==
X-Forwarded-Encrypted: i=1; AL+hErGwt4OpSChNEOWMn5coGVHWKMp/xaJ5TIouJD3ZlwlrbXkgvRf2BDJMhtZK3ggG2GY9T9QAExb49SGf@vger.kernel.org
X-Gm-Message-State: APuU4Z+JGP1T6PyzYPR2eV+lVf1jd8NTZ5E8I5NPI8yimro8jiaGG2B7
	AX6XNBGwsC1A1QTgPzzLrnv4gvl3uUxHPwjFIoc04NW3Yyi/0QYodero
X-Gm-Gg: AYBFou1uDj8etdNL9zM3W4UDtEOfWkWd8LIN0Lwpmbv0NcnVNY3GQL+SKugPfPgZhne
	XwFD8RxCbSPb/wu0dtrs7293MFi+krGOoiQJobM18i/BH2l3Cp6duL0K7Vz8dpvBnWZhfWHRxBx
	iXfyDaUY0hZINCP429Pcfv3iNY+XeC7wWnN7mAIZND1qUvSqVjjTdJ09nkEqx8gv79ipeMkUwQD
	H9GNUY46NZtCWlW1JIGz/32sMrkgA591dDH18iDivZ0HD08vbqAKqAGrmKyYk8vj7MMltdHMWjp
	Av9cJNttYxoloda+ciQd3k8IffbGBAj3hwr/U/FYTifmltnXxYE75lryGbayRe0XoUXhIXbE+JZ
	szYySRkDQnVbn8BJu+RI98Qe+Wmb/1/19wJ6rxfHuduXretI5Xgn/4LFv1QtTZNaDODUewntc3D
	+JkajXPKQfhgY7ODE/RgBxrXObLJvCNNCegrVeWo/Q9pzF/B1N5TKCwivlWa7xLmAAjNugIirlJ
	7qGm4GeYPYeJjcmACCGDs7WTD7Wp/qmlgXFcvdps+rVVpqDfI5nJktuBND5XXtl92/eaNkxcKDB
	gfEMNWs5m50dUUKCKGPXiPZafpa3X/BLvRKHmBx3T7FsK7R3goq0uKgZUtf/Ck+Jvg==
X-Received: by 2002:a05:600c:8b8a:b0:4a1:9078:911 with SMTP id 5b1f17b1804b1-4bb55abbadamr13368985e9.31.1794522670201;
        Thu, 12 Nov 2026 14:31:10 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb5720e9c2sm42715e9.3.2026.11.12.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 14:31:09 -0800 (PST)
Date: Thu, 12 Nov 2026 22:31:07 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-hardening@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andreas Schwab <schwab@linux-m68k.org>, Andy
 Shevchenko <andy@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Daniel
 Scally <djrscally@gmail.com>, Danilo Krummrich <dakr@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Hans Verkuil
 <hverkuil-cisco@xs4all.nl>, Heikki Krogerus
 <heikki.krogerus@linux.intel.com>, Joe Perches <joe@perches.com>, Johan
 Hovold <johan@kernel.org>, Kees Cook <kees@kernel.org>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Len Brown <lenb@kernel.org>, Linus
 Torvalds <torvalds@linux-foundation.org>, Linus Walleij
 <linusw@kernel.org>, Namhyung Kim <namhyung@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Rob Herring <robh@kernel.org>, Sakari Ailus
 <sakari.ailus@linux.intel.com>, Saravana Kannan <saravanak@kernel.org>,
 Steven Rostedt <rostedt@goodmis.org>, Tom Zanussi <zanussi@kernel.org>,
 linux-acpi@vger.kernel.org, driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-gpio@vger.kernel.org, Bartosz Golaszewski
 <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/6] string: Add strprefix(), and deprecate
 str_has_prefix()
Message-ID: <20261112223107.3a9efb85@pumpkin>
In-Reply-To: <a74fabd985a874da7556ae1601053b4bcc100f13.1794425425.git.alx@kernel.org>
References: <cover.1794425425.git.alx@kernel.org>
	<a74fabd985a874da7556ae1601053b4bcc100f13.1794425425.git.alx@kernel.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Post: <mailto:linux-acpi@vger.kernel.org>
List-Help: <mailto:linux-acpi+help@vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-acpi+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 11 Nov 2026 20:55:15 +0100
Alejandro Colomar <alx@kernel.org> wrote:

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
> Move the description from str_has_prefix(), and describe
> str_has_prefix() by comparing it to strprefix().
> 
> Reported-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Link: https://lore.kernel.org/linux-hardening/20261104-fwnode-for-each-prop-v1-1-6e28fe1c72c4@oss.qualcomm.com/
> Cc: Andy Shevchenko <andy@kernel.org>
> Signed-off-by: Alejandro Colomar <alx@kernel.org>
> ---
>  include/linux/string.h   | 28 +++++++++++++++++++++++-----
>  lib/tests/string_kunit.c |  9 +++++++++
>  2 files changed, 32 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 6cb5cdd01158..d08ca10c39a2 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -545,16 +545,34 @@ void memcpy_and_pad(void *dest, size_t dest_len, const void *src, size_t count,
>  	       sizeof(*(obj)) - offsetof(typeof(*(obj)), member));	\
>  })
>  
> +/**
> + * strprefix - string prefix
> + * @s: The string to be tested
> + * @prefix: The string to see if @s starts with
> + *
> + * A common way to test a prefix of a string is to do:
> + *  strncmp(s, prefix, sizeof(prefix) - 1)
> + *
> + * But this can lead to bugs due to typos, or if prefix is a pointer
> + * and not a constant.  Instead use strprefix().
> + *
> + * Returns:
> + * *  @s+strlen(@prefix) if @s starts with @prefix
> + * *  NULL if @s does not start with @prefix
> + */
> +static inline char *strprefix(const char *s, const char *prefix)
> +{
> +	size_t len = strlen(prefix);
> +	return strncmp(s, prefix, len) == 0 ? (char *) s + len : NULL;
> +}

I suspect this would be better as a real function.
Possibly even just a simple loop rather than based on calls to
both strlen and strncmp().
(Even if the strelen() is mostly a compile-time constant.)

Something like:
#undef strprefix // Or put it the name in ()
const char *strprefix(const char *s, const char *prefix)
{
	do {
		if (!*s)
			return *p ? NULL : s;
	} while (*s++ == *p++);
	return p[-1] ? NULL : s - 1;
}

And in the header:
const char *strprefix(const char *s, const char *prefix);
#define strprefix(s, p) ((typeof(s))strprefix(s, p))

David

> +
>  /**
>   * str_has_prefix - Test if a string has a given prefix
>   * @str: The string to test
>   * @prefix: The string to see if @str starts with
>   *
> - * A common way to test a prefix of a string is to do:
> - *  strncmp(str, prefix, sizeof(prefix) - 1)
> - *
> - * But this can lead to bugs due to typos, or if prefix is a pointer
> - * and not a constant. Instead use str_has_prefix().
> + * This is similar to strprefix(), but returns an offset instead of
> + * a pointer.
>   *
>   * Returns:
>   * * strlen(@prefix) if @str starts with @prefix
> diff --git a/lib/tests/string_kunit.c b/lib/tests/string_kunit.c
> index 0819ace5b027..73d2614b1474 100644
> --- a/lib/tests/string_kunit.c
> +++ b/lib/tests/string_kunit.c
> @@ -287,6 +287,14 @@ static void string_test_strspn(struct kunit *test)
>  	}
>  }
>  
> +static void string_test_strprefix(struct kunit *test)
> +{
> +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foo"), "bar"));
> +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", ""), "foobar"));
> +	KUNIT_ASSERT_EQ(test, 0, strcmp(strprefix("foobar", "foobar"), ""));
> +	KUNIT_ASSERT_NULL(test, strprefix("foobar", "bar"));
> +}
> +
>  static char strcmp_buffer1[STRCMP_LARGE_BUF_LEN];
>  static char strcmp_buffer2[STRCMP_LARGE_BUF_LEN];
>  
> @@ -891,6 +899,7 @@ static struct kunit_case string_test_cases[] = {
>  	KUNIT_CASE(string_test_strnchr),
>  	KUNIT_CASE(string_test_strrchr),
>  	KUNIT_CASE(string_test_strspn),
> +	KUNIT_CASE(string_test_strprefix),
>  	KUNIT_CASE(string_test_strcmp),
>  	KUNIT_CASE(string_test_strcmp_long_strings),
>  	KUNIT_CASE(string_test_strncmp),


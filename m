Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACFE3F6C4D
	for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 08:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784016665; cv=none; b=JvYiT6Xgg1OZW5uWGoAH0y3r/oyC9RXPuOKmFts1PEhtzS9Y4LF8cgicNIlUcTjIN1I9xNo0IAgjazw0LZmqDWcLAWM0M2CpFgJGlhhBjpKiv5O/l6rd8xTgwpc6SczAVGVW+2dG03w3aWTWJZEqHk9i0Zah3tEbtF1XYOK6Xg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784016665; c=relaxed/simple;
	bh=95yEhS2RY9tvQKYNJAneFxQrWu4TncTLuEUaUZafNCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QYiT2yeTl7WD+tM6CqlNQONibgUQDdLoxmnnrYKK5G/HPSSlWubeUfABXmv/wURi+UuCsEs/7W/fdlNN77IM8m2m94QONrShwgh2PL91ovJT85qqU7/dKg34ECGrvljZ/V7dZht7ernP29IwlpqdW6VjQcGldhYN4sKusmSywpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=od5gKdG0; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="od5gKdG0"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8454160043aso475086b3a.3
        for <linux-acpi@vger.kernel.org>; Tue, 14 Jul 2026 01:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1784016663; x=1784621463; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAS+vEtyAAAxc3NKkZi+AZEqveghGOCf+a2cUuueeZ0=;
        b=od5gKdG0kstqkk3D8c2JXxhgsC3ysrwdofxvZY/XwFQV+K5K7ROuRpyMXq+CHTIk9q
         pbcaoWrgulr4QXhJ90FcMrYSjHhdezLw2YL8CYOoUWkVLm8BLxxGVrS6F66fKtjnv9mI
         kkYv8WPl8QcYxQ4Pi8chNkJ8+qSbc0zJNpXQk7exwlk5m68nztwSczIfhpAyAqpsNPwa
         kI8r/sftwDSnQuaYap4qH5wZypH5v7tZNwLtD6KYt1iZEs2hqOfFA7CnqPkf9XvvMTeR
         QfjhhmqU525DZiM9xEhbj19xvqSlzZsVWO90u7KL1dXxA7bukDwMT2iWhjJ85Z9LYsRM
         yKSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784016663; x=1784621463;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=nAS+vEtyAAAxc3NKkZi+AZEqveghGOCf+a2cUuueeZ0=;
        b=fSthmHwf683mtcfajNLI7piNXE8uAzZeRxu4bnB89ej3+ENhYURkML8eKYyFneCToP
         PF+Dh/ySY7QjA0pyma8xwoyhRw0WBUz1wsSLHshpYzyK3OxK+QkbmieMmI2KpDML82tu
         Ax8tij8b8N9yotqjLGRv55/e6imNjULoGVfdNe+Jmv8giA0Nfgy8WuqY3/tnItGvxYDZ
         dcuZETztg48FQI2t68YXVCsGTmeqiYsczCePrHhu6Xq2gFDOqYokEw+8XIUIGzRJp/YC
         Q8LB0+CSxgNLpj76tESENwUmybpa2bql4EiuBsS0fNG38B9qpFCxWwC5LuIRalNILlYv
         TjNA==
X-Forwarded-Encrypted: i=1; AHgh+RrQCjUfNvf432ESbjtX6BPmRymtqEOuuWzUy9KyQsJsvQ1Ys4PQhsO0Xrvc4ADIM2zW98jhbj2a5uB+@vger.kernel.org
X-Gm-Message-State: AOJu0YxwLYa8UivIxHHwiw8aeXgOSaDh7yHLiom0TN34kZLPZsJr0sPI
	5HwJeA8xAhR/At8HFhjQN/OnLif21xLRRNo+uLYMDPeVAK17+kHNzF6Tx9U1o6A0yWyCw/rKBDw
	KOPF7
X-Gm-Gg: AfdE7cneizEgyEI8XxZRRntB9qIIcmnl5AGESEwDGvjNgZzmPPoAJ7wmjcMPAx/rwpU
	wYGcA1lF0l/eKQAObYBEZJP15mKJWorJBWgVyw6Q0z/eNTDFThf2WAQsrPJhwW2C0xpOcYKXjr+
	v1j5c0UxCXYh3ExsxaQf10jVwT9h+sCcjR6u24iFQYSdr/jCJCIyLSVK4qOkiaJ2XPiq4FifWF4
	gOZ9uoRTxTWbYFb4Mui1R+DDNPlZcxLfo08Y1VnkCAk+EgW+Gqo44u9pJAYYlKmAjzYtFbatGU2
	sNG2Cj1TfvwkZG5W9IjVqx4mmC2ZQ0lA89TUQZoeV4R3vN81oHdRq3u7rGK65pONjJkoXsJGL7h
	rfOmzQ5CP12GzIWIoXXzwYppqa6PoDWigzuzEIP/pRoaKL2KOs3YxFb9CDrTsDjVN+XquIyigpj
	2B+BGRDE1tjM/h
X-Received: by 2002:a05:6300:67c2:b0:3b4:75c0:3ec0 with SMTP id adf61e73a8af0-3c1103d29f2mr12378480637.30.1784016662505;
        Tue, 14 Jul 2026 01:11:02 -0700 (PDT)
Received: from localhost ([122.172.82.94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13b659d87a2sm70644994c88.13.2026.07.14.01.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2026 01:11:01 -0700 (PDT)
Date: Tue, 14 Jul 2026 13:40:59 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: 
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Lixu Zhang <lixu.zhang@intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, "Enrico Weigelt, metux IT consult" <info@metux.net>, 
	Viresh Kumar <vireshk@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v1 20/20] gpio: Unify style of various *_device_id arrays
Message-ID: <apbfpx4qdqnertxomfums55iznn75xl4aqzjjmjuhpw2r5d4gn@xybd6vdeyz5g>
References: <cover.1784013063.git.u.kleine-koenig@baylibre.com>
 <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1f2d39342995533857417eb890628f7643b9a159.1784013063.git.u.kleine-koenig@baylibre.com>

On 14-07-26, 09:24, Uwe Kleine-König (The Capable Hub) wrote:
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index 42871db05ec1..062c70fe4671 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -647,7 +647,7 @@ static void virtio_gpio_remove(struct virtio_device *vdev)
>  
>  static const struct virtio_device_id id_table[] = {
>  	{ .device = VIRTIO_ID_GPIO, .vendor = VIRTIO_DEV_ANY_ID },
> -	{},
> +	{ }
>  };
>  MODULE_DEVICE_TABLE(virtio, id_table);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh

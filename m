Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F8133DED9
	for <linux-acpi@vger.kernel.org>; Wed, 20 May 2026 05:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779254864; cv=none; b=U73vHLYdWqOvHjuc62bznWuNlh/n1vAS2o077Umeg7Y6+VAy+3C4BGU4W5xg3VKNKZzXJ9AsysJUSkRaGu+2BM7tDmDCV46d1P9LPxBczee5hj1Gpud03XQjfbE7YS8U6/0+GhyggX5MDcFLmulWutSiYJm+w6MJBFHYODvvTOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779254864; c=relaxed/simple;
	bh=l0zRM2r+AQUNnb8A268apqaIB3mS80ht+d+1M1KKNFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3lZUOO+ZcgWk6xGJcoPBdU9PczCMMdq4SLwS5MvoDve6/i0WTAQkSZ8icAT1D00TaCluG4ovA/o4FoW1rSa9gavxsfMuDrVfPdY9PPM0uNbYyaRIEKAXM7cQDHmaXxqQuo/FJicFSG/kZL6QBsyzC1wGQfCp16tkQDUoCYlk0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VYNJtPac; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VYNJtPac"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12ddbe104ccso3128059c88.0
        for <linux-acpi@vger.kernel.org>; Tue, 19 May 2026 22:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779254862; x=1779859662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tWnObvvYz2jxVvNJZ4O4Otjd3qRMPJxYo5uUEck8zsM=;
        b=VYNJtPacffiX92QpyrOU3Lyjiq8y8ThCuoAAkgBCYCptHiXE1n9o72gsaMSUmdzi+C
         3RCRowkltdAC1/1x2ZA5jwW6rbRQYvxJ9x1v0xrJMOqh7uLemCY5uJH8ve7LsEjNnGlx
         oV0KNVE0D9y9v/fOltAdg2TFCxTy/Q8GoUQ4QhZld4mXawtyqQkdnTakHz5gIEfuZOd4
         do6LRUIsh+oDtslTnLsjYvUQC6neJwikmm40m8oCBmcDcJv1ZGZmLZrldMqY33lxxRQQ
         laXNIk/ukJBcX2qLKsBrLmT/XTSnOB99uU5iOuZZS8ZGXpoL05YHG1w6L/BoiN7/7QIn
         rjLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779254862; x=1779859662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tWnObvvYz2jxVvNJZ4O4Otjd3qRMPJxYo5uUEck8zsM=;
        b=sm/uxCTJ2AiKeIjdtEKR59fdBN/1p1Fjb+WxmZa7Be4waSfLIsPCM22NnKO7iG80Pa
         mCI0/lwSe2Y9+WMmWKoMSoKRLx/xKGitfptNUEUbaXqTDOja8p2DIZbrMVAWYrg+HGhs
         mCwyoZG8o+6ipxLT6dksW2NkJBfEzTJ6qD+U3Vnx3dGVkRe917PAXv7Peyx3JmWhN523
         IahG+csA6u7ZGahZ/dCST3u+CZC2TVAApU/owhdwVjyY/cxLCQnA7P9SuGbMjN/eZ61h
         4igGIY40Y+vW+s0Iwnyvj0UmWOMYTx/vfKlWRsXn0zsgsne9x6qhrjGHnBl7mCWNqLFV
         HmQQ==
X-Forwarded-Encrypted: i=1; AFNElJ8PRRocWviUzh68BktSbACVXhUws3taKoQQKGIudlvW2IgrLwh0xtG5V3iBP5HLiIONRrO1tvQsIqTw@vger.kernel.org
X-Gm-Message-State: AOJu0YyaWRc0iyeqWL1B+VPT8MLOqavXr5ekk+W6w3LkvIJImu8HTnI5
	Bj1iNAgO9CHhPMzTrT6RFc7tSzubW3m0q/sUtK1xwBs7Mkm7q2kCUuoi
X-Gm-Gg: Acq92OEEfpFdGhTPEMTAUIJNv1cZ3JivkCFYeK9WYQRJdDR7PI14OnihzqVVi86xZNo
	KIhol/yS9DP7PogilrklzfduRoO4ggs9RqOrwDkIEQBiYvWKFCDC1h/AsEyZyUCp40MU1oslg6B
	pRQLz5qk3AhhZdGnDLFowXRxNYNtDMiiQkoH+Dq/xxr5GOmFvadhkuGvBTJJSFtwUmUwNYXkRzi
	dJKOZBJjgdnZHp2PBYSfbjSJBkIPUJzzXJl2kXdpG8MX2+LJ1RFYlBNOQayKxVMNAJVqtG0Hjwq
	CFlZ9XIp2Z8DwCuuP//dahUaALYfArYWDqE2tj/9Sd74/4/rG+N72pPvqeO/6qCtmg21aiCe2iH
	pfLTzEYgoSQXfJz/WVD5Qnf3QIqYgJDxqPHMT2sqzts/GGDkwfqkrjAYWUMnse0oOU9+i8JLrI/
	oWtaDvF2BFux8As/kZF2wz6x0ATIB/uaDWsXhMSdBoZVvSo2yLvo1iigtMsUoilRVX
X-Received: by 2002:a05:7022:e14:b0:135:d5d1:514 with SMTP id a92af1059eb24-135d5d1061cmr2290514c88.14.1779254861871;
        Tue, 19 May 2026 22:27:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:7677:c3e6:c92a:e780])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cbdcf140sm25863329c88.5.2026.05.19.22.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 22:27:41 -0700 (PDT)
Date: Tue, 19 May 2026 22:27:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Frank Rowand <frowand.list@gmail.com>, Mika Westerberg <westeri@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, 
	Janusz Krzysztofik <jmkrzyszt@gmail.com>, Tony Lindgren <tony@atomide.com>, 
	Russell King <linux@armlinux.org.uk>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org, 
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 5/6] gpio: remove machine hogs
Message-ID: <ag1GJygtLgngKQqj@google.com>
References: <20260309-gpio-hog-fwnode-v2-0-4e61f3dbf06a@oss.qualcomm.com>
 <20260309-gpio-hog-fwnode-v2-5-4e61f3dbf06a@oss.qualcomm.com>
 <ag0Dn66ZVnbTc7J2@google.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ag0Dn66ZVnbTc7J2@google.com>

On Tue, May 19, 2026 at 05:46:50PM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 09, 2026 at 01:42:41PM +0100, Bartosz Golaszewski wrote:
> > With no more users, remove legacy machine hog API from the kernel.
> > 
> > Reviewed-by: Linus Walleij <linusw@kernel.org>
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> 
> Argh! What is the replacement for this? I have patches for rsk7203 to
> use them to get rid of legacy gpio use, like this:
> 
> diff --git a/arch/sh/boards/mach-rsk/devices-rsk7203.c b/arch/sh/boards/mach-rsk/devices-rsk7203.c
> index f8760a91e2f1..5bbd3b31cffb 100644
> --- a/arch/sh/boards/mach-rsk/devices-rsk7203.c
> +++ b/arch/sh/boards/mach-rsk/devices-rsk7203.c
> @@ -12,7 +12,7 @@
>  #include <linux/smsc911x.h>
>  #include <linux/input.h>
>  #include <linux/io.h>
> -#include <linux/gpio.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/gpio/machine.h>
>  #include <linux/gpio/property.h>
>  #include <asm/machvec.h>
> @@ -165,6 +165,19 @@ static const struct platform_device_info rsk7203_devices[] __initconst = {
>  	},
>  };
>  
> +/* The base of the function GPIOs in the flat enum */
> +#define SH7203_FN_BASE GPIO_FN_PINT7_PB
> +
> +static struct gpiod_hog rsk7203_gpio_hogs[] = {
> +	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_TXD0 - SH7203_FN_BASE,
> +		 "TXD0", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
> +	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_RXD0 - SH7203_FN_BASE,
> +		 "RXD0", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
> +	GPIO_HOG("sh7203_pfc-fn", GPIO_FN_IRQ0_PB - SH7203_FN_BASE,
> +		 "IRQ0_PB", GPIO_ACTIVE_HIGH, GPIOD_ASIS),
> +	{ }
> +};
> +
>  static int __init rsk7203_devices_setup(void)
>  {
>  	struct platform_device *pd;
> @@ -172,12 +185,10 @@ static int __init rsk7203_devices_setup(void)
>  	int i;
>  
>  	/* Select pins for SCIF0 */
> -	gpio_request(GPIO_FN_TXD0, NULL);
> -	gpio_request(GPIO_FN_RXD0, NULL);
> +	gpiod_add_hogs(rsk7203_gpio_hogs);
>  
>  	/* Setup LAN9118: CS1 in 16-bit Big Endian Mode, IRQ0 at Port B */
>  	__raw_writel(0x36db0400, 0xfffc0008); /* CS1BCR */
> -	gpio_request(GPIO_FN_IRQ0_PB, NULL);
>  
>  	error = software_node_register_node_group(rsk7203_swnodes);
>  	if (error) {
> 
> 
> If there is no replacement maybe we can resurrect this? Or shoudl we
> have add swnode support for hogs?

Hmm, I guess it is already there so I should simply switch. Sorry about
the noise.

Thanks.

-- 
Dmitry

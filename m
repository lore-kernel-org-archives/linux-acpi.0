Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DC58288C34
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 17:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775151144; cv=none; b=qu+AzeQY4bX6BSRXLfP7fHnl/ylbN5r6mNs87/nz4ppOJybXScc0NJ9R65QLD1YEzIN7vNZAbt2abwnpHJueR0UFLf4Jf5E/0bpHdPC72ptI6uFCJ0e7nnAQRR4firrq8EmmrQ/onBfnssqgRHB9iOzO5ViA4JVMMBeHkTb1xsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775151144; c=relaxed/simple;
	bh=zdBBr15vHbzzK+y/RTD6lEdsU2YY966kOlrvNECGXvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNobhOXmEwh7Q5kcGwj8/n+H6dZ1bNi1v6uvx9chnddwVDTkrsA4BfeRDzeV+nRkvlrPDCA1JYKyA2mrbr4IKGHXhm4PET8VyKCrvV2o5EMY+r5DuZ8EYGaDzsYHltZ86dGLVrizPiM6BouNEfiz6wa2lGurZNxx4BTJ1KiIc6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M7XJXmio; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M7XJXmio"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2c156c4a9efso1393166eec.1
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 10:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775151143; x=1775755943; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zz8YcwWkdWOvxMK3RVth/0rCZCw77MdxTEXEAAB58s4=;
        b=M7XJXmioN8DtSRvQFuJzekcXon7Z5sPBAnc5ZyVWObahwDggIllT80d/KrE+zeHKQD
         Ro74QkgBm80nH0dWvU+hGMjEy/uouG0GvBjjNeC8MoLhYUqPTPby4BQ0R01oDh6SqK/p
         gOgFX1Ot4+k+Lfeh8Oqvj+mwL6m8YTFI2eS+Q/2RMeh2bh9dWOkte20/23AKV65Dlpw7
         VtlTZLMsowxMpzzE+iOXnsiriQb1AC3WnmLAEQmaTKMrmgTvgZwVN5Yx54C4Bv/sx9q3
         stgI/FibEHpuBMoaWTq9xByz5QiotpdT0BFwEdla/oN7tViWzqQDbUGT6D7UEUSsPQde
         0wCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775151143; x=1775755943;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zz8YcwWkdWOvxMK3RVth/0rCZCw77MdxTEXEAAB58s4=;
        b=gUpwjB/w2krrglgess58wGol5Dn2cRkgb1fv1d51dZGiyQ9HKWe3IiM9V2ng3B2AkA
         FyN478HhJdEpRVg6SOfEm75wLabYKAbsMmlQtlvGFhho2O7ABKw177umszvBCKgYo64T
         RuItJYGTgHAWqQrsW0CtpnXeghSYI4zdqX65/8euio/dYRTYj6liC/NoBpXhKJ5L8V7F
         YQ72uLKgN+/4k7ibhfGNrnPWZ3x5GMi0RlbKQgR177zKApbdeKwA+3ZhmhQzN7JYStUh
         +h08+1dhcGYT80MdXRrFjNOZwvM4q8vRpwpSGOrGvOXKUVJiUi18sSmE6NdKTHZF0huN
         0R3g==
X-Forwarded-Encrypted: i=1; AJvYcCWT2HN7tuisLJvM2C0dG+Y8smVE+MP8D3RMZAt5neMZ/QfOlg2kZWhuW2g+3vh72CvAOD5U2aVZusZY@vger.kernel.org
X-Gm-Message-State: AOJu0YxPs9Bh+85jthNc0zNpKlux7TZpngDhe3j584pfXCe7beZCEezh
	Ir09UsWiOuRVSa/AzCFmZpIw0+a9RjRK+GCCByTMcSrct8KXltFGwemx
X-Gm-Gg: AeBDiet24FmjgkC6hP+wKqGs4YU81Kx++hSpxTiqsHoxN6JnV9KzxKYWbciOaZu2sci
	48BdLvwGB37lBI6UlWSrsOyS5wfQx8Y/ZzR4FdwaodHp8fyu1ZNCyVAIrraI1Wfts3oiHUZ8BiS
	1PJAA1A8fZxEGtVxp3jtXetZz7QK6B1JvTsI1nzeyuhxZtRlXfs7yf9lm4PcoXIayYvU+r0UQOK
	GtUNtKIxM/PsTsyYZ92+hUQM7K1vi0b86Q9jlWFIva3apIwjynSrJshY3by+xuNNSY1CItvVWU3
	cTDNB1nEkH4MkwAXHBAcufnL/FqiIP996c6x7K0GfQekSINOOVylpCjg65tlX/ZQ9XYt7VLs7kh
	X22QV2+dR/na2GDl0kgJpR8Juaspc1m1EMmBVr8O7uaJJcXNxAsnzf2R1u6IzLKLAh+k0m2AWfj
	pY0Q4TkP1Ym0jVPPOUBlCZa769XCqNDusTHE0mbYVkcPPvbocarz/+o9Ow0d5MSAX6
X-Received: by 2002:a05:7300:6da8:b0:2c0:ba91:48b6 with SMTP id 5a478bee46e88-2cbfc073927mr1038eec.26.1775151142569;
        Thu, 02 Apr 2026 10:32:22 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:902a:cd8d:1c0d:8926])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm3001257eec.0.2026.04.02.10.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 10:32:21 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:32:18 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>, 
	Kevin Hilman <khilman@baylibre.com>, Arnd Bergmann <arnd@arndb.de>, brgl@kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH v5 4/4] ARM: omap1: enable real software node lookup of
 GPIOs on Nokia 770
Message-ID: <ac6n1p3eLVFzumbt@google.com>
References: <20260402-nokia770-gpio-swnodes-v5-0-d730db3dd299@oss.qualcomm.com>
 <20260402-nokia770-gpio-swnodes-v5-4-d730db3dd299@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-nokia770-gpio-swnodes-v5-4-d730db3dd299@oss.qualcomm.com>

On Thu, Apr 02, 2026 at 04:15:05PM +0200, Bartosz Golaszewski wrote:
> @@ -244,6 +263,13 @@ static int __init omap16xx_gpio_init(void)
>  		iounmap(base);
>  
>  		platform_device_register(omap16xx_gpio_dev[i]);
> +
> +		ret = device_add_software_node(&omap16xx_gpio_dev[i]->dev,
> +					       omap16xx_gpio_swnodes[i]);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Failed to add software node.\n");
> +			return ret;
> +		}

I think the best and safest way is to convert to using
platform_driver_register_full() and set swnode in the relevant "info"
instance.

Thanks.

-- 
Dmitry

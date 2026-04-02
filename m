Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923253803D0
	for <linux-acpi@vger.kernel.org>; Thu,  2 Apr 2026 21:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775163887; cv=none; b=TcNN1Jt9I+N9GAyUE9hMRquGMxEGU8V6PI1Z9fK3u3P5yq8T9vIv35b9Ja7HkGbBd4Iz3gEz/jqOBRYP45z3mCxJ8gqpWuvXBWxnrrEjWh3kLLcZqVlh0bG9SD+BOyEqJeuPDz9yZNmy1CzgXGNXmCy6tMVVAZotyXlgHpivLT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775163887; c=relaxed/simple;
	bh=9niybiFB5IVgmN0LDSpn+N1s08D0u5vGDHQCV7xvlbU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VJntciK5GI3DK4WXRmLgJMju1tuN3X5TDMN99/1Iy7TxFXu7YrIG5zK6pUPmMyrZ0a6OQm+nneIW4MMIzU1xs6otfa4Nmf6BOVLPDSFGz+r3bD4+YS8BeMYXCCzcpBk7OoHYZDpTPj+GeZkRIr2pxEllrojcPyxAWQjZVzBpnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pidkZMHp; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pidkZMHp"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1271195d2a7so1660136c88.0
        for <linux-acpi@vger.kernel.org>; Thu, 02 Apr 2026 14:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775163882; x=1775768682; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YkigmJHvp4GgElx409CeKFIXm/H3rAfVDHZAfLtsfrs=;
        b=pidkZMHpIrSmQSbDRL8P8vnV09rQbwkTBwk5gtoF9VJCE5GaZ7TjqDK8ehQpGpnBr/
         bt9ESrBk2w2mb3nYGWxR51WKtOaseRIm8yfV3eCpdrQ5u16E1oErngngCgOyqm6FCnrz
         iT+y16nhiUu3C8s6poXOAATYHzU0n3ssDXtkoW5LKfQ+M42HuDQEVl5fRSGMxWllFZxN
         VoKf1I2MUv0Gcx/C6RDdraV+UQluUFiiZLT8CWp909yK7gpR3sA4hdDxWT+JCIjDRDK1
         3pizrRFONH6bcmiVkTfsO+MndY4Xzkpvx8JfXsCSPCYt9e8+evkl/yMZnPu8e4qOsCVH
         xvjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775163882; x=1775768682;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YkigmJHvp4GgElx409CeKFIXm/H3rAfVDHZAfLtsfrs=;
        b=rnfMGdywHE4a7eb8u7eaUQbuUKSQtWtLc/zvEZjxaBAbOnd9BGaNTiwmNk5YOojMkv
         nH1+tQ+6j79f3J5GLPhxjDItqQ5YXakksx6wsil4KhEBJLeWgTQApsUy8VVp4FJInwhe
         enJ/mGInO/8yhHP9jS8cE7f1M1wHD1J8WubUq//tfjstVrFVAvBVr4y0iAp+kH/UEwQm
         N1TS2k1mNWnodyFdv9sPGch1oB4FJWUPSVJ9gEtnbsKIqqAzLMIDtV0yxPAryYOWEOOG
         GFUGfZQYAwvDQphyFTG0dnzWR5moFPdhSS/yICwSUS4zzUITVyhQ+lQ/Fq7sotessHGr
         ULYQ==
X-Forwarded-Encrypted: i=1; AJvYcCVCa3j+6za93QUT3moGQL8C2SfFduKvE1CzqY7UZX+JjT2bWIP2qXxg9riv1h78nehBQnt2Rqs0jN28@vger.kernel.org
X-Gm-Message-State: AOJu0YzJiws1S/mF5cgy0lNLUvEcKGhYtBrmX0j/aliAPnpdGZKTErmL
	jJ9eWWTBO65lvXbM+1wPVHPMCXf6bpbyRqFrR4EUBdLkTsu8LUcR5KKQ
X-Gm-Gg: ATEYQzyhyCnLQ2/uEFLRdjC5E7FeWx2yT6pyB2Susfhn1SQwBJ1corGT2KiRo+SDCvt
	jyTYQN/0GfvjkzG8kLFmUBLqSsjUe9q1BOlSr/jB+T/TvKwlv9vpDIJxfBfrrdEMM25Q955KNpH
	kCpEfnRxEZ29OFynR5ZaQNAl30EcmoVIpnzHzHDSeHnHhgQHbMf9JagpqZ2CMK/Mpy7rbNLTHNp
	JWKyJxwrQ2sohaMk/7A06JfIG0Y/QcEWRjCseeJMopOtotmqNVzGBdCt+SDw2f99hWlIkCHawWv
	9mTzJcuSo1z/Gn5HA3LdU0ayg2oa6J5U+4yIr5CA4l8F1o0Ogl1sxYSEQty9j9+XXUVHMJej6f2
	EovoAwks4+1QVmt2/Nrz2OfpWoY3bqbt7oer+XwoQ4wHpr0LnXAnV2xiWsh5FMSZznfGBhtLRn+
	cTVaZjL1jjjuAluc4ajceKn83pJlWzf1q3yg9546IjizQQdWh1G4loAEmbHKRIjdPj
X-Received: by 2002:a05:7022:1603:b0:12b:ec96:c936 with SMTP id a92af1059eb24-12bfb70bfe6mr322111c88.14.1775163881666;
        Thu, 02 Apr 2026 14:04:41 -0700 (PDT)
Received: from google.com ([2a00:79e0:2ebe:8:902a:cd8d:1c0d:8926])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bede545e8sm2818277c88.11.2026.04.02.14.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 14:04:41 -0700 (PDT)
Date: Thu, 2 Apr 2026 14:04:37 -0700
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org, 
	driver-core@lists.linux.dev, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, brgl@kernel.org
Subject: Re: [PATCH v2 2/4] gpio: swnode: defer probe on references to
 unregistered software nodes
Message-ID: <ac7ZA6HJFBhyCROM@google.com>
References: <20260402-baytrail-real-swnode-v2-0-6f5054a4cc07@oss.qualcomm.com>
 <20260402-baytrail-real-swnode-v2-2-6f5054a4cc07@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260402-baytrail-real-swnode-v2-2-6f5054a4cc07@oss.qualcomm.com>

On Thu, Apr 02, 2026 at 02:54:27PM +0200, Bartosz Golaszewski wrote:
> fwnode_property_get_reference_args() now returns -ENXIO when called on a
> software node referencing another software node which has not yet been
> registered as a firmware node. It makes sense to defer probe in this
> situation as the node will most likely be registered later on and we'll
> be able to resolve the reference eventually. Change the behavior of
> swnode_find_gpio() to return -EPROBE_DEFER if the software node reference
> resolution returns -ENXIO.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> ---
>  drivers/gpio/gpiolib-swnode.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/gpio/gpiolib-swnode.c b/drivers/gpio/gpiolib-swnode.c
> index 0d7f3f09a0b4bee0cf1bbdaa8b7b8ae4cd5de581..06d74e9e199de0b91a019e5e15d4b83d330291e7 100644
> --- a/drivers/gpio/gpiolib-swnode.c
> +++ b/drivers/gpio/gpiolib-swnode.c
> @@ -95,6 +95,15 @@ struct gpio_desc *swnode_find_gpio(struct fwnode_handle *fwnode,
>  			break;
>  	}
>  	if (ret) {
> +		if (ret == -ENXIO)


I'll be just sitting here and quoting sashiko all day long ;)

"
If swnode_gpio_get_reference() returns -ENXIO during the first iteration
(for example, when checking the con_id-gpios suffix), won't the loop continue
since the return value is not 0?

Looking at the loop just above this block:

        for_each_gpio_property_name(propname, con_id) {
                ret = swnode_gpio_get_reference(fwnode, propname, idx, &args);
                if (ret == 0)
                        break;
        }

If the initial property check returns -ENXIO, but the subsequent fallback
check for the con_id-gpio suffix returns -ENOENT, the ret variable gets
overwritten. 

When the loop terminates, ret would be -ENOENT instead of -ENXIO. Could this
cause the probe deferral check to evaluate to false and fail the probe
entirely instead of deferring it as intended? 

Should the loop also break early if -ENXIO is encountered?

"

You need to change that to

	if (ret == 0 || ret == -ENXIO)
		break;

because if we get -ENXIO that means the GPIO must be there (the property
exists) but not ready yet and we do not want to fall back to another
suffix. 

Thanks.

-- 
Dmitry

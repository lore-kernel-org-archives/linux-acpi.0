Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B670D3D091D;
	Fri,  3 Jul 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783084935; cv=none; b=P+xkXUUuuYprd2aLgUVKVpr8ZpEnKsdzYyz1YTAnqTwO2zKnLVU7sx7D0oEx6LzG5uJSVOetP7QRJ2RCo/L5XgBpr292lkgMcX/GQF8NynYp9M4ZNspp69kMoop3CGYbClEpa178uqu8j+V2qzw56W2laXfyJJe9w1dnlRQyTXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783084935; c=relaxed/simple;
	bh=C9nNNNWEecneKAhgPEE/LVOIeRzDwZEtYSWUsvgwpJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBT9z0HchTBjRgD4TmznFY/RJYRzRExaS3+yZnX2cdEfBqZIWD2PCtA1r1Y2IuHoK8FJb3gmFifBWWcMJR+9RDk4j9/AmltvkOutyGOCubNPPm05EgFc3bgKyIMhFaogIJAwLzPA7ZGvrBp83ZLv1h578N1RLYXE6BCJlRiGg10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 663D8nYn003882
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Fri, 3 Jul 2026 22:38:50 +0930
Date: Fri, 3 Jul 2026 22:38:49 +0930
From: Jonathan Woithe <jwoithe@just42.net>
To: "Rafael J.  Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Hans de Goede <hansg@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Corentin Chary <corentin.chary@gmail.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Denis Benato <denis.benato@linux.dev>, Robert Gerlach <khnz@gmx.de>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
        Mark Pearson <mpearson-lenovo@squebb.ca>,
        "Derek J. Clark" <derekjohn.clark@gmail.com>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Azael Avalos <coproscefalo@gmail.com>
Subject: Re: [PATCH v1 03/10] platform/x86: fujitsu-laptop: Stop setting
 acpi_device_name/class()
Message-ID: <ake0YZM6W0f/Jqn3@marvin.atrad.com.au>
References: <5135166.31r3eYUQgx@rafael.j.wysocki>
 <3441919.aeNJFYEL58@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3441919.aeNJFYEL58@rafael.j.wysocki>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Fri, Jul 03, 2026 at 01:23:31PM +0200, Rafael J.  Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The driver sets acpi_device_name() that are only used for printing
> messages and initializing input class device names.  Since
> ACPI_FUJITSU_BL_DEVICE_NAME and ACPI_FUJITSU_LAPTOP_DEVICE_NAME can
> be used directly in all of those cases, make the driver do so and
> stop setting acpi_device_name() in it.
> 
> Likewise, acpi_device_class() set by the driver are never read
> afterward, so make the driver stop setting it and drop the symbol
> defined specifically for this purpose.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Looks good to me for fujitsu-laptop.

Acked-by: Jonathan Woithe <jwoithe@just42.net>


> ---
>  drivers/platform/x86/fujitsu-laptop.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/platform/x86/fujitsu-laptop.c b/drivers/platform/x86/fujitsu-laptop.c
> index 54d0b9cec4d3..ea543deef68f 100644
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -56,7 +56,6 @@
>  
>  #define FUJITSU_LCD_N_LEVELS		8
>  
> -#define ACPI_FUJITSU_CLASS		"fujitsu"
>  #define ACPI_FUJITSU_BL_HID		"FUJ02B1"
>  #define ACPI_FUJITSU_BL_DRIVER_NAME	"Fujitsu laptop FUJ02B1 ACPI brightness driver"
>  #define ACPI_FUJITSU_BL_DEVICE_NAME	"Fujitsu FUJ02B1"
> @@ -466,7 +465,7 @@ static int acpi_fujitsu_bl_input_setup(struct device *dev)
>  	snprintf(priv->phys, sizeof(priv->phys), "%s/video/input0",
>  		 acpi_device_hid(device));
>  
> -	priv->input->name = acpi_device_name(device);
> +	priv->input->name = ACPI_FUJITSU_BL_DEVICE_NAME;
>  	priv->input->phys = priv->phys;
>  	priv->input->id.bustype = BUS_HOST;
>  	priv->input->id.product = 0x06;
> @@ -546,13 +545,11 @@ static int acpi_fujitsu_bl_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	fujitsu_bl = priv;
> -	strscpy(acpi_device_name(device), ACPI_FUJITSU_BL_DEVICE_NAME);
> -	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
>  
>  	platform_set_drvdata(pdev, priv);
>  
> -	pr_info("ACPI: %s [%s]\n",
> -		acpi_device_name(device), acpi_device_bid(device));
> +	pr_info("ACPI: %s [%s]\n", ACPI_FUJITSU_BL_DEVICE_NAME,
> +		acpi_device_bid(device));
>  
>  	if (get_max_brightness(&pdev->dev) <= 0)
>  		priv->max_brightness = FUJITSU_LCD_N_LEVELS;
> @@ -681,7 +678,7 @@ static int acpi_fujitsu_laptop_input_setup(struct device *dev)
>  	snprintf(priv->phys, sizeof(priv->phys), "%s/input0",
>  		 acpi_device_hid(device));
>  
> -	priv->input->name = acpi_device_name(device);
> +	priv->input->name = ACPI_FUJITSU_LAPTOP_DEVICE_NAME;
>  	priv->input->phys = priv->phys;
>  	priv->input->id.bustype = BUS_HOST;
>  
> @@ -1012,9 +1009,6 @@ static int acpi_fujitsu_laptop_probe(struct platform_device *pdev)
>  	WARN_ONCE(fext, "More than one FUJ02E3 ACPI device was found.  Driver may not work as intended.");
>  	fext = &pdev->dev;
>  
> -	strscpy(acpi_device_name(device), ACPI_FUJITSU_LAPTOP_DEVICE_NAME);
> -	strscpy(acpi_device_class(device), ACPI_FUJITSU_CLASS);
> -
>  	platform_set_drvdata(pdev, priv);
>  
>  	/* kfifo */
> @@ -1024,8 +1018,8 @@ static int acpi_fujitsu_laptop_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	pr_info("ACPI: %s [%s]\n",
> -		acpi_device_name(device), acpi_device_bid(device));
> +	pr_info("ACPI: %s [%s]\n", ACPI_FUJITSU_LAPTOP_DEVICE_NAME,
> +		acpi_device_bid(device));
>  
>  	while (call_fext_func(fext, FUNC_BUTTONS, 0x1, 0x0, 0x0) != 0 &&
>  	       i++ < MAX_HOTKEY_RINGBUFFER_SIZE)
> -- 
> 2.51.0
> 
> 
> 

-- 

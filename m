Received: from server.atrad.com.au (server.atrad.com.au [150.101.241.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D9342236E3;
	Tue, 12 May 2026 00:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=150.101.241.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778546549; cv=none; b=oOCmLXb6sy23fvkaiKEJ9VngZakd2vJXzPtzJT77IFHLuNMKfP7lVvhN9GX2g3c7u9ywhSqX6QY3opIxVHEftH6VOBXC7ZqSshVOTrhhL6zsWgFnIXMKURfSZO5A4V5CJuVKOY695Cf0eMZUy2vTlTKnFJv+qQGT2sXxh9t9paM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778546549; c=relaxed/simple;
	bh=QXxkJwcxM0kowTwE5lbEn5I2ePQXfBlaBtcfwyQtPcY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Skr0wpQ1GlIA5nKFug0v/1ynFpAQvMRMmmnjsZfydbDJ8z8IRQypBnEQFWPJz9vQLVOqJixJdc9da//QGh4yUzAQ6RGfO2u07dhUoOIyHWgCPI5ClVbKQSZYyyZKSc+J+gTgSkwnRvI9mc6fSOei9oTN9VZydfYgQBKqX+gmcsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net; spf=pass smtp.mailfrom=just42.net; arc=none smtp.client-ip=150.101.241.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=just42.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=just42.net
Received: from marvin.atrad.com.au (marvin.atrad.com.au [192.168.0.2])
	by server.atrad.com.au (8.18.1/8.18.1) with ESMTPS id 64C0G6GH031500
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
	Tue, 12 May 2026 09:46:07 +0930
Date: Tue, 12 May 2026 09:46:06 +0930
From: Jonathan Woithe <jwoithe@just42.net>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Hans de Goede <hansg@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        Corentin Chary <corentin.chary@gmail.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Denis Benato <denis.benato@linux.dev>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Robert Gerlach <khnz@gmx.de>, Matan Ziv-Av <matan@svgalib.org>,
        Kenneth Chan <kenneth.t.chan@gmail.com>,
        Mattia Dongili <malattia@linux.it>,
        Jeremy Soller <jeremy@system76.com>,
        Azael Avalos <coproscefalo@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v1] platform/x86: Check ACPI_COMPANION() against NULL
 during probe
Message-ID: <agJxRrDj2M42R8S1@marvin.atrad.com.au>
References: <5990022.DvuYhMxLoT@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-acpi@vger.kernel.org
List-Id: <linux-acpi.vger.kernel.org>
List-Subscribe: <mailto:linux-acpi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-acpi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5990022.DvuYhMxLoT@rafael.j.wysocki>
X-MIMEDefang-action: accept
X-Scanned-By: MIMEDefang 2.86 on 192.168.0.1

On Mon, May 11, 2026 at 09:48:26PM +0200, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> Every platform driver can be forced to match a device that doesn't match
> its list of device IDs because of device_match_driver_override(), so
> platform drivers that rely on the existence of a device's ACPI companion
> object need to verify its presence.
> 
> Accordingly, add requisite ACPI_COMPANION() or ACPI_HANDLE() checks
> against NULL to multiple platform/x86 drivers that have been converted
> to platform drivers from ACPI drivers recently.

For the fujitsu-laptop portions of the patch as below:

    Acked-by: Jonathan Woithe <jwoithe@just42.net>

Regards
  jonathan

--

> :
> Fixes: 6da22b031a3c ("platform/x86: fujitsu: Convert laptop driver to a platform one")
> Fixes: d5c9212ccfaa ("platform/x86: fujitsu: Convert backlight driver to a platform one")
> :
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/platform/x86/fujitsu-laptop.c     |   12 ++++++++++--
> :
> --- a/drivers/platform/x86/fujitsu-laptop.c
> +++ b/drivers/platform/x86/fujitsu-laptop.c
> @@ -530,10 +530,14 @@ static void acpi_fujitsu_bl_notify(acpi_
>  
>  static int acpi_fujitsu_bl_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
> +	struct acpi_device *device;
>  	struct fujitsu_bl *priv;
>  	int ret;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	if (acpi_video_get_backlight_type() != acpi_backlight_vendor)
>  		return -ENODEV;
>  
> @@ -993,10 +997,14 @@ static void acpi_fujitsu_laptop_notify(a
>  
>  static int acpi_fujitsu_laptop_probe(struct platform_device *pdev)
>  {
> -	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
>  	struct fujitsu_laptop *priv;
> +	struct acpi_device *device;
>  	int ret, i = 0;
>  
> +	device = ACPI_COMPANION(&pdev->dev);
> +	if (!device)
> +		return -ENODEV;
> +
>  	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>  	if (!priv)
>  		return -ENOMEM;

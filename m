Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.10
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478887;
	b=EaBpQbMCiEIxgJCrIPvxCDhSxG7j5sroFM5aMrTXFiAUp4xEwl5zLzVPcu4aCmDc2H/H
	 ijtZzTk10NBL6ERMbhQ2EeABND6tnHp4HfLp3QwmwrJUmKO2VuTeuOdR7rW7yLVJ0xbVk
	 0NL81RzsrR/oW+ZpH0fzfE2rOXJMWEGcwVQgaHgi8PDyPOAQyq1OKpFgoraTUU8sCmULb
	 hhPISmq47eXhVVKB58eupLX3B3mNS2kSdd0iBBgaT6ZcVNZol8h8QSNfexz4eb13766Hb
	 earKi+Zz99Gen4JuUW8aNoJS1IuUAsMCuKGBkKHskD/MY/0AcqIIhoMwfX+ok5hQtPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478887;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:Date:To:cc:
	 Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
	bh=NVbji0KZV1uYZUK4TZCgFQxar91nD/H9oFtItu7ZRyY=;
	b=S4OYhJdctklN7E6/5i3eDbwjCaMN/AqH/MndBbbMvOtsIWbPQ1WpXlbEuxpeqn8d6yzX
	 NPjc5x9M0cE9tdC2lwYxYLx30sWiyMdbUY3jXIC40p5o6SsKw1WzTG4dECb+sIBWHNwek
	 udlh9buZJ0RRLyENB6l0fKI/v+OUAdVmiJZTUO17N/hAguRAd2N0C4sXp3Hkxnm6YMjd9
	 o/BSq3SZXxX4s7u939sR0a/GXQKclhsjorZ87DOk+aJPQ6PAaw/35Lo0QySdSvpETeVLq
	 ZqNky0+gKsouaN4Lj8heQd8Na/00Air6cQE5wp/W4+94AKJNAY8hpVIIYfbQLI1MuaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JFa1Uo6g;
	arc=none smtp.remote-ip=192.198.163.10
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD7BD606A33B;
	Thu, 12 Nov 2026 10:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD7BD606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JFa1Uo6g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794478887; x=1826014887;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9ryvtv+3D0u7ZmUKVKxFugtxHQCXrLGXh6W32QRNzjY=;
  b=JFa1Uo6ghSC6xIev84cCaylQslA7hOsf+RLg340XAKdjA5XmZKlTjh1/
   iGiMjZl+cXUZM51DWUYjetSU9YKSKAp472mkqYssg1l224iKtLnCI9zoe
   aHUpMJXvveSM59HbhCNDJrvfOr2Mtp7chc3oARQ8paPAYckWb7AhK+tHX
   k7cjjYxZU7NC8+6IwGTQTytLkHe40H1CKte/WDz06NbhYF88qbbkLCnj+
   1QzHfNRUph+ICuCqgcutdH4cbGpCoFWs1olXksY0GUFTVeQA7k6ABhiJ0
   bTjnDAsmu6DAbzZK7LVFQ7rQDU5g1qx8i42PB9pxIYsnuGNd9U4nqxS7h
   g==;
X-CSE-ConnectionGUID: 33oAaIa7ToaEXr+nv+c1IQ==
X-CSE-MsgGUID: HXZWRI9dRaedbeORUFlJ5g==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3160356"
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="3160356"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 02:21:26 -0800
X-CSE-ConnectionGUID: 65ZHtRybSxOdws+e3pTDYg==
X-CSE-MsgGUID: 57Vuhv93R72AniB1yhhDCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,209,1787036400"; 
   d="scan'208";a="10352280"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.68])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 02:21:22 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 12 Nov 2026 12:21:19 +0200 (EET)
To: Hans de Goede <johannes.goede@oss.qualcomm.com>
cc: Armin Wolf <W_Armin@gmx.de>, 
    Patrik Jakobsson <patrik.r.jakobsson@gmail.com>, 
    Han Gao <gaohan@iscas.ac.cn>, Han Gao <rabenda.cn@gmail.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, 
    platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org, 
    linux-riscv@lists.infradead.org
Subject: Re: [PATCH] platform/wmi: Allow wmi module to load when acpi_disabled
 is set
In-Reply-To: <20261111131613.6290-1-johannes.goede@oss.qualcomm.com>
Message-ID: <8382881b-f2d4-7909-d7d1-3a2c74f3b123@linux.intel.com>
References: <20261111131613.6290-1-johannes.goede@oss.qualcomm.com>
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

On Wed, 11 Nov 2026, Hans de Goede wrote:

> The core wmi module provides symbols which may be used by other modules.
> These other modules may still function when acpi_disabled is set, but
> the current behavior of acpi_wmi_init() returning -ENODEV when it is set
> causes loading these modules to fail because the wmi module these depend
> on fails to load with -ENODEV.
> 
> One example of this is booting a kernel with both DT and ACPI/WMI support
> on an arm64 systems with devicetree which will lead to acpi_disabled being
> set. Trying to load the amdgpu module will fail in this case because it
> uses symbols from the drivers/acpi/video module which in turn uses symbols
> from the wmi module. Note the video module itself already contains handling
> to still load when acpi_disables is set for similar reasons.
> 
> Fix this by allowing the wmi module to still load and also register
> the class and bus instances since some exported functions like
> wmi_driver_register() rely on these being valid.
> 
> Signed-off-by: Hans de Goede <johannes.goede@oss.qualcomm.com>

No Fixes tag?

Doesn't this fix a real issue and we want this go through the fixes 
branch?

-- 
 i.

> ---
>  drivers/platform/wmi/core.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/platform/wmi/core.c b/drivers/platform/wmi/core.c
> index 529825dcfbfe..412f2e23b01d 100644
> --- a/drivers/platform/wmi/core.c
> +++ b/drivers/platform/wmi/core.c
> @@ -1573,9 +1573,6 @@ static int __init acpi_wmi_init(void)
>  {
>  	int error;
>  
> -	if (acpi_disabled)
> -		return -ENODEV;
> -
>  	error = class_register(&wmi_bus_class);
>  	if (error)
>  		return error;
> @@ -1584,6 +1581,9 @@ static int __init acpi_wmi_init(void)
>  	if (error)
>  		goto err_unreg_class;
>  
> +	if (acpi_disabled)
> +		return 0;
> +
>  	error = platform_driver_register(&acpi_wmi_driver);
>  	if (error) {
>  		pr_err("Error loading mapper\n");
> @@ -1603,7 +1603,8 @@ static int __init acpi_wmi_init(void)
>  
>  static void __exit acpi_wmi_exit(void)
>  {
> -	platform_driver_unregister(&acpi_wmi_driver);
> +	if (!acpi_disabled)
> +		platform_driver_unregister(&acpi_wmi_driver);
>  	bus_unregister(&wmi_bus_type);
>  	class_unregister(&wmi_bus_class);
>  }
> 

-- 
 i.


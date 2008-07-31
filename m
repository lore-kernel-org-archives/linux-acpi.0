From: Jonathan Woithe <jwoithe@physics.adelaide.edu.au>
Subject: Re: Check for ACPI backlight support otherwise use vendor ACPI
Date: Fri, 1 Aug 2008 08:30:11 +0930 (CST)
Message-ID: <200807312300.m6VN0BY3015796@turbo.physics.adelaide.edu.au>
References: <1217518335.12217.24.camel@earth.gruber.myown>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from adelphi.physics.adelaide.edu.au ([129.127.102.1]:55378 "EHLO
	adelphi.physics.adelaide.edu.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754399AbYGaXA4 (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>);
	Thu, 31 Jul 2008 19:00:56 -0400
In-Reply-To: <1217518335.12217.24.camel@earth.gruber.myown> from "nokos@gmx.net" at Jul 31, 2008 05:32:15 PM
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: nokos@gmx.net
Cc: Thomas Renninger <trenn@suse.de>, ak@linux.intel.com, mjg59@srcf.ucam.org, jwoithe@physics.adelaide.edu.au, hmh@hmh.eng.br, rui.zhang@intel.com, corentincj@iksaif.net, linux-acpi@vger.kernel.org, dannybaumann@web.de, marcus@better.se, mzxreary@0pointer.de, carlos@strangeworlds.co.uk, malattia@linux.it

Hi gyys

> I didi some testing and found whats wrong with the backlight detection
> in video_detect.c you should change:
> 
> --- video_detect.c 2008-07-31 17:20:59.540059897 +0200
> +++ video_detect.c 2008-07-31 17:22:15.752034851 +0200
> @@ -45,9 +45,9 @@
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "Found generic backlight "
>  				  "support\n"));
>  		*cap |= ACPI_VIDEO_BACKLIGHT;
> -		return 0;
> +		return -ENODEV;
>  	}
> -	return -ENODEV;
> +	return 0;
>  }
>  
> 
> otherwise it stops walking the subtree at the first device which does
> not contain backlight (in my case GFX0 has CRT_ as first child which
> does not support backlight).

Makes sense to me (although admittedly I haven't looked deeply into it). 
Are there likely to be any obscure side effects on other hardware which
for some reason assumes backlight support is on the first device scanned?

I'll try to find some time over the weekend to make sure this causes no
ill-effects on the S7020.  It shouldn't, but you never know.

> BTW. the DRDY detection (for IGD) works ... now I have to find the IGD
> patches ... couldn't find them on the list and the version of linux-next
> I tried didn't contain anything which looked like it.

Unfortunately I don't know of a definitive source for these either.

Regards
  jonathan

From: none <alan-jenkins@tuffmail.co.uk>
Subject: Re: [PATCH 2/2 update] misc: Add dell-laptop driver
Date: Wed, 03 Dec 2008 13:01:25 +0000
Message-ID: <49368329.19e7300a.0526.5a68@mx.google.com>
References: <20081127163357.GA22846@srcf.ucam.org> <20081127163444.GB22846@srcf.ucam.org> <20081202115029.2b9d1153.akpm@linux-foundation.org> <20081202201645.GB31620@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.191]:53413 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811AbYLCNBe (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 3 Dec 2008 08:01:34 -0500
Received: by nf-out-0910.google.com with SMTP id d3so1835944nfc.21
        for <linux-acpi@vger.kernel.org>; Wed, 03 Dec 2008 05:01:32 -0800 (PST)
In-Reply-To: <20081202201645.GB31620@srcf.ucam.org>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, Matt_Domsch@dell.com, greg@kroah.com, linux-acpi@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>, Ivo van Doorn <ivdoorn@gmail.com>

Matthew Garrett wrote:
> misc: Add dell-laptop driver
>     
> Add a driver for controling Dell-specific backlight and rfkill interfaces.
> This driver makes use of the dcdbas interface to the Dell firmware to allow
> the backlight and rfkill interfaces on Dell systems to be driven through the
> standardised sysfs interfaces.
>     
> Signed-off-by: Matthew Garrett <mjg@redhat.com>
>
> ---
>
> Contains Andrew's suggested updates, plus a fix for a leak on the init 
> error path.
>   

Sorry, I should have mentioned this in my first message:

> +	if ((status & (1<<2|1<<8)) == (1<<2|1<<8)) {
> +		wifi_rfkill = rfkill_allocate(NULL, RFKILL_TYPE_WLAN);
> +		if (!wifi_rfkill)
> +			goto err_wifi;
> +		wifi_rfkill->name = "dell-wifi";
> +		wifi_rfkill->toggle_radio = dell_wifi_set;
> +		wifi_rfkill->get_state = dell_wifi_get;
>   

The rfkill doc (and code) say that you also need to initialize
wifi_rfkill->state to the current state of the hardware.

> +		ret = rfkill_register(wifi_rfkill);
> +		if (ret)
> +			goto err_wifi;
> +	}
> +

Regards
Alan

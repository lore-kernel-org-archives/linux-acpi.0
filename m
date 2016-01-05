From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] pnp: respect PNP_DRIVER_RES_DO_NOT_CHANGE when detaching
Date: Tue, 05 Jan 2016 14:00:18 +0100
Message-ID: <8867556.oYOjyMZnr7@vostro.rjw.lan>
References: <567105B2.3080109@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64079 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751608AbcAEM3i (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Tue, 5 Jan 2016 07:29:38 -0500
In-Reply-To: <567105B2.3080109@gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: linux-acpi@vger.kernel.org, rafael@kernel.org

On Wednesday, December 16, 2015 07:33:22 AM Heiner Kallweit wrote:
> I have a device (Nuvoton 6779D Super-IO IR RC with nuvoton-cir driver)
> which works after initial boot but not any longer if I unload and
> re-load the driver module.
> 
> Digging into the issue I found that unloading the driver calls
> pnp_disable_dev although the driver has flag PNP_DRIVER_RES_DO_NOT_CHANGE
> set. IMHO this is not right.
> 
> Let's have a look at the call chain when probing a device:
> pnp_device_probe
> 1. attaches the device
> 2. if it's not active and PNP_DRIVER_RES_DO_NOT_CHANGE is not set
>    it gets activated
> 3. probes driver
> 
> I think pnp_device_remove should do it in reverse order and also
> respect PNP_DRIVER_RES_DO_NOT_CHANGE. Therefore:
> 1. call drivers remove callback
> 2. if device is active and PNP_DRIVER_RES_DO_NOT_CHANGE is not set
>    disable it
> 3. detach device
> 
> The change works for me and sounds logical to me.
> However I don't know the pnp driver in detail so I might be wrong.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Applied, thanks!

Rafael


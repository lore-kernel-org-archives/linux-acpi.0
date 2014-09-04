From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v5 1/2] Mailbox: Add support for Platform Communication Channel
Date: Thu, 04 Sep 2014 16:55:38 +0200
Message-ID: <2751441.DbtaX4JgI6@wuerfel>
References: <1409782760-3958-1-git-send-email-ashwin.chaugule@linaro.org> <5470309.KpxVtJyk9p@wuerfel> <CAJ5Y-eaBMX_YGxL69AwKdq3y5n+XFsbD2J7AfHq197ST6AgCjQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.187]:58721 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbaIDOzy (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Thu, 4 Sep 2014 10:55:54 -0400
In-Reply-To: <CAJ5Y-eaBMX_YGxL69AwKdq3y5n+XFsbD2J7AfHq197ST6AgCjQ@mail.gmail.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Ashwin Chaugule <ashwin.chaugule@linaro.org>
Cc: linux acpi <linux-acpi@vger.kernel.org>, "linaro-acpi@lists.linaro.org" <linaro-acpi@lists.linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Brown <broonie@kernel.org>

On Thursday 04 September 2014 10:48:00 Ashwin Chaugule wrote:
> 
> >> + * Create a virtual device to back the PCCT, so
> >> + * that the generic Mailbox framework can do its
> >> + * ref counting.
> >> + */
> >> +struct platform_device pcc_pdev = {
> >> +     .name = "PCCT",
> >> +};
> >
> > Don't declare platform devices statically in C code, just
> > use platform_create_bundle() here to create the device dynamically
> > and bind it to the driver. That will also simplify the driver
> > initalization.
> >
> 
> Nice. Didn't know about this.

It's almost always inappropriate, but I guess here it makes sense.
Normally we want drivers to be loadable when the device shows up,
but you can't do that here anyway.

	Arnd

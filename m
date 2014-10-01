From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v3 11/15] input: gpio_keys_polled - Add support for GPIO descriptors
Date: Wed, 01 Oct 2014 10:13:50 +0200
Message-ID: <2914449.Ivz3LXP1xp@wuerfel>
References: <1410868367-11056-1-git-send-email-mika.westerberg@linux.intel.com> <1852462.V1jlbi8OPt@vostro.rjw.lan> <24790352.cekkkbNf7i@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:49186 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751290AbaJAIOB (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 1 Oct 2014 04:14:01 -0400
In-Reply-To: <24790352.cekkkbNf7i@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-kernel@vger.kernel.org, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-acpi@vger.kernel.org, devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Lee Jones <lee.jones@linaro.org>, Grant Likely <grant.likely@linaro.org>, Aaron Lu <aaron.lu@intel.com>, Darren Hart <dvhart@linux.intel.com>

On Wednesday 01 October 2014 04:17:46 Rafael J. Wysocki wrote:
> From: Aaron Lu <aaron.lu@intel.com>
> 
> GPIO descriptors are the preferred way over legacy GPIO numbers
> nowadays. Convert the driver to use GPIO descriptors internally but
> still allow passing legacy GPIO numbers from platform data to support
> existing platforms.
> 
> Signed-off-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Acked-by: Alexandre Courbot <acourbot@nvidia.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

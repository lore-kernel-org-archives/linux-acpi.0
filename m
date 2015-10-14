From: Frank Rowand <frowand.list@gmail.com>
Subject: Re: [PATCH v7 20/20] of/platform: Defer probes of registered devices
Date: Wed, 14 Oct 2015 16:12:23 -0700
Message-ID: <561EE157.4070604@gmail.com>
References: <1443517859-30376-1-git-send-email-tomeu.vizoso@collabora.com> <1443517859-30376-21-git-send-email-tomeu.vizoso@collabora.com>
Reply-To: frowand.list@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34579 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754687AbbJNXMZ (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 14 Oct 2015 19:12:25 -0400
In-Reply-To: <1443517859-30376-21-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Russell King <rmk+kernel@arm.linux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On 9/29/2015 2:10 AM, Tomeu Vizoso wrote:
> Instead of trying to match and probe platform and AMBA devices right
> after each is registered, delay their probes until device_initcall_sync.
                                                     ^^^^^^^^^^^^^^^^^^^^
                                                     late_initcall

> 
> This means that devices will start probing once all built-in drivers
> have registered, and after all platform and AMBA devices from the DT
> have been registered already.
> 
> This allows us to prevent deferred probes by probing dependencies on
> demand.
> 
> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
> ---

< snip >


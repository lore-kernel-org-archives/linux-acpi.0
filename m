From: Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
Date: Wed, 21 Oct 2015 08:44:44 -0500
Message-ID: <CAL_JsqLhZmc8cEC+tFJ25KLe0bQZsWmrRWGBMQake9VN6OjvdQ@mail.gmail.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com> <1445406845.701.55.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51358 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753455AbbJUNpI (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Oct 2015 09:45:08 -0400
In-Reply-To: <1445406845.701.55.camel@freescale.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Hu Mingkai-B21284 <Mingkai.Hu@freescale.com>

On Wed, Oct 21, 2015 at 12:54 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
>> Instead of trying to match and probe platform and AMBA devices right
>> after each is registered, delay their probes until device_initcall_sync.
>>
>> This means that devices will start probing once all built-in drivers
>> have registered, and after all platform and AMBA devices from the DT
>> have been registered already.
>>
>> This allows us to prevent deferred probes by probing dependencies on
>> demand.
>>
>> Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
>> ---
>>
>> Changes in v4:
>> - Also defer probes of AMBA devices registered from the DT as they can
>>   also request resources.
>>
>>  drivers/of/platform.c | 11 ++++++++---
>>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF platform
> device, and it must be probed before pcibios_init() which is a
> subsys_initcall(), or else the PCI bus never gets scanned.

Thanks for the report. This is probably getting dropped, but it could
be disabled for PPC.

Any plans to fix this and make PCI hosts hotplugable? For the scanning
part, generally the host controller drivers are responsible for
scanning their bus now.

Rob

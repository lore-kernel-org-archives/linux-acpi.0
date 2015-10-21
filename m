From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v6 22/22] of/platform: Defer probes of registered devices
Date: Wed, 21 Oct 2015 00:54:05 -0500
Message-ID: <1445406845.701.55.camel@freescale.com>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com>
	 <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-bn1on0131.outbound.protection.outlook.com ([157.56.110.131]:36352
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751912AbbJUFy0 (ORCPT <rfc822;linux-acpi@vger.kernel.org>);
	Wed, 21 Oct 2015 01:54:26 -0400
In-Reply-To: <1442844182-27787-23-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Brown <broonie@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, Hu Mingkai-B21284 <Mingkai.Hu@freescale.com>

On Mon, 2015-09-21 at 16:03 +0200, Tomeu Vizoso wrote:
> Instead of trying to match and probe platform and AMBA devices right
> after each is registered, delay their probes until device_initcall_sync.
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
> 
> Changes in v4:
> - Also defer probes of AMBA devices registered from the DT as they can
>   also request resources.
> 
>  drivers/of/platform.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)

This breaks arch/powerpc/sysdev/fsl_pci.c.  The PCI bus is an OF platform 
device, and it must be probed before pcibios_init() which is a 
subsys_initcall(), or else the PCI bus never gets scanned.

-Scott


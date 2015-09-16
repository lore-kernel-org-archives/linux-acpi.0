From: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Subject: Re: [PATCH v4 04/22] of: add function to allow probing a device from
 a OF node
Date: Wed, 16 Sep 2015 10:17:43 +0200
Message-ID: <CAAObsKBihtEeNN_NyTmB+U9NAJV6UmJ5LJrqBbO7h9KZPPh8LQ@mail.gmail.com>
References: <1441628627-5143-1-git-send-email-tomeu.vizoso@collabora.com>
 <1441628627-5143-5-git-send-email-tomeu.vizoso@collabora.com> <20150911120824.GP12027@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from mail-wi0-f181.google.com ([209.85.212.181]:33375 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751967AbbIPISE (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Wed, 16 Sep 2015 04:18:04 -0400
In-Reply-To: <20150911120824.GP12027@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Thierry Reding <thierry.reding@gmail.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Frank Rowand <frowand.list@gmail.com>, Grant Likely <grant.likely@linaro.org>, Alan Stern <stern@rowland.harvard.edu>

On 11 September 2015 at 14:08, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Sep 07, 2015 at 02:23:29PM +0200, Tomeu Vizoso wrote:
>> Walks the OF tree up and finds the closest ancestor that has a struct
>> device associated with it, probing it if isn't bound to a driver yet.
>
>> The above should ensure that the dependency represented by the passed OF
>> node is available, because probing a device should cause its descendants
>> to be probed as well (when they get registered).
>
> I'm still not seeing how this works for MFDs where the MFD binding is
> present directly in DT.

The same problem should happen with simple-bus nodes such as
nvidia,tegra124-host1x in which children devices are represented in
the DT (and registered right after their parent) and depend on their
parent for their operation.

Looked at why it wasn't being a problem in my tests and Thierry
mentioned that tegra_host1x_driver takes care of the synchronization
between the bus and their children. So children would make use of the
bus only once it has finished probing and is ready to work (the init
and exit callbacks in host1x_client_ops signal when the bus is safe to
use).

AFAICS, this is a must currently for correct operation in simple-bus
and simple-mfd situations, because probing order is currently very
unpredictable and it's totally possible for the probing of a child to
start before the probing of its parent has finished (if async probing
is enabled or if a module is loaded that registers a child's driver at
the wrong time).

I would prefer if the core would take care of making sure that parents
are always probed before their children, but the unconditional locking
of the parent device stands in the way.

Regards,

Tomeu

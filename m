From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v6 04/22] of: add function to allow probing a device from a OF node
Date: Sat, 24 Oct 2015 16:28:28 +0200
Message-ID: <3439880.XMRknxAf8e@vostro.rjw.lan>
References: <1442844182-27787-1-git-send-email-tomeu.vizoso@collabora.com> <CAAObsKCAX4DQGydQoYjJEYKTOEqpVozXdHnqXWdNYVkLsg7BVg@mail.gmail.com> <20151022235419.GF29919@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:41232 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751518AbbJXN7f (ORCPT
	<rfc822;linux-acpi@vger.kernel.org>); Sat, 24 Oct 2015 09:59:35 -0400
In-Reply-To: <20151022235419.GF29919@sirena.org.uk>
Sender: linux-acpi-owner@vger.kernel.org
List-Id: linux-acpi@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tomeu Vizoso <tomeu.vizoso@collabora.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thierry Reding <thierry.reding@gmail.com>, Alan Stern <stern@rowland.harvard.edu>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Linus Walleij <linus.walleij@linaro.org>, linux-acpi@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>

On Friday, October 23, 2015 08:54:19 AM Mark Brown wrote:
> 
> --7cm2iqirTL37Ot+N
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> 
> On Thu, Oct 22, 2015 at 03:03:37PM +0200, Tomeu Vizoso wrote:
> > On 22 October 2015 at 03:06, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> 
> > > Same question as from Greg: How does a subsystem know whether or not to use
> > > this function?
> 
> > Maybe I don't understand the comment, but as the commit message says,
> > subsystems can use this when looking up resources for drivers. Or you
> > mean that this information should be in the API docs?
> 
> I'm pretty sure what he's suggesting here is changing to "should always"
> (ie, explain the situations when a subsystem would do this, including
> decision criteria if it's optional).

Right.

Thanks,
Rafael

